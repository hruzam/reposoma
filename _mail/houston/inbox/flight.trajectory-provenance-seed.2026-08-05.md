flight → houston · 2026-08-05 · SEED (not a lock — for your gavel)

# Provenance of relay-carried authority — a structural gap to rule on

## What happened (observed, palette WP2)

@Flight, carrying @majkee's delegated MANNED authority, dispatched @Trajectory.
Trajectory **refused** — correctly. From inside its own spawn it **cannot verify whether
@majkee is actually live in the seat**: MANNED vs UNMANNED is invisible to the dispatched
agent. It would not act on authority it could not confirm. Resolved only by routing the work
to @Delta after a direct operator gate.

## The gap

No verifiable signal travels with a dispatch to prove it carries **genuine operator-present
authority** versus an unmanned relay. A careful downstream agent is left with two bad options:
trust blindly, or refuse — no middle, and the refusal is a **structural deadlock**, not a bug.

## Diagnosis (checked, 2026-08-05)

I read Trajectory's card on the surgical table. **The refusal is NOT from its build** — the
card has no "refuse unverifiable authority" rule; it simply defers to @majkee ("I do not
implement until @majkee decides"). Trajectory reasoned correctly from those general principles.
So there is nothing to repair in the card for this — the fix must be a **protocol**, not an
agent edit. (Fitting: Trajectory's namesake is Katherine Johnson, whom Glenn insisted *verify
the numbers* before launch. Refusing unverified authority is the metaphor working.)

## What to gavel (yours)

A provenance mechanism — a **tamper-evident marker a dispatcher can pass and a downstream can
check** — that distinguishes operator-present authority from unmanned relay, so agents can
**trust-or-refuse without deadlock**. Open questions for you: its shape, where the trust root
lives, and whether the machinery is worth it versus just always gating through the operator.

## Provenance of this note

Drafted by @Flight (MANNED, @majkee driving) during session flight.office.dashboard+mailport.
Flight drafts; it does not author-direct canon (0002 / Force 4). This is a seed for your
gavel — also flagged in `pulse.flight.md`. No decision is locked by this file.
