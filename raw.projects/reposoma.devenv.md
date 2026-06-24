---
overview: reposoma.devenv
path: /home/hruzam/www/ovum/reposoma.devenv
audience: sibling-project agents (subai.devenv, piql.dev, larva) on a scoped errand
role: cross-project ORIENTATION layer — narrative above the registry beacon; POINTERS, never canon
authored-by: "@Epoch (researcher, Claude Code) — verified against live artifacts"
authored: 2026-06-24
verified-against: registry.jsonl · trace.jsonl · bin/register (direct reads) · absence of analysis_report.md + spectral/ (direct reads) · flag.md · session.plan.md
supersedes-staleness: pulse.md (06-17, "P0 drafted/halted") and registry beacon (06-23, "onboarding/PENDING") — both lag the artifacts; see §0
canon-lives: NOT here — this file points; do not relitigate or copy decisions out of it
---

# reposoma.devenv — what is created here (overview for sibling agents)

> Read this if you were dispatched from another project and need to know what reposoma is,
> what it has actually built, what it shares with you, and where its real canon lives.
> This is the **narrative layer**. The pointer beacon is `~/reposoma/registry/reposoma.devenv.md`;
> the binding contract is `reposoma.devenv/PROJECT.yaml`; the locks are `reposoma.devenv/flag.md`.
> **Every claim below is dated and confidence-flagged. Re-verify volatile facts before leaning on them.**

---

## 0 · Status truth (verified 2026-06-24, against artifacts — not status lines)

The project's own status files disagreed, so this was checked against the real files on disk.
**Evidence tier is named per row** (direct-read vs proven-by-output vs documented-only):

| Claim | Verdict | Evidence (this run) | Tier | Conf |
|---|---|---|---|---|
| **P0 ribosome loop BEAT** | ✅ true | `registry.jsonl` holds 3 records at status `synthesized` — which *requires* both `register` (writes `pending_synthesis`) and `synthesize` to have run; `bin/register` read directly = complete working python3 | read + proven-by-output | **H** |
| **P1 H-temporal trace BEAT** | ✅ true | `trace.jsonl` read directly = 3 moves carrying the `subject` join-key; `_grid::{direction,parent,subject}-graph.csv` exist (the emit→validate→flatten outputs) | read + proven-by-output | **H** |
| **P2 spectral engine NOT executed** | ✅ true | `Read` of `analysis_report.md` and `spectral/` both return "does not exist" (2026-06-24) | direct absence-check | **H** |
| `pulse.md` "P0 drafted / execution halted" (06-17) | ✗ STALE | superseded by the 06-18 beat above | inferred | **H** |
| beacon "onboarding · contract PENDING" (06-23, by @Atlas) | ✗ LAGGING | `PROJECT.yaml` plainly exists in the repo | inferred | **H** |

**Bottom line: the metabolism beats. P0 ✓ · P1 ✓ · P2 is the live frontier, designed but not yet run.**

---

## 1 · What reposoma IS (one paragraph)

**reposoma = repository × ribosome:** a standalone, portable, **file-based knowledge metabolism** —
`capture → register → synthesize → spectral-analyze → derived views`. A *translating machine*, not
an application. It is a **sibling of larva, not larva**; a sibling tool alongside `subai.devenv`.
No DB server, no vector DB, no cloud-required state. *(Source: `intake/reposoma.devenv.intake.md` §A,
`CLAUDE.md`. Confidence H.)*

`reposoma.devenv` is the **workshop** (P0 + dev happens here, decision !D1). `reposoma.v2` is reserved
for the finished-product app (a later promotion target). `/home/hruzam/reposoma/` is the data substrate.

## 2 · The five laws (the rails every contributor obeys — digest only; full text = charter §1)

1. **#loop-before-organs** — no organ before the smallest loop beats. *(This is why P0/P1 exist as running code, not docs.)*
2. **#pulse-regime** — sequential dispatch; abort on first failed step.
3. **#discipline-follows-authorship** — hand-maintain only what has no upstream; everything else is derived/rebuilt.
4. **#truth-lives-in-files** — jsonl/json/md/csv; **no DB server; NOT a vector DB** — association is the spectral embedding, *computed not stored*.
5. **#sovereignty** — own the md/jsonl/sh/py layer; vendor primitives are thin, re-pointable sockets.

*(Source: `flag.md`, `CLAUDE.md`. Confidence H.)*

## 3 · The architecture in one breath

`FILES carry truth (LAW-4); the spectral EIGENVECTORS carry association.` The "vectors" are
**computed from the file-graph, not a database that replaces it.** Five layers:

1. **The ribosome loop** (P0) — `register → synthesize → check → retrieve`. *(built)*
2. **Truth in files** (P0) — `store/*.md` + `registry.jsonl` + `trace.jsonl`. *(built)*
3. **Two hemispheres → adjacency** (P1–P3) — H-spatial (wikilinks + registry co-occurrence) + H-temporal (the move trace). *(H-temporal built)*
4. **The spectral engine** (P2–P3) — `B → L_sym → eigh → (λ, U)`; eigenvectors `U` = each node's associative vector; clusters / centrality / Fiedler gap. *(planned, hardened, not yet run)*
5. **Derived views** (P1+) — fzf retriever · graph organ (?Q-8) · dashboard. All zero-discipline, swappable organs.

Full drawing: `reposoma.devenv/architecture.vision.md` (sovereign mermaid). *(Confidence H.)*

## 4 · What is built on disk (the concrete artifacts)

- **`bin/`** — `register` (sole id-minter, `vYYMMDDHHMMSS-NN`, stdlib-only python3 — **read directly this run**) · `synthesize` · `check` (the 3-assertion audit) · `retrieve` · plus P1 `emit` · `validate` · `flatten`.
- **`registry.jsonl`** — `{id,path,source,status,ts}`, append-only. 3 live records (read directly).
- **`store/`** — `<id>.md` with YAML frontmatter (`id/source/status/links`).
- **`trace.jsonl`** — H-temporal moves `{step,depth,kind,anchor,from,to,ts,subject}` (read directly). **`subject` = registry id, REQUIRED for content kinds — the H-temporal↔H-spatial join key** (a @Janus catch that makes the P3 composed query possible).
- **`_grid::{direction,parent,subject}-graph.csv`** — the P1 flatten projections; `subject-graph` is the bridge.
- **`.register.counter` / `.register.last_ts` / `.emit.step_counter`** — monotonic-id / monotonic-step guards. **Do not delete** (resetting = dirty trace).

*Provenance: `bin/register`, `registry.jsonl`, `trace.jsonl` read directly (2026-06-24, Conf H). The other
`bin/` scripts (`synthesize`/`check`/`retrieve`/`emit`/`validate`/`flatten`) and `store/` are not read this run —
their existence is **proven by their outputs** (the `synthesized` records, the trace, the `_grid::` CSVs).
The specific claim "`check` refused invented wikilinks" is **documented in `flag.md`/HANDOFF, not re-verified here** (Conf M).*
*(`trace.bad.jsonl` is a test fixture, slated to move to `tests/`.)*

## 5 · The team & the one head (how work is split — locked, §D)

One head: **@Houston** (reposoma basement architect) holds canon; **@majkee** (operator) is the human gate.
Grounded by RR-01, Janus-passed, **LOCKED**:

- **Claude (STANDING · lead)** — architecture · canon authorship · agentic Synthesizer design · cross-team audits + tests · the spectral numerics test-loop · the plan.
- **Composer/Cursor (STANDING · owner)** — deterministic tools (register, retrieve, validators, `_grid::` flatteners, dashboard) + surface/skin; cheap-exact (~1/10 cost), Claude audits.
- **Codex (ON-DEMAND)** — hard-math consult on spectral algebra; C++/native brick if ever summoned.
- **Gemini (ON-DEMAND · consult-only)** — method-math cross-check + large-context re-synthesis; owns no brick. *(Note: Gemini solo-delivery CLI sunset ~2026-06-18 — verify any auth path still survives before relying on it.)*

*(Source: `intake/reposoma.devenv.intake.md` §D, `flag.md`. Confidence H. Exact allocation is volatile — treat the §D source as authoritative.)*

## 6 · What sibling projects can reuse (the shared anchors)

- **spectral** — the same engine math (Laplacian → eig → KMeans) that `subai.devenv` uses. **Divergence worth knowing:** reposoma runs it as an *asynchronous batch-pulse analyzer* (cares about Fiedler/fragmentation telemetry); subai runs it as an *interactive out-of-process MCP tool* (cares about fast retrieval). *(Source: `research/outputs/spectral-engine.findings.2026-06-18.md`. Confidence H.)*
- **X→Z research law** — every study returns **X** (grounded @date) + **Z** (a develop-it vector, parked behind a flag, never on the spine).
- **Cooperation convention** — mail shape `<to>/<from>.<topic>.<utc-ts>.md`; **human pulls the trigger** (no headless bus until measured volume); research rides `research/inputs → research/outputs`.
- **piql** — decided as an *optional privacy-gate brick*, NOT the flash/mouth socket. *(`research/outputs/piql.decision.2026-06-17.md`.)*
- **vector-language** — the reduced 5-move profile (claim/decision/defer/gap/hook) for v0; full 13-move spec preserved in files.

## 7 · The live frontier (P2) and what's still open

**P2 spectral-spatial is ACTIVE (designed, not yet run — see §0).** The engine design is Janus-hardened:
**dense `scipy.linalg.eigh`** (not `eigsh` — degenerates on tiny graphs; eigsh reserved for >10k nodes) ·
symmetric `L_sym` for clustering but **directed adjacency for centrality** · λ₀-multiplicity guard +
**eigengap-magnitude refusal** (refuse to name `k` when the gap is mush → honest "no stable structure").
The P2 gate is an **honest fragmentation diagnostic**, not a forced cluster — a "too sparse to cluster"
finding is *success* (it's the telemetry that unlocks the conditional P2.5 link-inference). Batches:
0 (corpus ingest, Composer) · B (golden fixtures, Claude) fire first; A (numerics, Codex) follows B;
C (H-spatial compiler, Composer) follows 0; D (driver+report, Claude) last. *(Batch→owner detail is volatile;
`session/plan/session.plan.md` is authoritative.)*

**Open forks (NOT locked — do not assume answers):** ?Q-5 full socket↔seat map + MCP yes/no ·
?Q-7 bounded link-inference (justified ONLY by P2's own fragmentation telemetry) · ?Q-8 graph organ
(Cosmograph / Sigma.js / Vizdom candidates) · trace pruning/GC. **D6 abort convention** is grounded
(exit-code + step/wall-time caps + a write-allowlist fence — see `flag.md`/`session.plan.md` for the exact
codes) but pending one @Janus pass.

*(Source: `session/plan/session.plan.md`, `flag.md`. Confidence H.)*

## 8 · Where the real canon lives (read these, do not trust this file for detail)

| You want… | Go to |
|---|---|
| the contract (the one file an agent may assume) | `reposoma.devenv/PROJECT.yaml` |
| the locked decisions (do-not-relitigate) | `reposoma.devenv/flag.md` |
| the charter (architecture + §6 gavels + §8 addendum) | `reposoma.v1/DASHBOARD/synth.restart.reposoma.md` (canonical) |
| the bed (owner-split, gavels, Z-catalog) | `~/reposoma/raw.guides/intake/reposoma.devenv.intake.md` |
| the architecture drawing | `reposoma.devenv/architecture.vision.md` |
| conventions + boot order + 5 laws | `reposoma.devenv/CLAUDE.md` (the lighthouse) |
| the volatile now-state | `reposoma.devenv/pulse.md` (⚠ was stale at 06-17 — verify against artifacts) |
| the pointer beacon | `~/reposoma/registry/reposoma.devenv.md` |

> **Sovereignty note (LAW-5):** this overview is an *orientation pointer*, not a second canon.
> When it and the source files disagree, the **source files win** — and tell @Houston so this gets refreshed.

---

`sections to refresh: §0 status truth (re-verify P2 execution state) · §7 frontier (when a batch lands) · §5 team (if Gemini auth path changes post-sunset) · the stale pulse.md + 06-23 beacon (flag to @Houston).`
