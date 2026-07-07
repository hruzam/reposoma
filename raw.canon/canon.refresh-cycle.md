---
status: promoted   # gaveled by majkee 2026-06-20 — need-event: the card-freshness system is built and all cards were hand-migrated to half_life_days; card.template.md is in active use (not a design conversation)
captured_by: "the fetch → substrate → synthesis bond, named 2026-06-20; concrete template at raw.settings/card.template.md"
extends: "canon.reposoma-is-substrate (raw → distilled) · canon.context-economy (read the distillate, never the dump)"
expresses_as:
  - "fetch-skill → full-context dump (raw.*.harness.<date>.md) → synthesis → compact card (raw.card.*.md)"
  - "agents read the COMPACT card, never the full dump — the dump is synthesis-input only"
  - "synthesis IS the card-creator: it writes the card from card.template.md, carrying BOTH freshness fields (half_life prose + half_life_days int)"
  - "the dated full dumps are regenerable substrate — archivable; the card is the living distillate"
  - "freshness closes the loop: card stale when (today − verified) >= half_life_days → re-fetch + re-synthesize"
---

# The refresh cycle

A RELATIVE card is not hand-written — it is the **compact distillate of a full-context fetch.** The bond:

`fetch-* skill → full dump (raw.*.harness.<date>.md) → synthesis → compact card (raw.card.*.md)`

- **The dump is synthesis-input only.** Agents read the **card**, never the dump — `canon.context-economy` in the
  small (the dump is exactly what you don't want a seat eager-loading).
- **Synthesis is the card-creator.** It writes the card from the canonical template
  (`raw.settings/card.template.md`), carrying both freshness fields: `half_life:` (human prose) +
  `half_life_days:` (the integer the freshness tooling reads).
- **The loop closes on freshness:** stale when `today − verified >= half_life_days`; the recalibration trigger
  (`aihs-stale` → a `_mail/toAll` broadcast) flags it → re-fetch + re-synthesize. The larva "self-refreshing
  triangle" (cards = memory · researcher = perception), now with a real template and an integer clock.
- Old dated dumps are **regenerable substrate** — archivable; the card is the living distillate.

> Template: `raw.settings/card.template.md`. Lineage: larva `raw.larva.cards.structure-and-protocol.md`
> (verbatim — point, never edit).
