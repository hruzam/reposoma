# substrate.larva.jsonl-event-schemas

`source: larva.dev/.shared/registries/audit.jsonl.schema.json + repair.jsonl.schema.json`
`· excavated: 2026-07-10 (pre-burial salvage) · verdict at dig: ROUTE-later`
`· dig record: pulse.atlas.md [2026-07-10]`
`trigger: reposoma.devenv reaches the phase where agent-memory back-track wants structured`
`event ingestion (LAW-1: earned, not pre-built — devenv is P0 now) · destination: seed`
`material for the bin/register feed — file-native jsonl fits LAW-4 (runtime truth IS the`
`files) · secondary trigger: Houston's track-back tooling thread, if repair-map`
`formalization pain recurs (the gemini-line repair map was ad-hoc markdown)`

## Atlas commentary

majkee's framing at burial: *"my journaling was simpler back-track helper"* — these two
schemas are that journaling instinct, formalized. What they carry:

1. **A shared event envelope.** Both schemas agree on the spine: `ts` (ISO-8601) ·
   `agent` · `session_id`. That triple is the minimum joinable unit for back-tracking
   *who did what, when, in which session* — precisely what a RAG over agent memory needs
   as its record key. If devenv ever defines an event contract, start from this spine.
2. **The audit/repair split is a good taxonomy.** Audit = observation (findings, severity,
   paths inspected — no mutation claim). Repair = intervention (issue, root_cause,
   fix_steps, files touched). Observation-events and mutation-events indexed separately —
   a back-track query usually wants one or the other, rarely both.
3. **`mode: vertical | horizontal`** in the audit schema — larva's auditor distinguished
   depth-audits (one component, all layers) from breadth-audits (one layer, all
   components). Cheap, useful axis; worth keeping if audits become events.
4. **Required-vs-optional is disciplined:** repair *requires* `root_cause` — you cannot
   log a fix without naming a cause. That single constraint is the difference between a
   repair log and a changelog. Keep it.

Dead inside: `version: 0.1` metadata style and the standalone-schema-file mechanism —
devenv's contract style will differ. The field taxonomy is the salvage, not the format.

## Object 1 — audit event schema (verbatim)

```json
{
  "type": "audit",
  "version": "0.1",
  "required": ["ts", "mode", "agent", "session_id", "summary"],
  "fields": {
    "ts": "ISO-8601 timestamp",
    "mode": "vertical | horizontal",
    "agent": "agent name",
    "session_id": "session identifier",
    "summary": "one-line audit summary",
    "findings": "array of findings (optional)",
    "severity": "low | medium | high (optional)",
    "paths": "array of paths inspected (optional)"
  }
}
```

## Object 2 — repair event schema (verbatim)

```json
{
  "type": "repair",
  "version": "0.1",
  "required": ["ts", "agent", "session_id", "issue", "root_cause"],
  "fields": {
    "ts": "ISO-8601 timestamp",
    "agent": "agent name",
    "session_id": "session identifier",
    "issue": "short description",
    "root_cause": "cause summary",
    "fix_steps": "array of steps (optional)",
    "files": "array of files involved (optional)"
  }
}
```
