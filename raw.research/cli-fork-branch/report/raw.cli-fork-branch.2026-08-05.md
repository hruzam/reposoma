+++
title          = "CLI Session Fork / Branch / Rewind — Claude Code vs Codex CLI"
research_date  = "2026-08-20"
supersedes     = "raw.cli-fork-branch.2026-08-05.md (same file, full rewrite)"
scope          = ["claude-code", "codex-cli"]

# Reverse-index: which raw.settings cards treat this file as their source.
# The cards carry the half-life / recheck schedule; this file is the corpus.
consumed_by    = [
  "raw.settings/raw.card.claude-code.md",    # § Session fork / branch / rewind / navigation
  "raw.settings/raw.card.codex-cli.md",      # § Fork / resume / parallel sessions
]

[version_stamps]
claude_code = "v2.1.212+ (pivot version); verified latest at 2026-08-20 against code.claude.com"
codex_cli   = "0.146.0 stable (2026-07-29); 0.147.0 daily-alpha — do not cite alpha as shipped"

[recheck]
claude_code_changelog = "https://code.claude.com/docs/en/changelog"
claude_code_sessions  = "https://code.claude.com/docs/en/sessions"
claude_code_sub_agents = "https://code.claude.com/docs/en/sub-agents"
claude_code_checkpointing = "https://code.claude.com/docs/en/checkpointing"
claude_code_agent_view = "https://code.claude.com/docs/en/agent-view"
codex_cli_developer_commands = "https://learn.chatgpt.com/codex/developer-commands"
codex_cli_changelog = "https://learn.chatgpt.com/codex/changelog"

[confidence]
# H = official changelog/docs; M = reliable commentator; L = inferred/indirect
claude_code_command_surface = "H"
codex_cli_command_surface   = "H"
codex_cli_on_disk_internals = "H — source-verified against codex-rs/thread-store/src/types.rs main 2026-08-05"
community_patterns          = "M — practitioner blogs, shareuhack.com, codex.danielvaughan.com, incident.io report"
cost_numbers_claude         = "H"
cost_numbers_codex          = "M — third-party tooling only; OpenAI ships no equivalent docs"

[sections_to_refresh]
# populated by the Epoch run that last wrote this file; next run picks this up
version_stamps    = "both tools ship fast — re-verify claude-code latest tag and codex 0.147 stable status"
rewind_bug_cluster = "check anthropics/claude-code #70727 + #18516 — if closed, §6 gotcha softens"
fileCheckpointingEnabled = "setting name unverified in live docs — grep settings schema to confirm or retire"

[sources]
# all verified 2026-08-20; confidence per [confidence] table above
official_claude_auth      = { url = "https://code.claude.com/docs/en/authentication", confidence = "H" }
shareuhack_parallel       = { url = "https://www.shareuhack.com/en/posts/claude-code-parallel-workflow-guide-2026", confidence = "M" }
danielvaughan_lifecycle   = { url = "https://codex.danielvaughan.com/2026/06/05/codex-cli-session-lifecycle-archive-resume-fork-compact-management/", confidence = "M" }
claudekit_fork_explained  = { url = "https://claudekit.app/blog/claude-code-fork-conversation-explained", confidence = "M" }
techtimes_fork_cmd        = { url = "https://www.techtimes.com/articles/318344/20260613/claude-code-adds--fork-command-anthropic-brings-git-style-branching-ai-coding-sessions.htm", confidence = "M" }
code_claude_sessions      = { url = "https://code.claude.com/docs/en/sessions", confidence = "H" }
code_claude_checkpointing = { url = "https://code.claude.com/docs/en/checkpointing", confidence = "H" }
code_claude_sub_agents    = { url = "https://code.claude.com/docs/en/sub-agents", confidence = "H" }
codex_developer_commands  = { url = "https://learn.chatgpt.com/codex/developer-commands", confidence = "H" }
+++

# CLI Session Fork / Branch / Rewind — Claude Code vs Codex CLI

> **Research corpus.** This file is the source of truth for `raw.card.claude-code.md` and
> `raw.card.codex-cli.md`. Those cards carry the half-life / recheck schedule; this file carries
> the argument. Rewrite here first, then propagate delta to the cards.
> Version stamps, recheck URLs, and the consumed-by index live in the TOML header above.

---

## 1. Executive answer

Both tools give you a **session-level fork** — copy a saved transcript into a new session/thread
ID, leave the original untouched, diverge from there. That top-line equivalence holds; everything
below it diverges.

**Claude Code** is TUI-first and gives you four distinct fork shapes in one tool: an in-session
copy (`/branch`), a new-process copy (`--fork-session`), a background-session copy (`/fork`), and
an in-process subagent fork (`/subtask`). It adds two things Codex has no analogue for: a real
**rewind / checkpoint system** (`/rewind`, Esc-Esc) that snapshots code before every prompt, and a
rich **background-session + worktree isolation** layer with a `claude agents` dashboard.

**Codex CLI** is headless-first and simpler: `codex fork` / `codex resume` are top-level
subcommands (not slash commands), fork lineage is tracked server-side via a `forked_from_id`
pointer, and the TUI auto-creates a **contextual branch** when you edit an earlier prompt. It has
no rewind, no undo, no daemon dashboard — third-party tools (herdr, Codeman, dmux) exist to fill
that gap.

**The single most useful fact for anyone reading a tutorial:** at **v2.1.212** Claude Code swapped
the names `/fork` and `/subtask`. Before that version, `/fork` was the in-session subagent fork;
after it, `/fork` is the background-session fork and `/subtask` is the subagent fork. Reading a
pre-2.1.212 tutorial gets these backwards. Confidence: H (triple-sourced: CHANGELOG, sub-agents
docs, agent-view docs).

---

## 2. The fork family — Claude Code (v2.1.212+)

| Command | Kind | What it does |
|---|---|---|
| `/branch [name]` | SESSION fork, same process | Copies transcript to this point, switches the running process to write the copy; original stays on disk and in the picker. **Carries** in-session "allow" grants + in-flight background subagents/Bash. Auto-names from the true first prompt (past compaction summaries, v2.1.198+). |
| `claude --continue --fork-session` | SESSION fork, new process | CLI-flag equivalent of `/branch` but a *fresh* process — **grants do NOT carry; you must re-approve**. Use when you want a clean permission slate. |
| `/fork` (v2.1.212+) | SESSION fork → background | Copies the conversation into a **new independent background session** (own row in `claude agents`), own git worktree under `.claude/worktrees/`. Inherits history, cwd, model, permission mode, effort, in-session grants, and launch config. **Refuses** to fork sessions launched with a replaced system prompt or `--tools` allowlist. Requires agent view on; falls back to old-style subagent fork if agent view is off. |
| `/subtask <task>` | SUBAGENT fork, in-session | Spawns a forked subagent inheriting the **entire** conversation, system prompt, tools, model. Tool calls stay out of main context; only the final result returns. First request reuses parent's prompt cache (cheaper than a fresh subagent). One level only — a fork can't spawn forks. Enable via `CLAUDE_CODE_FORK_SUBAGENT=1`. |

**Decision heuristic (one line each):**
- `/subtask` → side task in the same process, same cache, cheapest; doesn't need to survive terminal close.
- `/fork` → independent background session with its own worktree; survives closing; shows up in `claude agents`.
- `/branch` → try an alternate path in-place, keep grants, stay in this terminal.
- `--fork-session` → same as `/branch` but you explicitly want a fresh permission slate.

---

## 3. Codex CLI fork family (0.146.0)

| Command | Kind | What it does |
|---|---|---|
| `codex fork [SESSION_ID]` | SESSION fork | Standalone subcommand; branches a prior session into a new thread ID; original untouched. `--last` skips the picker; `--all` widens beyond cwd; `-C <dir>` overrides cwd. |
| `codex resume [SESSION_ID]` | Resume same thread | Reopens an ended session on its original thread. `--last` / `--include-non-interactive` variants. Headless: `codex exec resume --last "prompt"`. |
| Contextual branch (auto) | Auto-fork on edit | Editing an earlier prompt or retrying a safety-buffered turn **auto-creates a contextual branch** preserving original conversation + attachments (shipped 0.145.0). Distinct from `codex fork`. |
| `/compact` | In-session compaction | Summarises earlier context, frees token budget. Use at milestones. Archive with `/archive`; restore with `codex unarchive <ID>`. |

**Codex decision heuristic:**
- Same task, next day → `codex resume --last`
- Different theory, don't lose original → `codex fork --last`
- Error loop → `codex fork --last` (escape to a clean branch; no rewind exists)
- Parallel tasks → separate tmux panes / terminal windows, each its own `codex` session

---

## 4. Case studies (PAD-inspired — scenario → goal → steps → outcome → verdicts)

> Format: each study is self-contained. Steps are copy-pasteable. Verdicts branch
> on what the operator actually sees. These are reference cases, not live sittings —
> you do not need to report back between steps.

---

### CS-1 — Claude Code: safe diverge (try a different approach)

**Scenario:** You are 20 messages into debugging an auth bug. Claude has been pursuing theory A
(session-cookie expiry). You want to test theory B (CORS header mismatch) without abandoning the
progress on theory A.

**Goal:** Two independent sessions, one per theory, both resumable, original untouched.

**Tool:** `/branch`

**Steps:**

```
# 1. In the running session, at any prompt:
/branch theory-b

# Claude Code output: "Switched to branch 'theory-b'. Original session preserved."
# You are now in a copy of the conversation at this point.
```

```
# 2. Proceed with theory B in this session.
# The original session (theory A) is in the picker — untouched.

# 3. To return to theory A:
/resume          # opens the picker; select the original by name
# OR
claude --resume theory-a   # if you named the original
```

**Outcome:**
- `[SUCCEEDED]` → You have two named sessions, each with the full prior context. You can
  switch between them via the picker at any time. Grants (tool approvals) you had when you
  branched are carried into theory-b.
- `[GRANTS MISSING]` → If you used `--fork-session` flag instead of `/branch`, grants do
  not carry — re-approve tools at the first prompt that needs them.
- `[BRANCH NOT IN PICKER]` → Known bug (#23692, closed not-planned). Widen the picker:
  press `Ctrl+A` (all projects) or `Ctrl+W` (all worktrees). If still missing, run
  `/status` inside the branched session — the name appears there even when picker hides it.

**When NOT to use this:** When you want the branch to run **simultaneously** (in parallel, in
another terminal). `/branch` switches the current terminal to the new session — it does not
open a second terminal. For parallel execution, see CS-5.

---

### CS-2 — Claude Code: background task while staying in foreground

**Scenario:** You are in the middle of a complex refactor. You want Claude to simultaneously
rewrite the entire test suite — a long, noisy job — while you continue the refactor in the
foreground. Both should run at the same time.

**Goal:** Two sessions running in parallel; test rewrite in background; foreground session
unaffected; background session resumable.

**Tool:** `/fork`

**Precondition:** Agent view must be on (`claude agents` is available in your Claude Code
version). If agent view is off, `/fork` falls back to subagent fork (CS-3 behaviour), not a
background session.

**Steps:**

```
# 1. In the running foreground session:
/fork

# Claude Code output:
# "Forking session... Created background session 'session-name-fork'.
# Moving to worktree: .claude/worktrees/<name>/"
# The foreground session continues running. The fork is now a background session.
```

```
# 2. The fork runs independently. Monitor it:
claude agents           # opens the background sessions dashboard

# Dashboard shows: session ID, status (running/waiting/done), worktree path.
# Press 'a' to attach and view the forked session's output.
# Press 's' to stop it.
```

```
# 3. When the fork is done (or you want to inspect it):
claude agents           # find the session
# Press Enter on it to attach
# OR
claude --resume <session-id>    # from outside
```

```
# 4. Merge or cherry-pick the test-suite changes:
# The fork ran in .claude/worktrees/<name>/ — its changes are isolated.
# Use git to cherry-pick, diff, or merge as you would any worktree branch.
git -C .claude/worktrees/<name> log --oneline    # inspect what it did
git cherry-pick <commit-hash>                     # bring specific changes across
```

**Outcome:**
- `[BOTH RUNNING]` → Foreground continues the refactor; background handles the test rewrite.
  Each has its own worktree, so file edits do not collide.
- `[FORK REFUSED]` → Session was launched with a replaced system prompt or `--tools` allowlist.
  `/fork` refuses partial copies. Start a clean session and fork from there.
- `[BACKGROUND VANISHED]` → Agent view off at launch time, or `claude agents` is empty. Check
  `/status` in the forked terminal, or grep `~/.claude/projects/` for the session JSONL.

**When NOT to use this:** When both tasks touch the same files. Parallel writes to the same
files across worktrees still produce merge conflicts — the worktree isolation handles
*context*, not *semantics*. Verify independence first (different file domains).

---

### CS-3 — Claude Code: quick side task, keep main context clean

**Scenario:** You are mid-refactor. You need Claude to grep 3000 lines of a log file, extract
error patterns, and summarise them — a noisy, self-contained job. You do not want that log
content permanently in your main session's context and token budget.

**Goal:** Side task completes, only the summary returns to the main session. Log noise stays
out of main context.

**Tool:** `/subtask`

**Precondition:** `CLAUDE_CODE_FORK_SUBAGENT=1` must be set in your shell or `settings.json`
`env` block.

```json
// ~/.claude/settings.json
{ "env": { "CLAUDE_CODE_FORK_SUBAGENT": "1" } }
```

**Steps:**

```
# In the running session:
/subtask Grep ~/.local/logs/app-2026-08-20.log for all lines containing "ERR" or "FATAL".
         Count occurrences by error code. Return a 5-line summary — codes, counts, top pattern.
```

```
# What happens internally:
# - A subagent fork spawns, inheriting the entire conversation + system prompt.
# - Its tool calls (Read, Bash grep) run in the fork's context, not the main one.
# - Only the final 5-line summary is returned to the main session.
# - The fork's full context is discarded after it exits.
# - First subagent call reuses the parent's prompt cache (cheaper than a fresh subagent).
```

**Outcome:**
- `[SUCCEEDED]` → Main session receives the 5-line summary. Log noise never entered main
  context. Token budget on the main session is unaffected by the grep work.
- `[FORK SPAWNS ANOTHER FORK]` → One level only. `/subtask` cannot itself call `/subtask`.
  If the side task is multi-stage, break it into a single prompt that handles all stages
  internally.
- `[ENV FLAG MISSING]` → Without `CLAUDE_CODE_FORK_SUBAGENT=1`, `/subtask` falls back to a
  normal in-session subagent (Task tool, NOT a fork). Context still stays scoped to the
  subagent's own window, but the prompt cache reuse is lost.

**When NOT to use this:** When you want the side task to persist, be resumable, or run
simultaneously in the background. `/subtask` is synchronous in the sense that the main session
waits for the result. For a true background parallel task, use CS-2 (`/fork`).

---

### CS-4 — Claude Code: pre-warm once, fork per feature

**Scenario:** You have a large codebase. Briefing Claude on the architecture takes 40k tokens.
You want to run 3 separate feature sessions today — auth, payments, notifications — without
re-briefing 3 times.

**Goal:** One briefing session; 3 independent feature sessions launched from it as clean copies.

**Tool:** `--fork-session` (flag form of `/branch`, new process per fork, clean permission slate)

**Steps:**

```
# 1. Build the context session:
claude -n arch-briefing

# Inside this session, feed Claude the architecture:
> Read src/auth/, src/payments/, src/notifications/ and summarise the shared patterns,
  key interfaces, and any cross-cutting concerns. Don't write any code yet.
# Wait for Claude to read and respond. This is your "warm" session.
```

```
# 2. Fork three independent feature sessions from it:
# Terminal 1:
claude --resume arch-briefing --fork-session -n feature-auth

# Terminal 2:
claude --resume arch-briefing --fork-session -n feature-payments

# Terminal 3:
claude --resume arch-briefing --fork-session -n feature-notifications
```

```
# Each fork starts with the full arch-briefing context already loaded.
# --fork-session means a fresh process — re-approve any tool grants at first use.
# The arch-briefing session is untouched.
```

**Outcome:**
- `[SUCCEEDED]` → 3 named sessions, each with 40k tokens of architecture context baked in.
  Each diverges independently. The briefing cost (token spend on reading the codebase) is
  paid once.
- `[GRANTS NOT CARRIED]` → Expected with `--fork-session`. Re-approve bash/write at the
  first tool use in each feature session. If you need grants to carry, use `/branch` instead
  (same-process fork), accepting that grants WILL carry into all branches.
- `[STALE CONTEXT ON RESUME OF BRIEFING]` → If you later add to arch-briefing and want a
  fourth fork, the earlier three do not retroactively update. Fork lineage is a snapshot at
  fork time, not a live sync.

**Boris Cherny's real-world scale of this pattern (M-confidence):** The creator of Claude Code
publicly runs 10–15 parallel sessions simultaneously — 5 in terminal across 5 git checkouts,
5–10 in browser/mobile. The pre-warm + fork-per-feature approach is one of the primary
patterns enabling that scale.

---

### CS-5 — Claude Code: two truly independent tasks in parallel

**Scenario:** You need a front-end component (touches `src/components/`) and a back-end
endpoint (touches `src/api/`) implemented simultaneously. Zero file overlap. You want both
running at the same time in separate terminals.

**Goal:** Two isolated Claude Code sessions, each in its own worktree, no shared state, both
running simultaneously.

**Tool:** `--worktree` × 2 (manual worktree isolation)

**Steps:**

```
# Terminal 1 — front-end:
claude --worktree fe-component -n task-fe

# Terminal 2 — back-end:
claude --worktree be-endpoint -n task-be
```

```
# What this creates:
# fe-component → isolated checkout at <repo>/.claude/worktrees/fe-component/
# be-endpoint  → isolated checkout at <repo>/.claude/worktrees/be-endpoint/
# Each session is fully independent: own session ID, own git branch, own working tree.
# File edits in one worktree do not affect the other.
```

```
# Verify independence before starting (3-question check):
# Q1: Does task-be need task-fe's output to proceed?  → NO ✓
# Q2: Do they touch any shared files (config, package.json, shared utils)?  → NO ✓
# Q3: Can each task be stated in one sentence with a clear deliverable?  → YES ✓
# All three pass → safe to parallelize.
```

```
# Monitor both from the dashboard:
claude agents     # shows all running background/worktree sessions
```

**Outcome:**
- `[BOTH RUNNING CLEAN]` → Two sessions, zero conflict, each produces diffs in its own
  worktree branch. Merge or cherry-pick after both complete.
- `[SHARED FILE CONFLICT]` → If both sessions edited `package.json` or any shared file,
  git merge will produce a conflict. The worktree isolates the checkout but not the
  semantics — a pre-flight independence check is the only real guard.
- `[CLAUDE.md COST AMPLIFIED]` → Every parallel session loads CLAUDE.md in full. A 300-line
  CLAUDE.md at 10 sessions = 10× the token spend on that file before any prompt. Keep
  CLAUDE.md under 200 lines (soft limit where adherence degrades); use `.claude/rules/<name>.md`
  with `paths:` frontmatter for path-scoped rules that only load when relevant.

**Community origin (M):** Incident.io reported running 4–5 agents simultaneously on UI
improvements, build optimisation, test specs, and backend features — each in separate file
domains. The 3-question independence check above is adapted from their published framework.

---

### CS-6 — Claude Code: escape an error loop / bad model drift

**Scenario:** After 5 back-and-forth corrections, Claude keeps making the same mistake (wrong
import path, repeated bad refactor). You cannot make further progress. The session has good
early context (the correct initial briefing) but bad late context (the accumulated corrections).

**Goal:** Escape the rut without losing the good early context. Do not start completely fresh.

**Tools:** `/rewind` (to restore to a clean point) → `/branch` (to try a fresh approach in a
copy of that clean point)

**Steps:**

```
# Option A — /rewind to a prior checkpoint:
# Press Esc-Esc on an EMPTY input line (no text in the prompt box).
# WARNING: Esc-Esc WITH text in the box silently wipes your draft instead.
# Recover a wiped draft: press Up-arrow.

# The rewind menu appears with 6 actions:
# 1. Restore code + conversation
# 2. Restore conversation only
# 3. Restore code only
# 4. Summarize from here
# 5. Summarize up to here
# 6. Never mind

# Select: "Restore code + conversation" → picks a checkpoint to restore to.
# Choose the checkpoint just BEFORE the first bad correction.
```

```
# Option B — /branch from the current state, then re-prompt cleanly:
/branch fresh-attempt

# In the branch, do NOT continue the conversation thread.
# Instead, use /clear to wipe the tail of the conversation:
/clear

# Re-feed only the good context (the original goal, not the accumulated corrections).
# This is faster than /rewind when the checkpoints are hard to locate.
```

**Official guidance (H):** Anthropic explicitly recommends: *"After ~2 failed corrections,
`/clear` and re-prompt — a clean session with a better prompt almost always outperforms a
long session with accumulated corrections."* (Claude Code best-practices doc.)

**Outcome:**
- `[REWIND SUCCEEDED]` → Session and/or code restored to a clean checkpoint. Proceed from
  there. The 100 most recent checkpoints are available; retention is 30 days.
- `[REWIND LEFT FILES ON DISK]` → Expected behaviour: `/rewind` does NOT revert bash-tool
  file changes (rm/mv/cp), subagent/background-skill edits, symlinks, or external edits.
  Even within its intended scope it intermittently fails (#70727, #18516). **Git is the real
  source of truth.** Run `git stash` / `git checkout -- .` to recover files independently
  of the conversation rewind.
- `[ESC-ESC DESTROYED DRAFT]` → Up-arrow recovers the last draft. If you had already
  submitted and don't want to rewind the conversation, use `/branch` instead.
- `[NO CHECKPOINTS AVAILABLE]` → Session was started with `--no-session-persistence` or
  started before the checkpointing feature shipped. Use `/branch` + `/clear` (Option B).

---

### CS-7 — Claude Code: recover a fork that vanished from the picker

**Scenario:** You forked a session yesterday (`/fork` or `/branch`). Today the picker
(`claude --resume`) does not show it. The session JSONL exists — you just can't find it.

**Goal:** Locate and resume the lost fork.

**Steps:**

```
# Step 1: Widen the picker scope.
claude --resume
# Inside the picker:
# Press Ctrl+A  → show ALL projects (not just current worktree)
# Press Ctrl+W  → show ALL worktrees
# Press Ctrl+B  → filter to current branch only (narrows, not what you want here)
# Paste a PR URL in the search box → jumps to sessions linked to that PR
```

```
# Step 2: If still not visible — grep the raw transcripts:
ls ~/.claude/projects/$(basename $PWD | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-')/
# Lists all session JSONL files for the current project.
# Or search all projects:
find ~/.claude/projects/ -name "*.jsonl" -newer ~/.claude/projects/ -not -path "*/subagents/*" \
  | head -20
```

```
# Step 3: Resume by UUID directly:
claude -p --resume <uuid-from-filename>
# -p = headless/print mode; --resume accepts UUIDs the TUI picker hides.
```

```
# Step 4: Check /status from inside any session to see its name + ID:
/status
# Shows: Login, Model, Context window, Session ID, name, worktree.
```

**Outcome:**
- `[FOUND VIA Ctrl+A]` → Picker was scoped to the wrong project; widening found it.
- `[FOUND VIA GREP]` → Session JSONL exists; `claude -p --resume <uuid>` opens it.
- `[STALE BRANCH ON RESUME]` → Known bug (#48270): resuming a fork sometimes lands on a
  stale branch whose state worsens on each resume. Check `git status` immediately after
  resuming to confirm you are on the right branch/state.
- `[TRULY GONE]` → The JSONL was past `cleanupPeriodDays` (default 30) and was purged.
  Content is not recoverable. Sessions named early survive the picker confusion even when
  the JSONL ages — but deletion is permanent.

---

### CS-8 — Codex CLI: resume after a break / next-day pickup

**Scenario:** You ended a Codex session yesterday mid-task. Today you want to continue exactly
where you left off on the same thread.

**Goal:** Resume the same session ID; full conversation history intact.

**Tool:** `codex resume`

**Steps:**

```
# Most common case — resume the most recent session:
codex resume --last

# If you want to pick from a list:
codex resume
# Interactive picker appears. Navigate, select.

# If you know the session ID:
codex resume abc123-def4-5678-ghij-klmnopqrstuv
```

```
# With an inline follow-up prompt (headless):
codex exec resume --last "Run the integration tests and report any failures"
```

```
# If the picker doesn't show the session (known bug class #9501, #20165):
find ~/.codex/sessions/ -name "rollout-*.jsonl" | sort | tail -5
# The filename format is: rollout-<ISO_TIMESTAMP>-<UUID>.jsonl[.zst]
# The UUID in the filename IS the session ID:
codex resume <UUID-from-filename>
```

**Outcome:**
- `[RESUMED CLEAN]` → Full conversation history restored. Continue the task.
- `[STATE MISMATCH AFTER CRASH]` → Bug #31982: after a hard shutdown, Codex may resume
  from a checkpoint ~2 hours behind actual git/disk state and proceed confidently. **Always
  run `git status` and `git log --oneline -5` before trusting a resumed Codex session
  after any unclean exit.** Verify that Claude's description of what it last did matches
  what git actually shows.
- `[SESSION NOT IN PICKER / FIND OUTPUT]` → Sessions are date-sharded
  (`~/.codex/sessions/YYYY/MM/DD/`). If you are looking for a session from a different date,
  widen your `find` path: `find ~/.codex/sessions/2026/ -name "rollout-*.jsonl"`.

---

### CS-9 — Codex CLI: escape an error loop / try a different approach

**Scenario:** The current Codex session is stuck in a rut — wrong approach, repeated mistake.
You want to try a different implementation strategy without losing the original context.

**Goal:** New session branched from the current one, original untouched, fresh start on the
strategy.

**Tool:** `codex fork`

**Note:** Codex has **no `/rewind`, no `/undo`** (shipped then removed — #9618). `git` is the
only reliable rollback for code changes. For conversation state, forking is the only escape.

**Steps:**

```
# After the session ends (or archive it first):
/archive          # marks session as done; prevents accidental extension

# Fork from the most recent session:
codex fork --last

# Or fork from a specific session ID:
codex fork abc123-def4-5678-ghij-klmnopqrstuv
```

```
# In the forked session, re-state the goal with a better framing:
> The auth refactor we attempted used approach X. That failed because Y.
  Try approach Z instead: [concrete alternative].
```

```
# If you want to fork from a mid-session point (specific turn):
# Codex's "contextual branch" handles this automatically:
# In the TUI, scroll back to the turn before the mistake and edit it.
# Codex auto-creates a contextual branch preserving the original thread.
# (Shipped 0.145.0 — verify your installed version supports it.)
```

**Outcome:**
- `[FORK SUCCEEDS]` → New session with the full prior context; original archived and
  untouched. Proceed with the better approach.
- `[FORK COST WARNING]` → The public `thread/fork` RPC **copies** rollout history (not
  a reference fork). For very large sessions, expect disk cost proportional to session
  size. A reference-based `history_base` backend path exists in the source but is not
  confirmed as the default for JSONL stores.
- `[CODE STATE WRONG AFTER FORK]` → Forking branches the *conversation*, not the git
  state. If the original session made bad file changes, those changes are still on disk.
  Run `git stash` / `git checkout -- .` before starting work in the forked session to
  get a clean file state.

---

### CS-10 — Codex CLI: parallel tasks (no native daemon)

**Scenario:** You want to run two Codex sessions simultaneously — one on a front-end component,
one on a back-end endpoint.

**Goal:** Two truly parallel Codex sessions, each tracked by its own session ID, no
interference.

**Tool:** tmux (or multiple terminals) + `codex` per pane

**Note:** Codex has no native background-session daemon, no `codex agents` dashboard, and no
`--worktree` equivalent. Third-party wrappers (herdr, Codeman, dmux for Claude Code) exist
because of this gap. The community workaround is manual terminal orchestration.

**Steps:**

```
# 1. Open two terminal panes (tmux example):
tmux new-session -s codex-work
tmux split-window -h    # split into two panes

# 2. Pane 1 — front-end task:
codex "Implement the UserCard component in src/components/UserCard.tsx.
       Props: { name, avatar, role }. Use the existing Button and Avatar components."

# 3. Pane 2 — back-end task:
codex "Add a GET /api/users/:id endpoint in src/api/users.ts.
       Return { id, name, role }. Use the existing db.query pattern from src/api/posts.ts."
```

```
# 4. Each pane runs its own Codex session with its own rollout file.
# Note the session IDs (shown in /status or in the rollout filename) if you want to resume later.
# Use /rename in each pane to give them human-readable names.
```

```
# 5. After both finish — merge:
git merge codex-be     # if each worked in its own branch
# Or simply review diffs per file since file domains were independent.
```

**Outcome:**
- `[BOTH RUNNING, NO CONFLICT]` → File domains were independent; merging is straightforward.
- `[MERGE CONFLICT]` → Shared file was edited by both sessions (e.g., a shared type file,
  tsconfig). Resolve manually. Next time, scope each session's instructions to its file
  domain explicitly and mention which shared files are off-limits.
- `[SESSION LOST AFTER CRASH]` → `find ~/.codex/sessions/ -name "rollout-*.jsonl" | sort | tail -5`
  and `codex resume <UUID>`.

---

## 5. Tips (Anthropic + community + OpenAI — enriched)

### When to fork vs. fresh vs. resume

- **Fork to explore risk without losing the thread.** Official Claude docs explicitly
  recommend `/branch` or `--fork-session` over `/rewind`'s Summarize options for
  "try a different approach while preserving the original session intact." (H)
- **After ~2 failed corrections: `/clear` and re-prompt.** Official Claude best-practice:
  "a clean session with a better prompt almost always outperforms a long session with
  accumulated corrections." (H)
- **After 3–4 `/compact` cycles quality visibly degrades.** Get a manual summary, `/clear`,
  re-feed the summary as genuinely fresh context. (M — popularaitools.ai)
- **Fresh for a PIVOT; resume/continue for a CONTINUATION.** For a genuine context switch
  (new unrelated goal), fresh + hand-written brief beats resume — raw resumption carries
  stale buried context and the token tax is real. It does NOT hold when the next step
  directly continues the same files (Anthropic blog: continuing avoids re-reading
  recently-touched files; fresh is explicitly slower and costlier there). (M/H mixed)
- **Codex: resume for "same task, next day"; fork for "different approach".** The
  danielvaughan.com framework distils to this one line and matches the official decision
  table. (M)

### Naming and recovery

- **Name sessions immediately** (`claude -n`, `/rename`, Ctrl+R in picker). The
  auto-generated display name is NOT a reliable resume handle. An unnamed session is
  findable only by scrolling. (H)
- **Widen the picker** with `Ctrl+A` / `Ctrl+W` / `Ctrl+B` before assuming a session
  is gone. Default scope is the current worktree only. (H)
- **Paste a PR URL** into picker search to jump to the session that created it, or use
  `claude --from-pr <n>`. (H)
- **Codex:** sessions are date-sharded under `~/.codex/sessions/YYYY/MM/DD/`. Recursive
  `find` + `codex resume <UUID>` is the recovery path when the picker fails (documented
  bug class: #9501, #20165, #21619, #19517). (H)

### Parallel session hygiene (community — M)

- **One git worktree + one tmux pane + one agent instance per task** is the dominant
  real-world pattern. Tools like `dmux` (formkit/dmux) automate "new pane + new worktree +
  launch agent."
- **Define each agent's deliverable AND output location before starting.** Multiple agents
  running without clear deliverables produce overlapping, conflicting changes.
  (community consensus — codeagentswarm.com, shareuhack.com)
- **CLAUDE.md amplification:** every parallel Claude Code session loads CLAUDE.md in full.
  10 sessions × 200-line CLAUDE.md = 10× the token spend on that file before any prompt.
  Use `.claude/rules/<name>.md` with `paths:` frontmatter for scoped rules.
- **Configure Stop + PermissionRequest hooks** to send notifications (Slack, terminal
  bell) so you don't have to watch 10+ tabs manually. (H — hooks docs; M — community
  adoption of this pattern)

### Cost discipline

- **`/subtask` (Claude) reuses the parent prompt cache** — cheaper than a fresh subagent;
  delegate verbose ops (test runs, log grep) to keep their tokens out of the paid main
  context. But Agent Teams cost ~7× in plan mode. (H)
- **Edit-and-regenerate, don't send follow-up corrections** — follow-ups stack permanently
  and replay on every resume (compounding the thinking-signature tax).
- **Codex `--ephemeral`** for zero-footprint CI runs. (H)
- **Do not trust Codex `model_context_window` / `model_auto_compact_token_limit`** as cost
  levers — bugs #16068, #19185, #16140 show them broken/unreliable. (H — the bugs exist)
- **The measurement asymmetry is structural:** Anthropic ships `/usage`, a dedicated costs
  doc, and a 5-driver taxonomy. OpenAI ships no equivalent quantified fork/resume cost
  documentation for Codex. Every Codex cost number in circulation comes from third-party
  tools mis-parsing rollout files (ccusage) or AI-generated wikis. (H — meta-finding)

---

## 6. Gotchas — do not sanitize

- **Rewind leaves files on disk.** `/rewind` "Restore code" does NOT revert bash-tool
  changes, subagent/background-skill edits, symlinks, or external edits — and even within
  scope it intermittently fails (#70727, #18516). Git is the real source of truth.
  (Documented gaps H; reliability failures M/bug-sourced)
- **Esc-Esc is a draft-destroyer.** With text in the input, double-Esc silently wipes your
  draft instead of opening rewind. Recover via Up-arrow. Open issues: #1493, #16176, #43717.
  (H)
- **Forks can vanish from the picker.** #23692 (compaction-fork never appears in `/resume`,
  closed not-planned), #27339 (forks "sometimes" disappear), #48270 (resume lands on stale
  branch worsening each resume). Fallback: `/status`, grep JSONL, `Ctrl+A`. (H)
- **Resume of a thinking-heavy session is expensive.** Bug #42260 (not-planned): resuming a
  24h/480-message session replays ~156k input tokens before you type, ~25% (~38.8k) is
  invisible thinking-signature overhead. Follow-up corrections compound this on every resume.
- **Codex stale-resume after crash.** #31982: Codex resumed ~2h20m behind actual git/disk
  state and proceeded confidently — risking duplicate commits / overwritten work. Run
  `git status` / `git log` before trusting any resumed Codex session after an unclean exit.
  (M — single report)
- **`fileCheckpointingEnabled` does not verify.** This setting name (from older notes) does
  not appear in current Claude Code settings or checkpointing docs. Checkpointing is
  documented as automatic and unconditional. Treat the setting name as stale until verified.
- **Codex `/undo` was removed.** It shipped, got pulled ("didn't get much use, and its
  design caused problems" — maintainer, #9618). Stale invocations print "No ghost snapshot
  available to undo." Use `codex fork` to escape bad state; use git to revert files. (H)

---

## 7. Head-to-head comparison

| Axis | Claude Code (v2.1.212+) | Codex CLI (0.146.0) |
|---|---|---|
| **Session fork** | `/branch` (in-session, same process) · `--fork-session` (new process) · `/fork` (→ background session). TUI-first. | `codex fork [ID]/--last/--all` — standalone subcommand, headless-first. |
| **In-session branch** | `/branch [name]` — copy transcript, switch running process to it. | No in-session fork command; edit-a-prompt auto-creates a **contextual branch** (0.145.0). |
| **Rewind / undo** | `/rewind` + Esc-Esc; 6-action checkpoint menu; snapshots before every prompt. | **None.** `/undo` shipped then removed; `/rewind` unshipped feature request. Use git. |
| **Auto-branch** | Not on edit; checkpoints are automatic per-prompt (code, not conversation-branch). | **Yes** — editing an earlier prompt / retrying a buffered turn auto-forks the conversation. |
| **On-disk store** | `~/.claude/projects/<slug>/<id>.jsonl` (+ nested subagent transcripts). | `~/.codex/sessions/YYYY/MM/DD/rollout-<ts>-<uuid>.jsonl[.zst]` (date-sharded). |
| **Fork cost model** | Full transcript copy on `/branch`; new-process fork re-approves permissions. No reference-fork. | Public `thread/fork` RPC **copies** history (bounded by turn IDs); a reference-based `history_base` path exists but is backend-opt-in, likely dormant for JSONL store. |
| **Resume** | `--continue`/`--resume`/`--from-pr`; resume-from-summary dialog on big idle sessions. | `codex resume [ID]/--last/--all/--include-non-interactive`; `codex exec resume` headless. No `/resume` in TUI. |
| **Navigation** | Rich picker (Ctrl+A/W/B, PR-URL search, preview, rename); `claude agents` background dashboard; `--teleport`/`--cloud`/`remote-control`. | `codex resume`/`fork` pickers; `codex cloud` for cloud chats. No agent dashboard, worktree auto-isolation, or teleport/remote-control. |
| **Parallel native support** | `--worktree` + `claude agents` dashboard + `/fork` background sessions. TUI-first orchestration. | Separate terminal panes / tmux windows. Third-party tools (herdr, Codeman) fill the gap. |

---

## 8. Cross-machine / remote (Claude Code only)

Three separate mental models — do not conflate:

| Command | Direction | What it means |
|---|---|---|
| `--teleport` | cloud → local | Pulls a claude.ai/code cloud session into a *new local copy*. One-way; local work does not sync back. Needs clean git + branch pushed. |
| `--cloud` | local → cloud | Creates a *new* cloud session. You cannot push an existing terminal session up (except via Desktop "Continue in"). |
| `remote-control` / `--rc` / `/rc` | local (steered from web/mobile) | Exposes a *local* running session to be steered from web or mobile. Execution stays local. |

Codex has no teleport / remote-control equivalent. `codex cloud` handles cloud chats only.
Native SSH support lives in the separate **Codex App** (alpha track, not the `codex` CLI binary).
Standard CLI workaround: tmux + ssh, or a third-party wrapper.

---

## 9. What would change this analysis

1. **Version drift (both tools).** The entire Claude Code fork story hinges on **v2.1.212**.
   A reader on an older build has `/fork` and `/subtask` inverted. Codex stable is **0.146.0**;
   0.147.0 in daily alpha. Re-verify both version stamps before citing.

2. **`history_base` reference-forking (Codex).** If the reference-backed fork path becomes
   default for the JSONL store, the "fork copies history / not O(1)" cost conclusion flips.

3. **`fileCheckpointingEnabled` gate (Claude).** Does not verify against live docs.
   If it turns out to still gate checkpointing, "checkpointing is unconditional" is wrong.

4. **Rewind-reliability bugs (#70727, #18516).** If Anthropic closes this cluster, the
   "leaves files on disk" gotcha softens from a standing defect to a fixed one.

---

*Sources verified 2026-08-20: code.claude.com/docs (H) · shareuhack.com parallel-workflow-guide
(M) · codex.danielvaughan.com session-lifecycle (M) · claudekit.app/blog/fork-explained (M) ·
github.com/anthropics/claude-code issues cited inline (H — existence of bugs, not resolution) ·
github.com/openai/codex issues cited inline (H — same) · Boris Cherny parallel-workflow
observation via techtimes.com (M — attributed but secondary)*
