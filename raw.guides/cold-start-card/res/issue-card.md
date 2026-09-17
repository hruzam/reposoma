---
title: Issue card — the flat vault, the fix-manual, and the fold to routines
chapter-of: cold-start-card
---

# issue-card `[GAVELED · REVIEW-AFTER-USE]` — flat vault, fix-manual, the fold

> **`[GAVELED · REVIEW-AFTER-USE]`** (alias `[PROVISIONAL]`; status legend in the parent
> `GUIDE.md`) — **In force: follow this as canon, it is not a draft** (majkee green-light
> 2026-09-17, session `cs-card-sys-update`). But it is new and unproven: re-audit after its
> **first real use** (a real issue card written + a real fold performed), and adjust then by
> the audit-always rule *without* a fresh gavel. This version REPLACES the earlier nested
> `issues/{open,parked,archive,reactions}` subtree and the `IR.<slug>.md` reaction-card type
> entirely — both are deleted from the design, not just superseded in prose.

## The model, in one line

**An issue card is memory — a fix manual.** It holds the defect AND (once known) how it
was fixed, in the card body, so a later agent looks the fix up instead of re-deriving it.

## The vault shape — flat, no nested state subtree

```
~/reposoma/_cold-start/
├── card/       CS.<slug>.<date>.md    live session glue        (cold-start category)
├── issues/     ISS.<slug>.<date>.md   caught issues — FLAT, no open/parked/archive/
│                                       reactions subfolders
├── routines/   RT.<slug>.md           recurring, born a routine (origin: intended)
│               ISS.<slug>.<date>.md   recurring, GRADUATED from an issue (origin: issue —
│                                       keeps its ISS. name + its catch-date as "first seen")
└── archive/    CS.* and ISS.*         drained CS cards + solved one-shot issues (shared
                                       with the cold-start category, not issue-only)
```

`issues/` sits at the SAME level as `card/`, `routines/`, `archive/` — a flat category
folder, not a state machine of its own. There is no `issues/open/`, no `issues/parked/`,
no `issues/archive/`, no `issues/reactions/`. Folder-as-state still holds — but the state
being tracked is "which top-level vault folder is this card in," same as every other
category, not a private open→parked→archive progression underneath `issues/`.

## The fold — the core mechanism, three lifecycle paths

Every issue card's life runs one of three paths:

1. **Known-recurring from the start** (structural — e.g. a tailscale-mount defect class
   that will keep happening by its nature) → the issue card goes **directly to
   `routines/`**, no detour through `issues/` or `archive/`.
2. **Assumed one-shot, stays solved** → once fixed, `mv` the card `issues/` → `archive/`.
   Done — it never recurs, its resolution is on record.
3. **Assumed one-shot, but RECURS later** → pull the card back out of `archive/` and `mv`
   it into `routines/`. The recurrence is what proves it was never really one-shot.

All three paths land in only two destinations, `routines/` or `archive/` — `issues/` is a
waiting room, not an endpoint.

## Origin signal — dual-surface (radar + manifest)

A card that graduates to `routines/` via path 1 or 3 above:

- **Keeps its `ISS.<slug>.<YYYY-MM-DD>.md` filename** — never renamed to `RT.`. Grep-visible
  origin radar: `RT.*` in `routines/` = born a routine, `ISS.*` in `routines/` = graduated
  from a caught issue.
- **Keeps its original catch-date** in the filename, now read as "first seen," not a lie —
  the card moved folders, its history didn't change.
- **Gains `origin: issue`** in frontmatter (`origin: intended` for a card born a routine),
  optionally with a `from_issue:` pointer for cards that split into a fresh routine card
  rather than being moved wholesale. See `res/cold-start-card.md` for the routine-side
  frontmatter shape.

This is the vault's existing dual-surface philosophy applied to provenance: filename for
zero-read matching, frontmatter for cheap metadata scan — same pattern as the sort-key and
`defect:`/`assoc:` split below.

## ISS frontmatter — the schema

Filename `ISS.<slug>.<YYYY-MM-DD>.md`. Same flat, `~`-anchored shared contract as every
category (`../GUIDE.md`), `kind: issue-card`, plus:

```yaml
---
kind: issue-card
date: 2026-09-16                 # also the filename date — the sort radar AND, once
                                 # graduated, the "first seen" mark
brand: claude
found_by: trajectory             # issue-domain author key (the finder)
project: ia-sync                 # which repo/component owns the defect (filter key)
root: ~/ia-sync
where: ~/ia-sync/zsh/system/tailscale.zsh (_ts_mount)   # the broken surface, whole path
defect: <ONE sentence describing the defect>            # the one-sentence description
assoc: [tailscale, sshfs, mount, race, daemon-guard, home, D-state]   # >=7 discriminators
severity: med                    # optional
pointers:
  - ~/<deeper trail — journal entry, related commit, sibling card>
---
```

- **`defect:` is the one-sentence description** — a reader filters on it without opening the
  body. **`assoc:` is the >=7 association tags** — the "know, not said" discriminators
  (class · tech · subsystem · host · symptom · area · severity) an agent greps to narrow
  candidates without a body read. Put the strongest one or two into the slug (radar), the
  rest live in `assoc:` (manifest).
- **No `status:` field** — a card's TOP-LEVEL folder (`issues/` / `routines/` / `archive/`)
  carries the state; a fold is a `mv` between them, nothing else.
- **`origin:` and `from_issue:`** only apply once a card has graduated into `routines/` —
  see the previous section. A card still sitting in `issues/` has no origin field; it hasn't
  folded yet.

## Parked — a note, not a state

Parked (deliberately-deferred — e.g. the larva case: known broken, operator says leave it
until a convergence point) is **not a structured state**. There is no `parked/` folder and
no `status: parked` field — both would violate the "folder = state, no status: field" law,
since `issues/` is already the one folder a not-yet-folded card lives in. Instead:

- Add `parked` as an entry in the card's `assoc:` list (grep-visible: `assoc: [..., parked]`).
- Add a body note explaining the deferral and the condition that would end it (what
  "converged enough to resolve" looks like).

A parked card is otherwise an ordinary `issues/`-resident card; it folds to `routines/` or
`archive/` exactly like any other once the deferral ends.

## Body — the fix-manual layer

Free prose after the frontmatter, point-never-copy. What was observed and when · the
consequence confirmed vs suspected · **once known, the fix itself or the playbook to apply
it** — this is what makes the card a fix manual rather than just a defect log · why it is
parked, if it is (see above) · where it was first flagged. The card + its pointers must be
sufficient; keep it small.

## Sort + drift — the durable radar

Unchanged from the family-wide rule (`../GUIDE.md`): sort by the filename `YYYY-MM-DD` date,
primary; a dated card missing the marker surfaces UNSORTED, never silently mis-ordered;
extracting the date substring for sort order is not filename-kind-inference and does not
violate the "machines never parse filenames for meaning" law.

## Run

1. Pull the facts from THIS session — the broken surface, when/how observed, the
   consequence, whether it looks structurally recurring or assumed one-shot. I hold the
   context; no subagent.
2. Compose: one-sentence `defect:`, >=7 `assoc:` tags, whole `~`-anchored paths, evidence
   body (+ the fix, once known). Point, don't copy — the card stays small.
3. Choose the destination by the fold call: known-recurring from the start → straight to
   `routines/`; otherwise → `issues/` (add `parked` to `assoc:` + a body note if this is a
   deliberate defer, not an active untriaged flag).
4. Draft, show majkee, confirm — then Write the file.
5. Confirm the path and that `origin:`/fold decisions past the initial write are majkee's
   per-card call, not something the skill decides unattended.
