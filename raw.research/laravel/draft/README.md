---
scope: laravel
sources_file: raw.research/laravel/draft/sources.jsonl
output_path: raw.research/laravel/report/raw.laravel.<YYYY-MM-DD>.md
card: raw.settings/raw.card.laravel.md
output_mode: briefing
window_days: 7
persist: ephemeral
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Laravel framework + PHP ecosystem — package releases, craft, and language
    evolution. Tier 1: laravel-news + laravel-daily. Tier 2: stitcher-io + freek-dev.
    Special watch: laravel/mcp + laravel/boost GitHub release cadence (AI surface,
    moving fast as of 2026-07).
  related_scopes:
    - raw.research/arch/      (OS substrate — separate scope)
    - raw.research/ai-news/   (AI/LLM layer — separate scope)
pull:
  photos_path: raw.research/laravel/photos/
  output_path: raw.research/laravel/report/report.laravel-daily.<YYYY-MM-DD>.md
  purpose: >
    Laravel Daily YouTube screenshots — Povilas Korop's daily short-form code posts.
    Extract visible code + practical explanation from each screenshot.
---

# Scope: laravel

Periodic briefing on the Laravel / PHP ecosystem. Invoked as `/refresh laravel`.
Window 7 days; persist ephemeral.

Tier 1: laravel-news (daily hub) + laravel-daily (Korop, weekly craft).
Tier 2: stitcher-io (Brent Roose — PHP language evolution, Tempest) +
        freek-dev (Freek Van der Herten / Spatie — 300+ packages, AI-in-Laravel).

Note: freek-dev RSS URL unverified at scope creation. Skill will attempt
`freek.dev/rss` on first run; flag as feed-error if broken.

Skill: `/refresh laravel`
Card: `raw.settings/raw.card.laravel.md`

## Pull (image extraction)

Screenshot inbox for Laravel Daily YouTube content. Invoke as `/pull laravel`.
Drop `.png`/`.jpg` screenshots into `raw.research/laravel/photos/` — skill reads,
extracts code + explanation, writes `report/report.laravel-daily.<YYYY-MM-DD>.md`.
Move processed photos to `photos/processed/` via the confirm prompt.
