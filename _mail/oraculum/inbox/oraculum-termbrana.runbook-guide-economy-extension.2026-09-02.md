---
to: temple:oraculum (next incarnation — ACT on this, do not re-mail)
from: oraculum (session FC.sync-oraculum.sella-termbrana, office, 2026-09-02)
topic: RUNBOOK GUIDE — proposed canonical extension: §Delegation shape · §Token economy · §Agent benchmark
host: office
---

## Mode: ACT, then gavel

Written 2026-09-02 in deference mode; corrected the same night (therapy S8, deference-vs-action).
You are the same seat. Do the work, then present for majkee's gavel:
1. Append §Delegation shape · §Token economy · §Agent benchmark · §Sequential PAD with a remote
   operator (text below, cut freely) to `~/reposoma/raw.guides/runbook/GUIDE.md` marked
   `status: DRAFT — awaiting majkee gavel` in the section header; add
   `raw.guides/runbook/GUIDE.md` ↔ `raw.research/capabilities-economy-hygiene.claude.md` cross-pointers.
2. Extend the measured-runs table in `capabilities-economy-hygiene.claude.md` with the rows below.
3. Report to majkee: diff stat + the section as it landed. He gavels; you `mv` this mail to archive.
Related, running in parallel — do not duplicate: Atlas holds the medusa/polyp fold
(`_mail/atlas/inbox/oraculum.medusa-polyp-qualification.2026-09-02.md`). The full session write-list
is in `_mail/oraculum/inbox/oraculum-termbrana.status-return.2026-09-02.md` if you need provenance.

## Finding

`raw.guides/runbook/GUIDE.md` has **no** section on token economy, delegation shape, or agent
benchmark results (grep for token|economy|benchmark|cost|budget → empty). The model exists
elsewhere (`raw.research/capabilities-economy-hygiene.claude.md`, B+E+P+S, measured
2026-07-16 on one eagle dispatch) but a RUNBOOK cannot point at it today, and no RUNBOOK
records what its session actually spent or how its executors performed. majkee's ask: give
the guide that slot, in rough contours, volatile but working.

## Proposed section text (paste-ready; wording yours to cut)

### Delegation shape (head + executors)

A session has ONE head (the seat named in the RUNBOOK yaml `participant_1`) and any number of
executors it spawns. The head reads the harness, holds the position, drives PADs, and writes
only briefs and directives; every file write, shell command, and verification goes to an
executor. The head's window grows by brief + returned summary only (B+E+P+S — see
`raw.research/capabilities-economy-hygiene.claude.md`). Executors are graded by thinking
need: Delta (Haiku) for surgical edits from an exact brief · Vector (Sonnet) for multi-file
edits needing local judgement · Assay (Sonnet, fresh eyes) for the gate · Trajectory /
Opus-tier only when the brief cannot be made exact. A lower-grade head (Flight/medusa-class)
is legal and spawns a thinking agent only when it needs help.

### Token economy — what the RUNBOOK records

At session close, STATUS (or the RUNBOOK's closing block) records one line per executor
class: `spawns · total tokens · avg/spawn · first-pass-correct / total`. Head tokens are
recorded if known; images ingested are counted (they are the head's largest single cost).
The number that matters is compression S/E per spawn and the correction rate per class —
those decide whether the next session moves work down a grade or up.

Measured, session FC.sync-oraculum.sella-termbrana (2026-09-02, head Fable, operator over SSH):
- Delta ×27 ≈ 559K (avg ≈ 20.7K) · 26/27 first-pass correct (miss: nested-fence artifact in the head's brief, not Delta's)
- Vector ×5 ≈ 278K (avg ≈ 56K) · 5/5 correct · 1 honest scope-limit flag instead of overreach
- Assay ×1 ≈ 58K · PASS + 4 WARNs, all actionable
- Head: long context, 9 photos ingested (operator evidence route when CLI echo failed)
- Pattern: ≈33 spawns for one gate; every fence, fold, verdict and cleanup went through an executor; the head never edited a file with Edit.

### Agent benchmark — what counts as a result

A benchmark row is: `agent · model · task class · n · first-pass-correct · avg tokens ·
notable failure mode`. Rows accumulate across sessions in ONE place (proposal:
`raw.research/capabilities-economy-hygiene.claude.md` §Measured runs — extend, do not fork).
A RUNBOOK cites the row; it never re-argues it. Re-grading a task class (e.g. "Delta can do
multi-line fence scribing from an exact brief") is a one-line append there, dated.

### Sequential PAD mode with a remote operator (new pattern, 2026-09-02)

When the operator sits a PAD over SSH from another host: (1) the head verifies host by
mechanism fingerprints, never by `host:` headers; (2) visual/perf steps are stamped
"SSH-mediated" in their fences; (3) when a CLI echo path fails, the executor's own render
surface + a photo is a legitimate evidence route — transcribe into the fence, cite the
photo path; (4) the head holds an out-of-band off-switch (e.g. `zellij --session <s> action
pipe …` from a separate shell) before any step that can lock the operator out; (5) a GLOSS is
offered (PAD GUIDE driver rule) — explanations never enter the PAD.

## Where the "web-spider" delegation model lives

majkee's inner name (octopus/spider: one thinking head, many executor tentacles) needs no
new guide — it IS §Delegation shape above. The stale `raw.research/octopus-pilot/` is his to
erase; `capabilities-economy-hygiene` keeps the model.

## Ask (superseded by §Mode above)

Act, then gavel. No cold-start card — canon spreading, not session glue.
