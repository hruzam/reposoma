---
card: card.laravel
brand: Research — Laravel / PHP ecosystem (scope: laravel)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~7 days
half_life_days: 7
recheck:
  - ~/reposoma/raw.research/laravel/draft/sources.jsonl
  - https://feed.laravel-news.com
  - https://github.com/laravel/mcp/releases
  - https://github.com/laravel/boost/releases
verify_cmd: "curl -s https://feed.laravel-news.com | grep -c '<item>'"
---

# laravel — synthesis log

Skill: `/refresh laravel` · Data: `raw.research/laravel/draft/sources.jsonl`
Substrate: `raw.research/laravel/report/`

## 2026-09-02

**Lead:** Craft-heavy week, less AI-surface churn than 2026-07-10. Laravel News: Compoships (multi-column Eloquent relationships), MKSine (Filament CMS with plugins/themes/blocks), Inertia.js 3.7 (cancel in-flight form submissions), starter kits move to Vite+ for unified code-quality checks, and Laravel 13.27 ships `refreshForUpdate()` for pessimistic locking. freek-dev's one in-window item: a Laravel AI SDK Slack-bot tutorial (tighten.com, Aug 31). laravel-daily and stitcher-io both quiet this window (closest stitcher-io item 1 day outside window).

**Convergence:** none in window

**Quiet:** laravel-daily (most recent 2026-08-12), stitcher-io (most recent 2026-08-25, 1 day short)

**Feed flags:** freek-dev (RSS still 404 at freek.dev/rss, unchanged since 2026-07-10 — fallback to freek.dev direct succeeded)

**Manual-check:** none

---

## 2026-07-10

**Lead:** AI-in-Laravel week: Intercept package adds middleware guardrails (prompt injection + PII filtering) to the Laravel AI SDK; a security tutorial demos four defensive layers; Laravel MPP / square1/laravel-mpp implements Machine Payments Protocol (402 responses) for monetizing AI agent API access. Laravel 13.19 ships HTTP QUERY verb support, bulk SQS dispatch, and collection additions. Shift adds AI review to its upgrade flow.

**Convergence:** laravel-mpp / Machine Payments Protocol (laravel-news, freek-dev — weak: laravel-news primary, freek-dev linking conroyp.com tutorial)

**Quiet:** laravel-daily, stitcher-io

**Feed flags:** freek-dev (RSS 404 at freek.dev/rss — fallback to freek.dev direct succeeded; content is link posts this week)

**Manual-check:** none

---

<!-- older runs appended below this line, newest first -->
