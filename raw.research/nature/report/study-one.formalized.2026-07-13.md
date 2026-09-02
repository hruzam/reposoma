# Agentive Fold — Decentralized Memory Substrate
## Method (A), fresh pass — folded directly from the raw empirical substrate

_Source: the raw research substrate (`raw.nature.2026-07-13.md`), folded in a single pass into
the intended target domain: a **decentralized agent-memory substrate** for LLM generation / RAG
/ agent orchestration. The contaminated neutral intermediate (`study-one.formalized`) and the
prior brief's hypotheses were **not** used as inputs — this is an independent derivation from
ground truth. Output vocabulary is agent-memory architecture only; the source domain does not
appear here (guard-safe by construction). Provenance to the raw substrate is by neutral pointer
only._

_This artifact **folds and flags**; it does **not** adjudicate whether the folded mechanisms are
genuine discoveries or rediscoveries of known practice. That reality-check belongs to the
laboratory (hard opposition + the challenger seats). Where a fold lands on an existing technique
it is marked `COLLISION:` as a **target for the challengers** — never as my verdict._

### Tag legend
- Source provenance (strength in the raw substrate): `MEASURED` · `INFERRED` · `DISPUTED` (raw flags it contested).
- Fold fidelity: `FOLD:TIGHT` (clean, non-trivial map) · `FOLD:LOOSE` (target mechanism strained/underspecified).
- `COLLISION:<technique>` — resembles known practice; challengers test identity-vs-difference.
- `ARTIFACT-DROPPED` — source detail with no target-domain signal; removed deliberately (listed at end).

---

## Domain map (the load-bearing dictionary)

| Structural role (source) | Agent-memory instantiation |
|---|---|
| the network | the decentralized memory substrate (shard mesh, no coordinator) |
| a growing thread | an ingestion/index thread that appends new entries at its active write-head |
| write-head / advancing frontier | the ingestion boundary — where new items are written and indexed |
| loop-closing fusion | associative cross-linking that closes redundant retrieval cycles |
| dedicated transport conduit | a high-throughput bulk-retrieval channel |
| commodity-C (source-class output) | compute/attention budget + generated context, flowing generation→memory |
| commodity-P/N (returned) | retrieved grounding context, flowing memory→generation |
| transport tiers (3 scales) | retrieval latency tiers: in-context / warm-index / cold-bulk pull |
| sink-generated pull | demand-pull: the generation state itself creates the retrieval pull-field |
| discrete signaling channel | the control-plane: coordination events, separate from context transport |
| hub node | a hot shard (heavy-tailed access) |
| decompose-and-reindex intake | the ingestion pipeline: raw inputs → indexable, retrievable units |
| hysteretic lifecycle switch | substrate state transition (serve ↔ consolidate/export) |
| drift-suppression | index-staleness / knowledge-drift control |
| frontier vs stable core | churny unverified indices vs low-churn verified core |
| dormant standby | cold/archived shards with warm-resume |
| identity across generations | logical substrate identity persisting across model/agent swaps |
| obligate vs facultative | pure-RAG agents vs strong-parametric agents |

---

## A. Substrate topology — cyclic-redundant, not a tree

- **Redundancy as a byproduct of associative linking.** The substrate grows as a branching
  write-frontier; when two index threads independently reach related content, a local fusion op
  cross-links them, closing a cycle. Each closed cycle yields ≥2 disjoint retrieval paths, so a
  single shard/link failure reroutes with no coordinator — redundancy is a *free byproduct* of
  the linking primitive, not a bolted-on replication layer. *Use-case:* fault-tolerant retrieval
  graph where resilience emerges from semantic cross-linking rather than explicit N-way
  replication. `MEASURED · FOLD:TIGHT · COLLISION: multi-path routing / replication`
- **Sign-switching attachment (spread, then consolidate).** New index threads first repel
  (maximize coverage), then interior threads attract and fuse (build connectivity) — a two-phase
  deployment. *Use-case:* ingestion policy that spreads for coverage on new corpus, then
  back-fills cross-links in hot regions. `MEASURED · FOLD:TIGHT`
- **Tunable coverage density (exploratory ↔ exploitation).** Deployment ranges from sparse-linear
  (fast, broad, cheap recall) to dense-mesh (thorough, high-connectivity); coverage per unit
  space stays ~constant as the corpus grows. *Use-case:* adaptive index density — spend budget
  where queries concentrate, stay sparse elsewhere, no global reindex.
  `MEASURED · FOLD:TIGHT · COLLISION: HNSW density params / adaptive indexing`

## B. Retrieval transport — distance-stratified tiers, demand-pulled

- **Three concurrent retrieval tiers, selected by scope.** T0 in-context (already in window; free
  but sub-scope) · T1 warm-index hop (active, bounded cost, mid-scope) · T2 cold-bulk pull
  (dominant for large/distant context). The effective tier minimizes transit time at that scope;
  the span is ~orders of magnitude in latency. *Use-case:* a retrieval stack that auto-selects
  tier by scope. `MEASURED · FOLD:TIGHT · COLLISION: cache hierarchy`
- **The consuming end powers its own supply (demand-pull).** The long-range tier is *sink-driven*
  — consumption at the generation end creates the gradient that pulls supply toward it. Folded:
  the generation process itself (embedding demand / attention state) continuously generates a
  pull-field that draws relevant context in, rather than emitting explicit `retrieve(k)` calls.
  *Use-case:* **gradient-pull RAG** — context flows to the generator by a demand-field, not by
  request messages; retrieval becomes continuous and self-powered.
  `MEASURED · FOLD:TIGHT · COLLISION: reactive-streams / backpressure` — *the distinction to
  challenge:* protocol-pull (consumer sends `request(n)`) vs gradient-pull (consumer's state
  physically generates the pull field).

## C. Generation↔memory exchange — coupled counter-flow

- **Fixed-proportion compute↔context coupling.** Generation emits compute/attention (C); the
  substrate returns grounding context (P); the two rates are, on average, proportional — a
  system-level exchange-rate constraint that governs substrate growth. *Use-case:* a
  self-regulating retrieval budget where context delivered scales with compute spent.
  `MEASURED · FOLD:TIGHT`
- **Compute gates expensive retrieval.** A secondary, costly retrieval mode (multi-hop / rerank)
  is *gated by* available compute — deep retrieval fires only when budget is high. *Use-case:*
  compute-gated adaptive retrieval depth. `INFERRED · FOLD:TIGHT · COLLISION: cost-based query planning`
- **Relatedness-conditioned, mostly one-way transfer.** How much context one shard forwards to
  another depends strongly on their semantic pairing; flows are predominantly one-directional per
  pair. *Use-case:* asymmetric relatedness-weighted propagation (not uniform gossip).
  `MEASURED · FOLD:LOOSE` (mechanism target underspecified)

## D. Load redistribution without a coordinator

- **Scarcity-inverse over-service (arbitrage load-balancing).** Shards in resource-poor regions
  over-serve per unit capacity; the substrate redistributes toward shortage with no coordinator —
  market-arbitrage load-balancing. *Use-case:* **coordinator-free load-balancing** — route
  tasks/context toward underloaded shards via a scarcity-inverse rule.
  `MEASURED · FOLD:TIGHT · COLLISION: gossip LB / power-of-two-choices` — *challenge:* does
  scarcity-inverse *structured* transfer differ from approximate gossip redistribution?
- **No fixed producer/consumer (source-sink reversal).** Context-flow direction across a shard
  pair reverses with current demand — active allocation, not gradient descent. A shard that was a
  sink for topic A is a source for topic B. *Use-case:* bidirectional context sharing where roles
  flip by query context. `MEASURED · FOLD:TIGHT`
- **Deficit signal steers ingestion (demand-driven indexing).** A shortage signal from a consumer
  steers new indexing toward that consumer's interface — a deficit broadcasts a gradient that
  pulls ingestion toward unmet demand. *Use-case:* index where demand is unmet, driven by a
  deficit gradient. `MEASURED · FOLD:TIGHT · COLLISION: workload-adaptive indexing`

## E. Control-plane separation

- **Fast discrete control channel, decoupled from data.** A control-plane carries discrete
  coordination events (invalidations, priority, liveness) mechanistically separate from the bulk
  context data-plane — proven separate (control persists when data transport is blocked).
  *Use-case:* coordination on a fast discrete bus independent of context movement.
  `MEASURED · FOLD:TIGHT · COLLISION: SDN control/data split · Raft heartbeats · sidecar`
- **Priming ahead of demand.** A consumer under stress propagates a signal that lets neighbors
  pre-warm *before* direct demand arrives. *Use-case:* mesh-propagated predictive prefetch /
  cache-warming ahead of load. `MEASURED · FOLD:TIGHT · COLLISION: predictive prefetch`
- **Signal/load confound (observability caution).** Control-channel activity mixes true
  coordination signals with a *byproduct signature of retrieval work itself* — the two aren't
  cleanly separable. *Implication:* don't read control-plane telemetry as pure intent; part is
  the shadow of load. `DISPUTED · FOLD:LOOSE`
- **Conduction verified, effect unproven.** Control events reliably propagate shard-to-shard
  (verified), but what they *accomplish* downstream is unproven, and the full stimulus→response
  latency of the control path is unmeasured. *Implication:* don't close tight control loops on
  this path without measuring its transfer function.
  `MEASURED (conduction) / DISPUTED (function) · FOLD:TIGHT / function-open`

## F. Hub structure & fragility

- **Scale-free hot shards.** Heavy-tailed access — a few hot shards carry most retrieval degree;
  new shards attach preferentially to hot ones. Robust to *random* shard loss, fragile to
  *targeted* hot-shard loss — the dominant availability-risk surface. *Use-case:* capacity-plan
  and replicate hot shards specifically; the substrate self-organizes hubs but inherits scale-free
  fragility. `MEASURED · FOLD:TIGHT · COLLISION: celebrity-key / hotspot / CDN hot objects`

## G. Ingestion & re-index pipeline

- **Decompose-and-reindex intake as a first-class role.** A class of the substrate specializes in
  breaking raw, unstructured input into indexable units and folding them back into retrievable
  knowledge — closing the loop that generation opens. Distinct from the exchange role: this class
  sources knowledge from *inert corpus*, not from live generation. *Use-case:* an
  ingestion/normalization pipeline as a separable substrate role (chunk, normalize, embed,
  re-index), decoupled from serving.
  `MEASURED · FOLD:TIGHT · COLLISION: ETL / chunking pipelines` (note the *role-separation* claim)

## H. Staleness & drift control (the structural-stability cluster)

- **Drift suppressed by structure, not per-write fidelity.** Four mechanisms:
  1. **Write-dilution at the frontier** — new writes diluted across many candidate shards,
     lowering the chance any single bad write fixes into the core.
  2. **Low-write stable core (growth by extension)** — the substrate grows by adding new shards,
     not by mutating the stable core; the core is near-read-only.
  3. **Correction hardened over lifetime** — the long-lived error-correction path sharpens with age.
  4. **Role-asymmetric error partitioning** — route *unverified* new retrievals to expendable
     frontier indices (high churn, fast eviction); keep *verified* context in the stable core
     (low churn). Uncertainty goes to the disposable layer; tested knowledge to the durable layer.
  *Use-case:* a **two-tier index where uncertainty is routed by role** — new/unverified → churny
  frontier, quality-gated → durable core; stability becomes a *structural* property, not a
  per-write-fidelity property.
  `MEASURED · FOLD:TIGHT · COLLISION: LSM levels / hot-cold tiering` — *challenge:* is
  error-routing *by role* (uncertainty→expendable, tested→durable) implemented anywhere, or do
  current tiers treat all nodes as equivalent?
- **Spatial staleness clock.** Index staleness scales with *knowledge-space extent traversed*,
  not wall-clock time — implying most of the substrate is low-write and writes localize to the
  frontier. *Use-case:* scope/measure staleness per unit corpus-growth, not per unit time.
  `MEASURED / INFERRED · FOLD:LOOSE` (elegant reframe; target metric underspecified)

## I. Substrate lifecycle & identity persistence

- **Hysteretic serve→consolidate switch.** A substrate region switches from steady-serving to a
  terminal consolidation/export program only when a *conjunction* of conditions holds, with ≥2
  *direction-sensitive* (hysteretic) triggers — one suppressant variable must **fall** to release
  the switch; one ratio variable **reverses** between phases. (Specific physical setpoints are
  source-domain and omitted.) *Use-case:* **hysteretic compaction/export trigger** — make
  serve→compact depend on trajectory (load must fall *and stay fallen*), not instantaneous level,
  to avoid thrashing.
  `MEASURED (structure) · FOLD:TIGHT · COLLISION: AIMD / circuit-breaker hysteresis / LSM compaction`
- **Export/replication to new deployments.** Once consolidated, the substrate emits compact,
  dispersible index-packages that seed new deployments. *Use-case:* index snapshot/export as the
  propagation primitive. `MEASURED · FOLD:TIGHT · COLLISION: snapshot/export`
- **Identity persists across component and generation churn.** The substrate has no intrinsic
  lifespan; shards churn continuously while *logical identity* persists (conditional on reachable
  new corpus, no competitive eviction, drift under threshold) — and continuity survives the
  termination of any single *consumer* (agent/model). The memory bridges across model
  generations; consumers are transient attachments. *Use-case:* a **model-agnostic,
  identity-persistent memory substrate** that outlives model swaps, verified by uniform-signature
  identity across full extent.
  `MEASURED · FOLD:TIGHT · COLLISION: CRDT / consistent-hashing / externalized memory`
- **Dormant standby with warm-resume.** Cold/archived shards retain full resume capability without
  full reindex (distinct from cold-start). *Use-case:* archive tier with fast rehydrate.
  `MEASURED · FOLD:TIGHT · COLLISION: snapshot-restore`

## J. Dependency classes

- **Obligate vs facultative consumers.** Two consumer classes by dependency on the substrate:
  **obligate** (pure-RAG agents with no standalone knowledge-extraction — cannot function without
  live retrieval; total dependency) vs **facultative** (strong-parametric agents; retrieval
  optional/beneficial; retain a standalone mode plus an *alternative acquisition route* — tool-use
  / web — independent of the substrate). *Use-case:* **differentiated availability SLA** —
  obligate consumers make the substrate availability-critical; facultative consumers tolerate
  degraded mode. `MEASURED · FOLD:TIGHT · COLLISION: hard/soft dependency service design`
- **Soft boundary (a spectrum).** The obligate/facultative partition is soft — some facultative
  agents retain limited standalone extraction. *Design for a continuum of retrieval-reliance, not
  a binary.* `MEASURED · FOLD:TIGHT`

---

## Consolidated candidate use-cases (the "possible cases of use")

The strongest concrete design candidates the lab can build and oppose:
1. **Gradient-pull RAG** (B) — generation state generates the retrieval pull-field; continuous, self-powered retrieval.
2. **Coordinator-free scarcity-inverse load-balancing** (D) — route toward underloaded shards, no coordinator.
3. **Role-asymmetric error-partitioned index** (H) — uncertainty→frontier, verified→durable core.
4. **Control-plane / context-plane separation** (E) — fast discrete coordination bus.
5. **Hysteretic consolidation/export trigger** (I) — trajectory-gated serve↔compact.
6. **Model-agnostic identity-persistent substrate** (I) — memory outlives model generations.
7. **Deficit-gradient demand-driven indexing** (D) — index where demand is unmet.
8. **Differentiated availability SLA by dependency class** (J).

## Where the map strains (for the challengers)

- `FOLD:LOOSE`: relatedness-conditioned transfer (C), signal/load confound (E), spatial staleness
  clock (H) — target mechanisms underspecified; oppose or sharpen.
- Heavy `COLLISION` load: control-plane separation (E), hot-shard fragility (F), hysteretic switch
  (I), identity-persistence (I), ingestion pipeline (G), dormant standby (I) — these land on
  established practice; the lab decides *known* vs *novel*. I only mark the collision.
- Lowest collision / highest novelty-candidate: gradient-pull vs protocol-pull (B), scarcity-inverse
  *structured* transfer (D), role-asymmetric error partitioning (H). If genuine novelty exists,
  the map *localizes* it here — but I do not adjudicate it.

## Deliberately dropped (ARTIFACT-DROPPED — source detail with no target signal)

- Specific global-scale magnitudes (a source-domain fingerprint, no agent-memory meaning, and a
  re-identification beacon).
- The environmental setpoint *values* behind the hysteretic switch (kept the gate *structure*;
  dropped the physical numbers).
- Source-domain material/chemistry of the protective casing, and the low-level
  lifecycle/replication mechanics — no target-domain analog beyond "cold standby" and "export."
- All source-domain naming throughout — output is target-domain only.

---
_Fold complete. This artifact **maps and flags**; the laboratory **opposes and rules**._
