---
card: card.laravel
brand: Research — Laravel / PHP ecosystem (scope: laravel)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~7 days
half_life_days: 7
recheck:
  - ~/reposoma/raw.research/laravel/draft/sources.jsonl
  - https://feed.laravel-news.com
  - https://github.com/laravel/mcp/releases
  - https://github.com/laravel/boost/releases
verify_cmd: "curl -s https://feed.laravel-news.com | grep -c '<item>'"
---

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: feed.laravel-news.com, live-fetched 2026-10-08 by @Epoch. Pass 2 added Boost + laravel/mcp (GitHub releases, H) and PHP branch status (web search, M)._
- **Laravel 13.35** (Oct 7): `Route::query()`, opt-in model `defaults()`, property arrays in fake assertions, percentage-based worker memory limits. H
- **Laravel AI SDK 1.1** (Oct 6): Agent Skills support, Cohere text generation, approval for built-in tools, better provider-tool failover. H
- Ecosystem: Synapse (Redberry dashboard for AI SDK agents), VMPal (VMs for agents) — news only. M
- **Laravel Boost v2.10.3** (Oct 7): schema-builder table listing for unsupported DB drivers, fixes to four bundled skills. v2.10.2 (Oct 5): MCP support for Pi, rejects non-object JSON5 MCP config roots. v2.10.1 (Oct 1): keeps syncing CLAUDE.md for existing Claude Code projects, slims always-loaded guidelines. H
- **laravel/mcp v1.0.1** (Sep 24): loopback redirect URI validation by parsed host. **v1.0.0** (Sep 14, major): OAuth challenges on authenticated MCP routes, MCP conformance suite, client honors server caching hints, nested request input via dot notation, serves legacy `initialize` clients alongside the modern protocol. H
- **PHP:** 8.5 is the current stable branch; exact latest patch NOT confirmed (php.net snapshot stale; a Pantheon note of 2026-08-31 lists 8.5.10 and 8.4.25). PHP 8.6 GA scheduled 2026-11-19; RC1 (planned Sep 24) shipment unconfirmed. M — check php.net/downloads.

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
