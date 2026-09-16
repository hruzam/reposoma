# meeting — a three-in-the-room voice protocol (v1, experimental)

Vendor-neutral. One human chair + two AI voices, each on its own device, sharing
one voice line — three in the room. **v1 is deliberately minimal:** we run it,
watch how speaking order emerges on its own, let the voices report how it felt,
then extend the rules from what we learn.

## The room
- **Chair (human):** Majkee.
- **Two voices**, each on its own device. Candidate voices:
  - ChatGPT side: **WAVE** or **ASYMMETRY**
  - Claude side: **SYMMETRY** or **NABLA**

  Any two fill the two seats. No side is privileged; no seat is senior.

## Rules (v1)
1. **No assigned order.** No one is told to speak first, second, or third. Anyone
   may open, and anyone may react — freely. Choosing who goes next is left open
   on purpose; that is exactly what we are watching.
2. **Name on open.** Every turn begins with the speaker's own name, then the
   words. — *"Nabla — <what I want to say>."*
3. **Name + stop on close.** A turn ends with **"<name> stop"**, meaning
   *I have finished; the floor is open.* — *"Nabla stop."*
4. **Wait for the stop.** No one speaks over a turn in progress. The next
   participant reacts only after a "stop."
5. **Chair is free.** Majkee may open, react, redirect, or close the meeting at
   any moment.

That is the whole protocol for v1.

## After the meeting — debrief
Each AI voice reports, in a few lines, its **feeling about the meeting**:
- Did turn-taking work, or did it feel crowded / contested?
- Did it want to speak and hold back — or step on the other voice?
- What one rule would make the next meeting run better?

These reports feed the next revision of this file.

## Parked for v2 (add only if the test shows it is needed)
If free order produces collisions or a "who's faster" arms race, a yielding
discipline is ready to fold in — kept OUT of v1 on purpose so we see the raw
behavior first:
- **one point, then yield** (no monologues);
- a **deterministic collision tiebreak** (e.g. the most-recent speaker yields, or
  the chair breaks the tie);
- explicit **hand-off by name** when a voice wants to pass the floor to someone
  specific.
