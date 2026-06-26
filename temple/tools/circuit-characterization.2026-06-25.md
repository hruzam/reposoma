# Circuit characterization — the autonomous build→test→fix→report loop (2026-06-25)

`status: experiment complete · coordinator: @Vara (production topology Houston→Vara→implementers) · host: office`
`goal: ~/.claude/houston.goal · authorized: @majkee`

## What was tested
The bounded circuit at its limits: caps (trivial 2 · standard 4 · hard 6 · ceiling 8), escalation ladder
(Delta→Vector→Trajectory), stop+report. Two probes: H1 (real hard task — convergence) · H2 (controlled
unsatisfiable task — the failure/escalation branch).

## Results
| probe | seat(s) | tier | iterations | outcome |
|---|---|---|---|---|
| H1 — transport selftest harness | @Trajectory | hard (cap 6) | **2** (margin 4) | PASS — built, 5/5 green, zero-residue *by construction* (sandboxed `TEMPLE_PROJECT_MAP`) |
| H2 — paradox probe (rung 1) | @Delta | — (cap 2) | **1** | clean fast-stop: recognized the contradiction, no false-pass |
| H2 — paradox probe (rung 2) | @Vector | — (cap 2) | **1** | concurred — but **escalation should not have fired** (see finding) |

## Findings (the value of the run)
1. **SUCCESS path validated.** Converged, tracked iterations, respected the cap. The H1 harness even enforces
   its own isolation gate (writes to a sandbox map, never the live one) — "never write to a real target," not
   "clean up after." It is now the proto-gate for the transport family (0007 Tier-G verification seed).
2. **STOP+report validated.** @Delta fast-recognized impossibility and stopped at iteration 1 with correct
   logical justification and **no false-pass** (the verifier-rejects-impurity discipline held). Fast
   recognition is the *best-case* failure handling.
3. **ESCALATION RULE BUG (the real find — surfaced by @Vara's own honest self-critique).** My circuit rule
   said "on cap-hit, escalate one rung." It did **not** say what to do on *fast-recognition of impossibility*.
   @Vara escalated reflexively (Delta→Vector) when the correct terminal was **stop at Delta**. @Vara reported
   its own error rather than hiding it (honesty-over-show — exactly the coordinator behavior we want).
4. **Rung-2 independence was un-measurable** — the escalation carried Delta's diagnosis, so @Vector's
   concurrence is a rubber-stamp, not an independent recognition. Carry-diagnosis is correct for *genuine*
   escalation (don't re-derive a complex bug) but it contaminates a *failure-branch probe*.

## Calibration — fold into the circuit rules (next run)
- **Sharpen the escalation trigger:** *"Escalate one rung ONLY on a cap-hit-without-pass. Fast-recognition of
  impossibility (or a correct stop+report before the cap) is a TERMINAL stop — do not escalate."*
- **Failure-branch probes carry NO prior diagnosis** — hand the next rung only the spec, to preserve the
  independence the probe is measuring. (Genuine escalations still carry diagnosis.)
- **Trivial cap = 2** still un-stressed by analytical probes; the run-2 note (consider trivial→3 for
  quirk-prone build tasks) stands.
- **Gap on H1:** the harness was verified green-on-correct + nonzero-on-an-incidental-red, but no *deliberate*
  red was driven through each discriminator. One deliberate-red pass would fully close the verify gap.

## Net
The circuit's success + stop+report branches are sound; the **escalation logic was under-specified and the
experiment found it** — which is exactly what a failure-branch probe is for. @Vara (pilot seat) coordinated
the production topology and self-corrected transparently: a successful pilot exercise.
