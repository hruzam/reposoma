---
card: card.gemini-gems
brand: Google — Gemini app (Gems / chat)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~weeks — line is PARKED, consider longer (see refresh delta)
half_life_days: 21
recheck:
  - https://gemini.google/release-notes/
  - https://releasebot.io/updates/google/gemini
  - https://blog.google/products/gemini/
surface_type: chat (NO filesystem; standing instructions + knowledge)
---

# Gemini Gems — custom chatbots (Gemini-side authoring / research surface)

## Refresh delta 2026-09-02
- **No Gem-specific feature changes found** in gemini.google/release-notes/ or web search for the
  Jul 16 → Sep 2 window. Most recent Gem-management entry on the official notes page is still
  Sep 2025 (Gem sharing). CONFIDENCE: M (absence-of-evidence, two sources checked).
- **Adjacent app features shipped in the window** (not Gem primitives, but same app/surface):
  Voice dictation on macOS (Jul 29) · Student hub + mobile study notebooks (Aug 19) ·
  Gemini 3.5 Transcribe GA, speech-to-text w/ diarization, 85+ languages (Aug 26).
  SOURCE: gemini.google/release-notes/, WebSearch, fetched 2026-09-02. CONFIDENCE: H.
- **All Jun–Jul 2026 entries below (Gemini 3.5 Flash, Study Notebooks, Deep Research, Spark,
  Omni Flash, Meet Note-Taking, Personal Intelligence, Slides gen) are unchanged and still
  current** — no superseding or contradicting news found. CONFIDENCE: M.
- Card content is substantively stable; bumping `verified:` without material rewrite.

## What it is
- A "Gem" = a custom chatbot with standing instructions + optional knowledge files. Parallel to
  claude.ai Projects. NO filesystem / agent files.
- NOT affected by the Gemini CLI sunset (that's the CLI / Code-Assist surface; Gems are the consumer app).

## Configuration
- **Gem instructions** (standing prompt) ← researcher's / builder's system prompt lives here.
- **Knowledge** (attached files) ← feed the RELATIVE cards here.
- Grounding / Google Search for live "what's new" recalibration.

## New in Jun–Jul 2026 (verified 2026-07-16, still current as of 2026-09-02)
- **Gemini 3.5 Flash** (May, globally available via model dropdown): "best model to date for fast,
  efficient task completion" — available in the Gem model selector. Computer use capability (browser,
  mobile, desktop automation) added Jun 24 with enterprise safeguards (confirmation requirements,
  prompt injection detection).
- **Study Notebooks** (Jun 25 global, Jul 10 update; expanded to mobile Aug 19): personalized
  learning space inside Gemini app — bite-sized lessons, practice quizzes, progress tracking.
  Expanding to SAT/JEE/NEET/ACT/GRE prep. Separate feature from Gems, same app.
- **Deep Research expanded:** upload your own files and images as sources; transform reports into
  interactive visuals and quizzes in Canvas. Deep Research now available on Gemini 2.5 Flash at no cost.
- **Gemini Spark (macOS, Jun 30):** automate tasks across desktop files, assign tasks remotely from
  phone. Tracks topics + reacts to real-time events (blogs, news, finance, weather, sports).
  Connected apps: Google Tasks, Google Keep, Canva, Dropbox, Instacart, OpenTable, Zillow Rentals.
  ← Spark is a SEPARATE agentic feature from Gems — not a Gem primitive, but same app.
  Southeast Asia rollout (Jul 14): local-language support for Advanced subscribers.
- **Gemini Omni Flash** (Jun 30): 10-second video generation from text/photo/video, conversational editing.
  Text-to-image via Nano Banana 2 Lite at ~$0.034/1K images.
- **Meet Note-Taking** (Jun 29, Pro/Ultra), **Personal Intelligence** (Jun 29, US free users),
  **Google Slides generation** (Jun 30), **Daily Brief** (Gmail + Calendar dashboard) — all unchanged.

## Date fact
- Same as claude.ai: the app supplies the date; keep "today is <date>" in the prompt.

## Limits
- Invoke-on-demand (no autonomous schedule within a Gem itself). Recurring radar → CLI/automation.
- Gemini Spark IS autonomous/async — but it is a separate surface, not a Gem configuration option.
- Computer use (3.x Flash) is available in freeform chat; whether it surfaces inside a configured
  Gem still requires in-app confirmation (unchanged gap).

## Use in LARVA
- The 1:1 substitute for the claude.ai researcher/builder on the Google side — useful when you want
  Gemini's grounding or to keep a task on the Google stack. Your best-experience surface is claude.ai;
  Gems is the mirror.

## Honest gap
- Gem-specific knowledge-file limits and exact feature toggle set are not fully published — re-verify
  in-app. Which Jun–Aug additions are exposed as Gem configuration options vs. only freeform chat
  still requires in-app confirmation.
- `gemini.google/release-notes/` lags for Gem-specific items (last confirmed Gem-management entry
  Sep 2025); `releasebot.io/updates/google/gemini` remains the primary recheck source.
</content>
