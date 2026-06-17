# Decisions — the standing index of locks (the flag role for this substrate)

`tier: temple · this is the meta-repo's flag: invariants + a one-line index of locks`
`note: the substrate has no volatile session/pulse — that is per-project. Locks live here.`
`rule: ADRs are append-only — superseded, never edited (doctrine §1b).`

| # | Lock | Status |
|---|------|--------|
| 0001 | Sovereign build: **A markdown = canon**, B = thin enforcement layer, C = thin live slice (sized by operator). `agentctl` is the gate (superset of compile-down). Three tiers `[S]/[GC]/[GW]`. Graduation rule. Force-3 knowledge-vs-integration boundary. Two supply chains, never one file. | LOCKED 2026-06-17 |
| 0002 | **Force 4 = the gate, not the direction.** Agent drafts → human authors-by-approving a diff; agent-authored-direct canon forbidden. Closed-loop automation conditional on a detection-rate test. | LOCKED 2026-06-17 |

## Resolved opens (from 0001)
- **O3 — cleaned system map** — RESOLVED 2026-06-17: done in `system-map.md` (Atlas→Zenith added; self-clone and Houston→Delta kept; the "swarm" edge dropped).

## Still open
- **O1 — live-slice sizing (Model C)** — operator-only; the one untuned string. Settle with the detection/cost experiment, not more design.
- **O2 — spectral-engine driving challenge/process maps** — parked in the composition seed; out-of-process (engine as local MCP). Do not fold without a fresh frame.
