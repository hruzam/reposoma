---
title: Slug directories — the codified side-folder taxonomy
chapter-of: guide-writing
---

# Slug directories — what may sit beside GUIDE.md

`gaveled: majkee 2026-09-04 (session runbook-upgrade, cycle-04 fold) — closes the "raw/ is`
`uncodified" gap surfaced by the triple audit (Astrobley · Oraculum · Cartan).`

Directory names are **three characters**, Anthropic skill-folder convention as inspiration
(`SKILL.md` + `scripts/` + `references/` + `assets/`), not its letter. The slug entry remains
`GUIDE.md`; everything else beside it lives in one of these slots. Same law for guides and for
RUNBOOK canon — one home here; other guides point, never copy.

## The five slots

| dir | role | status | manifest treatment |
|---|---|---|---|
| `res/` | subchapters extending the base GUIDE | **canonized** | per file, `chapter-of:` marker required |
| `raw/` | collected substrate — evidence, session stories, patterns promoted from the field ("ran a session, found this behaviour, needs repair") | **canonized** | one directory line |
| `ast/` | templates and static assets a guide's reader copies or fills | reserved slot | one directory line |
| `src/` | process data staged toward a future GUIDE upgrade or restructuring | reserved slot | one directory line |
| `cod/` | scripts, if a guide ever needs executable help (lean: executables usually belong table-side, next to the engine — writer rule 4) | reserved slot | one directory line |

## The raw/ ↔ src/ seam

**`raw/` is inbound; `src/` is outbound.** Substrate collected *from* sessions (verbatim
evidence, detection patterns, stories) → `raw/`. Material being actively staged *toward* a
guide change (drafts, restructure workpieces) → `src/`. If in doubt: `raw/` — `src/` exists
only while a change is being prepared, and empties when it lands.

Recorded lean (Oraculum, 2026-09-04): if practice shows the seam does not hold — sessions
guessing between the two — `src/` folds into `raw/` and the slot retires. Watch it in use; do
not pre-solve it.

## Openness rule

The table is a vocabulary with reserved slots, not a closed set. A new three-char directory is
legal on first use: define its role in ONE line added to the owning GUIDE.md's `## Manifest`,
same session. An undeclared directory in a slug is drift. The orphan rule reaches
side-directories as **one line each**, never per-file — per-file listing applies to `res/`
chapters only.

## Resolver contract

`/guide` serves `GUIDE.md` and `res/` chapters only. `raw/`, `src/`, `ast/`, and `cod/` are
never served by the resolver; they are reached by explicit path from a manifest line or a
prompt.
