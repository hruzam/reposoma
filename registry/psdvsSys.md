---
beacon: psdvsSys
path: /home/hruzam/www/psdvs/psdvsSys
repo: —
host: home
status: active/bootstrap
contract: .dev/PROJECT.yaml
lighthouse: AGENTS.md
sibling-of: []
shares: []
deposited-by: atlas
updated: 2026-07-27
---

# psdvsSys — beacon

Nette (per-package) stock and mission management system for Pašerácká stezka dobrého vojáka
Švejka (Czech humanitarian organization). PHP 8.4 · PostgreSQL 16+ · nette/tester ·
PHPStan L8 · nette/coding-standard. Greenfield domain built over a Jeff Way course substrate
(job-listings scaffolding — throw-away schema; own domain model to be designed in Phase 1).
Harness transported via `psdvsSys.devenv`.

## Read first
- contract     → `.dev/PROJECT.yaml`
- decisions    → `.dev/flag.md`
- state        → `.dev/pulse.md`
- lighthouse   → `AGENTS.md`

## Notes
- Phase 0 (bootstrap) done 2026-07-07; Phase 1 (domain model design) is next
- Jeff Way job-listings scaffold present but throw-away — domain schema not yet designed
- `psdvsSys.devenv` at `/home/hruzam/www/psdvs/psdvsSys.devenv/` — needs `git init` + GitHub remote
- **2026-07-27 (ADR-001, majkee, relayed via Oraculum):** stack swapped Laravel → Nette.
  Superseded facts (kept for trail, not deleted): Laravel 13 · PHP 8.3+ · MariaDB (`psdvs`) ·
  PHPUnit 12 · Pint. Current facts: Nette (per-package) · PHP 8.4 · PostgreSQL 16+ ·
  nette/tester · PHPStan L8 · nette/coding-standard. Source of truth: project `AGENTS.md`.
