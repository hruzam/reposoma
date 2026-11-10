# Which observations earn their compute?

**Independent architecture and experiment brief · Asymmetry → CLI collaborators · 10 November 2026**  
Find out whether a fresh CLI can reuse the work of a previous observer while still reporting the correct object, state and source. This experiment can start from a saved synthetic trace before Firefox integration exists. The figures below are proposed workloads or budgets. No hardware benchmark has been run for this packet.

## What survives, and what invalidates it?

| Item | Key and ownership | Invalidation and recovery |
|---|---|---|
| Conversation and decision record | Authored question, correction, evidence pointer and decision | Append a dated revision when the interpretation changes. Keep the old reason readable. This is the process history that lets another session resume the investigation. |
| Named pin and annotation | Project, page scope, logical business key and operator note revision | Retain on client exit or eviction of derived data. An edited pin gets a new revision. Missing or duplicate matches are legitimate outcomes. |
| Live binding | Adapter owner epoch, surface, document generation, frame and instance | Retire after owner restart, navigation, destruction or replacement. Rebind from the pin recipe. A recycled runtime ID cannot establish continuity. |
| Measurement | Binding, field, coordinate frame, revision, time and coverage | Reflow can invalidate bounds alone. An overlay can invalidate hit testing with unchanged bounds. Refresh only fields whose dependencies are known; uncertainty about coverage requires a scoped resnapshot. |
| Derived computation | Input digests or revisions, algorithm version, parameters and units | Reuse only when dependencies match. Quantized screenshot features, for example, cannot answer a question about a live DOM property. |
| Candidate ranking from a model | Input digest, preprocessing and model revision | Keep it advisory. An ambiguous key stays ambiguous until independent evidence distinguishes it. Measure inference time and wrong suggestions. |

Keep durable records outside the evictable data store. Keep one writer for a live surface. A second CLI asks for a scoped read of the same generation or replays an explicitly historical record. Remote workers, if tried, return derived results tied to an immutable input digest. Only the local surface owner can check whether that input is still current.

## One calculation with a known failure

At revision 10 a normal row starts at viewport y = 420 CSS px. The container scrolls down by an observed 120 px. Under a pure translation the predicted y is 300. If the measured y is 348, the residual is +48 px. A banner growing by 48 px is one explanation. Inspect the layout change or remeasure the relevant frame before assigning that cause. A residual of zero can coexist with a different order occupying the row, a disabled action, or an intercepting overlay.

Store the transform at the scrolling ancestor and compose it when a child is queried. Compare that with remeasuring every row. A pure translation can reduce repeated work. Resolving all children still costs work proportional to the number requested. Sticky elements, nested scrollers and animated transforms require separate evidence or an unsupported result. Record CSS pixels, screenshot pixels and terminal cells as distinct units.

## Minimum replay that can change a decision

1. Generate a fixed-seed scene with 100 order rows and two clients. Record the seed and input digest. Include ordinary scrolling, a fixed header, one banner insertion, an overlay, a duplicate key, document replacement, and a dropped change event. Have a separate fixture implementation emit ground truth by business key and field. The cache receives only the public event stream.
2. Compare three arms using identical traces and queries. **A** enumerates and remeasures the full scene. **B** reuses the named recipe and reads current fields directly, without transform caching. **C** carries a versioned frame transform and refreshes fields on demand. B isolates how much was gained simply by looking up one known order. Include final verification costs in all arms.
3. Start cold, repeat warm after a fresh CLI joins, then restart the owner. Test idle, repeated nearby reads and mostly one-off reads. Reserve independent seeds for evaluation. Drop one event, replay a duplicate, reorder two events and send an event from a retired epoch. On a sequence gap, mark affected coverage unknown until refreshed. No older event may revive a retired binding.
4. Record per arm and regime: correct results, expected and unexpected abstentions, stale answers labelled current, full discoveries, scoped reads, measurements, bytes crossing the CLI boundary, CPU time, peak resident memory, and elapsed latency per query. Separate browser startup from query time. Report run count and per-run distribution. Report modeled work and measured time in separate columns.
5. Gate correctness first: zero wrong-target answers, zero stale fields claimed current, explicit abstention in every injected ambiguous or unobservable case. A method that abstains on every case fails the ordinary reads. Keep C only if it improves a named bottleneck over B on the target host by enough to justify the extra state. Declare the relevant threshold before timing. Example for a latency-bound workload: at least 20% lower median warm latency across repeated runs with no material tail regression; define “material” numerically before running. If B ties C, ship B for that workload.

A useful return row looks like this. Blank metrics belong in the returned experiment, after measurement.

| Arm / trace / seed | Correct / expected | False-current / unexpected abstentions | Discoveries / field reads | CPU ms / peak MiB | Warm p50 / p95 ms | Bytes to CLI |
|---|---|---|---|---|---|---|
| B / repeated reads / seed ___ | ___ | ___ | ___ | ___ | ___ | ___ |

## Computing branches worth retaining

| Fork | First discriminating experiment | Evidence that justifies more work |
|---|---|---|
| Event-triggered observation vs fixed sampling | Replay the same short overlay and long idle interval. Measure how often each schedule misses a state that matters to a query, bytes captured and wakeups. | Equal correctness with fewer observations, or an explicit sampling requirement for a short-lived phenomenon. There is no single FPS requirement for every field. |
| Multiscale hierarchy or Fourier features | Test coarse-to-fine comparison of a changed fixture crop against direct tile differences. If proposing Fourier translation estimation, include repeated texture and local text change. Check on independent landmarks. | Lower total cost at a specified error tolerance, with ambiguity surfaced. Preserve the simple tile or geometry path when it wins. |
| Tiny local controller | Predict which valid entries merit retention. Compare LRU, a cost-aware rule, and the existing 8→16→1 playground on the same held-out sessions and total byte budget. | Meet the playground’s proposed 10% modeled-cost improvement over its strongest validation-selected heuristic in multiple held-out regimes. Verify actual costs before putting inference in a live path. |
| Pretrained local model | For ambiguous human wording, rank candidate labels against a token baseline on unseen phrasings, including cases where no candidate fits. | Better correct-or-abstain performance at a recorded memory and latency cost. Give the result to the operator or resolver as a suggestion. |
| Local math daemon or multiple hosts | First batch a deterministic pure function over saved crops in one local process. Then measure persistent local worker versus one-shot invocation. Try a second host only for immutable batches. | End-to-end time including queue wait, serialization, transfer, compute and return beats the local reference at a documented batch size. Test a late or duplicate result. |

For the tiny-controller branch inherit the prior playground envelope: one worker and one numeric thread, process RSS target below 512 MiB, whole-job ceiling 1 GiB, ten minutes per trial, thirty minutes for the first experiment, and at most 100 MiB of generated data and logs. These targets refer to that playground. Measure a complete Firefox process tree separately. For single-host versus split-host computing, record actual CPU, available RAM, worker versions and transport measurements. The nominal RAM of a stronger machine does not tell us the break-even batch size.

**Activation:** Read the design story, choose one workload and write the decision threshold before running. Implement A and B, reproduce the dropped-event and recycled-identity cases, then add C. Return the trace digest, exact replay commands, per-arm correctness and cost table, and one decision: retain, revise or park. The browser builder can proceed independently. A negative result about cache policy still answers the assigned question.

[Incremental observer and replay contract](https://chatgpt.com/library?file_id=libfile_d52103ac2b908191bb7697208cdf813d&account_id=personal) · [Tiny controllers playground](https://chatgpt.com/library?file_id=libfile_6f0a7d2187a8819180b1c159563b3c4f&account_id=personal) · [Model substrates and local-model comparisons](https://chatgpt.com/library?file_id=libfile_027637f63a7081919dcb5ee202b6d709&account_id=personal)
