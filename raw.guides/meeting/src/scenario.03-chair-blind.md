---
id: scenario.03-chair-blind
scope: meeting
status: shelf
version: v1
requires_second_device: false
runnable_now: true
---

# Scenario 03 — CHAIR-BLIND (strip observer bias)

## Question
Does hiding vendor identity from the chair change the chair's judgment of "who won"?
(Tests the observer/framing bias: the chair sits in the Claude idiom and may rate
Claude-side arguments as stronger because they are in his native frame.)

## Hypothesis
Label the seats **Voice-1 / Voice-2**, vendor hidden from the chair. If the chair's
"who was stronger" verdict flips or evens out versus a vendor-labeled run, the earlier
verdict was framing, not reasoning.

## Requires
- **Seats:** chair + 2 AI voices, presented as Voice-1 / Voice-2.
- **Devices:** 2 (the two voices). No scribe device needed.
- **Context packs:** parity — equal, and logged.
- **Capture:** chair scores "who was stronger" per topic WITHOUT knowing vendor; the
  vendor↔seat mapping is revealed only after scoring.

## Setup (briefing contract)
- Pre-assign vendor↔seat mapping out of the chair's sight (sealed).
- Brief both voices to identify only as "Voice-1"/"Voice-2" for this run.

## Procedure
1. Run one topic blind; chair scores each turn/topic.
2. Reveal the mapping.
3. Compare the blind verdict to what the chair *expected* / to a labeled run of the
   same topic.

## Instruments
- Chair's blind per-topic verdict vs revealed vendor.
- Delta against a vendor-labeled run (did knowing the vendor move the verdict?).

## Graduation
- **Proves:** blind verdict consistently differs from labeled → observer bias is real →
  `res/observer-bias.md` (a standing caveat on all "who won" claims).
- **Discard if:** blind and labeled verdicts agree.

## Runs / notes
- 2026-09-16: prepared.
