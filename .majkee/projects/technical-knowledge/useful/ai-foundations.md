---
title: AI foundations
scope: technical-knowledge
kind: knowledge-note
updated: '2026-11-05'
---

# AI foundations

TC01, TC02; decision trees from TC03 are in the priority
[decision-methods](../../decision-methods/README.md) scope. Extracted 4 November 2026.

## Attention: retaining the actual mechanism

For scaled dot-product attention, query/key similarities are divided by the square
root of key dimension, normalized with softmax, and used to weight the values:

```text
Attention(Q, K, V) = softmax(QKᵀ / √dₖ) V
```

Different heads provide distinct learned projections. A transformer also includes
other components; an attention animation alone is not a recipe for reproducing a
trained language model. Read the original architecture when exact details matter.
[Attention Is All You Need](https://arxiv.org/abs/1706.03762).

My proposed learning check is to calculate one small attention row by hand: scores,
normalized weights, then weighted values. Separate that exercise from claims about
training data, compute requirements or model quality.

## Recommendations: distinguish stages

A useful architecture separates candidate generation, scoring and re-ranking.
The first stage reduces the search space; the next ranks relevance; the last can
account for additional constraints such as diversity and freshness.
[Google's recommendation-system overview](https://developers.google.com/machine-learning/recommendation/overview/types).

The captured animation illustrates learning from interactions. Its displayed score
is not evidence of a particular production recommender's accuracy. My takeaway for
a future clipping tool is to choose explicit retrieval and ranking criteria, then
evaluate relevance on held-out examples instead of treating clicks as the only goal.
