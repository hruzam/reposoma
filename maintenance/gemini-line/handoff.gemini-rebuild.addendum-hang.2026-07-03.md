# Handoff: Gemini Rebuild — Hang Addendum
# Epoch RE/SEARCH output — 2026-07-03

Calibration date: **2026-07-03**
Reference release: **v0.49.0** (stable as of research date)
All findings live-verified unless flagged [TRAINING-RECALL / UNVERIFIED].
Confidence: H = official doc or merged PR; M = GitHub issue anatomy + community; L = inferred/indirect.

This addendum closes the gap left by the Phase 0a handoff (handoff.gemini-rebuild.md). That pass
answered "what is correct for headless usage." This pass answers "what blocks a headless call."

---

## Q8 — stdin semantics of `-p` in non-TTY contexts

### Findings

**The critical fact: `-p` does NOT suppress stdin reading.**

From source analysis (deepwiki.com/waywardgeek/gemini-cli non-interactive mode page, confirmed
against issue #6715):

> "When non-interactive, stdin data is read and prepended to any --prompt argument before being
> passed to runNonInteractive()."

The processing order is:
1. stdin is read to EOF
2. `-p` text is appended after the stdin content
3. Combined input is passed to `runNonInteractive()`

In a non-TTY environment (any script, pipe, command substitution), `process.stdin.isTTY` is
false. The CLI calls `readStdin()` unconditionally regardless of whether `-p` was supplied.
`readStdin()` blocks until stdin is closed (EOF). If nothing explicitly closes stdin, the call
hangs indefinitely.

**Root cause of the regression (confirmed via issue #6715, closed):**
In v0.1.22, the condition `&& !input` was removed from the `readStdin()` guard. Before the
regression, `readStdin()` only ran when stdin was non-TTY AND no input was already provided.
After v0.1.22, it runs unconditionally in any non-TTY context regardless of `-p`.
The regression was documented and the workaround confirmed; fix status in v0.49.0 is UNVERIFIED —
the safe pattern (`< /dev/null`) is required regardless.

SOURCE: https://github.com/google-gemini/gemini-cli/issues/6715 — CONFIDENCE: H
SOURCE: https://deepwiki.com/waywardgeek/gemini-cli/10-non-interactive-mode — CONFIDENCE: M

**Confirmed workarounds (from issue #6715):**

Shell script:
```bash
gemini -p "your prompt here" < /dev/null
```

Python subprocess:
```python
subprocess.run(["gemini", "-p", "prompt"], stdin=subprocess.DEVNULL)
```

Node.js child_process:
```js
child.stdin.end();
```

Also effective, though noisy: `echo "" | gemini -p "prompt"`

**`--output-format json`:** Does NOT resolve the stdin blocking. It controls output format only.
It does not signal EOF to stdin. Must be combined with `< /dev/null`.

**Re-verification of Q1 load-bearing sentence:**
Old handoff stated: "Appended to stdin input if provided. Forces non-interactive mode."
This is technically correct: `-p` text IS appended after stdin content. But the handoff left a
critical gap: it implied that `-p` forces non-interactive AND resolves stdin, when in fact `-p`
forces non-interactive mode but stdin is STILL read first and blocks until EOF. The old handoff
was not wrong about the append direction; it was silent about the blocking hazard.
CORRECTED: "stdin is read to EOF first; `-p` text is appended after; without `< /dev/null`, the
stdin read blocks indefinitely in any non-TTY context."

### Recommendation

Every `gemini -p` invocation in any script, agent launcher, or CI context MUST add `< /dev/null`.
No exceptions. This is the primary hang mechanism for all script-based callers.

---

## Q9 — Positional prompt without `-p`

### Findings

**`gemini "some text"` (positional arg, no -p): triggers INTERACTIVE mode.**

From the official CLI reference (geminicli.com/docs/cli/cli-reference/):
> "Positional argument (query): Defaults to interactive mode in a TTY."

From issue #6706 (Phase 1: Introduce Positional Prompt, closed/implemented):
> "Modify the CLI to accept a prompt as a positional argument (e.g., `gemini "my prompt"`).
> This boots Gemini CLI into interactive mode with the initial prompt."

The positional arg is therefore explicitly designed to seed an interactive REPL session, not to
run one-shot headless. The documentation confirms `-p` is the flag that forces non-interactive.

**`RESULT=$(gemini "@agent task")` is hang-by-construction. Two failure modes stack:**

1. Command substitution (`$(...)`) inherits the calling script's stdin. In a script, stdin is not
   a TTY, so `process.stdin.isTTY` = false, `readStdin()` fires and blocks waiting for EOF —
   same mechanism as Q8.

2. Even if stdin were closed, a positional arg triggers interactive REPL. The REPL session prints
   to a terminal UI and never exits on its own. Command substitution captures the stdout of a
   process that never terminates. The shell waits forever.

Both failure modes alone are sufficient for a 20-minute silent hang. Together they compound.

**Issue #8689 (positional arg ignored with other flags):**
When other flags like `-e none` are combined with a positional arg, the positional prompt is
silently ignored and the CLI enters interactive mode with no initial text. This makes the failure
mode even more opaque.

SOURCE: https://geminicli.com/docs/cli/cli-reference/ — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/6706 — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/8689 — CONFIDENCE: H

### Recommendation

Remove ALL uses of `gemini "@agentname task"` (positional arg) from every script, spec, and
fallback pattern. The CLI fallback in task specs using this pattern must be replaced with:

```bash
gemini -p "@agentname task" < /dev/null
```

Command substitution is safe only when both conditions hold: `-p` is used AND `< /dev/null`
is appended:

```bash
RESULT=$(gemini -p "@agentname task" < /dev/null)
```

---

## Q10 — Worst-case wall time of `gemini -p "@agentname task"`

### Findings

**Default subagent limits (as of v0.49.0 era):**
From issue #25768 and #22323:
- `maxTurns`: 20 (was 30; generalist subagent reduced)
- `maxTimeMinutes`: 10

These are the PER-SESSION limits for the agent's agentic loop. After `maxTimeMinutes`, the
session is terminated and the CLI returns exit code 53 — but see caveat below.

**Node.js default API call timeout: up to 5 minutes per call.**
Issue #18030 documents that when a backend API call hangs (server not responding), the CLI has
no explicit client-side timeout. The call silently waits until Node.js/undici's default socket
timeout fires at approximately 5 minutes. There is no retry during this 5-minute window. The
existing "exponential backoff resilience logic" is NOT triggered by timeout — it is only triggered
by error responses, not by silent hangs.

**503 retry behavior:**
Issue #19927 (closed as "not planned"):
> "forces manual resubmission after just 3 failed attempts"

There is currently NO configurable retry loop for 503 in non-interactive mode. The CLI shows
"High Demand" and stops after ~3 attempts. In headless `-p` mode, the CLI may hang or exit
depending on version.

**Worst-case wall time calculation:**

| Phase | Duration |
|---|---|
| Startup (MCP init, ripgrep, keyring) | 8–300s (see Q12) |
| One API call hang (Node timeout, no response) | up to 5 min |
| 503 retry cycle (3 attempts, no backoff) | ~1 min |
| Agent agentic loop (maxTimeMinutes) | 10 min |
| Model fallback after timeout (Gemini 3.0 Flash, hardcoded) | unknown |

Without startup blockers: plausible total = 5 min (single hung call) + 10 min (agent timeout) = 15–20 min.
With startup blockers (ripgrep download): 300s + 10 min agent + 5 min call hang = ~20 min.

The observed 20-minute silence is precisely within this range.

**Hardcoded model fallback (issue #24412):**
When `maxTimeMinutes` is exceeded, the generalist subagent falls back to Gemini 3.0 Flash
automatically. This behavior is hardcoded with no disable flag. The fallback extends session
lifetime but degrades quality silently.

**Can wall time be bounded per-invocation?**
- `timeout_mins` in agent frontmatter: YES, reduces the agent loop timeout below 10 min.
  Set to a lower value (e.g., 3 min) to fail faster.
- CLI `timeout` wrapper: `timeout 300 gemini -p "..." < /dev/null` — hard-kills the process
  at N seconds regardless of internal state. Recommended for all automated callers.
- Node API call timeout: currently NOT configurable via flags or settings.json.

SOURCE: https://github.com/google-gemini/gemini-cli/issues/25768 — CONFIDENCE: M
SOURCE: https://github.com/google-gemini/gemini-cli/issues/18030 — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/24412 — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/19927 — CONFIDENCE: H

### Recommendation

Wrap every automated `gemini -p` invocation in a shell `timeout` with a hard wall:

```bash
timeout 180 gemini -p "@agentname task" < /dev/null
```

Set `timeout_mins: 3` in agent frontmatter as a second bound. The shell `timeout` is the
authoritative kill because it operates at the OS process level, independent of internal timeouts.

---

## Q11 — Auth resolution headless

### Findings

**Official credential resolution order (from auth docs + PR #14745):**

1. `GEMINI_API_KEY` env var — checked FIRST; if present, keychain is skipped entirely (PR #14745)
2. System keychain (keytar/OS keyring) — if GEMINI_API_KEY absent, keytar is queried
   CAVEAT: on Linux with GNOME Keyring, `keytar.setPassword()` blocks indefinitely (issue #21622)
3. File-based token storage (`~/.gemini/` credentials file) — fallback if keytar fails
   Force this path: `GEMINI_FORCE_FILE_STORAGE=true` env var (documented in issue comments)
4. `GOOGLE_API_KEY` env var — secondary API key fallback
5. ADC (Application Default Credentials): `GOOGLE_APPLICATION_CREDENTIALS`, `GOOGLE_CLOUD_PROJECT`,
   `GOOGLE_CLOUD_LOCATION`
6. Browser OAuth — interactive only; in headless contexts this path is a hang source

CONFIDENCE: M — assembled from PR #14745, auth docs, issue #21622, issue #13853; no single
official document states the full resolution order.

**What happens when no credential is found in headless mode:**

The official docs (google-gemini.github.io auth page) state:
> "The CLI will exit with an error in non-interactive mode if no suitable environment variables
> are found."

However, issue #13853 (v0.18.0 regression, still open in some versions) documents that the CLI
can hang on "Waiting for auth..." with no browser fallback and no timeout. The regression
introduced a code path where the browser OAuth flow is attempted (and blocks) even when stdin is
not a TTY.

Fix status in v0.49.0: UNVERIFIED. Do not rely on fail-fast behavior; enforce credential
presence before invocation.

**`NO_BROWSER` env var:**
NOT documented in any official source. Not in CLI reference, not in auth docs, not in any
confirmed GitHub comment. Do not use.

**`GEMINI_FORCE_FILE_STORAGE=true`:**
Documented in issue #21622 and #25559 comments. Forces file-based storage, bypasses keytar.
Resolves the GNOME Keyring hang immediately. Not in official docs; confirmed by community.
CONFIDENCE: M

SOURCE: https://google-gemini.github.io/gemini-cli/docs/get-started/authentication.html — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/pull/14745 — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/13853 — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/21622 — CONFIDENCE: M
SOURCE: https://github.com/google-gemini/gemini-cli/issues/25559 — CONFIDENCE: M

### Recommendation

For every headless invocation context, set the full auth guard:

```bash
export GEMINI_API_KEY="..."            # primary; must be present before any call
export GEMINI_FORCE_FILE_STORAGE=true  # Linux guard against keyring hang
```

Add a preflight check to every launcher script:

```bash
if [[ -z "${GEMINI_API_KEY:-}" ]]; then
  echo "GEMINI_API_KEY not set — aborting" >&2
  exit 1
fi
```

This converts the potential infinite hang into an immediate fail-fast exit.

---

## Q12 — Startup blockers in `-p` mode

### Findings

**MCP servers ARE loaded in headless `-p` mode.**

From official docs and issue #4544: MCP servers from `~/.gemini/settings.json` are initialized
at startup for ALL sessions including headless. The proposed fix in #4544 ("stop MCP init from
blocking startup but continue to have it block submission of first prompt") was the goal, but
the effect is that a hanging MCP server still blocks the first prompt from being submitted.

The 8–12 second startup delay from MCP init (issue #4544) is the optimistic case. A dead or
network-unavailable MCP server can block indefinitely.

SOURCE: https://github.com/google-gemini/gemini-cli/issues/4544 — CONFIDENCE: H

**Ripgrep download hang — the most common startup blocker:**

Issue #20433 (confirmed, multiple duplicates #18045, #13611, #24306):
If `rg` is absent from `~/.gemini/tmp/bin/rg` AND network is restricted or behind proxy, the
CLI attempts a background download with a 300-second (5-minute) timeout. The UI shows
"Initializing..." and deadlocks for the full 300 seconds.

Confirmed workarounds:
- `"useRipgrep": false` in `~/.gemini/settings.json` — disables the download and rg dependency
- OR: install rg system-wide and symlink: `ln -s /usr/bin/rg ~/.gemini/tmp/bin/rg`

Additionally, from issue #26777: `getRipgrepPath()` does NOT fall back to system PATH even when
`rg` is installed globally. The symlink to `~/.gemini/tmp/bin/rg` is required.

SOURCE: https://github.com/google-gemini/gemini-cli/issues/20433 — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/26777 — CONFIDENCE: H

**Keyring hang at startup (Linux):**

Issue #21622: `keytar.setPassword()` in `HybridTokenStorage.initializeStorage()` blocks
indefinitely on some GNOME/Linux configurations even with libsecret installed.
Fix: `GEMINI_FORCE_FILE_STORAGE=true` (see Q11).

**TUI/IdeClient hang on headless starts:**

Issue #21477: `IdeClient.getInstance()` blocks `BuiltinCommandLoader` in bare (non-IDE) terminal
contexts. Behavior: CLI hangs at "Initializing..." in bare headless sessions that aren't inside
a known IDE. Status: open as of research date.

**`DEBUG` env var hang:**

PR #14580 (merged): When `DEBUG` env var is set, the CLI freezes in non-interactive contexts
waiting for a debugger to connect. Fixed in the PR. Ensure `DEBUG` is unset in all launcher
scripts:
```bash
unset DEBUG
```

**Per-invocation MCP disable:**

```bash
gemini -p "prompt" --allowed-mcp-server-names "" < /dev/null
# Restricts to zero named MCP servers for that call
```

Or pass a specific allowlist to avoid loading all servers:
```bash
gemini -p "prompt" --allowed-mcp-server-names "server1" < /dev/null
```

Extensions (`-e` / `--extensions`): passing an empty list restricts extension loading.
These flags do NOT suppress ALL MCP loading from settings.json; they scope which servers are
USABLE for that invocation, but servers may still be initialized.

SOURCE: https://github.com/google-gemini/gemini-cli/pull/14580 — CONFIDENCE: H
SOURCE: https://github.com/google-gemini/gemini-cli/issues/21477 — CONFIDENCE: H

### Recommendation

All launcher scripts must include:

```bash
unset DEBUG                            # prevent debugger hang (PR #14580)
export GEMINI_FORCE_FILE_STORAGE=true  # prevent keyring hang on Linux
```

In `~/.gemini/settings.json`:
```json
{
  "useRipgrep": false
}
```

Or ensure rg symlink: `~/.gemini/tmp/bin/rg` → system rg binary. The symlink is more robust
than `useRipgrep: false` (which sacrifices grep capability).

---

## Q13 — REST/curl timeout discipline

### Findings

**Recommended curl flags for `generativelanguage.googleapis.com`:**

From community practice and Gemini 3.1 Pro timeout guide:

- `--connect-timeout 10` — TCP connection establishment; 10 seconds is sufficient for Google's
  anycast endpoints
- `--max-time 120` — total request time including response; minimum for complex models with
  21–35s time-to-first-token (Gemini 3.1 Pro typical range)
- For Flash models: `--max-time 60` is adequate; Flash is typically 3–8s TTFT
- For streaming (`stream-json`): `--max-time` should be 300+ (streaming duration is unbounded
  by definition); prefer `--no-buffer` with chunked parsing

**503 retry discipline:**

503 = server overload; NOT a timeout; NOT a rate limit. Retry with exponential backoff.

Confirmed pattern from Google Enterprise Agent Platform retry docs and community:
- 5 retry attempts
- initial_delay: 1s
- backoff_factor: 2 (exponential)
- Retry delays: 1s, 2s, 4s, 8s, 16s → total retry window: ~31 seconds
- Retryable codes: 503, 429 (with longer initial delay for 429)
- NOT retryable: 400, 401, 403, 404

```bash
_gemini_rest() {
  local attempt delay=1
  for attempt in 1 2 3 4 5; do
    local http_code
    http_code=$(curl -s -o /tmp/gemini_resp -w "%{http_code}" \
      --connect-timeout 10 \
      --max-time 120 \
      -H "x-goog-api-key: ${GEMINI_API_KEY}" \
      -H "Content-Type: application/json" \
      -d "${payload}" \
      "https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent")
    [[ "${http_code}" == "200" ]] && { cat /tmp/gemini_resp; return 0; }
    [[ "${http_code}" == "503" || "${http_code}" == "429" ]] || { echo "Fatal: ${http_code}" >&2; return 1; }
    sleep "${delay}"
    delay=$(( delay * 2 ))
  done
  echo "REST call failed after 5 attempts" >&2
  return 1
}
```

SOURCE: https://docs.cloud.google.com/gemini-enterprise-agent-platform/models/retry-strategy — CONFIDENCE: H
SOURCE: https://www.aifreeapi.com/en/posts/gemini-3-1-pro-timeout-fix — CONFIDENCE: M

**Streaming vs non-streaming timeout difference:**

Non-streaming (`generateContent`): `--max-time 120` covers full request
Streaming (`streamGenerateContent`): use `--max-time 600` and consume chunks as they arrive;
a 120s max-time will kill a long streaming response mid-stream

### Recommendation

Every `curl` call to `generativelanguage.googleapis.com` must include:
- `--connect-timeout 10`
- `--max-time 60` for Flash, `--max-time 120` for Pro, `--max-time 600` for streaming
- Wrapped in a 5-attempt retry loop with exponential backoff on 503 and 429

Do NOT use `curl` without these flags in any automated context. A missing `--max-time` produces
the same 5-minute silent hang as the CLI's internal Node timeout.

---

## Q1 Re-verification (load-bearing sentence from Phase 0a)

Original Phase 0a claim:
> "Prompt text. Appended to stdin input if provided. Forces non-interactive mode."

**CORRECTED interpretation:**

- "Appended to stdin input" is technically correct: the combined prompt = [stdin content] + [-p text].
  The order is: stdin first, -p second. The handoff correctly stated the append direction.

- "Forces non-interactive mode" is correct: -p bypasses the interactive REPL.

- WHAT THE OLD HANDOFF DID NOT SAY AND SHOULD HAVE: `-p` does NOT prevent stdin from being read.
  In any non-TTY context, stdin is read unconditionally to EOF BEFORE processing. Without
  `< /dev/null`, the call blocks indefinitely regardless of whether `-p` is provided.

The old handoff's Q1 was not wrong; it was critically incomplete on the stdin blocking point.
This is the single largest gap between Phase 0a and the observed hang behavior.

---

## SPEC PATCHES

Patches to `task.gemini-rebuild.phase1-infra.md` and `task.gemini-rebuild.phase1-scripts.md`:

### PATCH-1: Every gemini invocation gets `< /dev/null`

In every script, every curl alternative path, every fallback:

```bash
# BEFORE (hang-by-construction):
gemini -p "@agentname $task"

# AFTER (correct):
gemini -p "@agentname $task" < /dev/null
```

Apply to: all occurrences in phase1-scripts.md, all code examples in phase1-infra.md.

### PATCH-2: Replace positional-arg CLI fallback

Find and replace any pattern of the form:

```bash
# BEFORE (hang-by-construction — positional arg → interactive REPL, never exits):
RESULT=$(gemini "@bluebottle $task")
gemini "@agentname $task"

# AFTER:
RESULT=$(gemini -p "@bluebottle $task" < /dev/null)
```

### PATCH-3: Wrap every gemini CLI invocation in timeout

```bash
# AFTER pattern for all CLI calls:
timeout 180 gemini -p "@agentname $task" < /dev/null
exit_code=$?
if [[ $exit_code -eq 124 ]]; then
  echo "gemini call timed out after 180s" >&2
  exit 1
fi
```

Update phase1-scripts.md to specify 180s as the hard wall for all automated CLI calls.

### PATCH-4: Add auth preflight check to all launcher scripts

At the top of every launcher script, before any gemini invocation:

```bash
: "${GEMINI_API_KEY:?GEMINI_API_KEY must be set for headless operation}"
export GEMINI_FORCE_FILE_STORAGE=true
unset DEBUG
```

Add this block to phase1-scripts.md as a required preamble for all per-agent `.sh` scripts.

### PATCH-5: Add useRipgrep to settings.json spec

In phase1-infra.md, the `~/.gemini/settings.json` specification must include:

```json
{
  "useRipgrep": false
}
```

OR specify the symlink requirement:
`~/.gemini/tmp/bin/rg` must exist and point to the system `rg` binary.
Add the symlink creation to the machine bootstrap checklist.

### PATCH-6: Every curl call gets timeout flags and retry wrapper

Replace all bare `curl` calls to `generativelanguage.googleapis.com` with:

```bash
curl --connect-timeout 10 --max-time 60 ...  # Flash
curl --connect-timeout 10 --max-time 120 ... # Pro
```

Wrap in 5-attempt retry loop with exponential backoff on 503/429. Extract the retry wrapper
into `processor.sh` as a shared function so all per-agent scripts inherit it.

### PATCH-7: Add `timeout_mins` to all agent frontmatter specs

In phase1-infra.md agent frontmatter specs, add:

```yaml
timeout_mins: 3
```

for lightweight agents (Orby, Bluebottle REST fallback, Epoch-Gemini).
Set `timeout_mins: 8` for agentic implementers (Astrobley, Vega) where longer loops are expected.
The shell `timeout 180` (Patch-3) is the hard kill; `timeout_mins` is the agent's self-limit.

### PATCH-8: Remove any use of `--approval-mode auto_edit` without policy verification

Issue #20469 documents that policy rules were silently ignored in `--approval-mode auto_edit`
headless mode. If this flag appears in any spec example, add a note: "Verify fix PR #20639 is
included in the deployed version before relying on policy enforcement in auto_edit mode."

---

## HANG CLASS RANKING

Ranked by probability of causing the specific observed behavior (20-minute silent silence from scripts/agents):

**RANK 1 — stdin blocking without `< /dev/null` (MOST LIKELY)**
Confidence: H. The root cause is a confirmed regression (v0.1.22, issue #6715): `-p` does not
suppress stdin reading. In any script/agent context, `readStdin()` blocks indefinitely. If the
build spec used `gemini -p "..."` without `< /dev/null`, this is the primary hang. 20-minute
duration matches an eventual timeout (Node's 5-minute default) or an external watchdog.

**RANK 2 — Positional arg used instead of `-p` (VERY LIKELY if spec used `gemini "@agent task"`)**
Confidence: H. Interactive REPL seeded with text never exits when called from a script. The
command substitution pattern `RESULT=$(gemini "@agent task")` is documented in the old build
spec as the CLI fallback. This is hang-by-construction. 20 minutes = waiting for a session that
never terminates.

**RANK 3 — Ripgrep missing / download hang (LIKELY if machine lacks rg)**
Confidence: H. If `~/.gemini/tmp/bin/rg` is absent and network is restricted, startup hangs
for 300 seconds at "Initializing...". This alone accounts for 5 minutes; combined with Rank 1,
accounts for 20 minutes.

**RANK 4 — Keyring/keytar blocking on Linux (LIKELY on Linux systems without workaround)**
Confidence: M. `keytar.setPassword()` blocks indefinitely on GNOME even with libsecret present.
Startup hangs silently before any prompt is processed. The machine is running Manjaro Linux
(from env context) — GNOME Keyring presence is architecture-dependent. If GNOME is in use,
this is a confirmed hang vector.

**RANK 5 — Node.js 5-minute per-call timeout (LIKELY if API call hung)**
Confidence: H. No client-side timeout on API calls. A single unresponsive call hangs for up to
5 minutes. Four such calls in sequence = 20 minutes. Distinct from the stdin blocking: this
occurs AFTER the prompt is submitted, while the backend is non-responsive.

**RANK 6 — MCP server init blocking first prompt (POSSIBLE)**
Confidence: M. A dead MCP server in `~/.gemini/settings.json` can block startup or the first
prompt submission indefinitely. If any MCP server is configured that is unreachable (e.g., the
mariadb-local MCP in this project's context), it is a startup hang source.

**RANK 7 — Auth not found → browser OAuth hang (POSSIBLE, version-dependent)**
Confidence: M. Issue #13853 documents versions where missing auth triggers an indefinite wait
for a browser that never opens. If `GEMINI_API_KEY` is absent and no cached credential exists,
this path fires.

**RANK 8 — `DEBUG` env var → debugger connection wait (POSSIBLE if DEBUG is set)**
Confidence: H (if DEBUG is set). PR #14580 confirms: `DEBUG` set in environment causes CLI to
freeze waiting for debugger in non-interactive mode. Unlikely to be the primary cause unless
DEBUG is set in the shell environment.

**Summary verdict:** Ranks 1 and 2 together (stdin block + positional arg) are the most likely
root cause for the specific 20-minute hang pattern. Ranks 3 and 4 are compounding factors that
would extend a shorter hang into the 20-minute range. All eight hang classes must be addressed;
eliminating Rank 1+2 alone will not guarantee clean operation on Linux without Rank 3+4 mitigations.

---

*Epoch — 2026-07-03 — live-verified against official sources and GitHub issues except where
flagged [TRAINING-RECALL / UNVERIFIED] or confidence L*
*Output path: /home/hruzam/reposoma/_mail/toAll/inbox/handoff.gemini-rebuild.addendum-hang.2026-07-03.md*
