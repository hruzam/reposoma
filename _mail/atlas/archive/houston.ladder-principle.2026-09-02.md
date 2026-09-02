---
to: temple:atlas (next atlas-ui / atlas-auto session)
from: houston (session, office, 2026-09-02)
topic: the ladder principle — how tiered review/advice is wired, and where it collapses
host: office
reason: majkee cleaning house ("too many legs for sessions"); this is the map before you canonize/adjust globally
---

## One-line

**A reviewer/advisor always runs exactly ONE model-grade above the agent it serves —
never the same grade, never two grades up.** That single invariant is the ladder.

## The two axes it stands on

1. **Model tier ladder** (four rungs, low→high):
   `Haiku → Sonnet → Opus → Fable`
2. **Effort** — a *second* axis on the same rung. Same model, harder thinking.
   Example: `advisor-mid` = Opus/default vs `advisor-advanced` = Opus/**high**.
   Two seats, one model, different effort — because today effort is fixed per-seat, not per-call.

## The rung map (how the advisor family is bound today)

| Reviewed agent tier | Reviewer seat      | Reviewer runs on | Rule expressed |
|---------------------|--------------------|------------------|----------------|
| Haiku               | `advisor-low`      | Sonnet           | +1 rung        |
| Sonnet              | `advisor-mid`      | Opus             | +1 rung        |
| Sonnet (strategic)  | `advisor-advanced` | Opus / high effort | +1 rung, +effort |
| Opus                | `advisor-high`     | Fable            | +1 rung        |

Same principle drives the implementer ladder: `@delta` (Haiku surgical) →
`@vector` (Sonnet, when the file/context exceeds Haiku's ceiling). Vector's own card says
it *collapses back into Delta* once per-subagent effort ships.

## Why the invariant is shaped this way

- **Decorrelated error, cheaply.** Same-tier review shares the reviewed agent's blind spots
  (writer's-blindness at the model level). One rung up buys a genuinely stronger critic.
- **Cost discipline.** Two rungs up (e.g. Fable to check a Haiku diff) burns tokens for
  judgment the task never needed. +1 is the minimum jump that still changes the answer.
- **So the ladder is a frugality rule, not a hierarchy of prestige.** Match the critic to
  the stakes; spend exactly one grade more, no more.

## The part that matters for "cleaning house"

**Most of these seats exist only because Claude Code has no per-spawn model/effort control.**
The four `advisor-*` seats are ONE role (second-opinion reviewer) forked into four cards to
fake a `model`/`effort` parameter. Likewise `vector` ≈ `delta` at a higher tier.

When **per-subagent effort ships (GitHub #43083)** the honest shape is:
- collapse `advisor-low/mid/advanced/high` → **one `advisor` seat** the caller spawns with
  `model = reviewed_tier + 1` and `effort` set by stakes.
- collapse `vector` → `delta` with `effort = medium`.

That is the biggest leg-reduction available and it loses nothing but duplication.

## Do NOT collapse on tier alone (guard rail)

These share a rung but are **role-distinct**, not ladder duplicates — merging them by model
would destroy real function:
- `@janus` = adversarial challenger (one verdict, one risk, one alt) — Opus.
- `@agol` = cross-phase synthesis, *no* verdict shape — Fable.
- `@color` = formal/vector-math proof co-brain — Opus.
- `@oraculum` = scientist-tier planner, "Houston on steroids."

Ladder = *how strong a critic*. Role = *what kind of thinking*. Only ever collapse seats
that differ solely on the ladder axis, never seats that differ on the role axis.

## What I ask of Atlas

1. When you canonize, treat the four `advisor-*` cards as **one role pending #43083**, and
   write the collapse plan (single `advisor` + `model`/`effort` params) rather than blessing
   four permanent seats.
2. Keep the `+1 rung, never same, never +2` rule as the written law of any merged advisor seat.
3. Leave the role-distinct Opus/Fable seats (janus/agol/color/oraculum) alone — they are not
   ladder rungs.

Gates: majkee owns naming, promotion, and any commit. This is a brief, not a spec.
