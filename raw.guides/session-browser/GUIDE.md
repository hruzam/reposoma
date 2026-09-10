---
title: Session browser — rb-* toolset (TUI, bed browser, presence-board client)
scope: session-browser
audience: operator + agent
machine: both
verified: 2026-09-09
verify_cmd: "rb-selftest && rb-board"
---

# Session browser — the `session/` scope's instruments

_The machine-layer client family for session work: a TUI that browses `.dev/session/`
bed trees, and the presence-board client. Built in session `runbook-tool-00`
(nablarva bed, 2026-09-04→09, @Trajectory cSharp, majkee gavels). **Trust disk over
doc:** on any conflict about what a command DOES, the source script wins and this
guide is the bug._

## What and where

| piece | path |
|---|---|
| source (edit HERE) | `~/ia-sync/zsh/session/` — `base.zsh` · `keyboard.zsh` · `runbook.zsh` · `board.zsh` · `runbook.py` |
| live (never edit) | `~/.config/zsh/session/` via `deploy.sh` |
| wiring | `config.<machine>.zsh` exports `RB_ROOT` + sources `session/base.zsh` |
| board law | `raw.guides/runbook/res/presence-board.md` — gaveled 2026-09-09; this guide documents only the CLIENT |
| own-attachment state | `~/.local/state/session-board/` — machine-local, never synced |

## Verbs (keyboard P1/P3/P4)

```
rb-open [root]          launch the TUI browser
rb-pick [root]          fzf bed picker → prints path
rb-board                render the presence board (* = own attachments)
rb-mark [bed] [note...] attach a session to the board (bed defaults to $PWD)
rb-unmark [bed|id]      detach own record(s); no arg = all own on this machine
rb-selftest             sandboxed selftest — zero side effects, PASS/FAIL lines
rb-help                 help panel · rb-keys — alias listing
```

Root resolution for `rb-open`/`rb-pick`: explicit argument → `$RB_ROOT` (the default
bench, set per machine in config) → walk-up from `$PWD` to a `.dev/session/`. Any
tree works: `rb-open ~/ia-sync/.dev/session` browses ia-sync's beds.

## TUI map

D1 (left) = beds: `[state] slug` — `?` no RUNBOOK · `·` no STATUS · `→` STATUS
present · `!` `in_flight:` not canonical `none` · `~` lowercase-filename drift ·
`●` bed has a valid local-host board attachment.
D2 (right) = selected bed: fixed strip (`next:` + raw `in_flight:` when flagged),
then sections R2 STATUS · R5 `_bus/` · R1 RUNBOOK · R3 bed files · R4 `raw/`.

```
↑↓ scroll · Tab focus D1↔D2 · j/k node · J/K group jump · Enter/Space fold ∣ read
1–5 section jump · F fold RUNBOOK · e $EDITOR (GUI editors detach; TUI stays)
B board modal · m/u attach/detach selected bed · b buffer pane · p collect path
r reload · q/Esc quit (collected paths print to scroll-back)
Reader: ↑↓ PgUp/PgDn g/G · e edit · q/Esc/← back
```

Auto-reload: 1 s tick, mtime-gated (STATUS, `_bus/`, board). WRITELN law
everywhere: text wraps, never scrolls sideways.

## Truth-display rules (the reader's contract with you)

- `next:` supports flat and quoted values AND YAML block scalars (`>-`, `|`, …) —
  the folded instruction is shown, not the marker.
- `in_flight:` is read STRICTLY: only canonical `none` (or empty) is idle. Anything
  else flags `!` and the raw value is displayed in the strip so you see *why* —
  the reader never guesses an author's meaning. Write canonical `none`.
- Invalid or unparseable data renders **unknown** (`?`, `—`, malformed rows with
  reasons) — never silently healthy, never hidden.
- **Gate glyphs are observational presence facts, nothing more.** `→` means "a
  STATUS file exists" — it promises neither activity nor an unmet gate; `!` means
  "in_flight: is not canonical none" — not proof of live work. The browser never
  claims or infers closure: finished-means-pruned stands (a closure-receipt
  proposal was declined law-side, bus POINT 34, 2026-09-10 — reopenable on
  concrete need). Reach the STATUS and cited closing evidence yourself; the
  glyph only tells you the file is there to reach.

## Presence-board client (advisory — informs, never authorizes)

The contract is law-side: `raw.guides/runbook/res/presence-board.md`. Client facts:

- `rb-mark` composes a `presence-board/v1` record, **self-checks it against the
  grammar, and refuses to write an invalid record** (e.g. a bed outside `~` cannot
  be `~`-anchored). Exclusive create; collision → fresh ID retry.
- Ownership: only records this machine's client created (remembered in own-state)
  can be detached without an explicit id. Foreign records are never touched;
  orphan removal is an explicit human act.
- Staleness (>24 h) renders dim — display policy only; age proves nothing.
- Env knobs: `RB_BOARD` (board dir; default `~/reposoma/_active`) · `RB_SEAT`
  (declaring seat; default `majkee`) · `RB_STATE` (own-state dir; selftest uses it).
- Transport is git: cross-machine presence lags until pull — the board is not a
  real-time census, by contract.

## Troubleshooting

- `rb-open: command not found` → the shell predates deploy: `cd ~/ia-sync && git
  pull && bash deploy.sh`, then open a NEW terminal.
- Board empty on the other machine → reposoma not pulled there yet (git lag).
- `e` opens nothing → check the message line: it names the editor and the outcome
  (`→ subl: file` = detached GUI; `vi exited N` = terminal editor failed).
- Anything odd → `rb-selftest` first: sandboxed, zero side effects.
