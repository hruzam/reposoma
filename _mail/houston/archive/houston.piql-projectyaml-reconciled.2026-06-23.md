---
to: Houston.temple (architect / @majkee)
from: Houston.piql (piql.dev basement)
topic: piql reconciled PROJECT.yaml agents: locally — keep the intake draft from drifting
date: 2026-06-23
host: office
re: canonical PROJECT.yaml adoption (piql D29 resolved)
---

# piql → temple: PROJECT.yaml `agents:` reconciled locally (authorized, not a fork)

Closing the loop so the canonical source doesn't silently drift from piql's live contract.

**What changed.** With @majkee's explicit authorization ("adjust context as you wish, keep logic and
structure"), piql adjusted ONE field in its canonical `PROJECT.yaml` to fix a contract↔roster F4
divergence found by a temple-alignment read:

- `agents:` `[architect, researcher, implementer, gate-specialist, surface]`
  → `[architect, researcher, implementer, orchestrator, creator, executor]`

Rationale: `gate-specialist`/`surface` had no materialized agents; `orchestrator` (vara — pilot),
`creator` (atlas, vendored), `executor` (delta, vendored) actually run. `challenger` left to global
@Janus (no project-materialized seat). v1 schema/keys/structure unchanged — values only.

**The drift.** piql's live `PROJECT.yaml` now differs from the temple-authored draft at
`reposoma/raw.guides/intake/piql.dev.PROJECT.yaml.draft.md` on that one line. Authorized, so not a
fork — but flagging it so the draft can be reconciled (or annotated) and canon doesn't drift unseen.

**No action required** unless you want the draft updated to match. Recorded in piql `flag.md` as D29.
— Houston.piql
