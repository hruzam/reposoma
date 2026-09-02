---
card: card.codex-cli
brand: OpenAI — Codex CLI
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~1-2 weeks (ships multiple alpha builds/day; stable line moves weekly)
half_life_days: 10
recheck:
  - https://learn.chatgpt.com/codex/changelog          # official human-readable changelog
  - https://learn.chatgpt.com/codex/developer-commands  # CLI command/flag reference
  - https://github.com/openai/codex/releases            # source-of-truth release tags
  - https://developers.openai.com/codex/config-reference # config.toml knobs (redirects to learn.chatgpt.com/docs/config-file/config-reference)
verify_cmd: codex --version
model_floor: gpt-5-codex   # UNCONFIRMED this pass — config-ref example shows "gpt-5.5" generically; do NOT hardcode dated strings
# companion cards: card.claude-code · card.session-hygiene · card.gemini-cli · card.cursor-ide
corpus:
  fork_branch_study: raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md
  # ^ source corpus for §Session model (fork/resume/parallel); cards carry the bond, the corpus carries the argument; updated 2026-08-20
  epoch_delta_2026-09-01: raw.guides/codex-builder-user/refresh-delta.2026-09-01.md
  # ^ reused as source for this 2026-09-02 pass — see Refresh delta section below
---

# OpenAI Codex CLI — native surface

`SEED card — founded 2026-08-05 from the CLI fork/branch study. The session model is deeply covered;`
`other primitives are stubs pending a dedicated refresh. Codex vocabulary: "thread" not "session".`

## Refresh delta 2026-09-02
- **Stable jumped 0.146.0 → 0.152.1** since last card verify (2026-08-05); local office runtime is `0.150.1`, **2 minor releases behind** current stable (0.151.0, 0.152.0/0.152.1) and 3 behind the alpha tip (0.153.0-alpha.5). Source: github.com/openai/codex/releases, retrieved 2026-09-02. Confidence H.
- Reused @Epoch's 2026-09-01 pass (`raw.guides/codex-builder-user/refresh-delta.2026-09-01.md`) as first-line source per canon — do not re-derive what it already verified same-week.
- **New session-model surface since 0.149.0 (2026-08-20)**: `codex agents` interactive dashboard for managing tasks, `/cd` `/pwd` `/cwd` slash commands, `codex queue` (send messages to an existing local/remote session). Source: learn.chatgpt.com/codex/changelog, retrieved 2026-09-02. Confidence H.
- **0.150.0** (2026-08-26): `@`-mention task references (agents can read/create/message tasks), `/copy` component picker, auto-titled unnamed tasks, `Interrupt` hooks on top-level-turn interrupt. Same source/date, H.
- **0.151.0** (2026-08-29): MCP tool-discovery grace period, extensions can inspect/replace MCP tool results pre-model, combined plugin catalogs. Same source/date, H.
- **0.152.0** (2026-09-01): Vim `/`/`?` search in drafts, rate-limit banners with actionable options, credential-refresh progress in TUI (incl. Bedrock reauth), MCP server names allow package-style chars, per-tool `output_token_limit`. **0.152.1** same day: Guardian approval review now honors Node-metadata REPL policies. Same source, H.
- **0.153.0-alpha.1 through .5** all cut 2026-09-01→09-02 — daily-alpha cadence confirmed unchanged from the 2026-08-05 seed observation. Do not cite alpha features as shipped.
- **Model string conflict, unresolved**: 2026-09-01 Epoch pass found **GPT-5.6 Sol/Terra/Luna** GA (2026-07-09) as ChatGPT/Codex flagship (9to5mac + deploymentsafety.openai.com, H). Today's config-reference fetch shows the `model` key's doc example as `gpt-5.5` (learn.chatgpt.com/docs/config-file/config-reference, 2026-09-02, but this reads as a generic placeholder, not a confirmed current default — L confidence). Card's `model_floor: gpt-5-codex` remains **unconfirmed either way**; do not resolve from this signal.
- Fork/subagent internals (source-verified 2026-08-05 against `codex-rs/thread-store/src/types.rs`) not re-checked this pass — no changelog entry 2026-08-05→09-02 mentions `forked_from_id`, `parent_thread_id`, or `history_base`; treat as still-accurate pending a dedicated source re-diff.
- **half_life_days 10 held as-is this pass** — see return note for a proposed change (observed cadence argues for shortening, not lengthening).

## Version state (VOLATILE — re-verify, ships alphas daily)
- **Stable line: 0.152.1** (2026-09-01, patch). 0.152.0 (2026-09-01) is the last feature-bearing stable. 0.153.0-alpha.5 (2026-09-02) is the daily-alpha tip — **do NOT cite alpha features as shipped.**
- 0.149.0 (2026-08-20) → 0.152.1 (2026-09-01): steady weekly-cadence stable ships, see Refresh delta bullets above for per-version content.
- 0.145.0 (2026-07-21, historical): paginated thread history + efficient resume + search + persisted names + sub-agent support + memories + **contextual branch** — foundational session-model release, still load-bearing for §Session model below.
- A separate **Codex App** (alpha, own track) carries native SSH/remote — NOT the `codex` CLI binary. Not re-checked this pass.

## Session model — resume / fork (subcommands, NOT flags)
The structural difference from Claude Code: resume/fork are **top-level subcommands**, headless-first.
- `codex resume [SESSION_ID]` · `--last` (skip picker, most recent in cwd) · `--all` (widen beyond cwd) · `--include-non-interactive` (fold in exec-mode) · `--cd|-C <dir>` (override cwd).
- `codex fork [SESSION_ID]` · `--last` · `--all` · `--cd|-C` — mirrors `resume`; forks a prior session into a **new thread ID**, original untouched. Session-level (not subagent). Direct analog of Claude's `/branch`.
- **Headless:** `codex exec resume --last "instruction"` / `codex exec resume <ID>`. `codex exec --ephemeral` = **no rollout file written** (no resumability) — good for zero-footprint CI.
- **No interactive `/resume` slash command** — resume is CLI-only, before entering a session. TUI slashes: `/clear /agent /subagents /copy /diff /exit /approve /rename /archive /delete /new /cd /pwd /cwd` (no `/continue /undo /rewind`). `/cd /pwd /cwd` added 0.149.0 (2026-08-20) — CWD is now manageable mid-session, not just at launch.
- **New (0.149.0–0.150.0):** `codex agents` dashboard, `codex queue` (message an existing session), `@`-mention task refs, `Interrupt` hooks — layered on top of the session model above, not yet folded into the fork/subagent internals section below.

## Contextual branch (auto)
Editing an earlier prompt or retrying a safety-buffered turn **auto-creates a "contextual branch"** preserving the original conversation + attachments + mention bindings (0.145.0). Distinct from the explicit `fork` subcommand. **Claude Code has no equivalent.**

## The absences (HIGH — where Codex diverges hardest from Claude)
- **No `codex continue`** — absent from official docs (a third-party claim it exists is unreliable/LOW).
- **`/undo` was shipped then REMOVED** ("didn't get much use, design caused problems" — maintainer, openai/codex#9618). Stale calls print "No ghost snapshot available to undo."
- **No `/rewind` / `/revert`** — open, unshipped feature request (#9618; #16784 closed dup). Workaround: **git**, or `fork` away from a bad state. There is no checkpoint/rewind system. Not re-checked this pass.

## On-disk store — rollout files (source-verified HIGH, 2026-08-05)
- Path: `~/.codex/sessions/YYYY/MM/DD/rollout-<ISO_TIMESTAMP>-<UUID>.jsonl[.zst]`, date-sharded, one per session, appended on resume. `CODEX_HOME` overrides the base dir. Verified vs `codex-rs/rollout/src/list.rs`.
- **Session IDs = server-generated UUIDv7** (`Uuid::now_v7()`); no CLI flag sets them. Renaming a rollout file is cosmetic — `resume`/`fork` key off the ID inside the JSONL, not the filename.
- Envelope: each line = `{timestamp, optional ordinal, flattened RolloutItem}`; first record is `RolloutItem::SessionMeta`. (Full variant list MED — inferred, not read verbatim.)

## Fork/subagent internals (source-verified against `codex-rs/thread-store/src/types.rs`, `main` @ 2026-08-05 — not re-diffed 2026-09-02)
- **`forked_from_id: Option<ThreadId>`** — SESSION-fork lineage pointer (on `CreateThreadParams` + `StoredThread`; public as `thread.forkedFromId`). CONFIRMED (2026-08-05).
- **`parent_thread_id`** — SEPARATE field, the **SUBAGENT** pointer ("only set if this thread is a subagent"), sharing one `session_id` across root+subagents. CONFIRMED (2026-08-05). **Don't conflate session fork with subagent fork.**
- **`history_base: Option<HistoryPosition>`** — reference-based, non-copying fork path, but **opt-in backend capability, NOT default**. The public `thread/fork` RPC works **by copying** stored history. **Operator consequence: forking a large thread via the documented API physically copies rollout history — do NOT assume O(1) fork cost.**

## Cost — no official quantification (asymmetry vs Claude)
OpenAI ships **no** quantified fork/resume/compaction cost docs. Third-party numbers (ccusage up to ~91x apparent inflation on branched sessions) are **reporting artifacts**, not confirmed overbilling. Compaction knobs `model_context_window` / `model_auto_compact_token_limit` / `compaction_mode` remain **documented-but-broken** per 2026-08-05 issue survey (#16068, #19185, #16140) — not re-checked 2026-09-02. Config: `tui.resume_cwd = current|session` stops the cwd-mismatch prompt.

## Known session bugs (watch)
- **Stale-resume vs VCS** (#31982): after a hard shutdown Codex resumed from a checkpoint ~2h behind actual git/disk and proceeded confidently → duplicate-commit / overwrite risk. **Sanity-check `git status`/`git log` before trusting a resumed Codex session after any crash.**
- **Resume loses info** (#9198). **Picker buggy** (#9501/#20165/#21619/#19517) — fall back to `find`/grep under `~/.codex/sessions/` and `codex resume <uuid-from-filename>`.
- **No teleport/remote-control equivalent** — `codex cloud` handles cloud chats only; remote/SSH lives in the separate Codex App (alpha). CLI workaround: tmux + ssh, or a third-party wrapper (herdr, Codeman).

## Stubs — pending dedicated refresh
Config system (`~/.codex/config.toml`, profiles — note: `agents.*` keys and `features.multi_agent` (stable, on by default) exist per 2026-09-02 config-ref spot-check; `multi_agent_v2`/`agent_max_depth` NOT found there), MCP support, sandbox/approval model, exec/non-interactive JSONL event protocol (`thread.started`/`turn.*`/`item.*`), sub-agent definition surface. Full study + case studies: `raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md` (updated 2026-08-20).
