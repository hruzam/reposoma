---
kind: issue-card
date: 2026-07-29
brand: claude
found_by: kelvin
project: ia-sync
root: ~/ia-sync
where: ~/ia-sync/zsh/projects/larva.zsh:31 (+ aliases at :61-70)
defect: LARVA_SCRIPTS_DIR points at a directory that does not exist on office
assoc: [larva, zsh, scripts-dir, office, stale-config, latent, aliases, parked]
operator_call: >
  the larva era was mostly home's and is dead; newer larva associations exist but are
  deliberately unpublished until both machines are ~1:1. Neither repoint nor strip — leave
  until convergence, then resolve as part of whatever replaces it.
pointers:
  - ~/ia-sync/zsh/AGENTS.md
---

`projects/larva.zsh:31` sets `LARVA_SCRIPTS_DIR="$HOME/.config/zsh/larva"` — that directory
does not exist on office. The `broadcast`/`consult`/`slices`/`laika` aliases it defines
therefore point at nothing. Not triggered at startup (`projects/larva.zsh` loads on-demand
via `lrv`), so it is latent, not fatal. The scripts survive only at `archive/larva/`, which
the aliases do **not** reference.

Treat larva-adjacent wiring anywhere in the zsh tree the same way — stale by default, do not
revive without a deliberate convergence decision.

Migrated 2026-07-29 (originally) from the inline "KNOWN BROKEN" table in
`~/ia-sync/zsh/AGENTS.md` — first seed card for the issue vault.

---
Re-migrated 2026-09-17 from `~/reposoma/_issues/parked/` into the cold-start card vault's
issue subtree (session `cs-card-sys-update`, phase 1). Conformed to the issue-card schema
(added `assoc:`). The old-path original is left in place until majkee proves the new shape
and removes it in a reviewed commit — do not read both as two live issues.

Re-flattened 2026-09-17 (same session, phase 1 @vector) from `issues/parked/` up to flat
`issues/` — the nested `issues/{open,parked,archive,reactions}` subtree is retired in favor
of a flat `issues/` + fold-to-`routines/`-or-`archive/` model; parked is no longer a folder
or a `status:` field, it is the `parked` entry now added to `assoc:` above, alongside this
unchanged deferral note. See `~/reposoma/raw.guides/cold-start-card/res/issue-card.md`.
