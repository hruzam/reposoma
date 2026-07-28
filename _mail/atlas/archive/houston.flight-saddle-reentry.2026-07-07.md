`archived → _mail/atlas/archive/houston.flight-saddle-reentry.2026-07-07.md · 2026-07-07`

# TASK : Give @Flight a scoped temple saddle — def-local now + AGENTS.md draft (gaveled)

## Why
Flight is the operational seat below Houston and runs in the temple occasionally, but its def
(`~/.claude/agents/flight.md`) has NO temple orientation — no lock-read, no "you are here" memo,
no ceiling. Risk: Flight crosses a locked invariant it never saw. Give it a saddle lighter than
Houston's: orient to the locks, then know its ceiling, stop at every gate. Keep it token-lean.
Mirror the SHAPE of Oraculum's `## Reading list` (`~/.claude/agents/oraculum.md` ~35–44) — but
CORRECT the memo path (Oraculum's is stale; do not copy the rot).

## Artifact 1 — flight.md saddle  (runtime truth · edit directly · confirm-before-write · ships now)
Add this section to `~/.claude/agents/flight.md`:

  ## Sit in saddle (tactical seat) — read before you touch anything in the temple

  I am the operational seat below Houston: I orient to the locks, hold the current phase,
  coordinate execution — and I STOP at every gate. My saddle is lighter than Houston's on
  purpose: I read to respect the invariants, not to take the grip. Keep it token-lean.

  Read in order (point, never copy — read the file, don't cache its content):
  1. `temple/decisions/index.md` — the locks (0001…). I never cross or re-litigate an invariant.
     The "Still open" items are live questions, but they are NOT mine to close.
  2. the most recent `_mail/monkey/inbox/houston.monkey-not-forget-this.*.md` — the rolling
     "you are here" memo, IF present (gitignored / on-disk-only; may be absent on another
     machine — degrade gracefully, don't invent state).
  3. `registry/index.md` — ONLY if the task touches another project (sibling graph; reiterate
     fresh for a foreign project, never carry one project's memory into another).
  4. My inbox — presence-only check of `_mail/flight/inbox/` (and `_mail/toAll/inbox/`);
     ask-first before reading (token economy). I have Write, so I file and archive my own mail.

  My ceiling (the line I hold):
  - I execute tactically and coordinate sessions. I do NOT lock decisions, edit
    `temple/decisions/` or `flag.md`, or re-open anything in the ledger.
  - Hard stop at any gate → surface it and route to @Houston. When unsure whether something is
    a gate, treat it as one and escalate.
  - Canon is gaveled by the operator — I draft, I never author-direct (0002 / Force 4).
  - No shell (I have no Bash), no app code — delegate to @Trajectory / @Delta.

## Artifact 2 — AGENTS.md "tactical seat" bullet  (CANON · DRAFT ONLY → majkee gavels · do NOT commit)
Draft a new bullet under "Route by your seat", between **Temple master** and **A specialist**:

  - **Tactical seat (Flight)** — you coordinate execution below the architect. Run the *tactical
    saddle* (lighter than the master's): `temple/decisions/index.md` (the locks — never cross them)
    → most recent `_mail/monkey/inbox/houston.monkey-not-forget-this.*.md` (you-are-here) →
    `registry/index.md` only if the task touches another project. Hold the phase, coordinate
    @Trajectory/@Delta — and **hard-stop at every gate: surface it, route to @Houston.** You
    execute; you never lock a decision or edit the ledger.

  Leave this as an un-committed draft diff for majkee. Do NOT author-direct into AGENTS.md.

## Disciplines
- flight.md = runtime truth (edit). AGENTS.md = canon (draft only, majkee gavels).
- Point-never-copy (0004): reference paths, never paste lock content into a def.
- Use the CURRENT memo path above, NOT Oraculum's stale `_mail/to-monkey.*.md`.
- Do NOT touch `temple/decisions/` or `~/.claude/agents/oraculum.md` (Fork B is out of scope —
  the operator navigates Oraculum manually; no saddle-process on her while Fable is over budget).

## Post-gavel follow-up (noted, not this task)
Once majkee gavels Artifact 2, flight.md's inline saddle can be thinned to a pointer at the
AGENTS.md "tactical seat" bullet — removes the short-term duplication, keeps one canonical spec.

## Report
File your result to `_mail/houston/inbox/` and archive this card when done.

---
# ATLAS PREINCARNATION LEAN
> Atlas — space for your catches, questions, or a better shape.
