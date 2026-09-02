# laravel-daily-harvest — substrate
_Week: 2026-W34 | Harvested: 2026-08-18 | Screens: 24 | Tips taken: 17 | Left: 4_

> **BACKFILL run** — not a single-week harvest. Screens cover the last ~30 days of the
> Posts scroll (deep end reaches ~3–4-month-old posts). Screens arrived via chat paste
> (phone screenshots); @Delta later extracted them from the session JSONL and committed
> 24 JPGs to `harvest/2026-W34/` (commit `6bd7240`) — transcriptions remain primary.
> Links verified via a bounded @Epoch pass (this seat has no WebFetch).

## Tips taken

### AI-generated migrations collide on same-second timestamps
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** migrations, ai-codegen, mysql, sqlite, gotcha
- **Why it's for us:** Directly hits our AI-driven dev flow. LLMs chain
  `make:model ABC -m && make:model XYZ -m` → many migrations share one timestamp.
  Laravel then orders same-second files alphabetically — SQLite tests pass, MySQL
  breaks when a child table migrates before its parent. (Author observed even
  newest models doing this.)
- **Adoptable practice:** after AI-generated scaffolding, audit
  `database/migrations/` for duplicate timestamps; re-stamp so FK-dependency order
  is explicit. Don't trust green SQLite tests as proof of migration order.
- **Links visited:** none in this post.

### `latestOfMany()` — define "newest related record" once
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** eloquent, relationships, eager-loading
- **Why it's for us:** kills repeated `latest()->first()` call sites; the relation
  becomes eager-loadable, resource-usable, testable.
- **Adoptable code:**
    ```php
    public function latestMetric(): HasOne
    {
        return $this->hasOne(Metric::class)->latestOfMany();
    }

    $servers = Server::with('latestMetric')->get();
    echo $servers->first()->latestMetric?->cpu_usage;
    ```
- **Links visited:** none in this post.

### Higher-order collection messages
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** collections, readability
- **Why it's for us:** concise equivalents of common closure callbacks.
- **Adoptable code:**
    ```php
    $logs->each->delete();          // instead of ->each(fn ($log) => $log->delete())
    $names = $users->map->name;     // instead of ->map(fn ($user) => $user->name)
    ```
- **Links visited:** none in this post.

### `Str::squish()` — normalize pasted whitespace in one call
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** strings, input-sanitization
- **Why it's for us:** replaces `trim()` + regex for user-pasted text (double
  spaces, tabs, stray newlines): trims both ends and collapses inner whitespace.
- **Adoptable code:**
    ```php
    $title = Str::squish($request->title);
    // "  Launch   the  app " → "Launch the app"
    ```
- **Links visited:** none in this post.

### Rate limiter can return an ARRAY of limits — all must pass
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** rate-limiting, security, otp
- **Why it's for us:** one named limiter can enforce per-phone AND per-IP ceilings
  simultaneously.
- **Adoptable code:**
    ```php
    RateLimiter::for('otp-request', fn (Request $r): array => [
        Limit::perMinute(3)->by('phone:'.$r->input('phone')),
        Limit::perHour(8)->by('phone-hour:'.$r->input('phone')),
        Limit::perHour(30)->by('ip:'.$r->ip()),
    ]);
    // Route::post('otp/request', ...)->middleware('throttle:otp-request');
    ```
- **Links visited:** none in this post.

### `withExists()` — related-record boolean without loading the relation
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** eloquent, n+1, query-optimization
- **Why it's for us:** one query, aliased boolean column on every model — no
  per-row `exists()` loop.
- **Adoptable code:**
    ```php
    $specialists = Specialist::query()
        ->withExists([
            'favoritedBy as is_favorite' => fn ($q) => $q->whereKey($user->id),
        ])
        ->orderByDesc('is_favorite')
        ->get();

    $specialists->first()->is_favorite;
    ```
- **Links visited:** none in this post.

### Model `$attributes` property for default values
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** eloquent, defaults, enums
- **Why it's for us:** kills `$data['is_public'] ?? false` scattered across
  controllers; new Model instances get defaults before touching the DB.
- **Adoptable code:**
    ```php
    class Event extends Model
    {
        protected $attributes = [
            'is_public' => false,
            'status'    => EventStatus::Draft->value,
            'tags'      => '[]',
        ];
    }

    Event::create(['title' => $data['title']]);
    ```
- **Links visited:** none in this post.

### `#[BindWhen]` — conditional container binding (Laravel 13.22, PHP 8.5-gated)
- **Source:** Laravel Daily · community post · ~2026-08 · PR link in post
- **Tags:** container, attributes, php-8.5, feature-flags
- **Why it's for us:** conditional bindings as stacked attributes with a plain
  `#[Bind]` fallback; the closure receives the container, so conditions can read
  config/feature flags.
- **Adoptable code:**
    ```php
    #[BindWhen(BetaPaymentGateway::class, static function ($container) {
        return $container->make('config')->get('features.payments.beta');
    })]
    #[Bind(FakePaymentGateway::class, environments: ['local', 'testing'])]
    #[Bind(StripePaymentGateway::class)]
    interface PaymentGatewayInterface {}
    ```
- **Links visited (@Epoch, confidence H):** laravel/framework PR #60862 (author
  ziadoz) · shipped in v13.22.0, released 2026-07-24. Requires **PHP 8.5**
  (static closures as attribute parameters) — a PHP-8.5-adoption dependency for
  any project wanting it. https://github.com/laravel/framework/releases/tag/v13.22.0

### PHP enums can `use` traits — share helpers across all enums
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** php, enum, traits, dry
- **Why it's for us:** one small trait removes the same `values()`/`options()`
  helpers from every enum; inside the trait `self::cases()` still resolves to the
  using enum.
- **Adoptable code:**
    ```php
    trait HasEnumOptions
    {
        public static function values(): array
        {
            return array_column(self::cases(), 'value');
        }
    }

    enum Device: string
    {
        use HasEnumOptions;
        case Cpu = 'cpu';
        case Gpu = 'gpu';
    }
    ```
- **Links visited:** none in this post.

### Default objects directly in constructor parameters (new-in-initializers)
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** php, constructor-promotion, defaults
- **Why it's for us:** dependency defaults live at the declaration — no null
  checks or factory boilerplate for the common case.
- **Adoptable code:**
    ```php
    final readonly class CommandDrivenGame implements Game
    {
        public function __construct(
            private TurnDecisionProvider $turnDecisionProvider = new NoPendingDecisionProvider(),
            private PreparedTurnFactory $preparedTurnFactory = new PreparedTurnFactory(),
            private GameOutcomeRules $outcomeRules = new GameOutcomeRules(1, 2_000_000, 40, 50),
        ) {}
    }
    ```
- **Original note (commenter):** underscore numeric literals (`2_000_000`) — the
  bonus reminder in the same shot.
- **Links visited:** none in this post.

### API Resource from a plain array — no model required
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** api-resources, response-shaping
- **Why it's for us:** combine unrelated pieces of data into one response shape
  with a real Resource class instead of ad-hoc `response()->json()`.
- **Adoptable code:**
    ```php
    class AvailabilityResource extends JsonResource
    {
        public static $wrap = 'data';

        public function toArray(Request $request): array
        {
            return [
                'date'    => $this->resource['date']->toDateString(),
                'service' => $this->resource['service'],
            ];
        }
    }

    return new AvailabilityResource([
        'date' => $date, 'service' => $service, 'specialists' => $specialists,
    ]);
    ```
- **Links visited:** none in this post.

### `match()` every enum case, skip the default arm
- **Source:** Laravel Daily · community post · ~2026-08
- **Tags:** php, match, enum, fail-loud
- **Why it's for us:** a later-added enum case throws `UnhandledMatchError`
  instead of silently doing nothing — the missing case becomes impossible to
  ignore.
- **Adoptable code:**
    ```php
    match ($status) {
        AppointmentStatus::Confirmed, AppointmentStatus::Pending => null,
        AppointmentStatus::Completed => AppointmentCompleted::dispatch($this),
        AppointmentStatus::Cancelled => AppointmentCancelled::dispatch($this),
        // no default arm: a new case throws UnhandledMatchError
    };
    ```
- **Links visited:** none in this post.

### `switch` vs `match` — silent fall-through vs loud error
- **Source:** Laravel Daily · community post · ~4 months ago (deep scroll)
- **Tags:** php, match, switch, fail-loud
- **Why it's for us:** companion to the card above. `switch` without `default`
  silently returns nothing when a new driver/case is added; `match` without
  `default` throws immediately — "you'll know immediately, not after a mystery
  bug."
- **Adoptable code:**
    ```php
    $result = match ($driver) {
        'mysql'  => "mysql:host={$config['host']};port={$config['port']}",
        'pgsql'  => "pgsql:host={$config['host']};port={$config['port']}",
        'sqlsrv' => "sqlsrv:Server={$config['host']},{$config['port']}",
        'sqlite' => "sqlite:{$config['database']}",
    };
    ```
- **Original note (comments):** top comment flagged the post's `switch` example
  also lacked `break`s — worth remembering the example itself was sloppy.
- **Links visited:** none in this post.

### Multi-tenancy: a Global Scope is NOT enough
- **Source:** Laravel Daily · community post · ~3 months ago (deep scroll)
- **Tags:** multi-tenancy, security, validation, authorization, raw-queries
- **Why it's for us:** single-DB tenancy via `where('company_id')` global scope
  misses three leak paths devs forget — validation rules, permissions/policies,
  and raw DB queries.
- **Adoptable code:**
    ```php
    // 1) Enforce tenancy in VALIDATION
    'vessel_id' => [
        'required',
        Rule::exists('vessels', 'id')
            ->where('company_id', auth()->user()->company_id),
    ],

    // 2) Enforce via AUTHORIZATION layer
    Gate::authorize('view', $vessel);
    // VesselPolicy::view: return $user->company_id === $vessel->company_id;

    // 3) Always enforce tenancy in RAW QUERIES
    DB::select("SELECT * FROM vessels WHERE id = ? AND company_id = ?",
        [$id, auth()->user()->company_id]);
    ```
- **Links visited:** none in this post.

### Validator class outside controllers (Artisan command example)
- **Source:** Laravel Daily · community post · ~3 months ago (deep scroll)
- **Tags:** validation, artisan, commands
- **Why it's for us:** complex input checks in commands/jobs via `Validator::make`
  instead of if-statement pyramids.
- **Adoptable code:**
    ```php
    $validator = Validator::make($data, [
        'driver'   => 'required|in:mysql,pgsql,sqlite',
        'host'     => 'required|string|max:255',
        'port'     => 'required|integer|between:1,65535',
        'database' => 'required|regex:/^[a-zA-Z0-9_]+$/',
    ]);

    if ($validator->fails()) {
        foreach ($validator->errors()->all() as $error) {
            $this->error($error);
        }
        return 1;
    }
    ```
- **Links visited:** none in this post.

### `ShouldDispatchAfterCommit` — events fire only after the transaction commits
- **Source:** Laravel Daily · community post · ~3 months ago (deep scroll) · docs link in post
- **Tags:** events, transactions, data-integrity
- **Why it's for us:** listeners never see uncommitted data; on rollback the event
  is silently discarded (no email, no webhook). If no transaction is in progress,
  the event dispatches immediately.
- **Adoptable code:**
    ```php
    class OrderShipped implements ShouldDispatchAfterCommit
    {
        // ...
    }

    DB::transaction(function () use ($request) {
        $order = Order::create([...]);
        OrderShipped::dispatch($order);   // registered, dispatched only on commit
    });
    ```
- **Links visited (@Epoch, confidence H):** behavior confirmed in live 13.x docs
  (introduced Laravel 10.30, stable since):
  https://laravel.com/docs/13.x/events#dispatching-events-after-database-transactions

### Pest `->with()` datasets — one test, many inputs
- **Source:** Laravel Daily · community post · ~3 months ago (deep scroll)
- **Tags:** testing, pest, datasets
- **Why it's for us:** stops copy-pasting the same test with different inputs;
  each dataset case gets its own name in output.
- **Adoptable code:**
    ```php
    it('converts table names to model names', function (string $table, string $expected) {
        expect(tableToModel($table))->toBe($expected);
    })->with([
        'users'        => ['users', 'User'],
        'teams'        => ['teams', 'Team'],
        'team_members' => ['team_members', 'TeamMember'],
    ]);
    ```
- **Links visited:** none in this post.

## Left / parked

### NativePHP for Mobile v4 "SuperNative" — ⚠ benchmark claim UNVERIFIED
News post + video link; screenshot shows a photographed slide ("SuperNative vs
React Native 0.86" metric table). **@Epoch (confidence H on official sources):
NO published quantitative benchmark exists anywhere found** — not in
nativephp.com/blog/supernative (announced 2026-07-11), not in Laravel News, not
in search. The numbers live only on that slide. Substance that IS verified:
v4 renders Blade as real native views (SwiftUI / Jetpack Compose), no
WebView/JS bridge. **Do not cite the vs-RN-0.86 figures as fact.** Possible
lead: the two YouTube videos may contain informal numbers — unfetched.

### Laravel Boost v2.5 — guideline discovery default in `boost:update`
News; PR #882 (paulinevos) **verified by @Epoch (H)**: merged 2026-07-21;
discovery now runs by default, `--no-discover` opt-out, auto-skipped in
non-interactive mode. **Action note for our agent/CI workflows:** any scripted
`boost:update` should add `--no-discover` explicitly rather than relying on
non-interactive auto-skip. https://github.com/laravel/boost/pull/882
Parked as tooling-news, not a code tip — promote if a project adopts Boost.

### Upwork observation — API-first Laravel + React/Next still dominant
Author's job-market commentary: many/most Laravel jobs want API-first backend +
separate React/Next frontend; frontend-vs-backend split still real, not only
full-stack. No code. Market signal only.

### CMS Architect / "daily newsletter?" post — **PIVOT marker**
Job-posting commentary (Craft CMS / wine-SaaS Upwork listings) + author polling
readers about a newsletter. No code. **This is the last screen of the final
batch = the pivot: this manual harvest covers the Posts scroll from newest
(2026-08-18) down to this post. Next harvest stops when it reaches content at
or below this marker.**

## Deduped
- Enum "helper methods" to group cases — appeared in this batch, **already
  carded in 2026-W33** (`report/raw.laravel-daily-harvest.2026-W33.md`). Skipped.

## Run metadata
- Screens processed: 24/24 (two chat batches of 12; incl. one comments-overlay
  shot used as context for the switch/match card, not a separate tip)
- Links visited: 4, via one bounded @Epoch pass (atlas-ui seat has no WebFetch);
  1 claim rejected as unverifiable (NativePHP benchmarks)
- Substrate location: `harvest/2026-W34/` — 24 JPGs, extracted from session
  JSONL by @Delta post-run (commit `6bd7240`); transcriptions remain primary
- Coverage: backfill of ~last 30 days of scroll (deep end ~3–4-month-old posts);
  pivot = CMS-Architect/newsletter post (see Left/parked)
- Operator note: future batches routed to the owning seat per README ("this is
  last batch, then I will pass to whom belonging" — majkee, 2026-08-18)
