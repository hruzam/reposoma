# Laravel Daily Community-Post Tips — Synthesis (screenshots, ~May–Jun 2026)

Source: 20 screenshots from the Laravel Daily YouTube posts tab → 11 distinct
items. Each entry: the tip, why it matters, imago.cz application, and WHERE it
belongs in the two-repo setup (guideline = always-loaded rule; skill = on-demand;
n/a = just do it once).

---

## 1. Cache keys as reusable constants  →  guideline + pattern
Define `public const NAV_BADGE_CACHE_KEY = 'products.count';` on the model;
use it in `Cache::remember()` and in an Observer's created/deleted/restored
hooks calling `Cache::forget(Product::NAV_BADGE_CACHE_KEY)`.
Why: a mistyped raw string key breaks invalidation SILENTLY — no error, stale
data forever.
imago: nav badges, product counts, homepage block caches.
Placement: one line in `10-php-laravel.md`: "Cache keys are consts on the
owning model; invalidation via Observer; never raw string keys."

## 2. API response standardization: BaseController vs Trait  →  guideline (decision)
Two approaches shown: `ApiController` base class with successResponse()/
errorResponse(), or `ApiResponseTrait` added only to controllers that need it.
Plus: centralize exception→JSON in `bootstrap/app.php` via
`$exceptions->renderable()` for AuthorizationException / ModelNotFoundException
/ AccessDeniedHttpException with proper Response::HTTP_* codes.
Why: agents otherwise invent a new response shape per feature.
imago: pick ONE (trait is the lighter fit for a modular monolith — no forced
inheritance across modules), encode as rule + the exception block as a
copy-paste skill snippet.

## 3. Laravel 13.6: prefersJsonResponses()  →  note in skill (API module)
`->prefersJsonResponses()` in bootstrap/app.php forces JSON responses even
when the client omits `Accept: application/json`; explicit client preference
still wins; validation failures return JSON instead of redirect.
(PR by Wendell Adriel, Apr 2026.)
imago: relevant when/if storefront API or mobile endpoints ship.

## 4. Seeder tip: DB::unprepared() with raw SQL files  →  skill (migration)
`DB::unprepared(file_get_contents(database_path('seeders/sql/products.sql')))`
inside a seeder instead of hand-converting SQL exports into PHP seeders.
imago: PRIME tool for OpenCart→Laravel migration fixtures — dump legacy
tables, replay into test/staging. Caution: unprepared = no bindings; trusted
files only; never user input.

## 5. Query debugging: ->dd() and ->ddRawSql()  →  guideline (one line)
Append `->dd()` to any Eloquent query instead of `->get()` to dump SQL +
bindings; `->ddRawSql()` dumps SQL with bindings substituted (runnable as-is).
Works great in Tinker — pairs with Boost's tinker MCP tool.

## 6. Pest: LazilyRefreshDatabase > RefreshDatabase  →  n/a (do once) + guideline
In tests/Pest.php swap `RefreshDatabase::class` for
`LazilyRefreshDatabase::class` — migrations run only when a test first touches
the DB connection, not for every test. Free CI speedup.
Placement: change once; add rule "tests use LazilyRefreshDatabase" so agents
don't regress it.

## 7. Multi-tenant secure+private file uploads  →  skill (files module)
Options ladder: private local disk → private S3/R2 with tenant-prefixed paths
(`companies/{id}/documents/{uuid}.pdf`) → scoped disks → per-tenant buckets.
Recommended default: private S3/R2 + filename in DB + policies +
`Gate::authorize('download', $document)` before EVERY streamed download;
`abort_unless($media, 404)`.
imago mapping (not multi-tenant): same pattern for customer invoices, digital
products, order attachments — authorize per-download, never public URLs.

## 8. LaravelMetrics package  →  skill (admin dashboards)
Fluent metrics on any query: `LaravelMetrics::query(Order::query())
->sum('amount')->byMonth(6)->trends();` — count/sum, byDay/byMonth/byYear,
->metrics() (totals) vs ->trends() (chart series).
imago: Filament dashboard widgets (orders, revenue). NOTE: query-time
aggregation against live tables — fine at current scale with indexes+cache;
see rollup strategy discussed separately before scaling.

## 9. request()->fullUrlWithoutQuery()  →  guideline (one line, storefront)
`request()->fullUrlWithoutQuery('page')` or `(['page','sort','order'])` —
build filter/sort links that drop pagination but keep remaining params.
imago: catalog filter UI; prevents the classic "page 7 of a now-2-page
filtered result" bug.

## 10. laravel-lang/* supply-chain attack (May 23, 2026)  →  already actioned
New specifics from the screenshot: payload executes at AUTOLOAD time; 50+
package versions compromised (lang, http-statuses, attributes); if a
compromised version was installed, malware already ran → pin to a clean
COMMIT (not version) and rotate secrets immediately; older locked commits
from before the attack are safe but hold updates.
Placement: feeds the CI `composer audit` + lockfile-review policy from the
study (Part C3).

## 11. Cursor Composer 2.5 code-quality poll  →  guideline (one line)
AI generated working-but-archaic `Route::get('/', HomeController::class.'@index')`.
Rule: "Routes use array callable syntax `[Controller::class, 'method']`;
never string `@` notation." Tests passing ≠ idiomatic — this is the entire
argument for the guidelines layer, in one screenshot.

---

## Roll-up: where each item lands
- `10-php-laravel.md` additions (4 one-liners): #1, #5, #9, #11 (+#6 rule)
- New skills: `api-responses` (#2, #3), `data-migration` (#4),
  `private-files` (#7), `admin-metrics` (#8)
- Process/CI: #10
- One-time change: #6
