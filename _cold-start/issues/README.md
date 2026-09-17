# _cold-start/issues — the known-defect category (flat)

Known-but-not-yet-fixed defects — a fix manual, not just a defect log: once a fix is known,
it lives in the card body too. A category inside the shared card vault (`_cold-start/`),
FLAT — at the same level as `card/`, `routines/`, `archive/`, no nested subfolders. Same
mechanism as cold-start cards — frontmatter is truth, folder is state, git-pull is
transport — different lifecycle: **the fold**, not an open/parked/archive state machine.

A card's life runs one of three paths: known-recurring from the start → straight to
`routines/` · assumed one-shot, stays solved → `archive/` · assumed one-shot, recurs later →
`archive/` → `routines/`. A card that graduates into `routines/` keeps its `ISS.` filename
and catch-date (read as "first seen"), never renamed to `RT.`. Deliberately-deferred
(parked) is not a folder or a `status:` field — it's a `parked` entry in the card's `assoc:`
list plus a body note; the card stays right here in `issues/`.

Filename `ISS.<slug>.<YYYY-MM-DD>.md`; the date is the sort radar.

Law: `~/reposoma/raw.guides/cold-start-card/GUIDE.md` (thin signpost) +
`~/reposoma/raw.guides/cold-start-card/res/issue-card.md` (the issue-card subchapter — flat
model + the fold, full detail), `[ISSUE-DRAFT]` pending majkee's gavel as of 2026-09-17.
Written by the `/issue-card` skill. Supersedes the standalone `~/reposoma/_issues/` vault —
that path stays until the new shape is proven, then is removed.
