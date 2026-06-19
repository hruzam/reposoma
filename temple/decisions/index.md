# Decisions — the standing index of locks (the flag role for this substrate)

`tier: temple · this is the meta-repo's flag: invariants + a one-line index of locks`
`note: the substrate has no volatile session/pulse — that is per-project. Locks live here.`
`rule: ADRs are append-only — superseded, never edited (doctrine §1b).`

| # | Lock | Status |
|---|------|--------|
| 0001 | Sovereign build: **A markdown = canon**, B = thin enforcement layer, C = thin live slice (sized by operator). `agentctl` is the gate (superset of compile-down). Three tiers `[S]/[GC]/[GW]`. Graduation rule. Force-3 knowledge-vs-integration boundary. Two supply chains, never one file. | LOCKED 2026-06-17 |
| 0002 | **Force 4 = the gate, not the direction.** Agent drafts → human authors-by-approving a diff; agent-authored-direct canon forbidden. Closed-loop automation conditional on a detection-rate test. | LOCKED 2026-06-17 |
| 0003 | **Machine-provenance markers.** Host id = `echo $MACHINE_NAME` (per-machine from `~/.config/zsh/config.zsh`; office=`office`). Artifacts carry `host:`; per-repo `.host` via a one-liner (no framework). Machine-layer lighthouse `~/.config/zsh/AGENTS.md` (AGENTS.md, not CLAUDE.md); `substrate.` prefix parks legacy, nothing deleted; §4.7 — never bind its paths into a project surface. Concurrency guard is home-only. *(full record: `0003-machine-provenance.md`)* | LOCKED 2026-06-17 |
| 0004 | **Cross-project lighthouse registry** (plane 3). `registry/` — a thin POINTER beacon per project (`<project>.md`) + the sibling map (`index.md`) + the `README.md` spec. Rules: **point-never-copy** · one-direction (Force 4) · **project-relative anchors only — no `~/` paths; a machine layer is reached via its decision record (0003), §4.7 made structural** · `sibling-of`/`shares` fast-jump · `host:` provenance. Lock the convention, not the still-filling sibling-graph. *(full record: `0004-cross-project-registry.md`)* | LOCKED 2026-06-18 |

## Resolved opens (from 0001)
- **O3 — cleaned system map** — RESOLVED 2026-06-17: done in `system-map.md` (Atlas→Zenith added; self-clone and Houston→Delta kept; the "swarm" edge dropped).

## Still open
- **O1 — live-slice sizing (Model C)** — operator-only; the one untuned string. **Field-work gavel 2026-06-17 (majkee): deferred — adopt-what-is, leave the string untuned; `.mcp.json` stays a placeholder / `mcp_profile` minimal. Not meaningful drift; the lesson the pain teaches is to *log the call*, which this line does.** Settle later with the detection/cost experiment, not more design. **Trigger to un-defer:** the first time a basement hits a real "needed live runtime truth a file couldn't give" wall — that event is the data; then run the cheap one-evening detection/cost test and size the slice to it.
- **O2 — spectral-engine driving challenge/process maps** — parked in the composition seed; out-of-process (engine as local MCP). Do not fold without a fresh frame.
