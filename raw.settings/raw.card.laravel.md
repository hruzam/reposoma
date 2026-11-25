---
card: card.laravel
brand: Research — Laravel / PHP ecosystem (scope: laravel)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-11-25
half_life: ~7 days
half_life_days: 7
recheck:
  - ~/reposoma/raw.research/laravel/draft/sources.jsonl
  - https://feed.laravel-news.com
  - https://github.com/laravel/mcp/releases
  - https://github.com/laravel/boost/releases
verify_cmd: "curl -s https://feed.laravel-news.com | grep -c '<item>'"
---

## Refresh delta 2026-11-25
_Since last verify 2026-10-08. Sources live-fetched 2026-11-25 by @Epoch-sibling: feed.laravel-news.com, github.com/laravel/{framework,mcp,boost,ai}/releases, laravel.com/docs/13.x/releases, php.net (releases + supported-versions), web search for the PHP security release. GitHub release pages show dates without year; year taken as 2026 from page context. Not run: `php -v`, `composer show`, verify_cmd._
- **Laravel 13.44** (Nov 24): form-request model lookup helpers, alerts for long-running transactions, a PostgreSQL locking method (`lockForNoKeyUpdate()` per lead; method name not shown in the feed summary), and **PHP 8.6 support**. GitHub also shows **v13.44.1** (Nov 24, no itemized notes) and **v12.74.0** (Nov 24, 12.x backport: JSON Schema `uniqueItems` fix, validation/mail escaping fixes). Feed H (summary only); GitHub H.
- **Laravel 13.43.0** (Nov 17) is a SECURITY release: signed URL expiration bypasses, Eloquent mass-assignment guard bypass, XSS in the debug page, DoS in the JSON Schema deserializer; also `JsonSchema::rules()` (the Nov 23 feed item covers it), `#[RetryFor]` queue attribute, `releaseUsingBackoff()`, PHP 8.5 deprecation fix. 12.73.0 backports many fixes. ACTION: any app below 13.43 / 12.73 should update. H (GitHub releases).
- **Support policy (laravel.com, H):** Laravel 13 requires PHP 8.3+; the docs table still lists 13 as PHP 8.3 - 8.5 (released 2026-03-17, bug fixes until Q3 2027, security until 2028-03-17). 8.6 support is announced in 13.44 but the docs table has NOT been updated yet. Laravel 12: PHP 8.2 - 8.5, bug fixes until 2026-08-13 (ended), security fixes until 2027-02-24. Laravel 11 security ended 2026-03-12. Annual major cadence ~Q1.
- **PHP (php.net, H):** **8.6.0 GA released 2026-11-19** (supported-versions page: active to 2028-12-31, security to 2030-12-31). 8.5 latest listed patch **8.5.13** (2026-11-19). 8.4 active until 2026-12-31; 8.3 and 8.2 security-only; **8.2 EOL 2026-12-31** (about 5 weeks). Laravel 13 floor 8.3 is security-only on PHP's side.
- **PHP security (M, web search; php.net pages read did not carry details):** the 2026-10-21 release (8.5.12 / 8.4.27 / 8.3.36 / 8.2.35) fixed two critical unauthenticated RCE flaws (CVE-2026-109618, CVE-2026-109619; CVSS v4 9.2; memory corruption after abnormal request end; highest risk reported for mod_php). It applies UPSTREAM to all supported branches, not only a distro build. Lead's "php-legacy >= 8.3.36" is an Arch package naming, consistent with upstream 8.3.36. CONFLICT: Cybernews cites later numbers (8.2.36, 8.3.37, 8.4.28, 8.5.13) for a further timezone use-after-free (CVE-2026-129496); php.net lists 8.5.13 on 2026-11-19, consistent with a follow-up release. Minimum safe floor: 8.5.13 / latest patch of your branch; verify 8.2-8.4 numbers on php.net/downloads.
- **laravel/mcp v1.3.0** (Nov 24): OAuth resource-metadata URL resolution, translatable authorize view, Windows stdio fix, client capabilities exposed to handlers, PHP 8.6 in test matrix, **MCP Skills extension support**. Since v1.0.1: v1.1.1 (Oct 21, redirect URIs limited in dynamic client registration), v1.1.2 (Oct 26, OAuth hardening: HTTP/HTTPS only, response size cap, authorize page not framed), v1.2.0 (Nov 10, malformed requests return JSON-RPC errors; Origin validated on web routes; no redirect following), v1.2.1 (Nov 17, conformance fixtures, `Mcp-Param` validation, Guzzle 8). 0.9.7 (Oct 21) is a backport on the 0.x line. H.
- **Laravel AI SDK** (laravel/ai): latest **v1.4.2** (Nov 24; Anthropic tool-error flagging, structured-output tool choice, reasoning replay for OpenAI-compatible loops). v1.4.1 (Nov 17: Gemini Decisions API, Anthropic citations), v1.4.0 (Nov 10: raw HTTP response exposed, agent tool-failure recovery), v1.3.0 (Oct 19). Card's 1.1 (Oct 6) is superseded. H.
- **Laravel Boost:** latest **v2.10.4** (Oct 29): re-index rules command, testing skill allows PHPUnit TestCase, removed application-info MCP tool, Pest 5 allowed. No Boost release between Oct 29 and 2026-11-25 on the releases page. Also v2.10.0 (Sep 23): Claude Code guidelines now use AGENTS.md. H.
- **Not verified / not in card scope:** Herd/Valet/Sail versions (not mentioned in card; not checked), Laravel 14 timing (docs say ~Q1 annual cadence; no 14 announcement read), 13.44 article body.

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: feed.laravel-news.com, live-fetched 2026-10-08 by @Epoch. Pass 2 added Boost + laravel/mcp (GitHub releases, H) and PHP branch status (web search, M)._
- **Laravel 13.35** (Oct 7): `Route::query()`, opt-in model `defaults()`, property arrays in fake assertions, percentage-based worker memory limits. H
- **Laravel AI SDK 1.1** (Oct 6): Agent Skills support, Cohere text generation, approval for built-in tools, better provider-tool failover. H
- Ecosystem: Synapse (Redberry dashboard for AI SDK agents), VMPal (VMs for agents) — news only. M
- **Laravel Boost v2.10.3** (Oct 7): schema-builder table listing for unsupported DB drivers, fixes to four bundled skills. v2.10.2 (Oct 5): MCP support for Pi, rejects non-object JSON5 MCP config roots. v2.10.1 (Oct 1): keeps syncing CLAUDE.md for existing Claude Code projects, slims always-loaded guidelines. H
- **laravel/mcp v1.0.1** (Sep 24): loopback redirect URI validation by parsed host. **v1.0.0** (Sep 14, major): OAuth challenges on authenticated MCP routes, MCP conformance suite, client honors server caching hints, nested request input via dot notation, serves legacy `initialize` clients alongside the modern protocol. H
- **PHP:** 8.6 is the current stable branch (GA 2026-11-19); latest 8.5 patch 8.5.13 (php.net, H).

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
