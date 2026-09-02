---
status: promoted
promoted_by: "first Houston session loop — pulse.md is the first read before any plan"
validated_by:
  - "piql.dev temple pattern — pulse.md as volatile state, read before every session"
  - "freya.devstudio — same read order across the team"
expresses_as:
  - "all agents read pulse.md first — the single source of the current phase and hot context"
  - "the always-on entry file (CLAUDE.md / AGENTS.md) carries a pointer to pulse.md"
  - "pulse.md is git-ignored — local, never committed"   # AMENDED 2026-09-02 (majkee gavel): pulses are TRACKED — reposoma syncs whole across hosts; volatility ≠ locality
commonized_from: "freya.devstudio/canon/canon.pulse-heartbeat.md (2026-06-17)"
---

# Pulse heartbeat

One now-file (`pulse.md`) that all agents read first — the single source of the current
phase, hot context, and pointers. Loaded by convention from the always-on entry file, not by
a daemon or a vendor hook dependency.

## Read order

```
pulse.md → flag.md → canon/ → session/plan/session.plan.md
```

pulse.md is volatile — and, since 2026-09-02, **committed like everything else** (majkee gavel: the whole repo syncs across hosts; a now-file you cannot read on the other host is the sync/deploy tax in miniature — `raw.guides/project-topology/GUIDE.md`). Volatile means *rewritten often*, not *local*.
