---
title: Help tree — in-TUI browsable help for the runbook browser (`session/runbook.py`)
chapter-of: runbook
---

# Help tree

> **DRAFT — pending majkee's gavel (2026-09-17).** Written by @Trajectory against a
> verified build (files confirmed on disk, both syntax checks re-run independently, `?`
> keybind confirmed genuinely new — not self-locked, not yet in the Manifest below until
> gaveled).

Use the help tree when you're inside the `rb-open` TUI and need a quick answer — commands,
keys, or board semantics — without leaving the session you're browsing. It replaces "scroll
`rb-help`'s flat panel before you start" with a small, in-place lookup you reach for mid-session.
Converged from the same pattern used by the phone-side `agentive-help` brief (Termux lookup
viewer) — same shape (small tree of short notes + a popup that returns you exactly where you
were), different rendering layer (a curses subwindow here, not a tmux popup) and a different
audience (a desktop/terminal operator or agent, not a phone keyboard).

## Where it lives

```
~/ia-sync/zsh/session/help/
  commands/HELP.md
  keys/HELP.md
  board/HELP.md
```

One level of theme folders, each holding exactly one file, always named `HELP.md` — not a
per-topic tree. A future theme is a new folder alongside these three, still one `HELP.md`
inside. Authored on the surgical table (`~/ia-sync/zsh/session/`); `deploy.sh` spreads it to
the live `~/.config/zsh/session/` tree same as every other file in that scope.

## The `?` key

Inside `rb-open`'s TUI, `?` opens a boxed, centered overlay (≈80% of the terminal, not
fullscreen) showing the current theme's `HELP.md`, starting on `commands`. **Left/Right**
arrows cycle themes with wraparound (`commands → keys → board → commands`) — the same
lateral axis the rest of the TUI already uses for expand/collapse and pane movement, so
Up/Down keeps meaning "scroll this body of text" inside the overlay too. Dismiss with
`q`/`Q`/Esc: the overlay is drawn on a separate `curses.newwin`, mutates no outer-loop state
(cursor, focus, scroll offsets, expanded set), and the main loop's next full redraw wipes it
— you land back exactly where you were. Same UX law as the `agentive-help` tmux popup
("closes on keypress, returns you to exactly where you were"), enforced by a different
mechanism (state isolation + full redraw, not a subprocess popup).

One known, harmless behavioral difference from `board_view`/`buffer_view`: those call
`screen.get_wch()` on the same object as the main loop, inheriting its 1-second tick
(`curses.error` used as a timeout signal for periodic truth-refresh). The help overlay's own
window blocks on keypress instead — correct here, since `HELP.md` content is static and
doesn't need a live-refresh tick.

## Adding or editing a note

Edit the theme's `HELP.md` directly — plain markdown, short prose + fenced command blocks,
no frontmatter, sized for a popup read (not a manual). `board/HELP.md` points at
`~/reposoma/raw.guides/runbook/res/presence-board.md` for the full law rather than copying
it — point, never copy, same discipline as every other vault in this family.

## Relation to the CLI panel

`rb-help` (the flat `cat`-heredoc panel in `session/runbook.zsh`) is unchanged and stays as
the fallback for anyone who runs it before ever opening the TUI — it now carries one added
line pointing at `?` for the browsable version. Additive only; nothing was removed.

## Manifest row (once gaveled)

Add to the runbook GUIDE's `## Manifest`:

```
- `res/help-tree.md` · chapter · DRAFT — in-TUI browsable help tree for session/runbook.py (`?` key)
```
