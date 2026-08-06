# Codex line — harness builder guide

`status: DRAFT for gavel · 2026-07-25 · @Oraculum distill of @Epoch passes 2026-07-23/25 + WS2 live`
`smoke + WS3 wrapper build · daily-driver layer → codex-line.user.md`
`prime directive: ALL automation goes through the canonical wrapper codex-run.zsh — never bare`
`codex exec. The wrapper is the single home of every mitigation below. Lives at`
`~/.config/zsh/ai/codex-run.zsh — the ONLY path (the .larva/agents-staging/ staging dir`
`was deleted 2026-07-30; stale-ref flagged by Atlas, scrubbed 2026-07-31 per 0009, WS5 gavel).`

## Verified gotcha taxonomy (live-confirmed on codex-cli 0.145.0 unless noted)

| # | Gotcha | Mitigation (in wrapper) |
|---|---|---|
| G1 | stdin-hang on open non-TTY pipe (GH #20919) | `< /dev/null` ALWAYS |
| G2 | silent-exit fully detached from TTY (GH #19945) | one retry via `script -qfc` |
| G3 | exit codes untrustworthy | success = `"type":"turn.completed"` in `--json` stream, never `$?` |
| G4 | `npm i -g codex` = wrong 2012 package | `@openai/codex` scope mandatory |
| G5 | parallel runs collide on session state | `--ephemeral` on every scripted call |
| G6 | no `--list-models`; stale pins fail silently | pin per-call `-m`; surface model errors LOUD |
| G7 | no built-in throttle retry/backoff | shell `timeout` + external retry; cap parallelism 4–6 |
| G8 | human-readable preamble ON STDOUT before first JSON | keep RAW stream; derive JSON via `grep '^{'`; diagnose from RAW (plain-text errors live there) |
| E1 | 16–45K input-token overhead per exec call (measured) | batch contract — coder card bounces micro-tasks |
| — | `--ephemeral` ≠ filesystem isolation (session-only) | caller manages cwd (`CODEX_WORKDIR`) |

Wrapper failure signals: **exit 3** = no completion, unclassified · **exit 4** = empty after retry
(true silent-exit) · **exit 5** = classified upstream error (auth/429/unknown-model), text passed
verbatim to stderr.

## Config surface — what a harness may rely on

- **Precedence (high→low):** MDM → cloud requirements → system `requirements.toml` →
  `managed_config.toml` → `~/.codex/config.toml` → profile → project `.codex/config.toml` → flags.
- **⚠ Silently IGNORED in project-level `.codex/config.toml`:** `approval_policy`, `sandbox_mode`,
  `sandbox_workspace_write.*`, `model_provider(s)`, `openai_base_url`, `notify`, `profile(s)`,
  `otel.*`. Distributing project configs that set these = no-ops. Safety posture must be set at
  user level or passed as flags (our wrapper passes flags — immune by construction).
- **Trust model:** untrusted project dirs load user config only. A nested agent `cd`-ing into an
  untrusted repo gets user-level sandbox policy — maybe more permissive than the project intended.
- `wire_api = "responses"` now REQUIRED in `[model_providers.*]` — chat-completions path deprecated;
  custom-endpoint harnesses silently fail without it. (H)
- `[shell_environment_policy]` — default `inherit` filters `*KEY*/*SECRET*/*TOKEN*` names; audit
  before assuming env-passed credentials reach the child. `inherit = "all"` leaks; keep `core`. (H)
- `notify` key (user-level only): external program on events, JSON `{event_type, thread_id,
  message}` — candidate for temple doorbell integration; full schema UNVERIFIED.

## Headless contract (what codex-run wraps)

```
timeout $T codex exec --json --ephemeral --sandbox workspace-write [-m model] "$prompt" < /dev/null
```
- Event stream: `thread.started` → `turn.started` → `item.completed` (agent_message / file_change)
  → `turn.completed` (+`usage{input,cached,output}` — report it; that's the quota ledger).
- `--output-schema schema.json` — JSON-Schema-constrained output; gpt-5 family only (M). Useful for
  structured relay tasks; wrapper does not use it yet (candidate extension).
- `--output-last-message <path>` — file-drop alternative to stream parsing.
- No `--cwd` flag: `cd` first (`CODEX_WORKDIR` in wrapper).

## Multi-agent V2 (if Codex ever spawns its own — currently OFF, keep it off)

`[features] multi_agent_v2 = true` · depth cap `agent_max_depth = 3` · subagents inherit sandbox,
cannot escalate. **Landmines:** omitted `fork_turns` defaults to FULL-history fork — massive context
duplication in trees (GH #20077, H) · GPT-5.6 Sol ignores per-subagent model overrides — everything
becomes Sol (GH #31814, open) · `"encrypted": true` schema 400s (GH #26753). Temple position: our
orchestration stays on the Claude side (0005 — Claude plans, Codex executes); do not enable until a
real need + these bugs close.

## Hooks (Codex side — richer than Claude's)

11 events (Session/Prompt/PreToolUse/PostToolUse/PermissionRequest/Pre+PostCompact/Subagent*/Stop) ·
bidirectional: stdin JSON in, stdout JSON out (`continue`, `stopReason`, `systemMessage`) · **exit 2
= block** (not any non-zero) · `/hooks` TUI to inspect/trust · `--dangerously-bypass-hook-trust`
exists for automation — treat as a red flag in review. `~/.codex/hooks.json` already exists on disk
(default install) — inspect before assuming it's empty.

## Misc harness facts

- Session JSONL rollouts = forensic trail (`~/.codex/sessions/YYYY/MM/DD/…`); `codex archive`
  excludes from resume picker, file persists.
- `/import` (v0.145) migrates MCP config + memory FROM Claude Code/Cursor — verify what it takes
  before trusting in bootstrap scripts. We do not use MCP on this line (4–32× token overhead).
- OTel export available (`[otel]`, `log_user_prompt = false` default) — observability without
  custom instrumentation if ever needed.
- Retries: per-provider `request_max_retries` only; interop with Plus-auth path UNVERIFIED.

## UNVERIFIED / refresh triggers

- `[features] undo` reliability · custom slash-command system (none found) · `memories/goals`
  sqlite schema · `notify` payload schema · #31814/#26753 fix status in 0.146.x.
- **Refresh discipline:** CLI ships ~weekly. @Epoch delta-check the changelog before any new
  harness work if >1 week stale; full re-pass if >1 month (see runcard underlines).

`provenance: maintenance/codex-line/runcard.codex-onboarding.2026-07-24.md (WS2 evidence, WS3`
`review record) · Epoch reports 2026-07-23 + 2026-07-25 (sources + confidence therein)`
