---
card: card.gemini-gems
brand: Google — Gemini app (Gems / chat)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-16
half_life: ~weeks
half_life_days: 21
recheck:
  - https://gemini.google/release-notes/
  - https://releasebot.io/updates/google/gemini
  - https://blog.google/products/gemini/
surface_type: chat (NO filesystem; standing instructions + knowledge)
---

# Gemini Gems — custom chatbots (Gemini-side authoring / research surface)

## What it is
- A "Gem" = a custom chatbot with standing instructions + optional knowledge files. Parallel to
  claude.ai Projects. NO filesystem / agent files.
- NOT affected by the Gemini CLI sunset (that's the CLI / Code-Assist surface; Gems are the consumer app).

## Configuration
- **Gem instructions** (standing prompt) ← researcher's / builder's system prompt lives here.
- **Knowledge** (attached files) ← feed the RELATIVE cards here.
- Grounding / Google Search for live "what's new" recalibration.

## New in Jun–Jul 2026 (verified 2026-07-16)
- **Gemini 3.5 Flash** (May, globally available via model dropdown): "best model to date for fast,
  efficient task completion" — available in the Gem model selector. Computer use capability (browser,
  mobile, desktop automation) added Jun 24 with enterprise safeguards (confirmation requirements,
  prompt injection detection).
- **Study Notebooks** (Jun 25 global, Jul 10 update): personalized learning space inside Gemini app —
  bite-sized lessons tailored to knowledge gaps, practice quizzes, progress tracking. Expanding to
  SAT/JEE/NEET/ACT/GRE prep. Separate feature from Gems, same app.
- **Deep Research expanded:** upload your own files and images as sources; transform reports into
  interactive visuals and quizzes in Canvas. Deep Research now available on Gemini 2.5 Flash at no cost.
- **Gemini Spark (macOS, Jun 30):** automate tasks across desktop files, assign tasks remotely from
  phone. Tracks topics + reacts to real-time events (blogs, news, finance, weather, sports).
  Connected apps: Google Tasks, Google Keep, Canva, Dropbox, Instacart, OpenTable, Zillow Rentals.
  ← Spark is a SEPARATE agentic feature from Gems — not a Gem primitive, but same app.
  **Southeast Asia rollout (Jul 14):** Spark now available in local languages for Advanced subscribers
  across Southeast Asia (Vietnam 89%, Thailand 87% native-language adoption).
- **Gemini Omni Flash** (Jun 30): 10-second video generation from text/photo/video, conversational editing.
  Text-to-image via Nano Banana 2 Lite at ~$0.034/1K images (4-second generation). For Gemini subscribers.
- **Meet Note-Taking** (Jun 29, Pro/Ultra): transcribes meetings, generates summaries + action items,
  auto-saves to Google Docs.
- **Personal Intelligence** (Jun 29, US free users): personalized image generation integrating Gmail,
  Photos, YouTube, Search data.
- **Google Slides generation** (Jun 30): multi-slide decks from prompts, grounded in Drive content.
- **Daily Brief:** personal intelligence dashboard from Gmail + Calendar, powered by connected apps.
- **Claude Tag for Slack parallel:** Gemini has no direct equivalent noted in this period.

## Date fact
- Same as claude.ai: the app supplies the date; keep "today is <date>" in the prompt.

## Limits
- Invoke-on-demand (no autonomous schedule within a Gem itself). Recurring radar → CLI/automation.
- Gemini Spark IS autonomous/async — but it is a separate surface, not a Gem configuration option.
- Computer use (3.5 Flash) is available in freeform chat; whether it surfaces inside a configured Gem
  requires in-app confirmation.

## Use in LARVA
- The 1:1 substitute for the claude.ai researcher/builder on the Google side — useful when you want
  Gemini's grounding or to keep a task on the Google stack. Your best-experience surface is claude.ai;
  Gems is the mirror.

## Honest gap
- Gem-specific knowledge-file limits and exact feature toggle set are not fully published — re-verify
  in-app. The Jun–Jul additions above are Gemini app features; which are exposed as Gem configuration
  options vs. only available in freeform chat requires in-app confirmation.
- `gemini.google/release-notes/` lags (last confirmed entry May 2026 on that page); use `releasebot.io/updates/google/gemini`
  as primary recheck source until the official page catches up.
