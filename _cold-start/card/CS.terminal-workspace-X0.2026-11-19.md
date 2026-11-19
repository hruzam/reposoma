---
kind: cold-start-card
date: 2026-11-19
brand: claude
seat: claude-colleague
project: nablarva
root: ~/unikuklatrix/nablarva
commit: 3bbbf08 (core)
task: terminal-workspace X0 — independent review of proposed X1 done (RETURN 01 = REVISE); awaiting Cartan VERDICT + Majkee X0/X1 decisions
resume: claude --agent trajectory → "Read ~/unikuklatrix/nablarva/.dev/session/terminal-workspace-X0-approaches/STATUS.md and follow it"
model: opus
dedicated: cartan (controller, next action); claude-colleague only on a new POINT
recommend: Don't act from this card — STATUS owns next. Cartan verifies RETURN 01 first; the X1 revision needs Majkee's call.
runbook: ~/unikuklatrix/nablarva/.dev/session/terminal-workspace-X0-approaches/RUNBOOK.md
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/terminal-workspace-X0-approaches/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/terminal-workspace-X0-approaches/_bus/01.claude-colleague.return.md
  - ~/unikuklatrix/nablarva/.dev/session/terminal-workspace-X0-approaches/raw/handoff.claude-colleague.2026-11-19.md
  - ~/unikuklatrix/nablarva/.dev/session/terminal-workspace-X0-approaches/raw/handoff.cartan.2026-11-17.md
  - ~/unikuklatrix/nablarva/.dev/session/terminal-workspace-X0-approaches/CS.terminal-workspace.office.2026-11-19.md
---

# terminal-workspace X0 — claude-colleague re-entry

Transfer pointer only. **STATUS owns the position.** This card carries no next action.

- **First step on office:** `git -C ~/unikuklatrix/nablarva pull` and `git -C ~/reposoma pull`
  (plain pull, never `--rebase`, per L12). Then read the STATUS above.
- **Cartan's own transfer card** is bed-local (pointer 5), so read that for the controller path.
  This card covers the Claude seat's side.
- **What this seat produced:** RETURN 01 (review, REVISE) and a handoff that distils the proposals
  and three open operator decisions. Both are claims until Cartan's VERDICT.
- **Re-entering this seat:** only against a new numbered POINT from Cartan. Never self-assign from
  the handoff.
- **Lesson:** `cat -n` one file at a time. Multi-file numbering continues across files, and that
  corrupted citations once (RETURN M9, retracted before handoff).
- **Not transported:** the doc downloads in the home Claude scratchpad. The RETURN cites the
  source URLs, so re-fetch if needed.
