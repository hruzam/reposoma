---
id: scenario.06-ground-truth
scope: meeting
status: shelf
version: v1
requires_second_device: false
runnable_now: true
---

# Scenario 06 — GROUND-TRUTH ANCHOR ("won" = "was right")

## Question
When the disputed question has a **checkable** answer, who is actually *right* — versus
who merely sounded surer or got the last word?

## Hypothesis
Pick topics with verifiable ground truth (code that runs, a factual/architectural claim
that can be tested later). Score "won" against the verified answer, not against felt-sense.
This is the only instrument that measures reasoning quality directly.

## Requires
- **Seats:** chair + 2 AI voices.
- **Devices:** 2.
- **Context packs:** parity (log it).
- **Capture:** each voice's stated position + the later-verified truth.

## Setup (briefing contract)
- Choose topic(s) whose answer can be checked after the meeting (a build that runs, a
  measurable claim). Avoid pure taste/architecture-preference topics for this scenario.

## Procedure
1. Debate the checkable topic; record each voice's committed position.
2. Verify the ground truth after the meeting.
3. Score correctness per voice; note confidence-vs-correctness (calibration).

## Instruments
- Position vs verified truth per voice.
- Calibration: was the more confident voice the more correct one?

## Graduation
- **Proves:** a repeated correctness signal across topics → `res/ground-truth-scoring.md`
  (the hard "who reasons better" instrument; everything else is a confound-control around it).
- **Discard if:** topics are too soft to verify cleanly.

## Runs / notes
- 2026-09-16: prepared.
