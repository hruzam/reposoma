---
title: Token economy and delegation shape
chapter-of: runbook
---
# RUNBOOK · res — token economy and delegation shape

`what: what a RUNBOOK fixes about WHO spends tokens, and what a session records about what it spent.`
`scope: extending chapter of raw.guides/runbook/GUIDE.md — vendor agnostic. Model names are weather; grades are the law.`
`status: DRAFT — awaiting majkee gavel (authored 2026-09-03, session roster-reform-01-triad, from Oraculum's 2026-09-02 proposal + the measured corpus)`
`source of truth for the numbers: raw.research/capabilities-economy-hygiene.claude.md — this chapter points, never re-argues. Cross-check there only when a number here looks stale.`

## Delegation shape — one head, graded executors

A session has **one head** — the seat named in the RUNBOOK's `participant` list as `status_owner` —
and any number of **executors** it spawns. The head reads the harness, holds the position, drives
PADs, and writes only briefs, directives, and the state file. Every file edit, shell command, and
verification goes to an executor.

The account behind that rule is `B + E + P + S`: an executor pays a **boot tax** `B` (fixed,
~10k on a Sonnet-tier seat, unmeasured on Haiku) plus its **work** `E`, both quarantined in its own
window and discarded on return; the head grows by the **prompt** `P` it wrote and the **summary**
`S` it got back — nothing else. Isolation is not a total-token saving (every spawn re-pays `B`); it
buys a flat head window and wall-clock parallelism. A good executor returns `S/E < 0.1`.

Executors are graded by **thinking need**, not by prestige:

| grade | when | Claude reference |
|---|---|---|
| surgical | exact brief, bounded files, zero judgement | @Delta |
| local judgement | multi-file edit, the brief cannot be made exact everywhere | @Vector |
| fresh-eyes gate | verification without the writer's context | @Assay |
| senior | the brief cannot be made exact at all; pushback wanted | @Trajectory / Opus-tier |

A lower-grade head (Flight-class) is legal and spawns a thinking seat only when it needs help.
**Effort is a routing axis of its own** — the participant tuple `{brand, model, effort}` carries
it because one wrong effort default has cost more than any wrong tier choice (measured: 122×).

## What the RUNBOOK fixes at authoring

- The head, by name, as `status_owner`.
- Each seat's `{brand, model, effort}` — the declared shape, fixed for the session.
- Optionally, in `prompt-0`: the executor grade per task class the head is expected to use
  (*"fences and folds → surgical; the migration → local judgement; gate → fresh-eyes"*). One line.
  This is what lets the next session say "move that class down a grade."

Nothing about spend goes into the RUNBOOK after authoring — it is read once.

## What a session records about spend — and where

Not in the RUNBOOK (read-once, no mutable field). Not in STATUS (a replacement snapshot that dies
with the gate). The record is **promoted evidence**, written once at closure:

```
executor class · spawns · total tokens · avg/spawn · first-pass-correct / total · S/E if known
head tokens if known · anything unusual the head ingested (images, long pastes) as a note
```

Then **one row per executor class** is appended to the temple's single benchmark table
(`capabilities-economy-hygiene.claude.md` §2b). The two numbers that decide the next session:

- **correction rate per class** — above ~20% on a task class → move that class up a grade;
- **S/E per spawn** — a class that returns bloated summaries is costing the head, not itself.

## Agent benchmark — what counts as a result

A row is `date · session · agent · model · task class · n · first-pass-correct · avg tokens ·
notable failure mode`. Rows accumulate in ONE place; a RUNBOOK cites the row, never re-argues it.
Re-grading a task class ("surgical can do multi-line fence scribing from an exact brief") is a
dated one-line append there — not a new document.

## Not in this chapter

- **Sequential PAD with a remote operator** — one session's observation (2026-09-02); lives in
  `raw.guides/PAD/raw/` until a second run makes it a pattern.
- **Head cost baselines** — no public per-loop figure exists across tiers; a "normal" session
  spend cannot be cited yet. Record; do not compare against an invented norm.
- **Model strings** — never here. The grade table names seats; the roster names models.
