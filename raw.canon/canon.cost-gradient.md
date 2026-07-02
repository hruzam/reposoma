---
status: promoted
promoted_by: "building the freya.devstudio agent team 2026-06-08 — concrete need to assign models"
validated_by:
  - "a challenger (Opus) caught a plan error a cheaper model missed — 2026-06-08"
  - "an executor (Haiku) ran surgical commands without unnecessary judgment — 2026-06-08"
refined_by:
  - "2026-06-17 — Fable tier added above Opus; reasoning lane is Fable→Opus with a model-floor fallback for unavailability"
expresses_as:
  - "perception lane: cheap (reading, grep, simple writes) → Haiku"
  - "execution lane: judgment + execution (research, routing, implementation, creation) → Sonnet"
  - "reasoning lane: rare/expensive (architecture, second voice, strategy) → Opus, or Fable where entitled"
  - "verify lane: hooks (0 tokens)"
  - "never hardcode a dated model string — the floor lives in one place per agent; a fallbackModel handles unavailability"
commonized_from: "freya.devstudio/canon/canon.cost-gradient.md (2026-06-17)"
---

# Cost gradient

Route work by cost: cheap perception (reading a card, context), rare reasoning
(architecture, promoting a canon entry), free hook-based verification. Spend the expensive
tier only where it changes the outcome.

## Tier (2026-06-17)

Fable 5 > Opus 4.8 > Sonnet 4.6 > Haiku 4.5.

| Tier | When to use | Global examples |
|------|-------------|-----------------|
| **Fable / Opus** | Irreversible decisions, architecture, second voice, strategy | agol (Fable, advisor), oraculum (Fable, scientist-tier), houston (Opus, architect), janus (Opus, challenge) |
| **Sonnet** | Judgment + execution, live verification, creation | trajectory (implement), atlas-auto / atlas-ui (create) |
| **Haiku** | Deterministic, surgical, no judgment | delta (executor), recorder (librarian), zenith (reader), guard hooks |

If a task does not require judgment → Sonnet is too expensive.
If it does not require architecture → Opus / Fable is too expensive.

## Model floor

The floor lives in **one place per agent** (the `model:` field), never as a dated string in
prose. Unavailability is absorbed by a `fallbackModel` (e.g. Fable → Opus), not by editing
agents. Rate-limit fallback is operational routing — a separate concern from unavailability.
