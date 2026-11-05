# Cache methods

Priority extraction requested by Majkee, 4 November 2026. These are personal
knowledge notes, with no attachment to another project and no implementation decision.
Origin: clipping items TC08, TC06 and TC31 in the 3 November phone intake.

Read in this order:

1. [Application caches: eviction and freshness](application-caches.md).
2. [The hit-rate threshold in the screenshot](load-threshold.md).
3. [Transformer KV caches](kv-caches.md).
4. [AKV: controlling active attention state](akv.md).
5. [SwaT: exchanging state across models](cross-model-kv.md).

Application values, attention state and cross-model communication have different
correctness conditions. Identify the cached object before comparing methods.

| Question | Read |
|---|---|
| Which application entry should leave a full cache? | Application caches |
| Can a small hit-rate change prevent backend overload? | Load threshold |
| Why does generation consume growing cache memory? | KV caches |
| Can an agent discard old attention state without rewriting its transcript? | AKV |
| Can one model hand internal state to another? | SwaT |

The first two notes support ordinary engineering discussion. The last two describe
published research whose reported benefits were not independently reproduced here.
The [decision-methods](../decision-methods/README.md) notes cover both trees you asked about.

For future use, record the cached object, validity conditions, memory budget,
workload, baseline, hit/miss rates and tail latency before selecting a policy.
That measurement proposal is myShell's synthesis; no workload benchmark was run.
