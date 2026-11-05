# Assessment and next actions

**Historical first-review plan.** On 4 November 2026 Majkee prioritized cache
methods and both decision trees. The resulting [knowledge tree](../technical-knowledge/README.md)
and [extraction receipt](EXTRACTION.md) supersede this queue and its image-retention
suggestions. The text below records the 3 November review, not the current file count.

Reviewed by myShell on **3 November 2026**. This is personal working material.
The [catalog](CATALOG.md) holds each captured claim, assessment, primary links,
evidence status and image references. No recommended tool was installed or executed.

## What this collection is useful for

The strongest material is a set of learning prompts and research leads. It does
not justify adding dozens of tools. Many apparent recommendations are consecutive
frames from one reel, often including a transition, advertisement or repeated slide.
Grouping them leaves 62 items with different purposes: reference, learning exercise,
research watchlist, product lead or incomplete fragment.

My priority would be to reuse a few items against an actual task. The highest-value
near-term candidates are structural code search, a small backend reliability exercise,
and source-aware reading about retrieval. The agent-memory and orchestration lists
should wait until there is a concrete problem that existing mechanisms cannot solve.
That priority is my judgment, not an outcome measured on your projects.

## Corrections worth keeping

- **TC05 — STAIR:** the 65-fold ratio is explainable by invalid-document-identifier
  rates in the paper. It does not establish a 65-fold improvement in final answers,
  eliminate RAG, or support the post's liability conclusion. The transferable idea
  is to preserve document structure and evaluate retrieval separately from generation.
  [Primary paper](https://arxiv.org/html/2609.03874v2).
- **TC09 — JEPA:** the small-versus-large-model headline concerns representation
  alignment. It is not a general assistant ranking.
  [Primary abstract](https://arxiv.org/abs/2610.39302).
- **TC10 — weight edits:** the successful example addresses a particular looping
  failure; the author also reports a model where the edits did not materially help.
  [Author's experiments](https://rikiyat.github.io/blog/weight-space-programming/).
- **TC18 — cybersecurity skills:** the repository explicitly disclaims affiliation
  with Anthropic. Keep that provenance beside the name.
  [Project notice](https://github.com/mukul975/Anthropic-Cybersecurity-Skills).
- **TC46 — Nuclei AI:** the official scanner has an AI flag, with an API-key and
  cloud dependency. The label in the reel does not establish a separate product.
  [Official documentation](https://docs.projectdiscovery.io/opensource/nuclei/running).

These are source checks, not independent replications. No conclusion about the
reliability of all outputs from a model, scanner or skill follows from them.

## A small queue, in priority order

| Priority | Material | Proposed bounded action | Done when |
|---|---|---|---|
| 1 | TC34 ast-grep | On a future authorized coding task, compare one structural query with the existing text search on a small fixture. | It finds the intended syntax cases, including formatting variants, without unrelated matches. |
| 2 | TC35 portfolio + TC30 pagination | Build one small tenant-scoped webhook example with an idempotency key, retry behavior and a paginated event list. | Duplicate delivery creates one logical event, a simulated retry succeeds, and list responses remain bounded. |
| 3 | TC05 STAIR | Read the evaluation definition, then compare structure-aware retrieval and a simple baseline on representative documents. | A small labeled question set separates retrieval errors from answer errors; results include failures. |
| 4 | TC38 + TC42 defense | In a disposable local lab, inventory exposure and inspect a benign packet capture. | One finding is explained with packet/system evidence and a known benign counterexample. |
| Optional | TC52 Bandit | A short command-line practice session if shell fundamentals need reinforcement. | Notes explain the commands and concepts used; no need to collect another tool. |

These are proposals for later work; this intake did not implement them or acquire
authority over another project's harness or infrastructure. Pick one active experiment
at a time. The table is a personal queue, not a RUNBOOK or project doing-state.

## Park without losing

- **AI runtime research:** TC04, TC06–TC10. Revisit when cluster orchestration,
  internal model-state access, inference cost or model research becomes relevant.
- **Agent infrastructure and skills:** TC14–TC20. Start from a measured gap; audit
  an individual dependency rather than installing a whole social-media bundle.
- **Commercial security products:** TC47. Need an actual assessment scope and
  comparison criteria before a buying or integration decision.
- **Creative tools:** TC53–TC55. Concrete optional experiments exist in the catalog;
  none is necessary to finish sorting these screenshots.
- **Unclear or incomplete sources:** TC17, TC19, TC43, TC44, TC48, TC60, TC61.
  Preserve the images and uncertainty. Recover exact sources only if the subject
  becomes useful; guessed URLs would make the collection less trustworthy.
- **Generic lists and dated advertisements:** retain as searchable references.
  Treat captured prices, job offers, popularity counts and performance claims as
  dated observations, not current facts.

## Limits of this intake

The calendar window is 28 October–3 November 2026, selected from screenshot
filenames. The copy also contains 56 older screenshots, 17 trashed screenshots and
three non-screenshot images. Those 76 files were excluded from content review and
left in the original intake folder. Twelve in-window captures were skipped as
personal, unrelated or memes; their names and raw text are not in the tracked catalog.

All 230 in-window candidates were visually screened using contact sheets, with
selected originals inspected at full size and local English OCR used as an aid.
This is sufficient for thematic triage, not a verbatim transcript of every tiny
code sample. Faint, obscured or cropped content remains explicitly unresolved.
