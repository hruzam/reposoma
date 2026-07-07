---
to: houston
from: atlas-auto
subject: propagation pass — piql.dev (report-only)
date: 2026-06-25
host: office
---

# Propagation Pass Report — piql.dev

```
project:          piql.dev
projected-from:   decisions@2026-06-25
scope:            decisions 0006 (model×effort matrix, new seats @Vara/@Vector) + 0007 (tool-lifecycle)
run-by:           @AtlasAuto (atlas-auto)
run-type:         REPORT-ONLY — nothing applied, nothing in piql was changed
```

---

## Bucket 1 — auto-changed (WOULD apply, NOT applied)

These are mechanical drifts from canon: no recorded rationale in flag.md or any decision.

| surface | field | local | canon (0006 L2) | action |
|---------|-------|-------|-----------------|--------|
| `.claude/agents/vara-piql-orchestrator.md` | `effort` | `medium` | `high` | Would update to `high` |

**Rationale:** D30 records Vara as a *pilot orchestrator seat* but records no rationale for effort:medium. Canon 0006 L2 assigns Vara at sonnet·high with explicit justification (explicit planning + coordination behavior — CrewAI Manager pattern; effort=high activates self-interrogation). The effort discrepancy has no recorded piql-local reason. All other 6 agents (Houston, Trajectory, Atlas-ui, Atlas-auto, Epoch, Delta) match their canon model×effort exactly.

> Cross-ref for architect: D30 also records `Vara = PILOT` status with a named promotion threshold. Raising effort:medium→high is independent of pilot/permanent status — effort is a behavioral axis, not a governance axis. That said, see Ambiguous Cases below.

**Naming drift also flagged (mechanical, lower stakes):**

| surface | finding | would-fix |
|---------|---------|-----------|
| `trajectory-piql-senior-dev.md` body | References `coder-junior` as spawn target; the resident executor is `delta` (no `-piql-` suffix) | Update body reference from `coder-junior` → `delta` |
| `delta.md` `name:` field | Uses bare `delta`, not `delta-piql` or project-scoped name | Deliberate reuse of global executor name (no recorded reason to scope it) — leave as is unless architect wants project prefix applied uniformly |

---

## Bucket 2 — flagged-for-architect (JUDGMENT-RESIDUE — do NOT apply)

These are divergences where a recorded rationale or deliberate design choice makes auto-propagation inappropriate.

### F1 — Authorized archetype list (D29) — leave as-is, on record

```
canon-says:       0006 L2 defines a 15-seat global matrix
local-says:       PROJECT.yaml agents: [architect, researcher, implementer, orchestrator, creator, executor]
recorded-rationale: D29 (2026-06-23) — @majkee explicitly authorized this reduced set.
                   "challenger" left to global @Janus (no project-materialized seat).
                   This is NOT a fork; it is the authorized projection of canon for piql's team scope.
```

**Assessment:** all six archetypes are materialized (Houston/Epoch/Trajectory/Vara/Atlas-ui+auto/Delta).
Zero missing seats when measured against the D29 authorized list. No action required.

### F2 — @Vector absent from piql

```
canon-says:       0006 L3 activates @Vector (sonnet·medium) as a new global seat; 0006 L4 escalation
                  ladder places Vector between Delta and Trajectory
local-says:       no vector agent in .claude/agents/
recorded-rationale: D29 authorizes a closed six-archetype list with no mid-tier implementer seat.
                   Additionally, 0006 L4 note: "Vector and Delta collapse into a single @Delta when
                   per-subagent effort ships (GitHub #43083)" — suggesting Vector is transitional.
```

**Assessment:** adding Vector would expand beyond D29-authorized scope and violates the dispatch STEP 5 no-expand guard. This is the decision the architect must make: does the 0006 escalation ladder warrant adding Vector to piql, or does D29's scope hold?

**This is the single most consequential flagged item** — it directly touches the escalation contract and if @majkee decides to add Vector, it would also trigger trust-regen (see Bucket 3).

### F3 — Houston → Trajectory direct routing

```
canon-says:       Houston dispatches execution via Vara: Houston → Vara → Trajectory/Vector/Delta
                  (system-map.md dispatch hierarchy, 0006 L2 "What an agent does differently")
local-says:       houston-piql-architect.md says "I delegate execution to @Vara and @Trajectory"
                  (both listed as direct receivers, not Vara-then-Trajectory)
recorded-rationale: D30 records Vara as PILOT seat
```

**Assessment:** two competing readings, and both are visible in the agent body text itself. On one hand the "and @Trajectory" may be a deliberate hedge while Vara is provisional. On the other hand, the agent's own body is internally contradictory: line 28 says "I delegate execution to @Vara and @Trajectory" yet the "What I do not do" section says "Route in-flight tasks (that is @Vara)" — which implies Trajectory is NOT a direct target of Houston for routing. The contradiction is evidence this is **stale body prose**, not a deliberate design decision. This is the cleanest case in this pass of the auto/flag ambiguity: topology divergence where it is genuinely unclear whether the text reflects intent or just un-updated wording. Put here (not MECHANICAL) because D30 is on record and the architect should see the internal contradiction explicitly. Recommend the architect clarify and update if Vara is promoted, or acknowledge the hedge if Vara remains a pilot.

### F4 — .claude/agents/* committed (Tier-G-ignored vs committed)

```
canon-says:       doctrine §2 (agents-as-data): CLI agent projections are Tier G-ignored
local-says:       piql commits .claude/agents/* (flag.md alignment note: "mixed state, flagged not
                  yet reconciled")
recorded-rationale: D31 caution — "this does NOT assert piql's current .claude/agents/* tracking is
                   already correctly tiered — known mixed state"
```

**Assessment:** acknowledged open question in flag.md. Listed here to make it visible as a 0007-related item (tool-lifecycle doctrine: Tier-S intent in PROJECT.yaml, Tier-G-committed for trust-bearing facts, Tier-G-ignored for renewable CLI projections). No auto-fix candidate — requires deliberate gitignore decision.

---

## Bucket 3 — trust-regen-needed (flag only — never applied)

These involve permissions, tool lists, or trust config that must be regenerated locally if canon changes are adopted. Listed as awareness flags only.

- `trust-regen-needed`: if @Vector is added (F2 above), its `tools:` list and permissions must be authored locally — never copied from the global seat definition.
- `trust-regen-needed`: Houston's `memory: user`, `maxTurns: 50`, and `Stop` hook are trust/permission-adjacent fields excluded from this pass entirely. If those fields change in canon, they must be re-evaluated per piql's operating model.
- `trust-regen-needed`: Trajectory's `tools: Read, Grep, Glob, Edit, Write, Bash, Agent` includes Bash + Agent — the widest grant in the project. This is a local authorization decision; was not examined against canon (trust does not port — §7).

---

## flagged-upstream

One governance pattern worth the architect's attention for possible canonization:

- **D30's named-promotion-threshold pattern** (explicit threshold before a pilot seat becomes permanent: "promote only when @majkee can no longer route + review dispatch volume by hand") is cleaner governance than most project flags achieve. If 0008 (propagation + pilot seat governance) is being drafted, this threshold formulation is a strong template for how to record provisional seats canon-wide.

---

### Ambiguous cases (for 0008)

These are the borderline calls this run was uncertain about. Each is evidence for sharpening the auto/flag rule.

**A1 — Vara effort: auto-change or judgment-residue?**

The effort discrepancy (medium vs high) has no recorded piql-local rationale → leans mechanical. But the seat itself is marked PILOT (D30), and one could argue that a provisional seat intentionally runs at lower effort until proven. The auto/flag rule has no language for "effort choice on a pilot seat." Decision taken: put in MECHANICAL with a D30 cross-reference. But if the rule were "any change touching a D30-recorded provisional seat requires architect judgment," it would land in JUDGMENT-RESIDUE instead. The architect should encode this case in 0008.

**A2 — coder-junior → delta naming drift: mechanical or out-of-scope?**

Trajectory's body refers to `coder-junior` which was the pre-D29 executor name. The current executor is `delta`. This is clearly stale — but is it a propagation-pass responsibility (model/effort/topology) or a local coherence issue (the kind of thing a `materialize --verify` would catch under a lockfile)? Put in MECHANICAL as naming drift, but it's closer to a consistency lint than a topology projection. The boundary between "propagation scope" and "local lint" is not yet drawn.

**A3 — delta name prefix: project-scoped or global reuse?**

`delta.md` uses `name: delta` (no `-piql-` suffix). Other agents use `name: ...-piql-...` prefixes. Is this intentional global reuse or naming inconsistency? The global delta agent at `~/.claude/agents/delta.md` uses the same bare `delta` identity — so this might be a local copy/fork of the global, or it might be the global loaded into project scope. The auto/flag rule needs guidance on: when does a project-scoped agent without the project prefix indicate intentional reuse vs naming drift?

**A4 — 0007 tool-lifecycle: no equivalent in piql PROJECT.yaml `tools:` block**

Decision 0007 establishes tool-emission duty tied to the `tools:` block in PROJECT.yaml and a gate-verified lockfile. piql's `PROJECT.yaml` has no `tools:` block (only `mcp_profile: none`). Conservative exclusion from all buckets is correct: **0007 is a verified no-op for piql today** — the emission duty triggers at tool *graduation*, and piql has no tools to emit. The missing block is not a gap; it reflects piql's current state accurately. If piql ever graduates a tool, the block would be added at that time. No action needed; included here only to document that 0007 was considered and confirmed inert for this project at this date.

---

## Summary counts

| bucket | count |
|--------|-------|
| MECHANICAL (auto-changed, not applied) | 1 model×effort item (Vara effort:medium→high) + 1 naming drift item (coder-junior→delta) |
| JUDGMENT-RESIDUE (flagged-for-architect) | 4 items (F1 D29 on-record · F2 Vector absence · F3 Houston routing · F4 tier commitment) |
| TRUST-REGEN-NEEDED | 3 flags (Vector if added · Houston trust fields · Trajectory Bash grant) |
| FLAGGED-UPSTREAM | 1 (D30 pilot-threshold pattern for 0008) |

---

*Run completed 2026-06-25. No files were changed in piql.dev. This report is the sole output.*
*Next step: architect reviews, makes judgment calls on F2 (Vector) and F3 (routing), then this report can inform a materialization or a direct edit session.*
