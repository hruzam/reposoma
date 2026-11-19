---
kind: cold-start-card
date: 2026-11-19
brand: claude
seat: trajectory
project: nablarva
projects: [nablarva, ia-sync]
root: ~/unikuklatrix/nablarva
commit: see git log -1 on core (bed-move commit, 2026-11-19)
task: Continue the personal session-window helper (tmux views + per-CLI metadata) on office from its moved substrate bed.
resume: claude --agent trajectory → /cold-start-card   (cwd ~/unikuklatrix/nablarva)
model: opus
dedicated: trajectory
recommend: Confirm the provisional gate with Majkee first; then one probe — the installed Claude statusLine stdin payload — before any helper code.
runbook: ~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/STATUS.md
pointers:
  - ~/unikuklatrix/nablarva/AGENTS.md
  - ~/unikuklatrix/nablarva/.dev/session/pulse.md
  - ~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/raw/goal-substrate.2026-11-13.md
  - ~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/raw/claude-export.md
  - ~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/raw/handoff.senior-advice.trajectory.2026-11-14.md
  - ~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/raw/live-tmux-setup.2026-11-13.md
  - ~/ia-sync/claude/hooks/statusline.sh
source_host: home / hruzam
destination_host: office (verify hostname on entry)
---

# Office re-entry — session-window X0 substrate

Transfer pointer only. **STATUS owns the position** (one-authority rule). No RUNBOOK exists
yet; the `runbook:` key points at STATUS until one is authored.

## What moved

`~/ia-sync/.dev/session/helper-utils-00-tmux/raw/*` → `~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/raw/`
verbatim (sha256 checked). ia-sync keeps a `MOVED.md` tombstone. Raw files still cite
ia-sync-relative paths (e.g. `zsh/session/ovitmugen.*`) — those resolve against `~/ia-sync`.

## Not transported (home-local)

- Home tmux session `helper-utils-00-tmux` and its `--claude` / `--codex` grouped views.
- `raw/tmux-comfort.conf` as *loaded* state — office tmux server has none of it.
- Session resumes are home-local: Claude `d1ca16e9-…`, Codex `01a1d43b-…`. Start fresh on office.

## First tool shot

```sh
hostname; git -C ~/unikuklatrix/nablarva status -sb; git -C ~/unikuklatrix/nablarva log --oneline -3
cat ~/unikuklatrix/nablarva/.dev/session/session-window-X0-substrate/STATUS.md
claude --version; tmux -V
```

## Lesson

The native Claude status line truncated in practice while the docs promise multiline —
verify the installed CLI's payload before designing around either account.
