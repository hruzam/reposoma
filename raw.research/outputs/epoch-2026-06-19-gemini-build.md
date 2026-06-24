# @Epoch research report
Date: 2026-06-19
Triggered by: Gemini-seat build go/wait decision + MCP wiring + research methodology draft
Scope: default radar (Gemini CLI / Antigravity CLI, model landscape) + project-specific Q3

---

## Q1 RECOMMENDATION (lead): WAIT — do not lean on headless Gemini right now

**Discriminating constraint:** reliable unattended API-key auth in `agy` (the Antigravity CLI
that replaced Gemini CLI as of yesterday, 2026-06-18) is an OPEN FEATURE REQUEST, not a
shipped capability. OAuth is the default auth method; token persistence across sessions is
broken in headless Linux environments. The `-p`/`--print` flag silently drops output to stdout
under non-TTY (exits 0, returns nothing). These three failures together mean an unattended
deep-web-researcher built on `agy` today will be unreliable.

If the use case is SUPERVISED (human watching the terminal), proceed with restrictions noted
below. If it is UNATTENDED/scripted, wait.

---

## Findings

### Finding 1 — Gemini CLI shut down 2026-06-18 (yesterday); replaced by Antigravity CLI

WHAT changed: The original `gemini` CLI (google-gemini/gemini-cli, 105k GitHub stars,
open-source Node.js) was terminated for free, Google AI Pro, and Ultra subscriber tiers
effective 2026-06-18. The replacement is Antigravity CLI (`agy`), a closed-source Go binary.

SINCE when: 2026-06-18 (one day ago)

SOURCE (links):
- https://github.com/google-gemini/gemini-cli/discussions/27274
- https://www.techtimes.com/articles/318660/20260618/gemini-cli-shutdown-takes-effect-ci-cd-pipelines-break-go-based-antigravity-cli-arrives.htm
- https://inventivehq.com/blog/gemini-cli-deprecated-antigravity-cli-migration

CONFIDENCE: H (official GitHub discussion + multiple independent reports of actual shutdown)

IMPACT: Any script, bridge, or agent calling `gemini` died yesterday. The operator's prior
`~/.gemini` config was legacy Gemini CLI config — the wipe to green-field was correct. Legacy
MCP config (context7, filesystem from raw.gemini.bckp/) is NOT directly portable to `agy`.

ACTION: Do not attempt to restore the old `gemini` binary or config. Build fresh on `agy`.

---

### Finding 2 — Headless API-key auth in `agy` is an open feature request, not shipped

WHAT changed: `agy` defaults to OAuth (personal Google login). For headless/unattended use,
API-key auth via `GEMINI_API_KEY` or `ANTIGRAVITY_API_KEY` was a proposed feature in
github.com/google-antigravity/antigravity-cli issue #78 (approximately one month old as of
this run). Conflicting signals:
- Several search summaries report `ANTIGRAVITY_API_KEY` works as an env var
- Issue #78 remains open with no confirmed-merged status found in this run
- A May 2026 commentator note flags an env-var bug in global MCP config that forced
  hardcoding of keys, suggesting the env-var path was unreliable as recently as last month

SOURCE (links):
- https://github.com/google-antigravity/antigravity-cli/issues/78
- https://antigravitylab.net/en/articles/integrations/antigravity-cli-agy-headless-non-tty-stdout-ci

CONFIDENCE: M — source conflict unresolved. The variable may be wired but reliability is
unconfirmed from an official source; WebFetch was denied in this run, preventing a direct
read of the agy docs or the issue thread.

IMPACT: If `ANTIGRAVITY_API_KEY` is not reliably wired, headless runs will demand OAuth
browser re-auth, which is unscriptable in an unattended agent loop.

ACTION: Before building, test manually: `export ANTIGRAVITY_API_KEY=<your-key>; agy -p "echo
test"` in a non-TTY context (redirect to file). Confirm non-empty output. If it succeeds,
headless is viable with the workaround below.

---

### Finding 3 — Gemini API unrestricted standard keys are rejected starting TODAY (2026-06-19)

WHAT changed: Google's Gemini API now rejects requests from unrestricted standard API keys
as of 2026-06-19. Keys must have explicit restrictions applied (e.g., "Restrict to Gemini API
only" in AI Studio) to continue working. Full standard-key rejection follows in September 2026.

SINCE when: 2026-06-19 (today)

SOURCE:
- https://cybernews.com/security/google-gemini-reject-unrestricted-standard-keys/
- https://ai.google.dev/gemini-api/docs/api-key

CONFIDENCE: H

IMPACT: If the operator's API key is an older unrestricted key, it will start failing TODAY.
This is independent of CLI version — it hits at the API level.

ACTION: Log into AI Studio NOW. Check any existing key for "Unrestricted" label. Apply
"Restrict to Gemini API only" restriction before use. New keys created in AI Studio are
auth keys by default and are safe.

---

### Finding 4 — `agy -p` / `--print` silently drops output under non-TTY

WHAT changed: In the current `agy` version, the `-p`/`--print` flag (non-interactive single
prompt) exits with code 0 but emits nothing to stdout when stdout is not connected to a TTY
(e.g., in a pipe, CI, or when output is redirected to a file). This is a known bug.

SOURCE:
- https://github.com/google-antigravity/antigravity-cli/issues/7
- https://antigravitylab.net/en/articles/integrations/antigravity-cli-agy-headless-non-tty-stdout-ci

CONFIDENCE: M (GitHub issue + independent write-up; not confirmed against current release notes)

IMPACT: Silent failure is worse than a crash. An agent loop that calls `agy -p` and checks
exit code will believe it succeeded while capturing an empty string.

ACTION: Workaround confirmed by community: wrap in `script -qec 'agy -p "your prompt"'
/dev/null`. Check that output is non-empty in addition to checking exit code.

---

### Finding 5 — OAuth token persistence broken in headless Linux

WHAT changed: `agy` OAuth tokens are not persisted across terminal sessions in headless Linux
(including WSL). Each new session requires re-authentication via browser.

SOURCE:
- https://github.com/google-antigravity/antigravity-cli/issues/57

CONFIDENCE: M

IMPACT: Any agent meant to run on a schedule or be invoked by a parent agent without a TTY
will hit this; it makes OAuth-only auth unviable for the Gemini researcher seat.

ACTION: If API-key auth is confirmed working (see Finding 2 action), use it. If not,
do not attempt to build an unattended Gemini researcher seat until this is resolved.

---

## Q2 — Fresh MCP wiring for a Gemini deep-web-researcher

### Finding 6 — MCP config in `agy` uses a new path and a dedicated file

WHAT changed: Antigravity CLI does NOT use `settings.json` for MCP (unlike legacy Gemini CLI).
MCP is now configured in a dedicated file. Two locations:
- Global: `~/.gemini/config/mcp_config.json`  (some sources say `~/.gemini/antigravity-cli/mcp_config.json` — see conflict note)
- Project-local: `.agents/mcp_config.json` in the workspace root

SOURCE conflict: two paths appear in the search results:
- `~/.gemini/config/mcp_config.json` — from the Antigravity official docs summary
- `~/.gemini/antigravity-cli/mcp_config.json` — from a May 2026 community post

Recommend verifying with `agy --help` or the official docs at antigravity.google/docs before
hardcoding a path.

SOURCE:
- https://medium.com/google-cloud/configuring-mcp-servers-and-skills-for-antigravity-cli-and-ide-a938c7eebb78
- https://codelabs.developers.google.com/google-workspace-mcp-antigravity

CONFIDENCE: M (no direct doc read; WebFetch blocked)

### Finding 7 — Config format is standard MCP; security model requires explicit env passthrough

The `mcpServers` object format is stable MCP protocol shape:

```json
{
  "mcpServers": {
    "serverName": {
      "command": "path/to/executable",
      "args": ["--arg1", "value1"],
      "env": {
        "API_KEY": "your-api-key"
      }
    }
  }
}
```

CRITICAL: `agy` sanitizes env before spawning MCP server processes. API keys and secrets in
the host environment are NOT automatically inherited by MCP servers. You MUST declare them
explicitly in the `env` block of the server config. This is the likely cause of the legacy
MCP pain point.

SOURCE:
- https://google-gemini.github.io/gemini-cli/docs/tools/mcp-server.html (legacy doc, format
  appears inherited by agy based on community sources)
- https://medium.com/google-cloud/configuring-mcp-servers-and-skills-for-antigravity-cli-and-ide-a938c7eebb78

CONFIDENCE: M

### Finding 8 — For a web-research agent, consider native grounding before adding MCP

Gemini models have native Google Search grounding built in. For a deep-web-researcher, the
genuinely minimal MCP setup may be NO search MCP at all — rely on Gemini's native grounding,
and add only a minimal filesystem MCP if write-to-file is needed. Adding context7 or a heavy
web-search MCP server replicates what the model already has natively and adds surface area
for breakage.

Recommended minimal build for a Gemini web-research agent:
1. No search MCP — use native grounding
2. No context7 — research scope handled by prompt, not a library-docs tool
3. Filesystem MCP if and only if the agent needs to write output files autonomously
4. All env vars for filesystem MCP declared explicitly in the `env` block

SOURCE: Inferred from Gemini capability documentation + MCP security notes above
CONFIDENCE: M (reasoning-based, not from a single cited source)

---

## Q3 — Deep-web-research customary rules

The named source files (`research/harness/pattern.json` and `research/harness/pattern.jsonl`)
were absent at the specified paths on 2026-06-19. The directory `research/harness/` exists
(Read returns EISDIR, confirming it is a directory) but cannot be enumerated without a shell
tool. Additional candidate paths (`patterns.json`, `orby.md`, `README.md` in that dir) were
also absent.

RESULT: The customary rules draft was synthesized UNSEEDED from @Epoch's methodology and
general deep-web-research discipline. It has been written to:

  /home/hruzam/reposoma/raw.guides/research.web/research-pattern.draft.md

The header notes the unseeded status explicitly. The Gemini side should overlay any recovered
Orby patterns on top and remove the DRAFT / UNSEEDED markers when synthesis is complete.

---

## Q4 — Claude Fable status

WHAT: Claude Fable 5 is NOT deprecated in the standard sense. It was launched 2026-06-09
and was EMERGENCY-SUSPENDED 2026-06-12 by a US government export control directive citing
national security (alleged jailbreak method). The suspension is indefinite, applies to all
customers globally, and came with no migration window or deprecation guide. All other Anthropic
models (Opus 4.8, etc.) remain online. The operator memory note "Fable-5 gated" understates
the situation — it is suspended, not gated.

SOURCE:
- https://www.marktechpost.com/2026/06/13/anthropic-disables-claude-fable-5-and-mythos-5-after-us-government-order/
- https://www.anthropic.com/news/claude-fable-5-mythos-5

CONFIDENCE: M (WebSearch summary of multiple corroborating reports; WebFetch blocked from
reading the Anthropic primary page directly)

---

## Summary: Q1 go/wait decision matrix

| Run mode              | Recommendation         | Blocking issue                          |
|-----------------------|------------------------|-----------------------------------------|
| Unattended / scripted | WAIT                   | API-key auth unconfirmed; -p bug; token loss |
| Supervised (TTY)      | PROCEED with caution   | Verify restricted API key; use `script` workaround |
| Full reconstruction   | 1–2 weeks             | Give agy headless issues time to resolve |

The single test that unlocks the go decision: run `export ANTIGRAVITY_API_KEY=<restricted-key>;
agy -p "return the word READY"` with stdout redirected to a file. If the file contains "READY",
headless is viable. If it is empty, wait.

---

## Sections to refresh: [Antigravity CLI issue #78 resolution status; ANTIGRAVITY_API_KEY confirmed working or not; exact global mcp_config.json path (official docs); Gemini API key restriction enforcement in practice; Fable/Mythos 5 suspension lift date or update; agy -p / --print bug fix release]
