---
card: card.gemini-gems
brand: Google — Gemini app (Gems / chat)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-02
half_life: ~weeks
half_life_days: 30
recheck:
  - https://gemini.google.com
  - https://blog.google/products/gemini/
surface_type: chat (NO filesystem; standing instructions + knowledge)
---

# Gemini Gems — custom chatbots (Gemini-side authoring / research surface)

## What it is
- A "Gem" = a custom chatbot with standing instructions + optional knowledge files. Parallel to
  claude.ai Projects. NO filesystem / agent files.
- NOT affected by the Gemini CLI June-18 sunset (that's the CLI / Code-Assist surface; Gems are the consumer app).

## Configuration
- **Gem instructions** (standing prompt) ← researcher's / builder's system prompt lives here.
- **Knowledge** (attached files) ← feed the RELATIVE cards here.
- Grounding / Google Search for live "what's new" recalibration.

## Date fact
- Same as claude.ai: the app supplies the date; keep "today is <date>" in the prompt.

## Limits
- Invoke-on-demand (no autonomous schedule in normal chat). Recurring radar → CLI/automation.

## Use in LARVA
- The 1:1 substitute for the claude.ai researcher/builder on the Google side — useful when you want
  Gemini's grounding or to keep a task on the Google stack. Your best-experience surface is claude.ai;
  Gems is the mirror.

## Honest gap
- I'm less certain of Gems' exact current knowledge-file limits / feature toggles than of the CLI
  surfaces; treat specifics as LOWER-confidence and re-verify in-app.
