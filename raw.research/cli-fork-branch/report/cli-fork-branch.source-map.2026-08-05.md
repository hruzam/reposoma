# CLI fork / branch / rewind — Source Map (Phase 2, blind discovery)

`study: cli-fork-branch · date: 2026-08-05 · method: research-pattern.md phase 2 · scope-plane: reposoma-corpus + web`
`question: how a solo operator USES and NAVIGATES forked/branched CLI sessions — Claude Code vs OpenAI Codex CLI`
`status: PHASE-2 COMPLETE — awaiting operator scope-gate before deep dive`

Seven blind lenses mapped trusted sources (they did not answer; substance below is source-attributed
fact-seed surfaced incidentally — treat every version/flag as re-verify-in-dive). Plus one supplementary
LOCAL lens (@Field over `ia-sync/_staging/` sella corpus).

---

## Assembled fact-seed (to be verified in dive)

### Claude Code — session model
- **Transcripts on disk:** `~/.claude/projects/<project>/<session-id>.jsonl` (one JSON/line). ⚠ coldstart doc says `~/.claude/sessions/` — **discrepancy to resolve in dive.** Format "internal, changes between versions, do not parse" (Anthropic).
- **Resume:** `--continue`/`-c`, `--resume`/`-r`, `--from-pr`, `/resume` picker.
- **SESSION fork:** `--fork-session` flag (w/ `--resume`|`--continue`) = new session ID, does NOT carry permission grants / background subagents. `/branch [name]` = in-session conversation branch, return via `/resume`; shared-process token/permission inheritance.
- **`/fork` CHANGED MEANING:** v2.1.161–211 = subagent-fork; **v2.1.212+ = background SESSION copy** (own row in `claude agents`); old behavior renamed `/subtask`. v2.1.216 forked sessions get own worktree.
- **Rewind/checkpoints:** `/rewind` + Esc-Esc menu; 5 actions (restore code/conversation/both, summarize from/up-to). Checkpoints = per-prompt working-tree file-diff snapshots, saved WITH transcript (survive `--resume`); retention **100 most recent, 30-day TTL** (`cleanupPeriodDays`); gated by `fileCheckpointingEnabled`. **NOT git** ("complement, don't replace VCS"). Not tracked: bash-originated file changes, subagent edits, symlinks.
- **Worktrees:** `-w`/`--worktree` + AGENTS.md `isolation: worktree` — environment-level fork, orthogonal to session fork.
- **Cost:** "Resume from summary" trigger = inactive >1hr AND >100k tokens (Pro/Max) → cache expired → full reprocess once. Best-practice doc: clean session > long session; `/clear` after 2 failed corrections. Issue #42260: resume replays ~156k tok, ~25% invisible thinking-signatures, closed **not-planned** (standing cost).

### OpenAI Codex CLI — session model
- **Vocabulary:** "thread" not "session" (newest docs).
- **Resume:** `codex resume [SESSION_ID]`, `resume --last`, `--all`, `--include-non-interactive`, `--cd/-C`. Headless variant `codex exec resume`.
- **Fork:** `codex fork [SESSION_ID]`, `fork --last`, `--all` — **first-class subcommand** (NOT a flag like Claude's `--fork-session`).
- **Contextual branch:** editing an earlier prompt / retrying a safety-buffered turn AUTO-creates a branch preserving the original — **Claude has no equivalent.**
- **Explicit absences:** no `codex continue`, no `undo`, no `rewind`.
- **Rollout files:** `rollout-<id>.jsonl` under `~/.codex/sessions/`; `session_id` server-generated, not user-overridable; `/resume` reads ID embedded in file. `--ephemeral` = no rollout persistence (sella).
- **Fork internals (DeepWiki, code-grounded, MED conf — verify vs repo source):** `forked_from_id` lineage pointer + `history_base` for paginated/non-duplicating forks (not full copy); `parent_thread_id` for subagent relations.
- **Versions:** 0.145.0 (2026-07-21) = paginated thread history + efficient resume + search + persisted names + sub-agent support + memories + contextual-branch. 0.146.0 (2026-07-29) = fork threads w/ paginated history incl. temporary forks (not in listings). Latest 0.147.0-alpha (Aug 4). **Ships multiple alphas/day — re-verify version live.**
- **Cost knobs:** `model_context_window`, `model_auto_compact_token_limit`, `compaction_mode` — but issues #16068/#19185/#16140 report these NOT respected under profiles.

### Cross-vendor comparators (pattern-scout)
- **Gemini CLI:** `/resume` Session Browser + `gemini --resume [idx|id]`; `/chat save|resume|list` (manual tagged snapshots = branching); separate checkpointing (pre-edit snapshot). Splits chat-branch from file-checkpoint (Claude bundles both in `/rewind`).
- **Cursor:** per-turn codebase checkpoints; mode-switch = fresh window; Side Chats = parallel threads; NO session-fork primitive (forum request open).
- **Aider:** git-commit-as-checkpoint; `/undo` reverts last aider commit; `/reset` clears chat. Different paradigm.
- **Infra patterns:** git worktrees, tmux persistent panes, Herdr / codeagentswarm (single-maintainer, EMERGING — re-verify liveness).

### First-principles
Both tools = append-only JSONL event log (Kleppmann log-as-primitive), state reconstructed by replay. Claude adds a separate per-prompt file-snapshot store for `/rewind` (git-adjacent, NOT git). Codex = `forked_from_id` lineage (lightweight DAG-of-sessions). Yardsticks: git commit-DAG (Pro Git ch.10) + append-only-log.

---

## Source list by lens (durable, re-checkable)

**L1 domain-primary (Claude):** code.claude.com/docs/en/{sessions, checkpointing, cli-reference, agent-view, sub-agents} · github anthropics/claude-code CHANGELOG.md (latest visible v2.1.222) · docs/llms.txt index.
**L2 domain-primary (Codex):** github.com/openai/codex/releases · learn.chatgpt.com/codex/changelog · learn.chatgpt.com/codex/developer-commands · github openai/codex/blob/main/docs/config.md · discussions/3827 (rollout files) · issues #17191/#4393/#4791/#10311 · developers.openai.com/codex/noninteractive.
**L3 first-principles:** code.claude.com sessions+checkpointing · openai/codex/tree/main/docs (no rollout schema doc — gap) · deepwiki openai/codex 4.4 · discussions/3827 · git-scm Pro Git ch.10 (DAG) · Kleppmann logs-for-data-infrastructure / DDIA ch.11 · simonw/claude-code-transcripts.
**L4 strategy-economics:** code.claude.com/docs/en/{sessions, costs, checkpointing, best-practices} · anthropics/claude-code issue #42260 (token breakdown, not-planned) · developers.openai.com/codex/config-reference · openai/codex issues #16068/#19185/#16140 · deepwiki openai/codex 4.4.
**L5 counterweight (dissent):** anthropics/claude-code issues #70727 (rewind leaves files), #18516 (rewind fails multi-file), #9055 (rewind-default UX), #1493 (Esc-Esc destructive), #23692 (forks vanish from picker) · openai/codex issues #31982 (stale resume vs VCS), #9198 (resume loses info) · Substack "Stop Resuming Long Sessions, Brief Them Instead" · TDS "Context Rot."
**L6 pattern-scout:** code.claude.com/docs/en/worktrees + checkpointing · pchalasani/claude-code-tools (tmux) · Herdr/dotzlaw · codeagentswarm · aider.chat/docs/git.html (+ issue #1018) · geminicli.com/docs/cli/{session-management, checkpointing} · docs.cursor.com/agent/chat/checkpoints · forum.cursor.com t/59826 (branching request).
**L7 local-corpus:** raw.card.session-hygiene (anchor) · raw.research/agent-docs report (command catalog) · harness/cloud-session-invariance · harness/remote-control-tmux-ssh · claude-code-coldstart mechanics · harness/lifecycle-skill-injection (`context: fork`) · raw.card.{claude-code, gemini-cli, cursor-ide}.
**L8 sella (Field):** `codex exec resume`/`--last` + `--ephemeral` (rollout persistence exists) · sharpest asymmetry: Codex headless `exec --json` typed-JSONL resumable has no Claude equal · `context: fork` = subagent NOT session — don't conflate. **No operator life-hacks in corpus → web must carry that load.**

---

## Gaps the dive MUST fill
1. **Community life-hacks / practitioner workflow** — operator's headline ask; blind lenses explicitly blind to "which mechanism operators actually reach for." → needs a dedicated dive.
2. Codex fork internals (`forked_from_id`/`history_base`) rest on AI-generated DeepWiki — verify vs actual repo source or flag MED.
3. Claude transcript path discrepancy (`projects/…/*.jsonl` vs `sessions/`).
4. `/branch` vs `--fork-session` vs `/fork` — mechanics/cost/when-to-use, not just listing.
5. Codex-side cost numbers — no official measurement (asymmetry vs Claude's #42260); flag, don't smooth.

## Load-bearing claims → Phase 5 adversarial verify
- **C1** Claude `--fork-session`/`/branch` and Codex `codex fork` are functionally the same operation (SESSION branch to new ID). *(refute: are they? /branch in-session vs fork new-session; permission/subagent carryover differs)*
- **C2** Codex has NO rewind/undo/checkpoint; Claude's `/rewind` is a genuine capability gap in Codex. *(refute: does contextual-branch or git cover it?)*
- **C3** Claude `/rewind` reliably restores code+conversation. *(refute: #70727/#18516 — leaves files / fails multi-file)*
- **C4** "Fresh session + brief" beats resume/fork for long sessions. *(refute: when does resume actually win?)*
- **C5** Codex `forked_from_id`+`history_base` = cheaper fork than Claude's full-session copy. *(refute: DeepWiki-sourced, unverified vs Claude cost)*
