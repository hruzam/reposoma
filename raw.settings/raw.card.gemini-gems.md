---
card: card.gemini-gems
brand: Google — Gemini app (Gems / chat)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-02
half_life: ~weeks
half_life_days: 30
recheck:
  - https://gemini.google/release-notes/
  - https://blog.google/products/gemini/
  - https://gemini.google/gemini-drops/
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

## New in Jun–Jul 2026 (Gemini app broadly)
- **Deep Research expanded:** upload your own files and images as sources; transform reports into
  interactive visuals and quizzes in Canvas. Deep Research now available on Gemini 2.5 Flash at no cost.
- **Gemini Spark (macOS launch):** automate tasks across desktop files, assign tasks remotely from
  phone. Tracks topics + reacts to real-time events (blogs, news, finance, weather, sports).
  Connected apps expanded: Google Tasks, Google Keep, Canva, Dropbox, Instacart, OpenTable, Zillow Rentals.
  ← Spark is a SEPARATE agentic feature from Gems — not a Gem primitive, but same app.
- **Gemini Omni:** video creation/editing from text+photo+video; custom AI avatars. Google AI subscribers, 18+.
- **Daily Brief:** personal intelligence dashboard from Gmail + Calendar, powered by connected apps.

## Date fact
- Same as claude.ai: the app supplies the date; keep "today is <date>" in the prompt.

## Limits
- Invoke-on-demand (no autonomous schedule within a Gem itself). Recurring radar → CLI/automation.
- Gemini Spark IS autonomous/async — but it is a separate surface, not a Gem configuration option.

## Use in LARVA
- The 1:1 substitute for the claude.ai researcher/builder on the Google side — useful when you want
  Gemini's grounding or to keep a task on the Google stack. Your best-experience surface is claude.ai;
  Gems is the mirror.

## Honest gap
- Gem-specific knowledge-file limits and exact feature toggle set are not fully published — re-verify
  in-app. The Jun–Jul additions above are Gemini app features; which are exposed as Gem configuration
  options vs. only available in freeform chat requires in-app confirmation.
