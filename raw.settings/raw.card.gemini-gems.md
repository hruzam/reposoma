---
card: card.gemini-gems
brand: Google — Gemini app (Gems / chat)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-11-25
half_life: ~weeks — line is PARKED, consider longer (see refresh delta)
half_life_days: 21
recheck:
  - https://gemini.google/release-notes/
  - https://releasebot.io/updates/google/gemini
  - https://blog.google/products/gemini/
surface_type: chat (NO filesystem; standing instructions + knowledge)
---

## Refresh delta 2026-11-25
_Since last verify 2026-10-08. Sources live-fetched 2026-11-25 by @Epoch sibling: gemini.google/release-notes (full page: 0-100K + 100K-166K; tail is 2023-2024 only), releasebot.io/updates/google/gemini (feed visible only Nov 16-24; Sep/Oct NOT visible there), blog.google/products/gemini/ (index = nav only, no articles; PARTIAL: blog posts only seen via releasebot summaries)._
- **Gems vs Skills (settled as far as release notes go):** 2026.09.30 entry still the latest word: "Skills will soon replace Gems as the tool for tailoring instructions for specific tasks"; "we will automatically migrate your Gems into skills when Gems go away"; Skills "currently available to 18+ and coming to more users soon". No later release-note entry says Gems are retired/renamed, and releasebot shows no Gems entry in Nov 16-24. So: Gems NOT yet confirmed gone; retirement announced, date NOT published. Gems = on a retirement path (not removed, not renamed). H (release notes), M on "not yet retired" (absence of evidence).
- **2026.10.13 — Gemini 4 "Argon"** rolling out to Google AI Pro and Ultra subscribers worldwide; same entry: "Customize" lets users add skills so Gemini handles routine tasks. H (release notes; wording from translated/Czech-locale rendering of page).
- **2026.11.17 — Tasks in Gemini** runs on new "Hydrogen 4" model (release notes) / "Gemini 4 Hydrogen" (blog via releasebot); free, six countries, no extra charge. H/M.
- **2026.11.17 — Gemini 4 Carbon:** paid Gemini API developers; "Google AI Ultra subscribers can try it in Google Antigravity, AI Studio, the Gemini app, and AI Mode in Search." M (releasebot summary of blog; blog page itself not read).
- **2026.11.18 — Gemini 4 Neon:** rolls out to Pro and Ultra subscribers in the Gemini app (and AI Pro/Ultra in Antigravity); positioned between Carbon (hardest long-horizon work) and Hydrogen (fast everyday execution). M (releasebot summary). The Gemini APP release notes page had NO Neon/Carbon entry in the portion read — treat app-notes as lagging.
- **AI Plus:** not mentioned in any source read. Plan gating for Gems/Skills themselves: NOT published in sources read.
- **Not Gems:** Genie 4 / Project Genie (Nov 18, Ultra; Pro waitlist) is a different product, not Gemini 4.
- Not verified: whether any Gem-specific limits changed; whether Skills have knowledge-file support; in-app Gem model selector contents (does it offer Gemini 4 tiers?); Gems/Skills sunset date.

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: gemini.google/release-notes, live-fetched 2026-10-08 by @Epoch (first ~100K of 157K chars read). Line is PARKED._
- **2026.09.30 — Skills in Gemini chat:** reusable instructions built from chats, auto-run on matching prompts, combinable; global, users 18+. **Gems are being REPLACED by Skills** ("will soon replace Gems"); existing Gems auto-migrate when retired. Card's Gems framing is on a retirement path. H
- **2026.09.10:** native Gemini app for Windows 10+ (Alt+Space), connects Gmail/Drive. H
- **Models (CORRECTION 2026-10-08, pass 2):** the Gemini APP release notes show no model change after Gemini 3.6 Flash (2026.07.21) — the full page is now read (the remaining ~57K chars are 2024-and-older entries) and it never mentions Gemini 3.8 Flash or Gemini 4. BUT OpenRouter's catalog lists `google/gemini-3.8-flash` created 2026-09-02 (M), and Latent Space AINews (Oct 1) reports "Gemini 4 Argon", Google DeepMind's new model, limited for now to vetted government and cybersecurity users, 1M output (M, headline-level; no Google page read). So "no model changes" holds for the Gemini APP release notes only; the API/model catalog (OpenRouter) and press (Latent Space) show newer models. Treat the release notes as silent on them, not as proof of absence.

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
- A "Gem" = a custom chatbot with standing instructions + optional knowledge files (parallel to claude.ai Projects). **Gems are being replaced by Skills** (release notes 2026.09.30; auto-migration when Gems go away, date unpublished) — treat Gem authoring as a legacy path. NO filesystem / agent files.
- NOT affected by the Gemini CLI sunset (that's the CLI / Code-Assist surface; Gems are the consumer app).

## Configuration
- **Gem instructions** (standing prompt) ← researcher's / builder's system prompt lives here (will migrate to Skills).
- **Knowledge** (attached files) ← feed the RELATIVE cards here.
- Grounding / Google Search for live "what's new" recalibration.

## New in Jun–Jul 2026 (verified 2026-07-16, still current as of 2026-09-02)
- **Gemini 3.5 Flash** (May, globally available via model dropdown): Gemini 3.5 Flash was the app's best-fast model until Gemini 4 (Oct-Nov 2026); whether the Gem selector exposes Gemini 4 tiers is unverified. Computer use capability (browser,
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
- release-notes carried the Gems->Skills notice; releasebot feed is shorter-window (Nov 16-24 visible) and blog.google index is nav-only to fetchers.
</content>
