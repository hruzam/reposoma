---
beacon: ham
path: /home/hruzam/www/psdvs/ham
repo: git@github.com:hruzam/ham-kharkiv-friends-rise.git   # fork of couleen/ham-kharkiv-friends-rise (owner: Jan Kubaty)
host: home
status: active/bootstrap
contract: .dev/PROJECT.yaml
lighthouse: AGENTS.md
sibling-of: []
shares: []
deposited-by: trajectory (atlas exception — majkee blessing 2026-09-19)
updated: 2026-09-19
---

# ham — beacon

Humanitarian Aid Management for Rotary Satellite Club "Kharkiv Friends Rise" — the sister
organisation supporting PSDVŠ actions. **Live system with real data**, foreign-owned code:
authored by Jan Kubaty (`couleen`) with Codex on OpenAI Sites; majkee contributes from a fork
until direct access is granted, then folds into the original.
TypeScript · React/Next on vinext · Cloudflare Worker · D1 (SQLite) · R2.

## Read first (the anchors — POINTERS, never copies)
- contract     → `.dev/PROJECT.yaml`
- decisions    → `.dev/flag.md`
- state        → `.dev/pulse.md`
- conventions  → `AGENTS.md` · `CLAUDE.md`
- lighthouse   → `AGENTS.md`
- domain rules → `HAM_HANDOFF_LOG_CZ.md` (owner's, tracked in the app repo; stale on features — code wins)
- stack primer → `.dev/guides/rosetta.laravel-to-ham.md` (Laravel → HAM map, for majkee)

## Notes
- **Harness shape: sync/deploy twin** — `ham.devenv` at `/home/hruzam/www/psdvs/ham.devenv`
  (`git@github.com:hruzam/ham.devenv.git`). Earned by fact 1: a foreign human writer on the
  code repo. Harness is hidden in the app via `.git/info/exclude` only — the owner's tracked
  `.gitignore` is never touched.
- Deploy is owner-only (OpenAI Sites). Merging to GitHub deploys nothing.
- Local test DB = simulated D1 SQLite file (`.dev/bin/db-local.sh`); synthetic data only.
- Scope folder `~/www/psdvs/`: `ham/` · `ham.devenv/` · `v0/` (archived PSDVS Laracasts
  material) · `psdvsSys/` (unregistered; under majkee review).
- **2026-09-19 (majkee gavel):** this beacon replaces the erased `psdvsSys` record, whose
  harness pointers resolved to nothing on disk. History keeps the old beacon (`git log -- registry/psdvsSys.md`).
