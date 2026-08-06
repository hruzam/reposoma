---
card: card.codex-cli
brand: OpenAI — Codex CLI
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-08-05
half_life: ~1-2 weeks (ships multiple alpha builds/day; stable line moves weekly)
half_life_days: 10
recheck:
  - https://learn.chatgpt.com/codex/changelog          # official human-readable changelog
  - https://learn.chatgpt.com/codex/developer-commands  # CLI command/flag reference
  - https://github.com/openai/codex/releases            # source-of-truth release tags
  - https://developers.openai.com/codex/config-reference # config.toml knobs
verify_cmd: codex --version
model_floor: gpt-5-codex   # CONFIRM current string via changelog; do NOT hardcode dated strings
# companion cards: card.claude-code · card.session-hygiene · card.gemini-cli · card.cursor-ide
# seeded-from: raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md (fork/branch study)
---

# OpenAI Codex CLI — native surface

`SEED card — founded 2026-08-05 from the CLI fork/branch study. The session model is deeply covered;`
`other primitives are stubs pending a dedicated refresh. Codex vocabulary: "thread" not "session".`

## Version state (VOLATILE — re-verify, ships alphas daily)
- **Stable line: 0.146.0** (2026-07-29). 0.147.0 in daily alpha as of 2026-08-05 — **do NOT cite alpha features as shipped.**
- 0.145.0 (2026-07-21): paginated thread history + efficient resume + search + persisted names + **sub-agent support** + memories + **contextual branch**.
- 0.146.0: fork threads w/ paginated history incl. **temporary forks** (not in listings), thread pinning, side-conversation switch, `/new`/`/clear` naming.
- A separate **Codex App** (alpha, own track) carries native SSH/remote — NOT the `codex` CLI binary.

## Session model — resume / fork (subcommands, NOT flags)
The structural difference from Claude Code: resume/fork are **top-level subcommands**, headless-first.
- `codex resume [SESSION_ID]` · `--last` (skip picker, most recent in cwd) · `--all` (widen beyond cwd) · `--include-non-interactive` (fold in exec-mode) · `--cd|-C <dir>` (override cwd).
- `codex fork [SESSION_ID]` · `--last` · `--all` · `--cd|-C` — mirrors `resume`; forks a prior session into a **new thread ID**, original untouched. Session-level (not subagent). Direct analog of Claude's `/branch`.
- **Headless:** `codex exec resume --last "instruction"` / `codex exec resume <ID>`. `codex exec --ephemeral` = **no rollout file written** (no resumability) — good for zero-footprint CI.
- **No interactive `/resume` slash command** — resume is CLI-only, before entering a session. TUI slashes: `/clear /agent /subagents /copy /diff /exit /approve /rename /archive /delete /new` (no `/resume /continue /undo /rewind`).

## Contextual branch (auto)
Editing an earlier prompt or retrying a safety-buffered turn **auto-creates a "contextual branch"** preserving the original conversation + attachments + mention bindings (0.145.0). Distinct from the explicit `fork` subcommand. **Claude Code has no equivalent.**

## The absences (HIGH — where Codex diverges hardest from Claude)
- **No `codex continue`** — absent from official docs (a third-party claim it exists is unreliable/LOW).
- **`/undo` was shipped then REMOVED** ("didn't get much use, design caused problems" — maintainer, openai/codex#9618). Stale calls print "No ghost snapshot available to undo."
- **No `/rewind` / `/revert`** — open, unshipped feature request (#9618; #16784 closed dup). Workaround: **git**, or `fork` away from a bad state. There is no checkpoint/rewind system.

## On-disk store — rollout files (source-verified HIGH)
- Path: `~/.codex/sessions/YYYY/MM/DD/rollout-<ISO_TIMESTAMP>-<UUID>.jsonl[.zst]`, date-sharded, one per session, appended on resume. `CODEX_HOME` overrides the base dir. Verified vs `codex-rs/rollout/src/list.rs`.
- **Session IDs = server-generated UUIDv7** (`Uuid::now_v7()`); no CLI flag sets them. Renaming a rollout file is cosmetic — `resume`/`fork` key off the ID inside the JSONL, not the filename.
- Envelope: each line = `{timestamp, optional ordinal, flattened RolloutItem}`; first record is `RolloutItem::SessionMeta`. (Full variant list MED — inferred, not read verbatim.)

## Fork/subagent internals (source-verified against `codex-rs/thread-store/src/types.rs`, `main` @ 2026-08-05)
- **`forked_from_id: Option<ThreadId>`** — SESSION-fork lineage pointer (on `CreateThreadParams` + `StoredThread`; public as `thread.forkedFromId`). CONFIRMED.
- **`parent_thread_id`** — SEPARATE field, the **SUBAGENT** pointer ("only set if this thread is a subagent"), sharing one `session_id` across root+subagents. Fork-lineage and subagent-lineage are independently typed. CONFIRMED. **Don't conflate session fork with subagent fork.**
- **`history_base: Option<HistoryPosition>`** — a reference-based, non-copying fork path (`ThreadStore::prepare_fork`/`ForkBoundary`), but **opt-in backend capability, NOT default** (trait returns `Unsupported` for stores without reference support). The public `thread/fork` RPC works **by copying** stored history (bounded by `lastTurnId`/`beforeTurnId`). **Operator consequence: forking a large thread via the documented API physically copies rollout history — do NOT assume O(1) fork cost.**

## Cost — no official quantification (asymmetry vs Claude)
OpenAI ships **no** quantified fork/resume/compaction cost docs. Third-party numbers (ccusage up to ~91x apparent inflation on branched sessions) are **reporting artifacts** (replayed parent-history prefix), not confirmed overbilling. Compaction knobs `model_context_window` / `model_auto_compact_token_limit` / `compaction_mode` are **documented-but-broken** (#16068 poisons the counter, #19185 clamps to ~258k, #16140 not model-aware) — don't rely on them as cost levers. Config: `tui.resume_cwd = current|session` stops the cwd-mismatch prompt.

## Known session bugs (watch)
- **Stale-resume vs VCS** (#31982): after a hard shutdown Codex resumed from a checkpoint ~2h behind actual git/disk and proceeded confidently → duplicate-commit / overwrite risk. **Sanity-check `git status`/`git log` before trusting a resumed Codex session after any crash.**
- **Resume loses info** (#9198). **Picker buggy** (#9501/#20165/#21619/#19517) — fall back to `find`/grep under `~/.codex/sessions/` and `codex resume <uuid-from-filename>`.
- **No teleport/remote-control equivalent** — `codex cloud` handles cloud chats only; remote/SSH lives in the separate Codex App (alpha). CLI workaround: tmux + ssh, or a third-party wrapper (herdr, Codeman).

## Stubs — pending dedicated refresh
Config system (`~/.codex/config.toml`, profiles), MCP support, sandbox/approval model, exec/non-interactive JSONL event protocol (`thread.started`/`turn.*`/`item.*`), sub-agent definition surface. Full study: `raw.research/cli-fork-branch/`.
