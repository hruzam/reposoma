# GLOSS — how to author an operator learning file

`what: the shape of a GLOSS — explanatory notes running alongside a PAD (or any`
`operator-facing run), the "what are we doing and why" for the human sitting it.`
`scope: STYLE only — vendor/project/driver agnostic. Never name a specific driver agent here —`
`say "the driver". status: GAVELED 2026-09-02 (majkee, session FC.sync-oraculum.sella-termbrana).`
`companions: raw.guides/PAD/GUIDE.md (the raw surface it explains) · raw.guides/runbook/GUIDE.md`
`(the session) · raw.guides/status/GUIDE.md (the position).`
`verified: 2026-09-02`

## What a GLOSS is

A **GLOSS** is explanatory notes running alongside a PAD (or any operator-facing run) — the
"what are we doing and why" for the human sitting it. Classical sense: a gloss explains a
primary text without touching it. The PAD stays raw and copy-pasteable; the GLOSS carries the
understanding. It is the operator's **learning** file, so it spans **all sessions of one part**
(not one session) — it outlives any single PAD or RUNBOOK it was written beside.

## When to reach for it

A human is sitting steps whose mechanics they do not yet own, OR the operator asks for
explanations.

**Driver rule:** offer a GLOSS at least when asked; if not asked, ask once whether one is
wanted. The operator decides — never silently skip, and never dump the explanations into the
PAD or into chat only.

## Three surfaces, never mixed

- **PAD** — raw commands + report fences. The raw surface.
- **GLOSS** — why. The understanding surface, **uncanonical** — never cite as truth.
- **Evidence / VERDICT** — distilled results. The truth surface.

Commands live only in the PAD; verdicts only in fences → evidence; explanations only in the
GLOSS.

## Anatomy

**1 — Header.** Backtick `what:` / `scope:` / `written by:` lines, stating UNCANONICAL.

**2 — Big picture (read once).** One section at the top of the file — the standing context that
does not change sitting to sitting.

**3 — Per-session sections.** `## <session slug> · <pad name>`, one per session sat.

**4 — Per-step notes.** `### STEP N — <title>`, one per step, covering:
- what the step proves,
- why each command line exists (plain words first, jargon after),
- what each verdict means for the product,
- why it is a *human* step, if it is.

Written by the driver **before** the step is run, never after as a rationalisation. No
commands, no outputs, no verdicts inside — those belong to the PAD and to evidence, not here.

## Placement + naming (pointer, not law — the consuming project decides)

**Default:** the project's session **ROOT**, sibling of the scratch file — **not** inside a
session bed (beds die with their task; learning survives) and **not** inside a
toolbox/product subtree (the operator surface stays out of the product).

**Disk name:** `GLOSS.<slug>.md` — `<slug>` = the project part it spans; one gloss per part.

**Artifact case in prose:** GLOSS, joining RUNBOOK · STATUS · PAD · POINT · RETURN · VERDICT.

## Anti-orphan rule

Every RUNBOOK of the part carries one pointer line `gloss: <relative path>`. A GLOSS with no
RUNBOOK pointing at it is an orphan → either wire it or delete it.

When the part closes, the GLOSS graduates to the operator's own shelf (their call), leaving a
"moved, safe to delete" stub.

## Style laws

- Plain thing first, name it after.
- One why per command line.
- Human-facing, never agent-facing.
- Never re-state the PAD.
- Never re-state the verdict.
- Short enough to read before running the step.

## First instance

`nablarva/.dev/session/GLOSS.termbrana.md` (2026-09-02, session
`toolbox-termbrana-02-m0-truthspike`).

## Accessories (extend like sella/)

This guide may grow side files the way `raw.guides/sella/` does — `res/` (runbooks, cards), `src/`
(observations, candidates), `raw/` (receipts), `dev-journal.gloss.md` (the guide's own journal).
None exist yet. First instance material lives with its project:
`nablarva/.dev/session/GLOSS.termbrana.md`. When a second project opens a GLOSS, or when the
"study session" use (operator walks a GLOSS with a tutor seat to extend their own knowledge —
majkee, 2026-09-02) gets its first sitting, start `dev-journal.gloss.md` here.
