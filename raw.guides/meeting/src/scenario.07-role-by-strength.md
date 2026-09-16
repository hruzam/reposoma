---
id: scenario.07-role-by-strength
scope: meeting
status: shelf
version: v1
requires_second_device: false
runnable_now: true
---

# Scenario 07 — ROLE-BY-STRENGTH ROUTING (not by vendor)

## Question
Does assigning generator vs critic by each voice's *demonstrated per-task strength* beat a
fixed/arbitrary assignment — WITHOUT hardcoding vendor→role?

## Hypothesis
Routing "generate" to the voice stronger on this task-type and "adversary/critique" to the
other improves solution quality over a fixed seat assignment. Strength is per-task and
**measured**, never assumed from brand.

## ⚠ Guardrail
Do NOT hardcode "Claude critiques / GPT generates" (or vice-versa). Flagship brand-strength
differences are thin/contested (@Epoch 2026-09-16 — and NO source benchmarks either brand on
the critique/calibration axis a meeting needs most). Assignment is per-task, evidence-driven,
and a variable under test — never a rule yet.

## Requires
- **Seats:** chair + 2 AI voices; an assigned-adversary role (rule 7) in play.
- **Devices:** none beyond the normal meeting.
- **Context packs:** parity.
- **Capture:** which voice held which role; outcome quality (ground-truth where possible).

## Setup (briefing contract)
- Pick a task-type with a plausible strength difference (e.g. code-implementation vs
  long-horizon architecture critique).
- Run once with role assignment X, once swapped; hold everything else constant.

## Procedure
1. Assign generator/critic per a stated, recorded rationale.
2. Run; score outcome (ground-truth if checkable; else consequence proxy).
3. Swap roles on a comparable task; compare.

## Instruments
- Role↔voice mapping + rationale.
- Outcome quality per assignment.
- Whether swapping degraded or improved the result.

## Graduation
- **Proves:** a stable, measured strength-routing win → `res/role-by-strength.md` (with the
  no-vendor-hardcode caveat baked in).
- **Discard if:** routing shows no reliable effect, or the strength signal is too noisy.

## Runs / notes
- 2026-09-16: authored from the Epoch + @mirror v3 revision. Depends on rule 7 (assigned adversary).
