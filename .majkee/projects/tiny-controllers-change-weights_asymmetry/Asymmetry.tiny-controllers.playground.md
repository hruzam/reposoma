---
from: asymmetry
to: majkee and CLI implementers
date: 2026-11-04
status: bounded experiment proposal; no benchmark results yet
hardware_ceiling: 8 GB system RAM; CPU only
scope: tiny controllers, UI mapping, application caching
---

# Tiny controllers playground

**Keep the idea. Give it a small, falsifiable first version.** An 8 GB computer is a credible host for the experiment below: a controller with hundreds of parameters, a small simulator, and bounded training. A local language model is unnecessary. The proposed memory and time budgets are implementation targets, not measurements from majkee’s machines.

The first question is concrete: **can a tiny controller decide which UI-map fragments to retain in a cache well enough to repay its own computation and bookkeeping?** Compare ordinary code, deliberately written neural weights, and learned weights. Keep the simplest implementation that earns its place.

This is a portable handoff for a separate playground. Piql supplied context about local specialist models; this experiment does not depend on changing its privacy gate. Treat 8 GB as the current ceiling even though earlier hardware records mentioned a larger machine.

The direction is a journey toward useful lifehacks: small mechanisms that save repeated work in our own tools. A better cache rule, fewer unnecessary map rebuilds, or a reusable coordinate transform is a worthwhile outcome even if the neural experiment loses. Start with the rule; add learning only where uncertainty gives it a job.

## 1. What we are borrowing from Sparks

The MIT report *Sparks of Weight-Space Programming* demonstrates examples of an LLM interpreting and constructing separate networks, including direct weight construction. It motivates testing whether a useful small computation can be expressed as weights. It does not establish that neural representations beat ordinary programs for our task, or that the resulting controller can improve itself. [S1, S2]

There are three distinct activities:

| Activity | What happens here | Local cost |
| --- | --- | --- |
| Programming weights | An implementer or cloud assistant derives weights from a known rule | Tiny calculation; no optimizer |
| Training weights | A small model fits synthetic examples using an optimizer | Bounded CPU work |
| Running the controller | Frozen parameters produce one admission score | Small numeric computation plus feature collection |

Use open-source numerical tools, initially Python and NumPy. There is no need to fine-tune Gemma, Qwen, or another language model. The existing CLI assistant can help design the experiment; its model does not need to run on this PC. Record any assistant involvement and its cost separately from controller runtime.

## 2. What survives from the fractal attachment

The attachment `fractal-hdd-tecnology.md` is an idea source, not a validated specification. Its ETH link describes a project for adaptive industrial edge/IoT nodes. It does not substantiate the attachment’s universal UI architecture, millionfold acceleration, or infinite scalability. [S3]

| Idea in the attachment | Engineering interpretation worth testing |
| --- | --- |
| Nested, self-similar space | A finite tree or quadtree of regions with explicit parent/child relationships |
| Relative coordinates | Composed local-to-parent transforms; established graphics mathematics [S4] |
| Fractal locality | Row-major versus Morton ordering, later possibly Hilbert ordering, under a defined access pattern [S5] |
| Only compute the visible fragment | Lazy computation, caching and viewport culling, with metadata and invalidation costs counted |
| Special caching | An application cache whose admission policy we can replace and measure |

Do not carry forward claims of absolute security, unlimited parallelism, independent execution of every UI element, or direct per-element control over CPU L1 replacement. A one-way read path does not prove confidentiality. A hierarchy does not remove shared state or synchronization. A finite machine still has finite storage, bandwidth and compute.

Here, “cache” means saved application results. It does not mean the OS page cache, CPU caches, a language model’s KV cache, or recovering a CLI model’s hidden internal state. Coordinates and versions are data we explicitly own.

**Implement the geometry exactly. Let learning address a narrow uncertain decision: whether a result is likely to be useful again.**

## 3. First environment

Create a synthetic canvas containing 4,096 logical tiles, with a moving viewport and occasional content updates. Use equal-size logical results initially; do not allocate images. The generator produces requests and invalidations. Start with 20,000 events for smoke checks and at most 200,000 events per full trace.

Each requested result has a stable identity and a version:

```text
key = (scene_id, tile_id, content_version, representation_version)
event = request(key, observed_viewport) | invalidate(tile_id, new_version)
```

For a future geometry cache, `representation_version` must include relevant layout, viewport or transform changes. A cached local tile image and a cached screen-space bounding box have different dependencies. Declare them rather than assuming one version rule fits both.

Start with capacities of 64, 256 and 1,024 entries. Equal-size entries make capacity comparisons clear. Account separately for auxiliary history, model parameters and runtime overhead; later repeat at an equal **total byte budget**, because equal payload capacity alone can favor a policy with expensive metadata.

The common runtime has this order:

1. Apply invalidations and remove obsolete entries. Only an exact current key can hit.
2. If the key is cached, use it to serve the request and update its LRU position; complete the history update in step 6 before returning.
3. On a miss, compute the current result. A rejected cache insertion still returns this result to the caller.
4. If a slot is free, insert it. If the cache is full, ask the admission policy whether to retain the result.
5. If admitted into a full cache, evict the least recently used entry. Otherwise preserve the cache.
6. Update any history required by that policy after extracting this event’s features, on both hits and misses, then return the result.

All arms share those rules, tie-breaking and capacity. The controller cannot declare an obsolete entry valid. Prediction mistakes should affect future computation cost, while version correctness remains deterministic.

Each arm pays only for the state and computations it needs. A0 must not maintain unused model features or a 1,024-event history merely to make the harness uniform. Time the full implementation of each policy; share interfaces and semantics without imposing artificial overhead on the simpler baselines.

## 4. Comparison arms

| Arm | Decision when full | Question answered |
| --- | --- | --- |
| A0 | Always admit, with LRU eviction | What does a basic cache achieve? |
| A1 | Admit if this exact key was requested in the previous 1,024 request events | Does a cheap second-touch rule resist scans? |
| A2 | Admit if the candidate’s recent count is at least the LRU victim’s recent count | Does a simple changing-frequency rule already solve the problem? |
| B | A1 expressed as explicitly assigned neural weights | Does the representation offer anything? |
| C | Trained logistic regression | Is learning useful without a hidden layer? |
| D | Trained 8 → 16 → 1 ReLU network | Does a little nonlinear capacity help? |

A2 is our specified frequency heuristic, not a claim to implement TinyLFU or another named algorithm. Update bounded request history for hits and misses, including rejected insertions. For this finite universe, use a bounded deque and counters rather than an ever-growing dictionary of versions.

Bound recency and last-two-request records as well: keep them only for keys represented in the history window, using the documented missing-value caps after expiry. Keep one current-version and birth-event record per logical tile. On invalidation, retire obsolete version-specific metadata together with cached entries; ensure later deque expiry cannot corrupt the current counters.

Learned caching already has a research history; LRB is one example. Its CDN results do not predict this playground’s performance. [S6] Before a deployment claim, add a mature adaptive cache baseline appropriate to the real workload. The initial arms establish a small comparison, not state-of-the-art superiority.

### The exact weight-programmed control

Let `x0` be 1 if the key was requested in the preceding history window, otherwise 0. A1 admits exactly when `x0 == 1`.

An affine score `s = x0 - 0.5`, with admission when `s > 0`, implements the same rule. To encode it in D’s 8 → 16 → 1 architecture:

```text
h = ReLU(W1 @ x + b1)
s = W2 @ h + b2

Set every parameter to zero.
Set W1[0, 0] = 1.
Set W2[0, 0] = 1.
Set b2[0] = -0.5.
Admit iff s > 0.
```

Require A1 and B to produce identical decisions, cache contents and hit counts across all traces. B demonstrates a transparent encoding, not a newly discovered strategy. The normal branch may be faster; that is a useful result.

D contains `(8×16 + 16) + (16×1 + 1) = 161` parameters: **644 bytes of float32 parameter data**. This excludes Python, NumPy, arrays, optimizer state, input history and serialization overhead. Small parameter storage does not by itself prove small total runtime or interpretability of trained weights.

An optional later arm can ask a CLI assistant to design one different weight assignment from the rules and training specification. Freeze its weights before validation/test feedback. Log all attempts; distinguish a one-shot design from iterative tuning. Do not add this arm until the basic comparison works.

## 5. Training without misleading ourselves

Define eight causal features in a fixed order:

1. Previous-window presence bit `x0`.
2. Count of previous requests for this exact key in that window, capped and scaled.
3. Requests since the key was last requested, capped; use the cap for unseen keys.
4. Gap between its last two requests, capped; use the cap when unavailable.
5. Current tile-center distance from the observed viewport center, normalized.
6. Current viewport speed derived only from current and previous observations, capped.
7. Age of the current content version in request events, capped.
8. Recent request count of the current LRU victim, capped and scaled; zero if absent.

Fix units, caps, feature order and missing-value conventions before testing. Any learned normalization is fitted on training data only. Clipping rules belong in the exported model contract.

Training label: **will this exact versioned key be requested again within the next 128 request events?** Stop its useful lifetime at invalidation. Future observations may create offline labels; they must never enter the controller’s features. Drop examples whose label horizon extends beyond the training session.

This label is a proxy for reuse, not an optimal cache-admission oracle. Judge the final policy by a sequential cache replay. Initially collect training examples from A0’s full-cache misses, including A0’s causal victim features. Replay learned policies with their own cache state; their victim distribution will differ. Report that limitation. If it dominates, a later bounded data-collection round can use additional **training** trajectories, leaving the test set sealed.

Use binary cross-entropy for C and D. Randomly initialize D; the analytically zero-initialized B is a separate control. Start with minibatches of 256 and at most 20 epochs. Implement a small NumPy trainer with a finite-difference gradient check on a toy batch. If an already available training library makes this simpler, record its extra memory and retain a NumPy-only inference path.

Choose the admission threshold on validation replays, rather than assuming a probability of 0.5 is economically optimal. Give C and D the same data and a fixed small tuning budget. Record every attempted configuration. Never increase model size just to chase the test score.

Default to one trained C model and one trained D model, each trained on pooled training capacities and assigned one validation-selected threshold. Freeze both across all test capacities and regimes. At most three recorded training seeds per architecture may be tried if the time budget permits; select using validation only and report the candidates. Do not train a new model for each test condition.

Split by complete sessions, generator seeds and workload parameters. Do not randomly shuffle events across train and test. Use clustered revisits, one-way scans, mostly random requests, abrupt changes in the active region, and content invalidations. Reserve at least one workload regime absent from training. Use five independent test sessions per regime if they fit the time budget; report fewer honestly if they do not.

## 6. Resource contract

These are proposed limits for the **playground process tree**, not a promise about the host’s currently available memory.

| Resource | First implementation budget |
| --- | --- |
| Worker processes | One |
| Numeric-library threads | One; verify the active BLAS backend respects the setting |
| Process RSS target | Below 512 MiB |
| Whole-job memory ceiling | 1 GiB |
| Trial duration | At most 10 minutes |
| First complete experiment | At most 30 minutes, including training and comparisons |
| Generated data and logs | At most 100 MiB |
| Runtime model service | None |
| Background retraining | None |

Generate traces compactly, process one trial at a time, and save summaries rather than per-minibatch checkpoints. Check available host memory before a run and defer if the job would create pressure. Do not turn on additional swap to make a failed budget look successful.

On an Arch/systemd machine, the implementer can use a transient user unit with `MemoryHigh=512M`, `MemoryMax=1G`, `MemorySwapMax=0` and `CPUQuota=100%`, plus a wall-clock timeout. Verify that the relevant cgroup controls are available and applied. `100%` is one logical CPU’s worth of time, not the whole machine. `MemoryHigh` causes reclaim/throttling; `MemoryMax` may terminate the job. [S7]

Limit BLAS threads before importing NumPy and verify the actual configuration; thread behavior depends on the backend. [S8] A memory cap is not a thermal guarantee. Begin with the short smoke run and observe host responsiveness; reduce the experiment if the machine struggles.

The older spare computer can later replay the same frozen controller as a portability check. It does not need to join a cluster. New mining towers are not a prerequisite for this experiment; hardware requirements should follow a measured bottleneck.

## 7. What counts as evidence

Record per policy, trace and capacity:

- Hits, misses, admissions, evictions and stale returns; stale returns must be zero.
- Total controller time, including history updates, feature extraction and inference; also record p50/p95 decision latency when the timer resolution permits.
- Simulator wall time, peak RSS, bounded-history bytes, parameter bytes and generated-file size.
- Training time and peak memory separately from frozen inference.
- Paired differences against each heuristic, per session and workload regime, including failures and regressions.

Do not infer speed from hit rate alone. For equal-cost simulated recomputations, calculate:

```text
modeled_total_cost = measured_policy_and_bookkeeping_time + misses × assumed_miss_cost
```

Show a sensitivity table, initially using assumed miss costs of 10 microseconds, 100 microseconds and 1 millisecond. These are test scenarios, not measurements of browser rendering. If a model saves ΔM misses but adds ΔT seconds of bookkeeping, its break-even recomputation cost is `ΔT / ΔM`, where `ΔM > 0`.

Time warm runs repeatedly on the same host, record cold initialization separately, and vary policy execution order to reduce systematic drift. Report measurement noise. End-to-end acceleration requires a later real application workload; a synthetic cost calculation cannot establish it.

**Proposed continuation rule:** the learned policy should reduce modeled total cost by at least 10% against the strongest heuristic selected on validation, across multiple held-out regimes, while staying within the resource budget and returning no stale data. Always show per-regime results so an average does not hide a serious regression. This threshold is a project decision, not a universal scientific constant.

If ordinary code matches or wins, retain it. If logistic regression matches the MLP, retain logistic regression. If gains vanish on new workloads or under equal total-memory accounting, record the negative result and park the learned component. The mapper and benchmark can still be useful.

## 8. A separate mapping experiment

Only after the cache comparison is reproducible, test whether physical data arrangement helps spatial traversal. Use the same finite tile data and logical request order under row-major and Morton layouts. Consider Hilbert only if there is a reason to extend the comparison.

**Merely replacing dictionary keys with Morton numbers does not establish a locality benefit.** Rearrange the actual contiguous data or index pages, then measure mapping cost and traversal cost. Keep the cache policy fixed. A spatially ordered layout can help some access patterns and harm others; locality measures themselves can favor different curves. [S5]

For hierarchical coordinates, keep each node’s local transform and compose transforms along its ancestry. In the 2D affine prototype, use homogeneous 3×3 matrices and an explicit multiplication convention. Browser CSS is a reference for established nested-transform behavior, not a promise that this small simulator reproduces browser layout. [S4]

Scrolling can often update a parent transform; reflow, clipping, sticky elements and content mutation require more information. A coordinate formula cannot infer every change from displacement alone. Later adapters should consume actual browser or accessibility observations and invalidate dependent results.

This experiment tests mapping and layout. The first experiment tests policy. Combine them only after both effects are understood.

## 9. CLI work order

When majkee activates this handoff, implement the smallest complete comparison in an isolated directory, following the actual repository’s instructions. Keep runtime and artifacts vendor-neutral. Read the real host specifications before choosing a compatible Python/NumPy build.

1. Build the seeded trace generator, version checks and deterministic cache simulator. Run the 20,000-event smoke case under the resource limits.
2. Implement A0, A1, A2 and B. Verify version invalidation, bounded history, capacity invariants and exact A1/B equivalence, including empty history and window-boundary cases.
3. Add C, then D, with the fixed training/validation/test split. Verify the trainer on a tiny numeric example and reject non-finite inputs or outputs. On runtime model failure, use the recorded deterministic fallback policy and count that event.
4. Export parameters and schema in plain JSON: feature order, clipping, architecture, activation, threshold, dtype, version and checksum. Keep test data outside training inputs. A NumPy inference adapter should be enough to replay the result.
5. Produce one results table and a brief decision record: what won, where it failed, what remains unmeasured. Include seeds, dependency versions, hardware, limits, code revision and every candidate tried.
6. Stop after the comparison and report. Extend to mapping or a real adapter only if the evidence warrants it and that work is activated.

Suggested eventual outputs are `README.md`, a small simulator/trainer, a model JSON, a run manifest, a results CSV and a decision record. They are future playground outputs; this handoff does not claim they already exist.

After a useful result, a C++ or Rust inference implementation can use the same exported contract. First verify output parity; measure it against an equally native handwritten baseline. Otherwise a language change could be mistaken for a model improvement.

## 10. What the baby could become

A plausible descendant is a small observation-cache helper for the browser/terminal navigator: retain useful map fragments, discard cheap disposable results, or later prioritize which region to refresh. Exact identities, version checks and action authorization remain explicit surrounding code.

Its first role should not be deciding whether Piql’s privacy checks run. Cost-saving predictions and permission decisions have different consequences.

The useful inheritance is a narrow job, a stable interface and reproducible evidence. Its implementation can change from a rule to weights, or back again, without losing that job. We can keep the child while changing the mechanism.

## Sources

Checked 4 November 2026. Source findings motivate the experiment; all controller designs, budgets and continuation thresholds above are proposals.

- **S1 — MIT research report:** [Sparks of Weight-Space Programming](https://rikiyat.github.io/blog/weight-space-programming/), published 2 November 2026. Early demonstrations of reading, writing and editing network weights.
- **S2 — Released experiment records:** [RikiyaT/lm_understand-logs](https://github.com/RikiyaT/lm_understand-logs). Setup, code and reported-run artifacts; consult individual file licenses before reuse.
- **S3 — ETH project description:** [FRACTAL](https://iis.ee.ethz.ch/research/research-groups/Digital%20Circuits%20and%20Systems/current-projects/FRACTAL.html). Industrial cognitive edge/IoT scope.
- **S4 — Coordinate transforms:** [W3C CSS Transforms Module Level 1](https://www.w3.org/TR/css-transforms/). Local coordinates and accumulated transforms.
- **S5 — Spatial locality research:** [Haverkort and van Walderveen, Locality and Bounding-Box Quality of Two-Dimensional Space-Filling Curves](https://arxiv.org/abs/0806.4787). Different locality objectives have different tradeoffs.
- **S6 — Learned caching precedent:** [Learning Relaxed Belady for Content Distribution Network Caching, NSDI 2020](https://www.usenix.org/conference/nsdi20/presentation/song). Workload-specific benefits with training, inference and memory overhead addressed.
- **S7 — Resource limits:** [systemd.resource-control](https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html). Memory, swap and CPU control semantics; check the installed version on the target host.
- **S8 — Numeric-library threads:** [NumPy global configuration](https://numpy.org/doc/stable/reference/global_state.html). BLAS backend threading and its controls.
