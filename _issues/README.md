# _issues — the known-defect vault (`open/` · `parked/` · `archive/`)

Central, cross-project record of known-but-not-yet-fixed defects. Sibling of `_cold-start/`
(session glue) and `_mail/` (correspondence) — same family, different concern: this one is
memory of *what's broken*, not *where a session left off* or *who said what*.

Folder = state, no `status:` field (a field would drift from the location):

- `open/` — flagged, not yet triaged into a keep-or-fix call
- `parked/` — triaged, deliberately deferred ("known, not fixed, operator call")
- `archive/` — resolved

Frontmatter is the source of truth — flat keys, every path whole and `~`-anchored, `project:`
tags which repo/component the defect belongs to (filter, not physical separation — one vault,
not one per project). Filename: `ISS.<slug>.<YYYY-MM-DD>.md`. Body is free prose, point-never-copy.

Locked 2026-09-16 (majkee gavel, session with @Trajectory): per-project vaults were considered
and rejected — Janus + Codex/@mirror independently converged on central-in-reposoma, reusing
the cold-start-card pattern (`project:` filter over N physical folders). Seeded from the first
real backlog: `~/ia-sync/zsh/AGENTS.md`'s inline "KNOWN BROKEN" table.

No dedicated GUIDE.md or skill yet — this README is the law until one is built (not yet asked for).
