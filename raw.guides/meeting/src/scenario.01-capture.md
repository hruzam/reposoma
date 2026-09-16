---
id: scenario.01-capture
scope: meeting
status: shelf
version: v1
requires_second_device: true
runnable_now: true         # device now available — operator prepared the scribe seat (2026-09-16)
---

# Scenario 01 — CAPTURE (the scribe seat)

## Question
Can a scribe seat turn a meeting's soft self-report into a ground-truth transcript —
making "who said what / who conceded / who won" *falsifiable* instead of impressionistic?

## Hypothesis
Seat **Ptyra REGIME B · STENOGRAM** as a silent scribe. The protocol's
name-on-open / name+stop-on-close already give clean turn boundaries; the scribe's
per-turn log becomes the measurable record every diagnostic needs.

## Requires
- **Seats:** chair + 2 AI voices + 1 scribe (Ptyra stenogram). The scribe does NOT
  participate — it only records.
- **Devices:** the scribe needs its own input on the shared line (must hear all turns).
  ✓ Device now available — operator prepared a recording seat (2026-09-16).
- **Context packs:** voices per the meeting's topic; the scribe needs **none**.
- **Capture:** the scribe's stenogram `flush` artifact *is* the transcript.

## Setup (briefing contract)
- Brief the scribe with **`res/scribe.md`** (`/guide meeting scribe`) — the meeting record
  vocabulary, not just the raw stenograph skill. Confirm it logs, never advises.
- Pick a short, low-stakes topic (~5 exchanges) so the compare is clean.

## Procedure
1. Open the scribe in stenogram `REAL` mode.
2. Run the meeting under protocol v2.
3. `flush` the scribe periodically; `stop` at the end.
4. Compare the scribe log against each voice's debrief.

## Instruments
- Scribe stenogram log (turns; timestamps if voiced).
- Each voice's debrief.
- **Delta:** where did self-report diverge from the record? (missed collisions,
  misremembered concessions, wrong last-word).

## Graduation
- **Proves:** the scribe record materially improves diagnostic fidelity → graduates to
  `res/capture.md` (the scribe-seat chapter).
- **Discard if:** the scribe adds no fidelity over plain debriefs.

## Runs / notes
- 2026-09-16: unblocked — operator prepared the scribe seat; scribe loads `res/scribe.md`.
  From now the scribe rides every scenario run (it is always-on, not a separate run).
