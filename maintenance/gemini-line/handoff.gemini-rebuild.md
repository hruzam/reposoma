# Handoff: Gemini Rebuild Spec Addendum
# Epoch RE/SEARCH output — 2026-07-03

Calibration date: **2026-07-03**
Stable release at time of research: **v0.49.0** (released 2026-06-25)
Nightly track: v0.51.0-nightly (builds through 2026-07-03 confirmed)
Sources fetched live; each finding notes confidence: H = official doc/changelog, M = reliable secondary, L = inferred/indirect.

---

## Q1 — Headless invocation

### Findings

**`-p` / `--prompt` flag:**
Formally documented as: *"Prompt text. Appended to stdin input if provided. Forces non-interactive mode."*
SOURCE: geminicli.com/docs/cli/cli-reference/ — CONFIDENCE: H

Behavior: Bypasses the interactive REPL entirely. Prints response to stdout. Exits on completion. Pipeable. Accepts file references (`@filename`) inside the prompt string. Works with `--output-format text|json|stream-json`.

**`@agentname` selector used with `-p`:**
The `@name` prefix at the start of a prompt (including prompts passed via `-p`) injects a system note nudging the primary model to delegate to that subagent. The subagent then runs its OWN agentic loop (multi-turn, tool use, up to `max_turns=30`). Result: the CLI session IS headless (exits after completion), but the subagent internally runs a full agentic loop — this is NOT a single-shot exchange. Avoid in pure one-shot contexts where tool execution is undesirable.
SOURCE: geminicli.com/docs/core/subagents/ — CONFIDENCE: H
NOTE: exact behavior of `@name -p` combined is not explicitly documented; the above is inferred from combining the two doc sections. Flag: M confidence for the interaction.

**`--raw` flag:**
**DOES NOT EXIST.** No `--raw` flag appears in the current CLI reference (v0.49.0). Not documented in geminicli.com/docs/cli/cli-reference/ or github.com/google-gemini/gemini-cli/blob/main/docs/cli/headless.md. Any scripts using `--raw` are broken.
CONFIDENCE: H (argument from absence; official reference is exhaustive)

**System prompt handling — `-p` vs `@name`:**
- Plain `gemini -p "task"`: Uses GEMINI.md hierarchy as system context (crawls current dir upward). No agent persona injected.
- `gemini -p "@agentname task"`: The agent's `~/.gemini/agents/<name>.md` body becomes the system prompt FOR THAT SUBAGENT invocation.
- To bypass GEMINI.md entirely (raw research pass): `GEMINI_SYSTEM_MD=false gemini -p "task"`
SOURCE: geminicli.com/docs/cli/system-prompt/ — CONFIDENCE: H

### Recommendation

**For one-shot with agent persona (a):**
```bash
gemini -p "@agentname your task here"
```
Note: agent runs its agentic loop internally, then exits. Not a true single exchange — expect tool calls and multiple internal turns.

**For one-shot without persona — raw research pass (b):**
```bash
GEMINI_SYSTEM_MD=false gemini -p "your raw prompt here"
```
Or pipe input: `echo "prompt" | GEMINI_SYSTEM_MD=false gemini -p ""`

Do not use `@name` as a standalone invocation style (i.e., `gemini @agentname "task"` as a shell command pattern). The `@` selector lives INSIDE the prompt string, not as a CLI argument position.

---

## Q2 — Policy Engine

### Findings

**`--allowed-tools` deprecation:**
CONFIRMED deprecated. Still present in the CLI reference with explicit label "Deprecated; use Policy Engine instead." The deprecated `tools.exclude` setting in `settings.json` is also being phased out. No documented removal version; the task's claim of "removal at v1.0" is UNVERIFIED — training-recall only. What is confirmed: do not build new scripts around `--allowed-tools`.
SOURCE: geminicli.com/docs/cli/cli-reference/ — CONFIDENCE: H

**Policy Engine location and loading:**
- User-level: `~/.gemini/policies/*.toml` (all `.toml` files in this directory are loaded and combined)
- Workspace-level: `.gemini/policies/*.toml` (currently DISABLED per docs)
- Admin-level: system directories or via `--admin-policy` flag

**TOML rule structure (confirmed from yolo.toml source):**
```toml
[[rule]]
toolName = "run_shell_command"          # string or array of strings; "*" = wildcard all
subagent = "agent_name"                  # optional: scope rule to specific subagent
mcpName = "server_name"                  # optional: target MCP server
toolAnnotations = { readOnlyHint = true } # optional: match by semantic annotation
argsPattern = "regex_pattern"            # optional: match tool args via regex
commandPrefix = "git"                    # optional: match command prefix
commandRegex = "pattern"                 # optional
decision = "allow"                       # allow | deny | ask_user
priority = 998                           # 0–999; higher wins; tiered by file source
modes = ["yolo"]                         # optional: ["default","autoEdit","yolo","plan"]
denyMessage = "Custom explanation"       # optional: shown when denied
interactive = true                       # optional: requires terminal interaction
allowRedirection = true                  # optional: allow shell redirection
```

**Priority tier system (from yolo.toml comments):**
- Default policies: `1 + priority/1000`
- Extension policies: `2 + priority/1000`
- Workspace policies: `3 + priority/1000` (currently disabled)
- User policies: `4 + priority/1000` ← where `~/.gemini/policies/*.toml` lands
- Admin policies: `5 + priority/1000` (highest override)

**Per-agent policy:**
No separate per-agent `.toml` alongside the `.md`. Rules are global, but the `subagent = "agent_name"` field in a rule scopes it to a specific agent. Agent `.md` definitions are NOT affected during load — Policy Engine only controls TOOL EXECUTION at runtime.

**Known bug (important for headless):**
Issue #20469: Policy Engine rules were ignored in non-interactive mode with `--approval-mode auto_edit`. Fixed in PR #20639 (status: closed). If running headless with `--approval-mode auto_edit`, upgrade to a build post-PR #20639. Confirmed closed/fixed.
SOURCE: github.com/google-gemini/gemini-cli/issues/20469 — CONFIDENCE: M

**MCP support:**
`mcpName = "*"` now supported to target all tools from any registered MCP server in a single rule (2026 enhancement).
SOURCE: geminicli.com/docs/reference/policy-engine/ — CONFIDENCE: H

### Recommendation

For per-agent scripts: do NOT add any Policy Engine flag or config to the script itself. Set policy globally in `~/.gemini/policies/agent-rules.toml`, use `subagent = "agentname"` to scope rules. No `.toml` file alongside the `.md` is needed or supported.

For headless invocations: use `--approval-mode yolo` with a TOML policy that explicitly controls what yolo-mode can and cannot do. Example:
```toml
# ~/.gemini/policies/headless-safe.toml
[[rule]]
toolName = "run_shell_command"
decision = "allow"
priority = 100
modes = ["yolo"]

[[rule]]
toolName = "write_file"
decision = "deny"
priority = 200
modes = ["yolo"]
denyMessage = "File writes not permitted in headless runs"
```

---

## Q3 — Agent injection: MD vs JSON

### Findings

**`.md` format — still canonical (v0.49.0):**
CONFIRMED. Custom agents are defined as Markdown files with YAML frontmatter in `~/.gemini/agents/<name>.md`. No change from prior versions. The markdown body IS the system prompt.
SOURCE: geminicli.com/docs/core/subagents/ — CONFIDENCE: H

**JSON alternative via `settings.json`:**
`settings.json` has a top-level `agents` key, but it is for CONFIGURATION OVERRIDES (browser agent settings, session modes, etc.) — NOT for defining custom agents. Custom agent definitions remain `.md` only.
SOURCE: geminicli.com/docs/reference/configuration/ — CONFIDENCE: H

**Frontmatter fields (confirmed v0.49.0):**
```yaml
---
name: agentname
description: "One-line description used for routing decisions"
kind: agent                    # optional
model: gemini-3.5-flash        # optional; see precedence note below
temperature: 0.7               # optional; range 0.0–2.0; default 1
max_turns: 30                  # optional; default 30
timeout_mins: 10               # optional; default 10
tools:                         # optional; explicit tool allowlist
  - read_file
  - run_shell_command
mcpServers:                    # optional; inline MCP config
  myserver:
    command: npx
    args: [...]
---
Agent system prompt begins here...
```
SOURCE: geminicli.com/docs/core/subagents/ — CONFIDENCE: H

**Model precedence (CRITICAL — affects double-lock pattern):**
Configuration is applied lowest-to-highest:
1. Hardcoded defaults
2. System defaults file
3. User `settings.json`
4. Project `settings.json`
5. System settings file
6. **Environment variables (`GEMINI_MODEL`)** ← HIGH
7. **CLI arguments (`--model`)** ← HIGHEST

Agent frontmatter `model:` is described as "inherits session model when omitted; overrides it when set." Where exactly frontmatter sits in this stack is NOT explicitly documented — the docs treat it as an agent-scoped override. However, the global precedence hierarchy places env vars above all settings files.

**Implication for double-lock pattern:** If `GEMINI_MODEL=gemini-2.5-pro` is exported in the shell environment AND frontmatter says `model: gemini-2.5-flash`, the env var likely wins for the session-level model; the frontmatter override MAY still apply at subagent invocation time (docs say it "overrides the inherited session model"). Exact interaction is AMBIGUOUS in docs.
CONFIDENCE: M — flag for testing

**Safe pattern:** If you want per-agent models, do NOT export a global `GEMINI_MODEL`. Set model only in frontmatter. If a global default is needed, set it in `settings.json` (`model.name`) which is lower priority than frontmatter.
Or: if you keep the double-lock, make BOTH values identical. Mismatched values = undefined behavior risk.

### Recommendation

Keep `.md` frontmatter as the sole agent definition format. Drop `settings.json` agents key for agent definitions — it's for infrastructure config only. Verify double-lock pattern: if `GEMINI_MODEL` env var is being set globally in scripts, it OVERRIDES or competes with frontmatter. Recommended: remove global `GEMINI_MODEL` from per-agent launcher scripts; rely on frontmatter `model:` exclusively, with a session-wide fallback set in user `settings.json`.

---

## Q4 — "Massive" failure cascade

### Findings

**503 pattern — server overload vs rate limit:**
- `503` = server overload / high demand. Per-project rate limits use `429 RESOURCE_EXHAUSTED` instead.
- 503 is NOT a per-key signal — it reflects backend capacity. Worst for preview/new models at launch (gemini-3.1-pro-preview had ~45% failure rate at Feb 2026 rollout).
- Retry-after headers: NOT documented for 503. Docs say "wait and retry after a short period" — no programmatic header to parse.
- 429 per-project spend-based: Paid Tier 1: $10/10min rolling; Tier 2-3: $200/10min.
SOURCE: ai.google.dev/gemini-api/docs/rate-limits + discuss.ai.google.dev/t/handling-429-503-errors — CONFIDENCE: H

**Token bloat — thoughtSignature accumulation (confirmed root cause):**
Issue #20933 documents: every tool call attaches a large `thoughtSignature` to the turn. In extended sessions, these accumulate in curated history, adding hundreds of thousands of non-essential tokens. The reported trigger: ~13% of visible context used, but internal tokens cause a 400 "input token count exceeds maximum" error.
Fix proposed in #20933: strip `thoughtSignature` from past turns, add 20K safety buffer to compression thresholds.
Status: CLOSED as duplicate of #11507. Full fix status: tracked in #11507 — resolution in v0.49.0 UNVERIFIED.
SOURCE: github.com/google-gemini/gemini-cli/issues/20933 — CONFIDENCE: H (issue anatomy); M (fix status)

**Crash bug #8609 anatomy:**
Full cascade:
1. Long session with Gemini 2.5 Pro (1M token capacity) accumulates context + tool history
2. At some threshold (originally ~32K for older model switches), CLI auto-switches to smaller context model
3. Smaller model's context cap < accumulated history size → session cannot continue
4. User attempts `/compress` to rescue session
5. `/compress` calculates `maxOutputTokens = 100,117` (attempting to summarize large context)
6. API ceiling is 65,537 tokens output max → request rejected
7. Session is unrecoverable without restart

Status in v0.49.0: Issue #8609 is CLOSED, but no resolution detail confirmed from available docs. The 20K safety buffer fix in #20933 partially addresses step 5-6 (adds buffer to compression thresholds). Whether the auto-switch trigger in steps 1-3 is also fixed: UNVERIFIED.
SOURCE: github.com/google-gemini/gemini-cli/issues/8609 — CONFIDENCE: H (anatomy); L (v0.49.0 fix status)

**Mitigations beyond `/compress`:**
- Set explicit model string (not `auto`) — avoids CLI auto-switching to smaller model
- Manual session restart every 20–30 tool-call turns (before thoughtSignature bloat accumulates)
- Use `--output-format stream-json` for headless runs to detect token count signals before cascade
- Do NOT use `GEMINI_MODEL=auto` for long sessions
- Avoid re-using sessions (`gemini -r`) across major work boundaries
- Monitor: `/model` command shows current active model; verify it hasn't silently switched

### Recommendation

For all rebuilt agent scripts: set an explicit model string, never `auto`. Treat sessions as ephemeral — launcher scripts should start fresh sessions for each task invocation (stateless headless calls with `-p`). Manual `/compress` remains the only interactive mitigation; in headless, restartless operation (each `-p` call is its own session) eliminates the cascade entirely.

---

## Q5 — Scripting portability

### Findings

**Shebang behavior during sourcing vs execution:**
- When a script is EXECUTED directly: the kernel reads the shebang line and invokes the specified interpreter. `#!/usr/bin/env bash` → bash.
- When a script is SOURCED (`source file.sh` or `. file.sh`): the shebang line is IGNORED. The PARENT shell's interpreter processes the content.

**Implication for `processor.sh` (sourced by keyboard.zsh, executed by agent scripts):**
- When sourced in zsh: zsh interprets the file's content (shebang ignored)
- When executed by bash (agent scripts, Claude Code Bash tool): bash interprets via shebang

This creates a DUAL-RUNTIME constraint: the code must be valid in BOTH bash and zsh simultaneously.

**bash vs zsh compatibility (shared function library):**
Compatible (safe in both):
- `function_name() { ... }` syntax (NOT `function keyword`)
- `[[ ]]` tests
- `$(...)` command substitution
- String operations: `${var:-default}`, `${var#prefix}`, `${var%suffix}`
- Positional parameters: `$1`, `$@`, `$#`
- `local` keyword inside functions

Incompatible — AVOID in sourced files:
- `local -n` (nameref — bash 4.3+, not zsh)
- `printf -v varname` (bash-specific)
- `mapfile` / `readarray` (bash 4, not available in zsh)
- `${var,,}` / `${var^^}` (lowercase/uppercase — bash 4+, zsh uses `${(L)var}` / `${(U)var}`)
- `declare -A` (associative arrays — syntax differs in zsh for same operation)

**Per-agent scripts (`bluebottle.sh`) — executed, never sourced:**
When called from Claude Code Bash tool: bash executes with shebang honored.
When called from keyboard alias: typically executed as a child process (not sourced). Shebang honored.
No dual-runtime constraint. `#!/usr/bin/env bash` with full bash feature set is safe.

**`#!/usr/bin/env bash` vs `#!/usr/bin/env zsh` vs `#!/bin/sh`:**
- `#!/bin/sh`: Maximum portability but loses arrays, `[[ ]]`, local, function-return. Too restrictive for agent scripts.
- `#!/usr/bin/env bash`: Best choice for executed scripts. Bash is available everywhere this team runs (Linux/macOS). Avoids hardcoded `/bin/bash` path differences.
- `#!/usr/bin/env zsh`: Works if zsh is always available in execution context — but Claude Code Bash tool runs vanilla bash, not zsh. Risk: if zsh is not on `$PATH` during bare execution, script fails silently.

**Standard community pattern — shared function library callable from multiple runtimes:**
Pattern: write in bash/POSIX-compatible syntax, use `.sh` extension, guard against sourcing vs executing with:
```bash
# At top of processor.sh:
# (No need for BASH_SOURCE guard if always sourced — but good practice)
```
SOURCE: oneuptime.com/blog/post/2026-02-13-posix-shell-compatibility/ + dotlinux.net/blog/bash-script-shebang-usage-and-best-practices/ — CONFIDENCE: M

### Recommendation

**`processor.sh` (shared function library):**
- Extension: `.sh`
- Shebang: `#!/usr/bin/env bash`
- Constraint: write bash/zsh-compatible syntax only (see incompatibility list above). No bash 4.3+ exclusive features.
- Sourcing pattern in keyboard.zsh: `source "$AI_DIR/processor.sh"` (zsh `source` is preferred over `.` for clarity; both work)

**Per-agent scripts (`bluebottle.sh`, etc.):**
- Extension: `.sh`
- Shebang: `#!/usr/bin/env bash`
- No compatibility constraint (always executed, never sourced). Full bash feature set is available.

**Sourcing pattern note:** When keyboard.zsh sources processor.sh, zsh evaluates it directly — the shebang has no effect. Keep function definitions in processor.sh syntactically valid for zsh (the compatibility list above covers the constraints).

---

## Q6 — Current model stability (2026-07-03)

### Findings

**Gemini 2.5 Pro — current stability:**
ACTIVE ISSUES. Multiple GitHub issues (e.g., #12226, #11650, #2470, #3485, #8269) document automatic downgrade from 2.5-pro to 2.5-flash after 2–3 prompts, triggered by capacity errors. Silent fallback — no warning unless debug mode enabled. Affects even paid Google Code Assist Standard subscribers. Issues marked priority/p1 in tracker.
Status in v0.49.0: NOT confirmed fixed. Issues persist.
SOURCE: github.com/google-gemini/gemini-cli/issues/12226 et al. — CONFIDENCE: H

**Gemini 2.5 Flash — current stability:**
MOST STABLE of the current roster. Used as the CLI's built-in fallback target. No comparable active issues. Recommended for automated/headless use where predictability matters.
SOURCE: github.com/google-gemini/gemini-cli issues (argument from absence of 2.5-flash-specific failures) — CONFIDENCE: M

**Gemini 3.1 Pro Preview — current stability:**
BAD. Known issues:
- Issue #21937 (March 2026): 100% error rate on Windows/v0.32.1 — infinite loading/timeout
- Issue #25192 (April 2026, v0.37.1): Infinite thinking loop, stops mid-workflow
- Both marked as duplicate/closed — tracking in parent issues, but resolution in v0.49.0 UNVERIFIED
- Model is still labeled "rolling out" / preview — limited server capacity
- Community reports: model works in other IDEs (suggesting CLI-specific implementation issues)
The operator's "line 3 was terrible last week" aligns with these documented behaviors.
SOURCE: github.com/google-gemini/gemini-cli/issues/21937, #25192 — CONFIDENCE: H

**Gemini 3.5 Flash — current stability:**
**GA since May 19, 2026 (Google I/O)**. Model string: `gemini-3.5-flash`. NOT preview. Context: 1M in / 64K out.
Agentic benchmarks vs 3.1 Pro:
- Terminal-Bench 2.1: +5.9pp (76.2% vs 70.3%)
- MCP Atlas: +5.4pp (83.6% vs 78.2%)
- Finance Agent v2: +14.9pp
- 4x faster than comparable frontier alternatives
Known limitations: dense long-context retrieval (MRCR v2 at 128k: -7.6pp vs 3.1 Pro), abstract reasoning benchmarks slightly lower.
No CLI-specific crash/hang issues found.
SOURCE: llm-stats.com/blog/research/gemini-3.5-flash-launch, blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-3-5/ — CONFIDENCE: H

**Gemini 3 Pro — current stability:**
GA. Available via CLI. Less active issue reporting than 3.1-preview. Used as the "Auto (Gemini 3)" fallback target in the routing system.
SOURCE: geminicli.com/docs/get-started/gemini-3/ — CONFIDENCE: M

**Community reports June 27 – July 3, 2026:**
Limited specific reports found from this exact window. The issues documented above span March–April 2026 and were still open in the tracker as of research date. No evidence of a new stability regression in the past 7 days; no evidence of major improvement in 3.1-preview either.
CONFIDENCE: L (limited data for this specific window)

### Recommendation

**Automated/headless (Orby, Epoch-Gemini, Bluebottle):** `gemini-2.5-flash` — most stable, no auto-switch vulnerability, good enough throughput for research and synthesis.

**Thinking/advisor (Vega):** `gemini-2.5-pro` — deepest reasoning, but accept the auto-switch risk. Set explicit model string; add session restart to recovery playbook.

**Implementer/coder (Astrobley):** `gemini-3.5-flash` — GA, strong agentic benchmarks, 4x faster, no documented CLI hang issues. Preferred over gemini-3.1-pro-preview until preview issues confirmed resolved.

**DO NOT USE in any automated scripts:** `gemini-3.1-pro-preview` — confirmed hang/loop failures, still in rolling preview, limited capacity. If the operator's "line 3 was terrible last week" referred to 3.1-preview, this is the correct resolution: migrate to 3.5-flash.

---

## Q7 — REST API current state

### Findings

**Endpoint:**
`POST https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent`
CONFIRMED CURRENT. v1beta actively maintained; docs last updated 2026-06-22.
Your current script uses `v1beta/models/gemini-2.5-flash:generateContent` — CORRECT.
SOURCE: ai.google.dev/api/generate-content — CONFIDENCE: H

**Auth header:**
`x-goog-api-key: $GOOGLE_API_KEY` — CONFIRMED CORRECT for API key auth.
`Authorization: Bearer` is for OAuth2 / service account auth (different flow). For API key authentication (which `$GOOGLE_API_KEY` implies), `x-goog-api-key` header is the right format.
Query param alternative: `?key=$GOOGLE_API_KEY` (functionally equivalent).
SOURCE: ai.google.dev/api/generate-content — CONFIDENCE: H

**Response path:**
`.candidates[0].content.parts[0].text` — CONFIRMED CORRECT.
Official docs describe response as: `GenerateContentResponse → candidates[0] → content → parts[] → text`.
SOURCE: ai.google.dev/api/generate-content — CONFIDENCE: H

**System instructions in REST body (key for agent persona injection):**
YES, supported. Pass in request body as:
```json
{
  "systemInstruction": {
    "parts": [{"text": "You are a researcher specializing in..."}]
  },
  "contents": [{"parts": [{"text": "User prompt here"}]}]
}
```
Type: `Content`, text-only currently.
This enables injecting agent persona WITHOUT a `~/.gemini/agents/` file. Useful for the `bluebottle.zsh` REST path.
SOURCE: ai.google.dev/api/generate-content — CONFIDENCE: H

**Rate limits for REST endpoint:**
- Per-project (not per key, not per region)
- 429 = quota/spend limit; 503 = server overload (no retry-after header)
- Free tier: restricted; Paid Tier 1: $10/10min rolling; Tier 2-3: $200/10min
- Model-specific RPM/TPM: not published statically — check AI Studio dashboard per-project
SOURCE: ai.google.dev/gemini-api/docs/rate-limits — CONFIDENCE: H

**v1 vs v1beta:**
v1 exists ("Interactions API is now generally available" per docs). v1beta remains the recommended path for accessing latest model features including the most recent Gemini 3.x models. No forced migration pressure found. Continue using v1beta.
SOURCE: ai.google.dev/api/generate-content — CONFIDENCE: H

### Recommendation

Current `bluebottle.zsh` REST setup is correct. No migration needed. Add `systemInstruction` field to the request body to inject agent persona programmatically — this is the preferred pattern for headless REST calls where `~/.gemini/agents/` is not available in the execution environment.

---

## CONSOLIDATED SCRIPTING VERDICT

**Extension:** `.sh` for all scripts (both shared library and per-agent)

**Shebang for `processor.sh` (shared function library):**
```
#!/usr/bin/env bash
```
⚠️ Caveat: when sourced by keyboard.zsh, this shebang is IGNORED and zsh interprets the content. Write bash/zsh-compatible syntax only:
- NO `local -n`, `printf -v`, `mapfile`, `readarray`, `${var,,}`, `${var^^}`
- YES to `[[ ]]`, `$(...)`, `${var:-default}`, `${var#pat}`, positional params, `local` in functions

**Shebang for per-agent scripts (`bluebottle.sh`, etc.):**
```
#!/usr/bin/env bash
```
No compatibility restriction — these are always EXECUTED (never sourced). Full bash feature set available.

**Sourcing pattern in keyboard.zsh:**
```zsh
source "${AI_DIR}/processor.sh"
# or equivalently:
. "${AI_DIR}/processor.sh"
```

**Calling per-agent scripts from Claude Code Bash tool:**
```bash
bash "${AI_DIR}/bluebottle.sh" "$arg"
# or just:
"${AI_DIR}/bluebottle.sh" "$arg"  # requires chmod +x
```

---

## MODEL ASSIGNMENTS

**Vega (thinking/advisor):**
`gemini-2.5-pro`
Rationale: deepest reasoning for high-stakes decisions. Accept auto-switch risk (add session restart to runbook). Do NOT use `gemini-3.1-pro-preview` — documented hanging/loops make it unreliable for interactive advisor sessions.

**Orby (researcher):**
`gemini-2.5-flash`
Rationale: stability paramount for automated research passes. Fast enough for iterative fetching. No auto-switch instability.

**Bluebottle (synthesizer):**
`gemini-2.5-flash`
Rationale: REST path makes model switch irrelevant (explicit per-call). Synthesis doesn't require pro-depth. Flash is 4x faster throughput.

**Astrobley (implementer):**
`gemini-3.5-flash` (NOT gemini-3.1-pro-preview)
Rationale: GA since 2026-05-19, superior agentic benchmarks (+14.9pp Finance Agent, +5.9pp Terminal-Bench), 4x faster, no CLI hang issues. The pro-preview depth advantage does NOT outweigh the hang/loop failure risk for an implementer doing tool-call-heavy work.

**Epoch-Gemini (recalibrator):**
`gemini-2.5-flash`
Rationale: recalibration runs must be reliable above all else. Flash is the stable anchor of the current lineup.

---

## FLAGS / OPEN ITEMS FOR BUILD PHASE

1. **`--raw` flag does not exist** — any existing script using it is broken; remove immediately.
2. **Double-lock pattern**: mismatched `GEMINI_MODEL` env var + frontmatter `model:` = undefined behavior. Audit all launcher scripts.
3. **Policy Engine + headless bug** (#20469): fixed in PR #20639. Verify v0.49.0 includes this fix before relying on Policy Engine in headless `-p` invocations.
4. **thoughtSignature bloat** (#20933 / #11507): architectural mitigation for rebuilt scripts = stateless headless calls (each task = fresh `-p` session, no session reuse). This eliminates the cascade entirely.
5. **gemini-3.5-flash `systemInstruction`**: verify this model supports the `systemInstruction` field in v1beta REST (expected yes, but test before deploying bluebottle rebuild).
6. **`@agentname` + `-p` interaction**: not explicitly documented for headless. Test manually: `gemini -p "@agentname simple probe"` to confirm the agent's system prompt loads and the session exits cleanly.

---

*Epoch — 2026-07-03 — all findings live-verified against official sources except where flagged [UNVERIFIED — training-recall only] or confidence L*
