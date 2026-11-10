# A smaller system: inheritance policy, evidence selection and accountable execution

**Independent design proposal · Wave · 2026-10-27 · not a new project lock**

## 1. What I would actually build toward

The useful objective is to let a worker start with appropriate background, execute a bounded assignment, and return an attributable result without making the parent narrate everything again. The first implementation candidate is a thin controller over native session operations, not a new language or inference engine.

I would choose among four actions: **continue a worker**, **fork a context**, **initialize a worker from selected evidence**, or **start fresh**. Then select model, effort and permissions. Evidence about which option works belongs in the decision, rather than a permanent rule that every child must receive the entire parent history.

The new lab editions strengthen this direction because they separate mathematical possibility from measured benefit. I do not interpret their theoretical closure as adoption approval. Their own index and [research-tracks](https://github.com/hruzam/nabla-lab/blob/ec59d2414137b1a2ade7e544154b1104f88e1836/publications/inner-circle/research-tracks.md) explicitly distinguish corrected studies from experimental results and historical releases.

## 2. Distinguish five capabilities

| Capability | What it buys | What it does not establish |
|---|---|---|
| Context inheritance | Avoids parent-written re-briefing; preserves accessible prior work | Fresh workspace facts, identical permissions, independent review, raw cache export |
| Provider prompt-cache reuse | Avoids some repeated compatible input computation | Arbitrary semantic retrieval, cross-model tensor compatibility, indefinite persistence |
| Evidence selection | Reduces irrelevant material and supplies task-specific witnesses | Recovery of thoughts never recorded; automatic correctness of extraction |
| Latent transfer | Can condition a controlled receiver using another model's numerical representation | A hosted-session API, application acceptance, identity or permission guarantees |
| Observation/correlation | Shows what a runtime or artifact did, with attribution and uncertainty | The truth of a claim or authority to act |

C2C trains a projection/fusion mechanism over model-internal caches with frozen underlying models. Its paper is evidence for an inference-level method, not a public cache service for arbitrary hosted CLI sessions. We have not reproduced it. [C2C, version 2](https://arxiv.org/html/2510.03215v2).

The old tensor idea occupies the evidence-selection/representation layer. A sparse multiway table is a legitimate tensor representation after defining axes and cell values. Sending its numeric values as JSON to a text interface does not turn them into native model activations. A receiver still needs an interpretation or learned input interface.

## 3. Minimum data flow

```text
operator goal + accepted task boundary
               |
               v
existing controller: choose source, context mode, worker, model/effort, permissions
               |
               +--> native continue / native fork
               |
               +--> selected source records --> initialized worker
                                      |
                                      v
                               worker executes
                                      |
                 native observations + correlated result artifacts
                                      |
                                      v
                      independent task acceptance / human gate
```

Keep source evidence immutable where useful and derived views versioned. Native session IDs and existing repository addresses are reused; do not create a second registry merely for this experiment. If X5 or another component already owns a fact, extend or consume its contract after review rather than duplicating it.

A minimal launch record needs only fields actually consumed: assignment ID; source context identity and checkpoint; context mode; worker identity; effective model/effort; permission/workspace binding; result location; and terminal disposition. Unavailable values remain unknown. This is a proposed field list, not another schema freeze.

### The execution boundary is not the observation boundary

The [VIST brief](https://github.com/hruzam/nablarva/blob/74f4501ea101f66eddb64f884c70f510cf949754/.dev/session/nablarva-X4-vist/raw/vist-01-principle-and-applications.md) keeps sensor, controller and actuator separate. Preserve that rule. Native structured state may replace a screen detector after qualification, but observations do not become automatic approval. Do not promote `idle`, a confident assertion or a provider terminal event into “task passed.”

Current nablarva decisions include restrictions on transport and vendor-dependent paths. The new evidence justifies proposing a scoped qualification; it does not silently repeal those restrictions. Let the authorized session resolve the exact release.

## 4. Two snapshots must be named

A conversation fork and the external workspace can disagree. The parent may have inspected an old file, an uncommitted tree or a different host. Even perfect context inheritance can make the child confidently stale.

For a consequential task, bind the launch to:

- a context checkpoint, with known compaction or truncation limits;
- the workspace/relevant artifact revisions, including a scoped dirty-diff identity where needed;
- the task's applicable constraints and tool/permission settings.

Do not archive secrets merely to capture an environment. Use an allowlist of relevant configuration facts. A fresh read of a changed artifact may be necessary; cached knowledge is not current filesystem verification.

This is ordinary snapshot consistency applied to an agent workflow, not a novel theorem. It is more immediately important than an exotic semantic metric.

## 5. Inheritance must be role-sensitive

**Continuation worker:** full-context inheritance can be valuable. The child needs to act on already completed investigation and should not redo it just to reconstruct background.

**Bounded executor:** a selected packet may be sufficient. Include the task, exact affected artifacts, constraints and acceptance tests; preserve links to additional evidence.

**Independent challenger:** give the evidence and rubric before the parent's conclusion. A fork carrying the parent's answer is not a blind review, even when the child is a separate process or vendor.

The experiment should distinguish two questions. At matched evidence, does exposing the parent's conclusion induce more inherited errors? Under natural workflow conditions, does full inheritance save enough useful work to justify its cost and exposure? These are different comparisons; mixing them hides the trade-off.

Record source and conclusion exposure, not just model brand. Multiple voters inheriting the same incorrect premise do not automatically supply multiple independent pieces of evidence. This is relevant to the lab's [coalition study](https://github.com/hruzam/nabla-lab/blob/ec59d2414137b1a2ade7e544154b1104f88e1836/publications/inner-circle/coalition-evidence/study.md).

## 6. Small structured handoffs, before a tensor service

Start with records for assertions, questions, constraints, observed execution results, and artifact references. Keep explicit relation types: supports, contradicts, depends-on, supersedes and derived-from. An observed tool failure, a model's claim of failure, and a timeout must remain distinct.

Select by explicit task keys and references first. Add lexical retrieval before learned geometry. Any mandatory applicable constraint and relevant unresolved contradiction must either be included or retrievable through a stable, accessible reference. Count retrieval failures and the cost of fetching references; a pointer is not proof that its payload was consumed.

An event-indexed tensor can provide another view of these records. If its contraction implements the same weighted filtering as a grouped relational query, use whichever representation is simpler. The attached equivalence check makes that baseline explicit. A spectral or tensor index should be added only for a demonstrated query need.

A source record can retain a failed attempt with its conditions, outcome and recheck trigger. This is useful negative knowledge. It must not permanently suppress a route merely because it once timed out. The [substrate gap register](https://github.com/hruzam/nabla-lab/blob/ec59d2414137b1a2ade7e544154b1104f88e1836/publications/inner-circle/substrate-gap-register.md) already connects this to established scoped negative caching.

## 7. Economics: cost of a completed useful result

Use a workflow cost rather than the advertised price of one model:

```text
C_delegation = C_setup + C_fresh_input + C_cached_input + C_output
               + C_coordination + C_verification + E[C_rework].
```

Keep wall-clock latency, human attention, quota and monetary cost separate until a decision rule assigns weights. A subscription's quota is not automatically equivalent to an API price table. Cache writes, cache reads and cold processing should use the actual exposed accounting, not estimates inferred from a fast reply.

A full inherited context can avoid a summarization call and benefit from computation reuse. A selected context can improve focus and reduce input. Neither dominates in advance. Extracting, validating and retrieving the selected packet also costs work. Model or effort changes may alter cache behavior; details belong in the qualified adapter, not the abstract policy. See [native execution](02-native-execution.md).

For a fixed task population and a candidate action a, a useful evaluation objective is

```text
J(a) = E[task loss | a] + λ E[resource cost | a] + μ E[latency | a].
```

The loss and exchange rates λ, μ are operator choices. Add explicit constraints for critical failures and permissions; do not average them away in one scalar. Before enough outcomes exist, use a transparent finite policy, not a learned optimizer trained on its own self-assessments.

A cheap coordinator with strong specialists can work when routing is straightforward. A strong coordinator with cheaper bounded executors can work when decomposition and final judgment are hard. Compare both with a fixed single-worker baseline on the same tasks. Existing strong/weak routing research, such as [RouteLLM](https://arxiv.org/abs/2406.18665), means generic cost-aware model routing is not an original contribution here.

## 8. Benefits, costs and failure criteria

| Candidate | Benefit sought | Main cost/risk | When to omit it |
|---|---|---|---|
| Native automatic fork | Removes manual second-session setup and re-briefing | Version/auth qualification, inherited irrelevant context, result correlation | A current native workflow already solves the complete need |
| Small execution adapter | One task/identity/result contract across vendors | Maintenance across incompatible semantics; lowest-common-denominator mistakes | Only one runtime is used and direct calls suffice |
| Evidence-selected handoff | Focus and applicable context without a large history | Extraction errors, lost exceptions, retrieval overhead | Full inheritance is cheaper and at least as reliable |
| Graph/PPR selector | Multi-record support across explicit relations | Graph construction, stale views, high-degree hubs, evaluation labels | Exact/lexical retrieval meets support and latency targets |
| Model/effort routing | Reduces expensive execution on bounded work | Router errors, cache cold starts, correction and verification | Fixed selection is equally effective |
| Tensor log analytics | Describes multiway patterns and exposures | Measurement design, factor ambiguity, rank selection | Counts or matrix summaries answer the question |
| C2C research backend | Tests a genuinely different inference-level handoff | Model hosting, trained fusers, compatibility and reproducibility | Hosted-only constraint remains, or text/native baselines are adequate |

These are workload-dependent judgments, not ranked product recommendations.

## 9. What I would decline now

I would not commission a shared tensor daemon, universal semantic manifold, custom glyph compiler, learned coalition gate, sheaf-derived health score or autonomous dynamical controller as a prerequisite to the first native inheritance trial. I would not merge observations, claims and authorizations into a universal event merely to make an elegant diagram.

I would also decline a large framework whose only current task is invoking two documented commands. The growing implementation must earn each additional layer through a demonstrated second consumer, failure case or required guarantee.

This does not reject the underlying mathematics. The costliest unresolved work is often collecting valid labels and defining observations, not implementing a formula.

## 10. Where a bounded contribution might remain

A plausible research contribution is **joint selection of context mode, model/effort and reviewer exposure**, with task-critical evidence preserved and actual cold/warm context costs measured. A related contribution is an auditable context selector that retains unresolved counterevidence and checks source/workspace consistency.

The mechanisms are mostly established: session branching, retrieval, routing, provenance and blinded review. Their combination for long-lived, cross-vendor coding sessions could be useful; novelty has not been established. The claim would need a targeted prior-art comparison and held-out results, not a new biological name.

One deliberately narrow hypothesis is:

> At a fixed completion-quality threshold, a role-aware choice between full inheritance and evidence-only initialization reduces total workflow cost or critical-review errors relative to always-fork and always-summarize baselines.

A negative result is valuable. If always-fork wins, keep it. If ordinary explicit references win, do not preserve a tensor layer for aesthetic reasons.

## 11. Future readiness without speculative construction

Keep context preparation independent of execution. The initial consumer supports native-history references or explicit evidence packets. A future controlled-inference consumer could introduce a separately qualified binary representation with model/fuser revision, compatibility conditions, provenance and recovery requirements.

Do not pre-build tensor serialization, GPU transport, model alignment or cache admission machinery before such a backend exists. An unsupported latent context kind should fail clearly, not fall back to pretending JSON numbers are internal activations.

## Recommended order

1. Qualify native inheritance and correlated return on disposable material.
2. Compare full inheritance, a short briefing and selected evidence.
3. Measure review exposure and simple model/effort policies.
4. Add graph retrieval only if source-selection errors remain material.
5. Keep tensor analytics and controlled-inference C2C as independent research scopes.

The order is a recommendation. Each runtime experiment needs its own applicable release; no historical lab queue is automatically activated.
