# Decisions — the standing index of locks (the flag role for this substrate)

`tier: temple · this is the meta-repo's flag: invariants + a one-line index of locks`
`note: the substrate has no volatile session/pulse — that is per-project. Locks live here.`
`rule: ADRs are append-only — superseded, never edited (doctrine §1b).`

| # | Lock | Status |
|---|------|--------|
| 0001 | Sovereign build: **A markdown = canon**, B = thin enforcement layer, C = thin live slice (sized by operator). `agentctl` is the gate (superset of compile-down). Three tiers `[S]/[GC]/[GW]`. Graduation rule. Force-3 knowledge-vs-integration boundary. Two supply chains, never one file. | LOCKED 2026-06-17 |
| 0002 | **Force 4 = the gate, not the direction.** Agent drafts → human authors-by-approving a diff; agent-authored-direct canon forbidden. Closed-loop automation conditional on a detection-rate test. | LOCKED 2026-06-17 |
| 0003 | **Machine-provenance markers.** Host id = `echo $MACHINE_NAME` (per-machine from `~/.config/zsh/config.zsh`; office=`office`). Artifacts carry `host:`; per-repo `.host` via a one-liner (no framework). Machine-layer lighthouse `~/.config/zsh/AGENTS.md` (AGENTS.md, not CLAUDE.md); `substrate.` prefix parks legacy, nothing deleted; §4.7 — never bind its paths into a project surface. Concurrency guard is home-only. *(full record: `0003-machine-provenance.md`)* | LOCKED 2026-06-17 |

## Resolved opens (from 0001)
- **O3 — cleaned system map** — RESOLVED 2026-06-17: done in `system-map.md` (Atlas→Zenith added; self-clone and Houston→Delta kept; the "swarm" edge dropped).

## Still open
- **O1 — live-slice sizing (Model C)** — operator-only; the one untuned string. **Field-work gavel 2026-06-17 (majkee): deferred — adopt-what-is, leave the string untuned; `.mcp.json` stays a placeholder / `mcp_profile` minimal. Not meaningful drift; the lesson the pain teaches is to *log the call*, which this line does.** Settle later with the detection/cost experiment, not more design.
- **O2 — spectral-engine driving challenge/process maps** — parked in the composition seed; out-of-process (engine as local MCP). Do not fold without a fresh frame.
- **O5 — cross-project lighthouse registry** — *PROPOSED 2026-06-18 (majkee lean) — scaffolding built, awaiting Janus + gavel to LOCK.* A project leaves a **beacon** (`registry/<project>.md`, thin POINTERS not copies) so a sibling's architect/researcher navigates it — or jumps to a shared artifact — by reading one file, never scanning. `registry/index.md` = the sibling map (first on road); `registry/README.md` = the spec. Rules: point-never-copy · one-direction (Force 4) · anchors-not-scans · `sibling-of`/`shares` for the shared-anchor jump · `host:` provenance (0003). The per-project lighthouse already half-exists (PROJECT.yaml + `docs.*` + a tracked "Read first" file; piql.dev's `mesh-state.md` is the model). Architects/atlases deposit beacons; `raw.projects/` retires once mined. Janus the convention, then lock.
