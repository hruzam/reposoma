---
kind: cold-start-card
date: 2026-09-26
brand: claude
seat: flight
project: ham
root: ~/www/psdvs/ham
commit: 47b5591 (local-dev)
task: Full-sim localbed-01 — populate all 25 HAM screens with synthetic data dense enough that every page shows realistic content via http://localhost:3001
resume: claude --agent flight
session: https://claude.ai/code/session_018JBmzr3yr5W7jhm3gWmszq
model: sonnet
dedicated: flight
recommend: "Office host: follow OFFICE-BRIEF.md steps 3–8 (approve scripts done ✓), then pick up at L5 — probe all GET routes via @Delta. Home session is parked; do NOT reset db on home."
runbook: ~/www/psdvs/ham/.dev/session/localbed-01-fullsim/RUNBOOK.md
pointers:
  - ~/www/psdvs/ham/.dev/session/localbed-01-fullsim/STATUS.md
  - ~/www/psdvs/ham/.dev/session/localbed-01-fullsim/OFFICE-BRIEF.md
  - ~/www/psdvs/ham.devenv/dev/session/localbed-01-fullsim/res/coverage.md
  - ~/www/psdvs/ham.devenv/dev/session/localbed-01-fullsim/res/PAD-00.host-deploy.2026-09-20.md
---

## State at card-write time

Session `localbed-01-fullsim` ran L1–L3 on **home** host and transferred to **office**.

| Line | Status |
|------|--------|
| L1 baseline | ✅ build exit 0 · test 48/48 |
| L2 coverage map | ✅ 25 pages × routes × tables |
| L3 seed (D1–D6) | ✅ 6 domain SQL files, ~95 rows total |
| L4 `.dev.vars` | ✅ home · ⚠️ must recreate on office |
| **L5 probe** | **← next — @Delta, all GET routes through :3001** |
| L6 verify | queued |
| L7 PAD | queued |
| L8 majkee sits | queued |

## Office transfer — where things stand

ham.devenv commit `778c814` (core) is on GitHub — carries all 6 seed files, updated
`db-local.sh`, STATUS, OFFICE-BRIEF, coverage map, L1-baseline.

**Office progress so far (PAD-00):**
- `npm install` ✅ — warnings are normal; Jan's lockfile, nothing to fix
- `npm approve-scripts` (7 packages) → command written in PAD-00 § Flights round
- Steps 3–8 still to run: `deploy.sh` → `.dev.vars` → cold `npm run dev` → `db-local.sh reset` → proxy

## First step for the next incarnation

On office:
1. Paste the approve-scripts line from PAD-00 § Flights round (or read OFFICE-BRIEF.md)
2. `bash ~/www/psdvs/ham.devenv/deploy.sh`
3. `printf 'ACCESS_CODE=TEST-ACCESS-2026\n' > ~/www/psdvs/ham/.dev.vars`
4. `cd ~/www/psdvs/ham && npm run dev` → Ctrl+C
5. `.dev/bin/db-local.sh reset` → confirm "6 domain file(s) loaded."
6. Start dev + proxy, open `claude --agent flight` → L5

## Session advice

`db-local.sh reset` guard: confirm dev server is NOT running before reset (one D1 file,
one writer at a time). `pgrep -f "vinext dev"` must be empty.

The PAD-00 file on office is the live process doc — write Flights-round answers there,
not here. This card is the pointer, STATUS is the position, PAD-00 is the dialogue log.

## Repo links (for office clone if needed)

- ham app: `git@github.com:hruzam/ham-kharkiv-friends-rise.git` branch `local-dev`
- devenv: `git@github.com:hruzam/ham.devenv.git` branch `core`
