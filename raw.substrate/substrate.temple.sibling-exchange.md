# substrate.temple.sibling-exchange — HOLD

**Status:** HOLD  
**Trigger:** Cross-project agent exchange reaches ≥3 instances where ad-hoc file-passing
creates friction — OR majkee explicitly names this as a design session target.  
**Deposited:** 2026-07-15 (Atlas, from majkee observation in session)  
**Guard:** Houston gate before any build. Eagle's sibling navigation covers read-only
cross-project queries — do not build until that is demonstrably insufficient.

---

## Observation (what prompted this)

Majkee observed that agents are passing findings between projects more often — e.g. an agent
in reposoma spawning a sub-agent (Explore) that produced results intended for a different
project. The pattern is growing as the sibling graph fills in. Current ad-hoc approaches:
- Copying findings into session context manually
- Writing files in one project and reading them from another via explicit path
- Mail in reposoma's `_mail/` bus (but that's temple-scoped, not project-scoped)

## What already exists

**Read layer** (covered — Eagle handles this):
- `registry/index.md` sibling graph (logical relationships)
- Individual beacons with `sibling-of:` frontmatter + `## Shared anchors` (entry points)
- `temple-project-map.zsh` (physical paths)
- Eagle subagent resolves sibling roots via cascade and reads harnesses cross-project

**Not covered:**
- Write / notify layer — no standardized protocol for an agent in project A to *deliver*
  an artifact to project B
- The `_mail/` bus exists inside reposoma and nabla-lab but is not cross-project
- No shared staging area between sibling pairs

## Design space

### Option A — Eagle is enough (current state, no new harness)
For read-only cross-project queries, Eagle's sibling navigation covers the use case.
Agent reads project A, finds something relevant to sibling B, reports to orchestrator,
orchestrator decides what to do with it. No write mechanism needed if the orchestrator
(human or Houston) handles the delivery.

**When this breaks:** when the delivery step is frequent enough that manual routing
becomes friction, or when a headless agent needs to deliver without human routing.

### Option B — Project-local mail buses (extend the existing pattern)
Each project gets its own `_mail/` bus (like nabla-lab already has). Sibling pairs
agree on a shared `_mail/toSibling/` subfolder convention. Agent in project A writes
to `_mail/to-<sibling>/inbox/`, agent in project B reads from its own inbox.

**Cost:** each project needs a `_mail/` tree and a read-protocol. Already gaveled for
nabla-lab and reposoma — extension cost = low per project.
**Risk:** inbox proliferation; no cross-machine sync (mail files are in project repos).

### Option C — Shared staging folder per sibling pair
A neutral folder outside both projects (in scope-group or a shared devenv location)
as a drop zone for cross-project artifacts. Each sibling pair gets one:
`elements-factory/_sibling-exchange/applications-in-common--freya.devstudio/`

**Cost:** needs scope-group structure + conventions. Heavier than B.
**Risk:** creates a third location to track; may violate "point-never-copy."

### Option D — Registry-mediated artifact references
Sibling exchange artifacts are referenced (not copied) via beacon `## Shared anchors` 
updates. The artifact stays in its source project; the sibling beacon records a pointer
to it. Pull-on-read, not push-on-write.

**Cost:** requires beacon discipline at every exchange point.
**Risk:** beacons become stale if not updated; works only for stable artifacts, not live state.

## Recommendation (draft — for Houston)

Start with **Option A** (current state, Eagle covers read). Move to **Option B** (project-local
mail buses, extend the `_mail/` pattern) when the first genuine friction point fires in a
live session. Option B is the lowest-cost write extension that stays within the existing
`_mail/` metaphor and decision record.

Options C and D: park. C adds complexity; D is elegant but requires constant beacon
discipline that has not yet proven sustainable.

**Do not build B until Option A demonstrably fails.**

## Related

- `raw.substrate/substrate.temple.liveness-layer.md` — wake-on-event / notifier concept;
  a live notifier between projects would be an extension of this same wall
- `reposoma/registry/index.md` — the sibling graph (the logical map)
- `~/.claude/agents/eagle.md` — sibling navigation already wired; read-only coverage
- `~/.claude/skills/project-read/SKILL.md` — same sibling navigation in skill form
- `_mail/README.md` — existing mail bus conventions (Option B would extend this)
