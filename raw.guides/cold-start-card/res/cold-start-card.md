---
title: Cold-start card — CS + routine detail (schema, drain lifecycle, Codex brand note)
chapter-of: cold-start-card
---

# cold-start-card — CS + routine detail

_Relocated from the single-file GUIDE (2026-09-17, session `cs-card-sys-update`, GUIDE
restructure into thin signpost + subchapters) — see the restructure banner at the top of
`../GUIDE.md`. This content is the pre-existing gaveled-2026-08-27 canon; only its file
location changed here, not its wording or meaning._

## When do I reach for this

- **Closing or pausing a session** that a later session (any brand, any host) must
  re-enter → write a **CS card** into the vault via your brand's `cold-start-card` skill.
- **Capturing a recurring task's glue** (routine you re-run, never "finished") → write an
  **RT card** into `routines/`.
- **Re-entering** → browse the vault (`cs-palette` once built, or `ls`/grep), read
  frontmatter first — it is the source of truth — then follow `resume:` / `prompt-0`.

## CS-card frontmatter — the field-by-field schema

```yaml
---
kind: cold-start-card            # cold-start-card | routine
date: 2026-08-27
brand: claude                    # claude | codex
seat: atlas-ui                   # card author (seat/agent name)
project: freya                   # origin project — registry key (temple-project-map)
projects: [freya, reposoma]      # optional — cross-project runs name the whole span
root: ~/www/elements-factory/freya   # project root, whole path
commit: abc1234 (core)           # short hash (branch)
task: <one line>
resume: <command + flags>        # e.g. claude --agent atlas-ui → /cold-start-card
model: sonnet                    # thinking level the task deserves:
                                 #   claude: fable | opus | sonnet | haiku
                                 #   codex:  sol | terra | ...
dedicated: <seat/agent the author recommends for the next incarnation>
recommend: <author's one-line steer>
runbook: ~/<project>/<session-root>/<program>-<NN>-<phase>/RUNBOOK.md   # optional —
                                 # point to the LIVE session RUNBOOK; the _runbook/
                                 # bench copy is a draft/template after promotion
pointers:                        # where depth lives — point, never copy
  - ~/reposoma/pulse.atlas.md
---
```

- Skip keys that are genuinely empty; never invent values.
- `model` + `dedicated` + `recommend` = the author's routing assessment — the human reads
  these in the palette (brick D2) before launching anything.

## Body — the continuity layer

Free prose after the frontmatter. The card alone may be tiny, but **card + its pointers
must be sufficient**. Add whichever apply: pending tasks (order matters) · state
pointers (dev-journals, pulse entries, staged files) · first-step instruction · session
advice (one lesson) · cleanup/hygiene debts. Point, never copy.

## Routine cards — RT frontmatter, and the two origins

A routine card is dateless (`RT.<slug>.md` — a date would lie, it recurs) and never
archives. It carries the same shared frontmatter contract (`../GUIDE.md`) with
`kind: routine`, plus one addition new to this restructure:

```yaml
---
kind: routine
origin: intended                 # intended | issue
from_issue: ~/reposoma/_cold-start/issues/ISS.<slug>.<date>.md   # only when origin: issue
...                               # the rest of the shared contract, as above
---
```

- **`origin: intended`** — born a routine from the start; filename is `RT.<slug>.md`.
- **`origin: issue`** — graduated out of an issue card that turned out to recur.
  **A graduated card KEEPS its `ISS.<slug>.<YYYY-MM-DD>.md` filename and its catch-date**
  when it moves into `routines/` — it is NOT renamed to `RT.`. The `ISS.` prefix stays as a
  grep-visible origin radar ("this routine started life as a caught defect"), and the date
  stays as the "first seen" mark, not a lie — the file simply lives in `routines/` now
  instead of `issues/` or `archive/`.
- The fold mechanism itself — which issues graduate, when, and why — is issue-card
  territory, not routine territory: see `res/issue-card.md`.

## Read-state — drain by default (the CS lifecycle)

1. **Write** — author fills the contract from the live session, shows majkee (interactive
   seats confirm before writing; see each skill).
2. **Read** — next incarnation reads frontmatter → pointers → body → fires `resume:` /
   `prompt-0`.
3. **Drain** — the reader who consumed a CS card moves it `card/` → `archive/`
   (Cinderella). A card meant for more readers carries `leave: for more readers` and
   stays until all have drained it. RT cards never move.

## One authority — boundary with the session beds (STATUS/RUNBOOK canon)

The 2026-08-27 canon's motivating failure was a bed where `status.md`, `pulse.md`, and a
**CS card** each claimed the next action — *"two files are allowed, two authorities are
not"* (`raw.guides/runbook/GUIDE.md`). The law for cards:

- **A cold-start card is a transfer/closure POINTER, never a second doing-state.**
- If a live session bed exists (a `STATUS.md` for an open gate): the card names the bed
  in `pointers:`, and `resume:`/`prompt-0` re-enter it — **the card carries NO competing
  next-action order; STATUS owns the position.**
- A card may carry its own next-action/repair-queue only when NO live bed exists —
  session closed clean, or glue for work that has no runbook.
- Seam test on every body line: would it still be true after the gate closes? → it
  belongs in flag/pulse/guide, not the card. Does it die with the gate? → it belongs in
  the bed's STATUS, not the card. The card holds what OUTLIVES the session but serves
  re-entry: pointers, resume, routing assessment, lessons.

## Brand note — Codex (read this as contract, not culture)

- Destination: `~/reposoma/_cold-start/card/` (expand `~` to the user home; both hosts
  resolve to `/home/hruzam`). Routines: `~/reposoma/_cold-start/routines/`.
- Write the shared frontmatter block first, exactly as specified above. Append
  Codex-specific evidence keys after it. Do not nest the shared keys.
- Keep claims distinguishable as observed / reported / inferred in the body.
- Do not stage or commit the card implicitly; report the created path. Committing
  reposoma is the operator's or an authorized seat's action — but note the card is
  invisible cross-machine until committed.
- A rollout JSONL is a track file: point to it, never copy transcript content.
