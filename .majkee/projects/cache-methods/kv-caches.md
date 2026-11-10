---
title: Transformer KV caches
scope: cache-methods
kind: knowledge-note
updated: '2026-11-05'
---

# Transformer KV caches

Extracted 4 November 2026 as background for TC08 and TC06. Primary reference checked:
[Hugging Face cache explanation](https://huggingface.co/docs/transformers/main/en/cache_explanation).

During autoregressive generation, each attention layer retains key and value
tensors for earlier positions. A new query attends to those stored tensors instead
of recomputing earlier keys and values at every decoding step. The cache grows with
the sequence and consumes memory; exact shape depends on the model's attention
configuration. This is computed attention state, not a store of finished answers.

Cache reuse is conditional on the computation that produced the state. Changing
the preceding input can change later states. A text transcript and its stored KV
states are related representations, not interchangeable objects.

My practical distinction for reading the captured material:

| Change | What it changes |
|---|---|
| Summarize or remove transcript text | The model's subsequent input |
| Reuse an unchanged prefix cache | Avoids recomputing compatible prior state |
| Drop selected active KV entries | Changes what later attention can access |
| Transfer KV between model families | Requires a compatible transformation, not string concatenation |

The last two rows point to [AKV](akv.md) and [SwaT](cross-model-kv.md), respectively.
Their papers add specific serving/training machinery. They cannot be assumed from
the mere presence of caching in a model API.

For an actual comparison, my proposed acceptance test is answer quality under a
fixed task set and memory budget, plus latency and recomputation cost. Include a
question that needs an older observation: dropping history can make a cheap run
fail in a way aggregate speed numbers conceal.
