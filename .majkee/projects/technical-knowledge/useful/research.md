---
title: Research knowledge worth keeping
scope: technical-knowledge
kind: knowledge-note
updated: '2026-11-05'
---

# Research knowledge worth keeping

Extracted 4 November 2026. These are source-backed ideas, not independently
reproduced benefits. Cache and routing research has dedicated priority notes:
[cache-methods](../../cache-methods/README.md) and
[capability routing](../../decision-methods/capability-routing.md).

## TC05 — preserve retrieval structure and define the error

STAIR exploits corpus structure such as a table of contents. Its hallucination
measure counts invalid document identifiers. The useful idea is to evaluate
retrieval validity separately from the truth of generated answers. The paper's
65-fold ratio does not establish a universal end-to-end improvement.
[Primary paper](https://arxiv.org/html/2609.03874v2).

My proposed evaluation separates: relevant material found, citation identifies a
real source, and answer supported by that source. A single aggregate success number
can hide which stage failed.

## TC09 — learn from the representation task

The JEPA paper investigates representation alignment and the effect of training
on suitable views of the same underlying scene. Its small-versus-large comparison
belongs to that task; it does not rank overall assistant ability.
[Primary abstract](https://arxiv.org/abs/2610.39302).

My reading question is which positive-pair assumptions make the result apply to
the data of interest. Keep the task and assumptions next to any quoted comparison.

## TC10 — distinguish removing a failure from creating ability

The weight-space-programming authors describe a targeted fix for looping behavior
and report a case where a different model did not materially improve. The useful
lesson is the narrow intervention and its negative result, as well as the successful
benchmark change. [Author's report](https://rikiyat.github.io/blog/weight-space-programming/).

My reuse criterion is to identify a reproducible failure, test the proposed edit
against it and check for regressions. Do not infer general self-improvement from
one targeted fix.
