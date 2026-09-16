---
kind: issue-card
date: 2026-07-29
project: ia-sync
root: ~/ia-sync
where: ~/ia-sync/zsh/projects/larva.zsh:31 (+ aliases at :61-70)
defect: LARVA_SCRIPTS_DIR points at a directory that does not exist on office
operator_call: >
  the larva era was mostly home's and is dead; newer larva associations exist but are
  deliberately unpublished until both machines are ~1:1. Neither repoint nor strip — leave
  until convergence, then resolve as part of whatever replaces it.
found_by: kelvin
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

Migrated 2026-09-16 from the inline "KNOWN BROKEN" table in `~/ia-sync/zsh/AGENTS.md` — first
seed card for the `_issues/` vault (see this vault's README for why it's central, not
per-project).
