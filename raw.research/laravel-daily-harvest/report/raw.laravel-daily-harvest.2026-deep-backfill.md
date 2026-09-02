# laravel-daily-harvest — substrate
_Batch: 2026-deep-backfill | Run: 2026-08-19 (live, single session) | Screens: 144 | Tips taken: 71 | Left/parked: 16 | Dups/variants: 26 | **CLOSED — photo consumption COMPLETE (majkee confirmed all screenshots delivered)**_

> **DEEP BACKFILL run — live, one post at a time (majkee on mobile, chat paste).**
> Route: starts at the NEWEST post (2026-08-19, so fresh post-W34 content may open
> the batch) → scrolls down THROUGH the W34-covered zone (expected all-DUP against
> the W34 report) → crosses W34's floor pivot (CMS-Architect/newsletter post) →
> true deep harvest below it, walking DOWN toward the point where posts stop being
> viable tip-shaped (majkee's hunch: ~March 2026 — verified by observation, not
> assumed). The last viable post found = **floor pivot marker**, recorded at close.
> Release dates: majkee supplies when known → recorded per-card in Source line.
> Dedup guard: W33 (enum group-helpers card) + W34 (17 cards + 4 parked).
> Links: majkee copies URLs when not readable from the shot; verification via
> WebFetch in-session (Medusa seat has it — no bounded Epoch pass needed).
> Substrate: chat-paste; JSONL extraction to `harvest/` possible post-run
> (W34 precedent, @Delta method).

## Tips taken

### Validation `sometimes` — validate only when the field is present
- **Source:** Laravel Daily · community post · ~8–11 mo (majkee batch) · `#practicalLaravelDocs`, docs 12.x link
- **Tags:** validation, optional-fields
- **Why it's for us:** optional field that must still be well-formed when supplied — no more `required` forcing or silent skip.
- **Adoptable code:**
    ```php
    // After - only validates phone format IF phone is provided
    $request->validate([
        'name'  => 'required|string',
        'email' => 'required|email',
        'phone' => 'sometimes|regex:/^\+?[1-9]\d{1,14}$/',
    ]);
    ```
- **Links visited:** none (docs link truncated in shot; behavior is standard docs).

### Scheduler tasks with conditions — `between()` / `environments()` / `when()` / `skip()`
- **Source:** Laravel Daily · community post · ~8–11 mo (majkee batch) · `#practicalLaravelDocs`, docs 12.x link
- **Tags:** scheduler, environments, conditional-execution
- **Why it's for us:** constraint methods instead of if-guards inside the command; env-gating at the schedule level.
- **Adoptable code:**
    ```php
    Schedule::command('heavy:processing')
        ->hourly()
        ->between('1:00', '6:00')          // Only low-traffic hours
        ->environments(['production'])     // Only on production
        ->when(fn () => Cache::get('maintenance_mode') !== true);

    Schedule::command('emails:marketing')
        ->daily()
        ->skip(fn () => Holiday::isToday());
    ```
- **Freya note:** our hourly renew job is prod-gated in AppServiceProvider — `environments(['production'])` at the schedule is the idiomatic place for that class of gate.
- **Links visited:** none.

### Cache failover driver + "deferred" queue (framework release features)
- **Source:** Laravel Daily · community post · ~8–11 mo (majkee batch) · Taylor Otwell tweet quoted
- **Tags:** cache, queue, resilience, release-features
- **Why it's for us:** failover cache auto-falls-back when primary store is down; deferred queue = sync-like jobs processed AFTER the HTTP response is sent (also the default failover queue for new apps, per Taylor).
- **Adoptable code:**
    ```php
    // config/cache.php
    'failover' => [
        'driver' => 'failover',
        'stores' => ['database', 'array'],
    ],
    // .env: CACHE_STORE=failover

    RecordDelivery::dispatch($order)->onConnection('deferred');
    ```
- **Freya note:** failover cache worth remembering against our shared-Redis fragility (paratest isolation root cause was shared external state).
- **Links visited:** none (x.com link truncated).

### `withCount(['rel as alias'])` with condition + order by the alias
- **Source:** Laravel Daily · community post · ~8–11 mo (majkee batch)
- **Tags:** eloquent, aggregates, n+1, dashboards
- **Why it's for us:** conditional aggregate as a named column, sortable — sibling of W34's `withExists` card (counts, not booleans).
- **Adoptable code:**
    ```php
    $query = User::query()
        ->withCount(['metrics as login_count' => function ($query) {
            $query->where('name', 'auth:logins');
        }])
        ->orderByDesc('login_count')
        ->take(10);
    ```
- **Links visited:** none.

### Auto-set `user_id` — four idioms compared (poll post, no authorial verdict)
- **Source:** Laravel Daily · community post · **9 months ago** (stamp visible) · 223👍 · 80 comments
- **Tags:** eloquent, controllers, idioms, mass-assignment
- **Why it's for us:** compact map of the four ways teams do it — useful vocabulary when reviewing code.
- **Code (as posted):**
    ```php
    // A:
    Post::create($request->validated() + ['user_id' => auth()->id()]);
    // B:
    Post::create([...$request->validated(), 'user_id' => auth()->id()]);
    // C (required hasMany relation):
    auth()->user()->posts()->create($request->validated());
    // D: set user_id in Observer or Model, not in Controller
    ```
- **Links visited:** none.

### Never `$request->all()` after a Form Request — use `validated()`
- **Source:** Laravel Daily · community post · ~8–11 mo (majkee batch) · article link (laraveldaily.com, truncated)
- **Tags:** security, validation, form-requests, mass-assignment
- **Why it's for us:** `all()` bypasses the Form Request's contract — unvalidated keys ride into `create()`; classic mass-assignment-adjacent hole.
- **Code (anti-pattern as posted):**
    ```php
    public function store(IncomeRequest $request)
    {
        $data = $request->all();      // WRONG: use $request->validated()
        $data['user_id'] = Auth::user()->id;
        Income::create($data);
    }
    ```
- **Freya note:** micro-audit candidate — grep `->all()` in controllers with Form Requests (queued for the close-phase value pass, not run).
- **Links visited:** none.

### Faker `bothify()` — patterned fake identifiers
- **Source:** Laravel Daily · community post · ~8–11 mo (majkee batch) · fakerphp.org docs link
- **Tags:** testing, factories, faker
- **Why it's for us:** one-liner for plate/SKU-shaped fakes: `?` random letter · `#` random digit · `*` either.
- **Adoptable code:**
    ```php
    'license_plate' => strtoupper(
        fake()->unique()->bothify('???-###')
    ),
    ```
- **Links visited:** none.

### `Str::of()` fluent pipeline vs plain PHP (A/B post)
- **Source:** Laravel Daily · community post · **7 months ago** (stamp visible)
- **Tags:** strings, readability, fluent
- **Why it's for us:** the fluent chain reads as the algorithm; adoptable idiom for string munging (initials example).
- **Adoptable code:**
    ```php
    $initials = Str::of($this->name)
        ->explode(' ')
        ->take(2)
        ->map(fn ($word) => Str::substr($word, 0, 1))
        ->implode('');
    ```
- **Links visited:** none.

### `whereRelation()` — `whereHas()` with a simple condition, shorter
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01)
- **Tags:** eloquent, relationships, query-builder
- **Adoptable code:**
    ```php
    // BEFORE:
    $posts = Post::whereHas('author', function ($query) {
        $query->where('is_active', true);
    })->get();
    // AFTER:
    $posts = Post::whereRelation('author', 'is_active', true)->get();
    ```
- **Links visited:** none.

### `$loop->parent` — outer-loop counters in nested Blade `@foreach`
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01)
- **Tags:** blade, loops
- **Adoptable code:**
    ```blade
    @foreach($sections as $section)
      <section id="section-{{ $loop->iteration }}">
        @foreach($section->articles as $article)
          <article data-parent="{{ $loop->parent->iteration }}"
                   data-item="{{ $loop->iteration }}">
            {{ $article->title }}
          </article>
        @endforeach
      </section>
    @endforeach
    ```
- **Links visited:** none.

### `to_route()` — cleaner `redirect()->route()`
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01) · "Laravel 9+"
- **Tags:** routing, controllers, helpers
- **Adoptable code:**
    ```php
    return to_route('profile.show', ['user' => $user->id]);
    // in store():
    return to_route('posts.index');
    ```
- **Links visited:** none.

### `withDefault()` on `belongsTo` — null-safe relations in Blade
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01) · codingsnacks.com watermark
- **Tags:** eloquent, relationships, null-safety, blade
- **Why it's for us:** missing related model returns a default instance instead of null — no `?->`/`??` scattered through templates.
- **Adoptable code:**
    ```php
    public function author(): BelongsTo
    {
        return $this->belongsTo(User::class)
            ->withDefault([
                'name'   => 'Anonymous',
                'avatar' => 'default-avatar.png',
            ]);
    }
    // or bare: ->withDefault();
    ```
- **Links visited:** none.

### Date validation rules understand `today` / `tomorrow` / `now` keywords
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01) · codingsnacks.com watermark
- **Tags:** validation, dates
- **Adoptable code:**
    ```php
    $data = $request->validate([
        'start_date'  => 'required|date|after_or_equal:today',
        'end_date'    => 'required|date|after:start_date',
        'review_date' => 'required|date|before:tomorrow',
        'completion'  => 'required|date|date_equals:today',
    ]);
    ```
- **Note:** `after:start_date` cross-references another FIELD — both idioms in one rule set.
- **Links visited:** none.

### `whereHas()` + `orDoesntHave()` — "matching relation OR no relation at all"
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01)
- **Tags:** eloquent, relationships, or-logic
- **Why it's for us:** the example IS e-commerce — orders with completed shipments OR not yet assigned; note the outer `where(fn)` grouping to keep OR scoped.
- **Adoptable code:**
    ```php
    $orders = Order::query()
        ->where(function ($query) {
            $query->whereHas('shipments', function ($q) {
                $q->where('status', 'completed');
            })->orDoesntHave('shipments');
        })
        ->with('customer')
        ->get();
    ```
- **Links visited:** none.

### `with()` accepts callbacks — constrain eager-loaded relations
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01)
- **Tags:** eloquent, eager-loading, n+1
- **Adoptable code:**
    ```php
    User::query()
        ->with(['posts' => function ($query) {
            $query->where('published', true)
                ->select('id', 'user_id', 'title', 'created_at')
                ->orderBy('created_at', 'desc')
                ->limit(5);
        }])
        ->get();
    ```
- **⚠ Caveat (ours, not the post's):** `limit()` inside an eager-load constraint was historically a GLOBAL limit across the whole related query, not per-parent; modern Laravel (11+) supports per-parent eager-load limits. Verify behavior on your version before trusting the `limit(5)` reading — the post shows it without comment.
- **Links visited:** none.

### `upsert()` — bulk insert-or-update in one query
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01) · codingsnacks.com watermark
- **Tags:** eloquent, bulk-operations, performance, ecommerce
- **Why it's for us:** SKU-keyed product sync example — direct freya import/sync shape. Requires a UNIQUE index on the `uniqueBy` column(s); much faster than `updateOrCreate()` loops.
- **Adoptable code:**
    ```php
    // migration: $table->string('sku')->unique(); // UNIQUE required for upsert!
    Product::upsert(
        [
            ['sku' => 'ABC123', 'name' => 'Product A', 'price' => 99.99],
            ['sku' => 'DEF456', 'name' => 'Product B', 'price' => 149.99],
            ['sku' => 'GHI789', 'name' => 'Product C', 'price' => 199.99],
        ],
        uniqueBy: ['sku'],
        update: ['name', 'price']
    );
    ```
- **Freya note:** flagged for the close-phase value pass — bulk-sync services in the renew pipeline are the natural audience. (Caveat for MariaDB: upsert = INSERT…ON DUPLICATE KEY UPDATE semantics; timestamps and events behave differently than Eloquent saves — model events do NOT fire.)
- **Links visited:** none.

### `$touches` — auto-refresh parent `updated_at` when a child changes
- **Source:** Laravel Daily · community post · **7 months ago** (~2026-01) *(carded one batch late — transcription miss owned by the harvest seat)*
- **Tags:** eloquent, timestamps, relationships, cache-invalidation
- **Adoptable code:**
    ```php
    class Product extends Model
    {
        protected $touches = ['category', 'store'];

        public function category() { return $this->belongsTo(Category::class); }
        public function store()    { return $this->belongsTo(Store::class); }
    }
    // $product->save() → category AND store updated_at refresh automatically
    ```
- **⚠ Caveat (ours):** every child save fires parent UPDATEs — on a hot e-commerce
  catalog this is a hidden write amplifier and can churn `updated_at`-keyed caches.
  Use where parent staleness actually matters, not by default.
- **Links visited:** none.

### `Blade::directive()` — custom directives compiled to PHP
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02)
- **Tags:** blade, directives, templates
- **Adoptable code:**
    ```php
    // app/Providers/AppServiceProvider.php  (boot)
    Blade::directive('badge', function ($expression) {
        return "<?php echo '<span class=\"badge\">' . $expression . '</span>'; ?>";
    });
    Blade::directive('price', function ($expression) {
        return "<?php echo '€' . number_format($expression, 2); ?>";
    });
    // Blade: <p>Status: @badge($order->status)</p>  ·  <p>@price($item->cost)</p>
    ```
- **Note:** directives compile into cached views — after changing a directive run
  `view:clear` or compiled templates keep the old expansion.
- **Links visited:** none.

### Scheduled commands: `onSuccess()` / `onFailure()` lifecycle callbacks
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02)
- **Tags:** scheduler, monitoring, error-tracking
- **Why it's for us:** monitoring/cleanup at the schedule definition instead of inside the command — pairs with the scheduler-conditions card above.
- **Adoptable code:**
    ```php
    Schedule::command('cleanup:temp-files')
        ->weekly()
        ->onSuccess(function () {
            MonitoringService::recordSuccess('cleanup:temp-files');
            DB::table('system_logs')->insert([
                'task' => 'cleanup', 'status' => 'success', 'timestamp' => now(),
            ]);
        })
        ->onFailure(function () {
            MonitoringService::recordFailure('cleanup:temp-files');
            DB::table('system_logs')->insert([
                'task' => 'cleanup', 'status' => 'failed', 'timestamp' => now(),
            ]);
        });
    ```
- **Freya note:** natural fit for renew-pipeline observability (hourly job) — flagged for the value pass.
- **Links visited:** none.

### `$request->date()` — request input straight to Carbon
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02)
- **Tags:** requests, dates, carbon, controllers
- **Adoptable code:**
    ```php
    $eventDate    = $request->date('event_date');                       // default format
    $startTime    = $request->date('start_time', 'H:i');                // custom format
    $deadline     = $request->date('deadline', null, 'America/New_York'); // timezone
    $optionalDate = $request->date('optional_date');                    // null if absent
    $daysUntil    = now()->diffInDays($eventDate);
    ```
- **Links visited:** none.

### `Password::defaults()` — global password rules, defined once
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02)
- **Tags:** validation, security, passwords
- **Adoptable code:**
    ```php
    // AppServiceProvider::boot()
    Password::defaults(function () {
        return Password::min(8)
            ->letters()->mixedCase()->numbers()->symbols()
            ->uncompromised();
    });
    // form request:
    'password' => ['required', Password::defaults()],
    ```
- **Links visited:** none.

### Eloquent `when()` — conditional filters as ONE fluent statement
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02)
- **Tags:** eloquent, filtering, search, readability
- **Why it's for us:** author's framing: filters read as one statement instead of if-pyramids; native alternative to `spatie/laravel-query-builder`. Example = job search with 5 optional filters (search/location/type/salaryMin/salaryMax), each `when($value, fn)` with grouped orWhere internals, closing `->latest()->paginate(12)->withQueryString()`.
- **Adoptable code (pattern core):**
    ```php
    $jobs = JobListing::query()
        ->with('employer')
        ->when($search, function (Builder $query) use ($search) {
            $query->where(function (Builder $q) use ($search) {
                $q->where('title', 'like', '%'.$search.'%')
                  ->orWhere('description', 'like', '%'.$search.'%');
            });
        })
        ->when($type, fn (Builder $q) => $q->where('type', $type))
        ->latest()->paginate(12)->withQueryString();
    ```
- **Freya note:** admin product/order filtering is this exact shape — value-pass candidate.
- **Links visited:** none.

### Laravel starter kits: safer production defaults (multi-screen post, merged)
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02) · changelog link
- **Tags:** defaults, security, destructive-commands, carbon-immutable, passwords
- **What ships:** starter kits' `AppServiceProvider` now calls a `configureDefaults()` with:
    ```php
    Date::use(CarbonImmutable::class);

    DB::prohibitDestructiveCommands(
        app()->isProduction(),
    );

    Password::defaults(fn (): ?Password => app()->isProduction()
        ? Password::min(12)->mixedCase()->letters()->numbers()->symbols()->uncompromised()
        : null
    );
    ```
- **⚡ Freya note (T37 material):** the OFFICIAL starter-kit idiom scopes the
  destructive-command guard to `isProduction()` ONLY. Skaven's `b83b09fb` guard
  uses `! runningUnitTests()` — stricter than the official default, and exactly
  the delta that killed the sanctioned local rebuild (ledger T37). Citable
  precedent for the team conversation: majkee's rejected opt-out would have
  landed freya ON the official idiom.
- **Links visited:** none (changelog URL generic).

### `File` rule facade — fluent image/file validation
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02)
- **Tags:** validation, uploads, images
- **Adoptable code:**
    ```php
    use Illuminate\Validation\Rules\File;

    $validated = $request->validate([
        'avatar' => [
            'required',
            File::image()
                ->min('100kb')->max('2mb')
                ->dimensions(Rule::dimensions()
                    ->minWidth(200)->minHeight(200)
                    ->maxWidth(4000)->maxHeight(4000)),
        ],
        'banner' => [
            File::types(['jpg', 'png', 'webp'])->max('5mb'),
        ],
    ]);
    ```
- **Freya note:** admin image-picker/upload flows — value-pass candidate.
- **Links visited:** none.

### `#[ObservedBy]` — observer registration as a model attribute
- **Source:** Laravel Daily · community post · **6 months ago** (~2026-02)
- **Tags:** eloquent, observers, attributes
- **Adoptable code:**
    ```php
    use Illuminate\Database\Eloquent\Attributes\ObservedBy;

    #[ObservedBy([MealPlanItemObserver::class])]
    class MealPlanItem extends Model { /* ... */ }
    // replaces MealPlanItem::observe(...) in AppServiceProvider::boot()
    ```
- **Note:** registration lives ON the model — greppable next to the class it affects.
- **Links visited:** none.

### Queue job config as PHP attributes — `#[Tries]` / `#[Backoff]` (Laravel 13)
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03) · quoted tweet (Jason McCreary, 2026-02-25)
- **Tags:** queues, attributes, laravel-13
- **Adoptable code:**
    ```php
    #[Tries(3)]
    #[Backoff(3000)]
    class DestroyWorker implements ShouldQueue
    {
        // replaces: public $tries = 3;  public $backoff = 3000;
    }
    ```
- **Freya note:** freya runs Laravel 13 — usable now; part of the wider L13 attribute wave.
- **Links visited:** none.

### Boost `search-docs` outage → Context7 fallback line for CLAUDE.md (multi-screen, merged)
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03) · incident-report link (x.com/pushpak1300)
- **Tags:** boost, mcp, ai-workflow, resilience
- **The tip:** AI-related external providers go down; have a documented fallback. The author's CLAUDE.md line:
    > "For library documentation, if some library is not available in Laravel Boost 'search-docs', always use context7. Automatically use the Context7 MCP tools to resolve library id and get library docs without me having to explicitly ask."
- **Freya note:** DIRECT harness relevance — our Boost `search-docs` is a mandated first step (T25-verified lane). A fallback rule belongs in the T49 skill/harness audit. (Fallback target for us is a decision — Context7 is the post's choice, not automatically ours.)
- **Links visited:** none (incident link truncated).

### Supply-chain warning: fake Laravel packages on Packagist shipping a RAT
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03) · thehackernews.com/2026/03 link
- **Tags:** security, composer, supply-chain
- **Substance:** malicious packages masquerading as Laravel utilities (`nhattuanbl/lara-helper` 37 DLs · `nhattuanbl/simple-queue` 29 · `nhattuanbl/lara-swagger` 49); lara-swagger clean itself but pulls lara-helper as a dependency → RAT install on Win/macOS/Linux; still downloadable at post time.
- **Practice:** known vendors only · packages you REALLY need · read reviews · read the source · watch transitive deps.
- **Freya note:** composer discipline ties to T43 (W3-manifest lane — team-gitignored composer.json) and T45's hygiene thread.
- **Links visited:** none.

### Prepare a Laravel codebase for AI agents — 5 levers (multi-screen, merged)
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03) · video series teased
- **Tags:** ai-agents, codebase-quality, testing, static-analysis, architecture
- **Thesis:** "AI coding agents don't fail because they're bad — they fail because the codebase is inconsistent/messy/untested. Agents are pattern-recognition machines; they write new code from your repeating patterns."
- **The 5 levers:** 1) automated tests (Pest) — safety net + pattern source for new tests · 2) static analysis (PHPStan/Larastan) — catches mess, forces consistency · 3) code style (Pint) — easier pattern imitation · 4) stronger types & PHPDoc (return types, DTOs) — less guesswork · 5) consistent architecture (thin controllers, Form Requests, services/actions, policies).
- **Freya note:** external confirmation of the in-house doctrine ("enforcement-before-refactor", the M-phase "same disease, two floors" narrative, Larastan-0-per-file gate). Citable in the Czech study / team conversation as independent community consensus.
- **Links visited:** none.

### Boost: re-run `boost:install` after adding third-party packages
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03)
- **Tags:** boost, ai-guidelines, skills
- **The tip:** third-party packages publish their own Boost guidelines/skills — `php artisan boost:install` again after installing one (screenshot shows filament, laravel/fortify, spatie/laravel-medialibrary, laraveljutsu/zap offering guidelines/skills; add/remove any time by re-running).
- **Freya note:** Boost-lane operational knowledge for T49/T56 — same interactivity caveat as `boost:update` (W34's `--no-discover` note).
- **Links visited:** none.

### Model-level validation in `booted()` — invariants that hold everywhere
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03) · GPT-5.4-generated example (Bingo Telegram bot) · DDD course link
- **Tags:** eloquent, validation, invariants, ddd
- **Why it's for us:** validation on the MODEL fires no matter the entry point — queue job, Pest, Tinker; controllers/Form Requests only guard HTTP.
- **Adoptable code (pattern):**
    ```php
    protected static function booted(): void
    {
        static::saving(function (self $drawnNumber): void {
            if ($drawnNumber->number < 1 || $drawnNumber->number > 75) {
                throw new InvalidArgumentException('Drawn bingo numbers must be between 1 and 75.');
            }
            // cross-field invariant check, throws on mismatch
        });
    }
    ```
- **Note:** this is invariant enforcement (throw), not user-facing validation — messages/UX stay in Form Requests; the model guards the last line.
- **Links visited:** none.

### Custom Pivot model — pivot with its own data as a first-class citizen (multi-screen, merged)
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03)
- **Tags:** eloquent, pivot, casts, relationships
- **Adoptable code (pattern):**
    ```php
    class BookingExtraService extends Pivot
    {
        public $incrementing = true;
        protected $table = 'booking_extra_service';
        protected $fillable = ['booking_id', 'extra_service_id', 'quantity', 'unit_price', 'price_type'];

        protected function casts(): array
        {
            return ['price_type' => PriceType::class, 'unit_price' => 'decimal:2'];
        }

        public function booking(): BelongsTo { return $this->belongsTo(Booking::class); }
        public function extraService(): BelongsTo { return $this->belongsTo(ExtraService::class); }
    }
    // Parent gets BOTH views of it:
    public function bookingExtraServices(): HasMany { return $this->hasMany(BookingExtraService::class); }
    public function extraServices(): BelongsToMany {
        return $this->belongsToMany(ExtraService::class, 'booking_extra_service')
            ->withPivot(['quantity', 'unit_price', 'price_type']);
    }
    ```
- **Note:** post binds it to a Filament Repeater via `->relationship()` — the general point: any UI needing the pivot as a real model benefits.
- **Freya note:** freya's parameter/product pivot tables with payload columns are this exact shape — value-pass candidate.
- **Links visited:** none.

### RateLimiter facade outside HTTP — throttle any action
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03) · docs 12.x rate-limiting link · Codex-generated example
- **Tags:** rate-limiting, services, telegram
- **Why it's for us:** complements the W34 named-limiter-arrays card — this is the MANUAL facade path (`tooManyAttempts`/`hit`) usable in services, bots, jobs, not just route middleware.
- **Adoptable code (pattern):**
    ```php
    $rateLimitKey = sprintf('telegram-bingo-claim:%s', $player->id);
    if (RateLimiter::tooManyAttempts($rateLimitKey, 1)) {
        $this->replyToChat($message, 'Please wait a few seconds before claiming Bingo again.');
        return;
    }
    RateLimiter::hit($rateLimitKey, 5); // decay seconds
    ```
- **Links visited:** none.

### Enums as a state machine — transitions defined IN the enum
- **Source:** Laravel Daily · community post · **5 months ago** (~2026-03)
- **Tags:** php, enum, state-machine, domain
- **Why it's for us:** kills scattered if/elseif transition logic; the enum becomes the single source of truth, the model enforces it.
- **Adoptable code:**
    ```php
    enum GameStatus: string
    {
        case Pending = 'pending';
        case Joining = 'joining';
        case InProgress = 'in_progress';
        case Completed = 'completed';
        case Cancelled = 'cancelled';

        public function canTransitionTo(self $status): bool
        {
            return match ($this) {
                self::Pending    => in_array($status, [self::Joining, self::Cancelled], true),
                self::Joining    => in_array($status, [self::InProgress, self::Cancelled], true),
                self::InProgress => in_array($status, [self::Completed, self::Cancelled], true),
                self::Completed, self::Cancelled => false,
            };
        }
    }
    // Model:
    public function transitionTo(GameStatus $status): void
    {
        if (! $this->status->canTransitionTo($status)) {
            throw new DomainException("Invalid status from {$this->status->value} to {$status->value}.");
        }
        $this->update(['status' => $status]);
    }
    ```
- **Freya note:** order-status flow is the obvious freya application — value-pass candidate.
- **Links visited:** none.

### AI guidelines evolution: "tests MUST cover happy paths AND failure scenarios"
- **Source:** Laravel Daily · community post · ~4 months (~2026-04) · repo: github.com/LaravelDaily/AI-Workflows-For-Laravel (133★, resolved via gh — post link truncated)
- **Tags:** ai-guidelines, testing, claude-md, workflow
- **The tip:** author's custom AI guideline line upgraded from "For new features, you MUST generate Pest automated tests" to add: "**Tests MUST cover both happy paths and failure scenarios: invalid input, unauthorized access, and boundary conditions.**" General idea portable to any language/framework. (Same file carries the Context7-fallback line carded above — `new-laravel-project/guidelines/laraveldaily-laravel.md`.)
- **Freya note:** T49 material twice over — (i) the guideline sentence itself is adoptable into our harness test rules; (ii) the repo is a mineable reference corpus for the skills audit.
- **Links visited:** repo existence verified via gh (WebFetch 404 on truncated URL).

### `CarbonPeriod` — generate every date in a range (no gaps in charts)
- **Source:** Laravel Daily · community post · **4 months ago** (~2026-04)
- **Tags:** carbon, dates, charts, reporting
- **Adoptable code:**
    ```php
    $counts = User::selectRaw('DATE(created_at) as date, count(*) as total')
        ->where('created_at', '>=', now()->subDays(29))
        ->groupBy('date')
        ->pluck('total', 'date');

    foreach (CarbonPeriod::create(now()->subDays(29), now()) as $date) {
        $labels[] = $date->format('M j');
        $data[]   = $counts[$date->format('Y-m-d')] ?? 0;
    }
    // Result: ['Mar 1' => 5, 'Mar 2' => 0, 'Mar 3' => 2] — no missing days
    ```
- **Freya note:** admin dashboards/sales charts — the missing-day gap is a classic report bug.
- **Links visited:** none.

### `encrypted:array` cast — encrypt + json in one declaration
- **Source:** Laravel Daily · community post · **4 months ago** (~2026-04)
- **Tags:** eloquent, casts, encryption, secrets
- **Adoptable code:**
    ```php
    protected function casts(): array
    {
        return [
            'config'        => 'array',
            'secret_config' => 'encrypted:array',
        ];
    }
    // $check->secret_config = ['token' => 'sk-...'];
    // $token = $check->secret_config['token'];  // decrypted automatically
    ```
- **⚠ Caveat (ours):** ties ciphertext to `APP_KEY` — key rotation needs re-encryption; encrypted columns are not queryable/indexable.
- **Freya note:** third-party API tokens/credentials stored in DB — value-pass candidate.
- **Links visited:** none.

### Laravel Installer v5.25.2 — `npm install --ignore-scripts` by default
- **Source:** Laravel Daily · community post · **4 months ago** (~2026-04) · PR #489 (taylorotwell merged)
- **Tags:** security, supply-chain, npm, tooling
- **Substance:** installer now runs `npm/yarn/pnpm/bun install --ignore-scripts` — blocks malicious `postinstall` script execution from compromised JS packages. "I advise to update."
- **Freya note:** JS-side sibling of the Packagist-RAT card — same supply-chain lesson, both feed one security-practice note.
- **Links visited:** none.

### `laravel new` — flag every wizard answer (incl. `--bun`, `--boost`)
- **Source:** Laravel Daily · community post · **4 months ago** (~2026-04) · installer NewCommand.php shot
- **Tags:** tooling, scaffolding, installer
- **Substance:** full option list visible in `configure()`: `--dev --git --branch --github --organization --database --react --svelte --vue --livewire --livewire-class-components --workos --teams --no-authentication --pest --phpunit --npm --pnpm --bun --yarn --boost --no-boost --using --force` — scriptable non-interactive scaffolding.
- **Freya note:** `--boost/--no-boost` at install time is worth knowing for any future temple project bootstrap (pairs with /new-project flow).
- **Links visited:** none.

### Hot take: don't over-engineer — 3-line store() stays in the controller
- **Source:** Laravel Daily · community post · **4 months ago** (~2026-04)
- **Tags:** architecture, pragmatism, actions, dto
- **Substance:** "Not everything needs an Action class, a DTO, and an Event. If your store method is 3 lines, LEAVE IT in the Controller. Over-engineering hurts readability more than 'fat controllers'." Code contrast: `User::create($request->validated())` vs DTO→Action→Event ceremony for the same CRUD.
- **Freya note:** aligns with temple doctrine (smallest safe solution) AND with the GOD-sync bricks rule's spirit — extraction on contact, not ceremony up front. Counterweight card to the "consistent architecture" lever in the AI-readiness card: consistency ≠ maximal layering.
- **Links visited:** none.

### Traits: wait for THREE uses before extracting
- **Source:** Laravel Daily · community post · **4 months ago** (~2026-04) · course lesson link
- **Tags:** php, traits, dry, rule-of-thumb
- **Substance:** don't extract a trait at the second duplication — wait for the third use. Example: `HasSlug` extracted only after Tag, Article AND Thread needed it.
- **Adoptable code (the example trait):**
    ```php
    trait HasSlug
    {
        public static function findBySlug(string $slug): self
        {
            return static::where('slug', $slug)->firstOrFail();
        }

        public function getRouteKeyName(): string
        {
            return 'slug';
        }

        protected static function bootHasSlug(): void
        {
            static::creating(function ($model) {
                $model->slug = Str::slug($model->title);
            });
        }
    }
    ```
- **Note:** also demonstrates the `boot{TraitName}()` auto-boot convention.
- **Links visited:** none.

### Unique slug with numeric suffix — starter-kit Teams algorithm
- **Source:** Laravel Daily · community post · **~4 months** (~2026-04) · github.com/laravel/livewire-starter-kit link
- **Tags:** slugs, uniqueness, algorithms
- **Substance:** `GeneratesUniqueTeamSlugs` concern — "john-smith" → "john-smith-1", "john-smith-2": query existing slugs (incl. trashed, `slug LIKE base-%`), regex-extract numeric suffixes, take max+1; `$excludeId` param for updates.
- **Adoptable code (core):**
    ```php
    $defaultSlug = Str::slug($name);
    $existingSlugs = static::withTrashed()
        ->where(fn ($q) => $q->where('slug', $defaultSlug)
            ->orWhere('slug', 'like', $defaultSlug.'-%'))
        ->when($excludeId, fn ($q) => $q->where('id', '!=', $excludeId))
        ->pluck('slug');
    $maxSuffix = $existingSlugs->map(function (string $slug) use ($defaultSlug): ?int {
        if ($slug === $defaultSlug) { return 0; }
        if (preg_match('/^'.preg_quote($defaultSlug, '/').'-(\d+)$/', $slug, $m)) { return (int) $m[1]; }
        return null;
    })->filter(fn (?int $s) => $s !== null)->max() ?? 0;
    return $existingSlugs->isEmpty() ? $defaultSlug : $defaultSlug.'-'.($maxSuffix + 1);
    ```
- **⚠ Caveat (ours):** race window between check and insert — pair with a unique index + retry for high-concurrency creation.
- **Freya note:** product/category slug generation — direct e-commerce shape.
- **Links visited:** none.

### `Number::abbreviate()` — human-readable big numbers (multi-screen, merged)
- **Source:** Laravel Daily · community post · W34-zone (~2–3 mo) · docs 13.x helpers link · Filament stat-cards example
- **Tags:** helpers, formatting, dashboards
- **Adoptable code:**
    ```php
    // BEFORE: 'tokens' => 7457147561, 'token_value' => '$4660.7175', 'requests' => 202668
    return [
        'tokens'      => Number::abbreviate((int) ($totals->tokens ?? 0), precision: 1),      // 7.5B
        'token_value' => '$'.Number::abbreviate((float) ($totals->token_value ?? 0), precision: 1), // $4.7K
        'requests'    => Number::abbreviate((int) ($totals->requests ?? 0), precision: 1),    // 202.7K
        'sessions'    => Number::abbreviate((int) ($totals->sessions ?? 0), precision: 1),    // 4.9K
    ];
    ```
- **⚠ Caveat (ours):** suffixes are English (K/M/B); for Czech admin UI check `Number::useLocale()`/`withLocale()` behavior or wrap with own suffix map (freya admin texts are Czech-only).
- **Freya note:** admin dashboard stat tiles — value-pass candidate.
- **Links visited:** none.

### `whereBelongsTo()` — relationship-based where without `_id` columns
- **Source:** Laravel Daily · community post · W34-zone (~2–3 mo)
- **Tags:** eloquent, relationships, readability, scopes
- **Adoptable code:**
    ```php
    // Before:
    Order::query()
        ->where('user_id', $user->id)
        ->where('book_id', $book->id)
        ->where('status', 'paid')
        ->exists();
    // After (with a paid() scope):
    Order::query()
        ->whereBelongsTo($user)
        ->whereBelongsTo($book)
        ->paid()
        ->exists();
    ```
- **Note:** author frames it honestly as personal preference; pairs with the `whereRelation()` card (both = relationship-expressed queries).
- **Links visited:** none.

### Stacked `Rule::unique()` — uniqueness across MULTIPLE tables
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06)
- **Tags:** validation, uniqueness, form-requests
- **Adoptable code:**
    ```php
    'email' => [
        'required',
        'email:rfc,dns',
        Rule::unique(Profile::class, 'email')->ignore($this->user()->id),
        Rule::unique(InvitationModel::class, 'email'),
    ],
    // messages(): 'email.unique' => 'Email is already in use or has a pending invitation.',
    ```
- **Freya note:** customer email vs invitations/newsletter tables — value-pass candidate.

### Seeding 1M rows — strategy benchmark (Claude-simulated, author-run; multi-screen, merged)
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06) · fresh L13
- **Tags:** seeding, performance, bulk-insert, benchmarks
- **Numbers (SQLite):** per-row Eloquent w/ bcrypt `hashed` cast = **5 rows/s** (202.8s/1k) · factory w/ cached pw = 1,896/s · query-builder chunk 1k = 264,671/s · +`--transaction` = 287,800/s · extended-insert = 359,791/s. **(MySQL/Herd, 1M):** Eloquent ~53 hrs extrapolated · query-builder chunk = 10.74s · extended-insert chunk 2k+tx = 9.18s · `LOAD DATA LOCAL INFILE` = 5.48s (182k/s).
- **Lessons:** the killer is per-row bcrypt + per-row INSERT, not Eloquent per se; cache the hash, chunk the inserts; SQLite beats MySQL on raw insert.
- **Freya note:** renew-pipeline legacy seeding + any local seed path (T38) — bulk strategies directly applicable.

### Validate route parameters BEFORE controllers — `where()` / `whereIn()`
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** routing, validation
- **Adoptable code:**
    ```php
    Route::get('{lang}/{page}', [DocController::class, 'show'])
        ->whereIn('lang', ['en', 'es', 'de', 'ja'])
        ->where('page', '[a-z0-9\-]+');
    Route::get('profile/@{username}/posts/{status}', [ProfileController::class, ...])
        ->where('username', '[a-zA-Z0-9_]{3,20}')
        ->whereIn('status', ['published', 'draft', 'archived']);
    ```
- **Note:** non-matching = 404 before any controller/validation code runs.

### Factory states as Business Language — `published()` not column soup
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** testing, factories, readability, ai-readiness
- **Adoptable code:**
    ```php
    public function published(): static
    {
        return $this->state(fn (array $attributes) => [
            'status'       => JobStatus::Published,
            'published_at' => now(),
            'deadline'     => now()->addMonth(),
        ]);
    }
    // Test: JobListing::factory()->for($company)->published()->create();
    ```
- **Note:** author ties it explicitly to AI-era readability — "tests read like product requirements." Boost guidelines already mandate checking factory states before manual setup; this is the authoring side of that rule.

### `fullUrlWithoutQuery()` — drop query params from the current URL
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** requests, urls, pagination, filters
- **Adoptable code:**
    ```php
    $resetPageUrl = request()->fullUrlWithoutQuery('page');
    $freshUrl     = request()->fullUrlWithoutQuery(['page', 'sort', 'order']);
    ```
- **Freya note:** admin filter/sort link building — pairs with `withQueryString()` from the `when()` card.

### ⚠ laravel-lang/* supply-chain attack (2026-05-22/23) — tag-rewrite credential stealer
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06) · Aikido tweet (2026-05-23)
- **Tags:** security, supply-chain, composer, incident
- **Substance:** attacker rewrote historical release tags of `laravel-lang/{lang, http-statuses, actions, attributes}` (233–700+ poisoned versions); injected `helpers.php` wired into composer `autoload.files` → runs on EVERY request; credential stealer; ~5,561 downstream repos backdoored in 6 hours. Tag rewrite defeats version pinning — pin to COMMIT, rotate secrets if hit.
- **⚡ FREYA CHECKED LIVE (2026-08-19, this session): CLEAN.** All 17 laravel-lang packages are dev-only; locked versions post-takedown; the 4 attacked packages carry NO autoload.files; only `routes/helpers/functions.php` autoloads (32 lines, legitimate `localizedRoute()`, inspected); `composer audit` shows no laravel-lang advisories. → ledger T57.
- **Third supply-chain card this harvest** (Packagist RAT · npm `--ignore-scripts` · laravel-lang) — the cluster justifies one standing security note in the value pass.

### `->dd()` / `->ddRawSql()` on Eloquent queries
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** debugging, sql, tinker
- **Adoptable code:**
    ```php
    User::where('id', 1)->dd();        // "select * from users where id = ?" + bindings
    User::where('id', 1)->ddRawSql();  // "select * from users where id = 1"
    ```

### `Schema::hasTable()` / `hasColumn()` — idempotent migrations
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** migrations, idempotency, deployments
- **Adoptable code:**
    ```php
    if (! Schema::hasColumn('users', 'phone_verified_at')) {
        Schema::table('users', function (Blueprint $table) {
            $table->timestamp('phone_verified_at')->nullable();
            $table->index('phone_verified_at');
        });
    }
    ```
- **⚠ Caveat (ours, T54 cross-ref):** guards make migrations survive partial deploys — but they can also MASK ordering bugs (a swapped duplicate-timestamp pair would "pass" silently instead of failing loud). Use for deploy resilience, not as a fix for ordering hygiene.

### `with('relation:col1,col2')` — column selection in eager loading
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06) · 191👍
- **Tags:** eloquent, eager-loading, performance
- **Adoptable code:**
    ```php
    $products = Product::with('reviews:id,product_id,rating,text')->limit(10)->get();
    ```
- **⚠ Caveat (ours):** the selected columns MUST include the FK (`product_id`) and `id`, or relation matching silently breaks. Colon-syntax sibling of the `with()`-callback card (callback = conditions too; colon = columns only).

### `.env` graveyard sweep — old projects hold live credentials (multi-screen, merged)
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06)
- **Tags:** security, secrets, env, hygiene
- **Adoptable practice:**
    ```bash
    find ~ -name ".env*" -type f 2>/dev/null
    ```
    Then: delete stale files, rotate any ACTIVE third-party creds found in old/testing/temp projects.
- **⚡ Freya note:** this is OUR movie — T44 (`.env_backup` with live-shaped secrets in git history, rewritten 08-17) and T45 (`.env_backup` gitignore gap). The sweep habit generalizes both; value-pass: run it on office+home boxes as a periodic hygiene tick.

### Custom relationship methods — filtered relations defined in the Model
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** eloquent, relationships, reusability
- **Adoptable code:**
    ```php
    public function completedOrders()
    {
        return $this->hasMany(Order::class)   // or ->orders()
            ->where('status', 'completed')
            ->orderByDesc('completed_at');
    }
    // $user->completedOrders()->get();  — instead of repeating the filter in controllers
    ```
- **Note:** family with `latestOfMany` (W34) and scopes — the model owns the vocabulary.

### Secure + private file uploads — authorize EVERY download (multi-screen, merged)
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06) · 294👍
- **Tags:** uploads, security, storage, authorization
- **Substance:** options ladder (private local disk · private S3/R2 with tenant-prefixed paths `companies/{id}/documents/{uuid}.pdf` · scoped disks · per-tenant buckets); recommended default = private bucket + filename in DB + policy + authorize on every view/download.
- **Adoptable code (core):**
    ```php
    public function download(Document $document): StreamedResponse
    {
        Gate::authorize('download', $document);
        $media = $document->getFirstMedia('file');
        abort_unless($media, 404);
        return Storage::disk($media->disk)->download(
            $media->getPathRelativeToRoot(), $media->name,
        );
    }
    ```
- **Freya note:** admin document/invoice downloads — never serve private files by direct path; value-pass candidate.

### ⚡ Don't send sensitive data to the LLM — "safe context" builder (multi-screen, merged)
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06) · laravel/ai example
- **Tags:** ai, llm, privacy, prompt-minimisation, laravel-ai
- **Substance:** dedicated `CompanyContextService::buildSafeContext()` returns ONLY non-sensitive metadata the LLM needs (category slug, title, dates, status booleans, `safe_summary`) — never file contents, never EIN/bank/tax fields. Paired agent (`implements Agent, HasStructuredOutput`) with instructions: "recommend based ONLY on structured data provided · do not assume absent facts · do not mention document contents · do not ask for EINs, bank account numbers, tax IDs, signatures" + JsonSchema-typed output (summary · priority enum · next_actions[]).
- **⚡ Freya note (T32/T41 material):** this is the exact prompt-minimisation pattern for the AdminAssistant KB lane (T32 line B/C/D) and matches the T41 GDPR stance (minimisation ≠ don't-look; structured safe context + audit). The shipped `AdminAssistant` + `laravel/ai` stack can adopt the safe-context-builder shape almost verbatim. Strongest single card of the harvest for our AI lane.

### Laravel 13.6: `prefersJsonResponses()` in bootstrap/app.php
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06) · PR by Wendell Adriel · shipped 13.6, 2026-04
- **Tags:** api, responses, laravel-13, bootstrap
- **Adoptable code:**
    ```php
    return Application::configure(basePath: dirname(__DIR__))
        ->withRouting(web: __DIR__.'/../routes/web.php', commands: __DIR__.'/../routes/console.php')
        ->prefersJsonResponses()
        ->create();
    // JSON even without Accept header; explicit 'Accept: text/html' still wins;
    // validation failures → JSON instead of redirect
    ```
- **Freya note:** relevant to any freya API surface (MCP endpoints, ajax admin routes); freya is L13 — verify ≥13.6 at value pass.

### Seeder from raw SQL export — `DB::unprepared()`
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** seeding, sql, migration-of-data
- **Adoptable code:**
    ```php
    class ProductSeeder extends Seeder
    {
        public function run(): void
        {
            $sql = file_get_contents(database_path('seeders/sql/products.sql'));
            DB::unprepared($sql);
        }
    }
    ```
- **⚠ Caveat (ours):** `unprepared()` = no bindings, whole-file execution — trusted static files only, never user-shaped input.
- **Freya note:** freya's local rebuild reality IS SQL dumps (majkee's `dbfr` + `database:load-backup`); this pattern formalizes dump-driven seeders — T38 (local empty agendas) candidate mechanism.

### `LazilyRefreshDatabase` — migrations only when the DB is touched
- **Source:** Laravel Daily · community post · **2 months ago** (~2026-06)
- **Tags:** testing, pest, performance
- **Adoptable code:**
    ```php
    // tests/Pest.php
    pest()->extend(TestCase::class)
        ->use(LazilyRefreshDatabase::class)
        ->in('Feature');
    ```
- **Freya note:** drop-in suite speedup for DB-less tests; adjacent to (not a fix for) the paratest isolation pain. Value-pass: check freya's `tests/Pest.php` current trait.

### Boost v2.4.9 changelog — the release right below freya's installed v2.4.10
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06) · github.com/laravel/boost/releases
- **Tags:** boost, agents, mcp, tooling
- **Substance (transcribed):** laravel/mcp 0.7.1 namespace renames adopted · Google **Antigravity** agent added (Gemini CLI agent REMOVED in its favor) · **Zed** editor agent added · Factory Droid agent · Docker Compose filename detection in Sail check · Dependabot 5-day cooldown + auto-merge · **AGENTS.md removed from Codex AND OpenCode project detection**.
- **⚡ Freya note:** this IS our Boost generation (we run 2.4.10). The AGENTS.md-detection change matters for the multi-IDE harness (T32's gitignored `.codex/` lane; Codex sessions no longer keyed off AGENTS.md by Boost detection). Zed agent → relevant to zed-editor seats. Feed T49/T56.

### AI codegen era-drift — Composer 2.5 emits `Controller::class.'@index'` (discussion)
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06)
- **Tags:** ai-codegen, idioms, code-review
- **Kernel:** Cursor Composer 2.5 generated `Route::get('/', HomeController::class.'@index')` — works, tests pass, but it's the pre-L8 string syntax instead of `[HomeController::class, 'index']`. AI reproduces outdated idioms from training data; "it works" ≠ "it's current."
- **Freya note:** family with the migration-timestamp card — both are AI-codegen review-checklist items (era drift · duplicate stamps). Feeds the codegen standing-rule candidate (T12/T49).

### Cache keys as Model constants — typo-proof invalidation
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06)
- **Tags:** caching, invalidation, constants, observers
- **Adoptable code:**
    ```php
    class Product extends Model
    {
        public const NAV_BADGE_CACHE_KEY = 'products.count';

        public static function cachedCount(): int
        {
            return Cache::remember(self::NAV_BADGE_CACHE_KEY, now()->addSeconds(60),
                fn (): int => self::count());
        }
    }
    // ProductObserver: created/deleted/restored → Cache::forget(Product::NAV_BADGE_CACHE_KEY);
    ```
- **Why:** a mistyped raw string breaks invalidation with NO error — just stale data forever.

### Callable transitions — one chunked/transactional engine, many state operations (multi-screen, merged)
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06) · 204👍
- **Tags:** php, callable, orders, batch-operations
- **Adoptable code (core):**
    ```php
    public function markPaid(Collection $orders): array
    {
        return $this->transition($orders, function (Order $order): bool {
            if (! $order->status->isPayable()) { return false; }
            $order->update(['status' => OrderStatus::Paid, 'paid_at' => now()]);
            return true;
        });
    }

    protected function transition(Collection $orders, callable $transition): array
    {
        $updated = 0; $skipped = 0;
        DB::transaction(function () use ($orders, $transition, &$updated, &$skipped): void {
            foreach ($orders->chunk(100) as $chunk) {
                foreach ($chunk as $order) {
                    $transition($order) ? $updated++ : $skipped++;
                }
            }
        });
        return compact('updated', 'skipped');
    }
    ```
- **Freya note:** batch order-state operations (expedice flows) — the engine/operation split composes with the enum-state-machine card.

### laravel-at/laravel-image-sanitize — block code execution via uploaded images
- **Source:** Laravel Daily · community post · ~2 mo (~2026-06) · 436👍 · packagist v5.0.0, 65k downloads
- **Tags:** security, uploads, images, middleware
- **Substance:** middleware sanitizing uploaded images against embedded malicious code (inspired by "How to Hack your Laravel" talk). Requires PHP 8.3+, L12/13, Intervention Image 4.
    ```php
    Route::post('/files', [FileController::class, 'upload'])
        ->name('file.upload')
        ->middleware(ImageSanitizeMiddleware::class);
    ```
- **Freya note:** admin product-image uploads — REAL adopt candidate (mature: 65k DLs); completes the upload-security pair with the File-rule and private-download cards. Value-pass shortlist.

### Mass delete skips model events — `chunkById` when cleanup hooks matter
- **Source:** Laravel Daily · community post · **1 month ago** (~2026-07)
- **Tags:** eloquent, events, observers, mass-operations
- **Adoptable code:**
    ```php
    // Before: EmailMessage::query()->delete();  // deleting event never fires → files orphaned
    EmailMessage::query()->chunkById(200, function ($emails) {
        foreach ($emails as $email) {
            $email->delete(); // fires the deleting hook
        }
    });
    ```
- **⚠ Freya note:** double-edged — mass ops in the renew pipeline RELY on events not firing (speed); admin cleanup features with file/relation teardown must NOT use mass delete. Same fact, two consequences — pairs with the `upsert()` card's no-events caveat.

### promptphp/intercept — security middleware for Laravel AI SDK agents
- **Source:** Laravel Daily · community post · ~1 mo (~2026-07) · github.com/promptphp/intercept
- **Tags:** ai, llm, security, prompt-injection, pii, laravel-ai
- **Substance:** middleware collection for `laravel/ai` agents — `PromptInjectionGuard` (detects "ignore previous instructions" class attacks) + `PIIRedactor` (detects/redacts sensitive values).
- **Adoptable code:**
    ```php
    class SupportAgent implements Agent, HasMiddleware
    {
        public function middleware(): array
        {
            return [
                new PromptInjectionGuard,
                new PIIRedactor,
            ];
        }
    }
    ```
- **⚡ Freya note (T32/T41):** completes the AI-safety trio — safe-context builder (design) + agent instructions (policy) + intercept middleware (enforcement). AdminAssistant already implements `Agent`; `HasMiddleware` is a drop-in evaluation. Young package — vet before adopting (supply-chain cards apply).

### `DB::listen()` — one app-wide slow-query listener
- **Source:** Laravel Daily · community post · **1 month ago** (~2026-07)
- **Tags:** database, performance, n+1, monitoring
- **Adoptable code:**
    ```php
    // AppServiceProvider::boot()
    DB::listen(function (QueryExecuted $query) {
        if ($query->time > 500) {
            logger()->warning('Slow query', [
                'sql'  => $query->sql,
                'time' => $query->time,
            ]);
        }
    });
    ```
- **Freya note:** freya already carries Debugbar/Telescope/Nightwatch — this is the zero-dependency production-lean variant; useful where full tooling is off. Octane caveat: listener registers once per worker, fine — but avoid capturing per-request state in the closure.

### JSON columns — query with `whereJsonContains()` / `whereJsonLength()`
- **Source:** Laravel Daily · community post · **1 day ago** (2026-08-18)
- **Tags:** eloquent, json, querying
- **Adoptable code:**
    ```php
    // cast: 'preferences' => 'array'
    User::whereJsonContains('preferences->notifications', 'email')->get();
    User::whereJsonLength('preferences->tags', '>', 3)->get();
    ```
- **Freya note (MariaDB):** JSON_CONTAINS/JSON_LENGTH supported (MariaDB 10.2+;
  JSON = LONGTEXT alias) — works, but no native JSON indexing; heavy use wants
  generated columns. On-contact idiom.

### `abort_if()` / `abort_unless()` — guard clauses without if-blocks
- **Source:** Laravel Daily · community post · **1 day ago** (2026-08-18)
- **Tags:** controllers, authorization, readability
- **Adoptable code:**
    ```php
    abort_if(! $user->isAdmin(), 403);
    abort_unless($user->isAdmin(), 403);
    abort_unless($post->isPublished() || $user->can('view', $post), 404);
    ```
- **Note:** for policy checks proper `Gate::authorize()`/policies stay preferred; this is the lightweight guard idiom.

## Left / parked

### provydon/laravel-scale — autoscaling scaffold package (fresh zone, ~this week)
Package recommendation post: https://github.com/provydon/laravel-scale — one
`php artisan scale:install` publishes Octane (FrankenPHP) + production Dockerfile
+ supervisord + web/worker service split + HTTPS-behind-proxy middleware; runs on
Render, Laravel Cloud, Fly, Railway, AWS ECS/EKS, GKE/Cloud Run. **Link verified
live (WebFetch 2026-08-19):** real, MIT, ~53 stars, 70 commits, single author
(provydon), 0 open issues, no beta markers — legit but young. Parked as
package-news, not a code tip (same precedent as W34's Boost 2.5 item) — promote
if a project wants container autoscaling. Note: stack-specific — assumes
FrankenPHP; an Octane/RoadRunner-on-classic-server app adopts nothing here.

### anthonybudd/Laravel-Lite — "World's Smallest Laravel Instance" (fresh zone, ~3 days)
Project-news post: https://github.com/anthonybudd/Laravel-Lite — minimal
microservice template on raw Illuminate components ($router->get closures,
JsonResponse), "crazy-fast cold starts", PHPUnit, Docker. Post's own framing is
skeptical: "I wonder if it's still a worth-solving problem in 2026. Remember
Lumen, anyone?" — top comment: "Are we getting Lumen again with a different
name?" **Verified (WebFetch 2026-08-19): 20★, 0 forks, 19 commits, no license
stated.** Parked as project-news/curiosity — Lumen-shaped idea the ecosystem
already retired once. No monolith relevance.

### Livewire PowerGrid v7.0.0-beta.1 — major rewrite (fresh zone, ~3 days; release 5 days before shot)
Release-news: Power-Components/livewire-powergrid v7 beta (luanfreitasdev) —
architectural rewrite: single fluent `struct()` → ThemeBuilder (HTML fully
separated from visual styles, no theme conditionals in Blade) · server-side
actions via `renderActions()` (drops `window.pgActions` JS/browser-cache path) ·
modular plugin system (Editable, Toggleable, Flatpickr date picker, Export,
new Filter Builder as isolated plugins). Beta disclaimer explicit — APIs may
change before 7.0.0 stable. Parked as release-news: adopt-relevant only for
PowerGrid users; themes target Tailwind/DaisyUI/Flux stacks.

### Laravel-Excel v4.0.0 — major release (fresh zone, ~3 days; release 2 days before shot)
Release-news: SpartnerNL/Laravel-Excel 4.0.0 (patrickbrouwers) — PHPOffice v5 ·
PhpSpreadsheet 5.3 · PHP 8.5 deprecation fix · queue jobs with batches · min
PHP/Laravel bumped (rector targeting PHP 8.3 minimum) · StyleCI→Pint · native
types · docs warn `FromQuery` requires unique ORDER BY. Parked as release-news —
upgrade-awareness card for projects on maatwebsite/excel 3.x.

### Obvious code comments confession — opinion poll
Author changed his mind on "obvious" section comments in route files ("code can
breathe, eyes can skim"); asks readers useful-or-worthless. Opinion post, no
technique beyond the preference itself. Left per the noise filter (readability
opinion), noted because the reversal itself is a data point on comment culture.

### Laravel AI SDK — release-day announcement (~2026-02)
News: "Laravel AI SDK should be released *today*", docs live a day early
(github laravel/docs, 12.x branch, ai-sdk.md, pushed by taylorotwell); "still
early, subject to change". Parked as release-news — **but a dated marker for
freya: this is the SDK the shipped AdminAssistant runs on (`laravel/ai` v0);
its public release ≈ Feb 2026.**

### AI SDK course shooting — external APIs just fail (multi-screen, merged)
Story post: OpenAI API failing repeatedly (`GenerateVideoThumbnailJob … 1m 12s
FAIL`, retried, failed again — terminal shots dated 2026-02-07) while filming
the AI SDK course; author deliberately keeps failures in the video ("REAL
stories, not ideal world"). No technique — parked as sentiment/story. Takeaway
kernel if wanted: design AI/external-API jobs for failure as the NORMAL path
(timeouts, retries, user-visible fallbacks).

### NativePHP "Jump" app — QR-code preview of Laravel/Livewire on device
News/tooling: install `nativephp/mobile`, `artisan native:jump` → browser QR →
Bifrost Jump app scans → app runs on Android, free, no Xcode/IDE. Course teased.
Parked as tooling-news; joins W34's NativePHP v4 parked line (benchmarks there
remain uncited-able).

### Blaze v1.0 launch email (Caleb Porzio) — Blade/Livewire render speed
News: launch "tomorrow" on-stream at Laravel Worldwide Meetup; complete rewrite
since the Laracon demo; teaser bench "rendering 25,000 anonymous components:
500ms → 13ms" + memoization/folding promised. Parked as tooling-news — **freya
note: Boost already ships a `blaze-optimize` skill in this stack; if admin
Livewire rendering ever hurts, this is the sanctioned lane to evaluate.**

### "Is Teams the same as multi-tenancy?" — blog-post pointer
Article pointer (laraveldaily.com/post/is-the-...): Level-1 application-level
tenancy diagram (one shared DB, `WHERE team_id = :current_team` — "Notion,
Linear, Slack pattern"). Concept explainer, no new technique beyond W34's
multi-tenancy checklist card. Parked as article pointer.

### Live-chat packages roundup — musonza/chat · munafio/chatify · wirechat/wirechat
Package poll post (W34-zone): three chat-package options, author asks what's
missed + offers a comparison review. No verdict, no code. Parked as package
roundup — freya has no chat-feature need beyond the shipped AdminAssistant.

### Laravel Installer news pair (~2 mo): v5.28 starter-kit hooks + auth-feature selection
Two posts, one lane: (i) **v5.28 interactive starter-kit installer hooks** —
PR #523 (benbjurstrom, taylorotwell merged): `post-create-project` hook in
composer.json `extra.laravel.installer.post-create-project`, runs INTERACTIVE
setup commands after app creation (unlike composer scripts); (ii) **auth
features now selectable** in starter kits (email verification · registration ·
2FA · passkeys · password confirmation — all-on by default; passkeys new).
Parked as installer-news; joins the `laravel new` options card family.

### Lerd — local PHP dev environment for Linux
Tooling: https://geodro.github.io/lerd/ — Linux-native local dev dashboard
(sites w/ per-project Laravel version, PHP-FPM 8.3/8.4/8.5 pools, Mailpit,
MySQL, Redis, Gotenberg, *.test DNS, file watcher). Author shares without
review (not a Linux user). Parked as tooling-news — **but majkee IS an Arch
user; worth a desktop look if the hand-rolled local stack ever chafes.**

### "Practical Laravel Security" course — 7 lessons / 43 min, text-based (~2 mo)
Course announcement (laraveldaily.com), compiled after the breach wave. Lesson
map transcribed for reference: 01 laravel-lang attack example · 02 composer
habits · 03 securing secret keys/passwords · 04 secure local development ·
05 how to know if you're affected · 06 emergency response checklist · 07 what
secrets need rotation (and in what order). Parked as course pointer — natural
companion to this harvest's supply-chain card cluster (RAT · npm scripts ·
laravel-lang · .env sweep); lesson 07's rotation-order topic maps onto our T44
precautionary-rotation residual.

### Market-signal pair (~2mo/1mo): Reddit jobs rant + Laravel Cloud story
(i) Reddit r/laravel "forced to JS/Python for lack of Laravel jobs" (104↑/67
comments) — joins the W34 Upwork observation in the market-signal cluster;
(ii) Laravel Cloud personal story — hobbyists compare VPS price, COMPANIES buy
reliability/convenience ("a totally different game"). Sentiment data, no code.

### eliseekn/laravel-metrics — dashboard trends package
Package rec: fluent `LaravelMetrics::query(Order::query())->sum('amount')
->byMonth(6)->trends()` / `->metrics()`. Parked as package-news — freya admin
dashboards could use the SHAPE, but the CarbonPeriod card covers the native
path; evaluate only if chart needs grow.

### Pesto — new PHP template engine (multi-screen, merged)
News: pestophp.com — HTML-attribute templating (`php-foreach`, `php-if`,
`<template>` wrapper), context-aware `{{ }}` escaping, self-published
benchmarks vs Blade/Twig. Curiosity — freya is Blade/Skaven; no adoption lane.
Benchmark figures are the project's own; do not cite as independent.

### ext-ffmpeg — FFmpeg language bindings for PHP (~2 wks)
Project-news: https://ext-ffmpeg.com — native FFmpeg bindings as PHP extension;
fluent `Media::open('input.mov')` → `MediaEncoder` `addVideo(..., VideoCodec::H264)`
`addAudio(..., AudioCodec::Copy)` `save('output.mp4')`. Parked as project-news
(276👍) — replaces shell-out ffmpeg wrappers if it matures; no current freya need.

## Deduped
- **Final batch B (freshest, ~1–2 days):** initials `Str::of()` pipeline +
  `whereRelation()` — both already carded from the ~Jan cluster. If these are
  fresh reposts (stamps not visible), the channel RECYCLES its own tips —
  relevant input for the epistemics session (repetition ≠ extra evidence).
- **Final batch A (W34 fresh-zone sweep, ~2wks–9d):** 9 exact W34/W33 dups —
  withExists · $attributes defaults · #[BindWhen] · enum traits · enum
  group-helpers (W33) · Boost PR #882 · new-in-initializers · API Resource
  plain array · **NativePHP v4 benchmark slide — the shot IS the slide photo
  behind W34's do-not-cite verdict (verdict unchanged: no published numbers)**.
- **W34 fresh-end convergence batch (~1mo/4wks, 2026-07):** `latestOfMany` ·
  higher-order collection messages · `Str::squish` · rate-limiter arrays — all
  exact W34 cards. **Same-second-migrations post = DUP of W34's #1 card, with
  NEW evidence worth keeping: attribution "Opus 4.8 Medium", screenshot shows
  `2026_07_12_174355` ×6 files + `_174356` ×5 + `_174357` ×3 — current-gen
  models, not legacy (→ appended to freya T54 context).** Route-helpers post
  (`whereNumber/whereUuid/whereAlpha/whereAlphaNumeric`) absorbed as variant
  into the Apr route-params card. Laravel Cloud story continuation absorbed
  (Taylor tweet 2026-07-03: "16 months after launch, most successful commercial
  product, on pace to 5x this year"). NativePHP pricing absorbed into its
  parked line: free tier (browser/camera/device/dialog/file/mic/network/share/
  system) · $49 (biometrics/geolocation/scanner/secure-storage) · $99
  (background-tasks/local-notifications/firebase) · Ultra sub $35/mo.
- **Boost re-run protip (W34-zone variant)** of the ~Mar `boost:install`-again
  card — NEW NUGGET kept: wire **`php artisan boost:update --discover`** into
  composer.json scripts for automated guideline refresh ("packages may have AI
  guidelines. Especially Spatie"). Screenshot shows spatie/laravel-activitylog ·
  medialibrary · sluggable offering guidelines/skills. → T49/T56 lane; remember
  our standing `--no-discover` caveat for NON-interactive contexts — these two
  flags are the deliberate opposite choices.
- **W34-zone middle section verified DUP ×6** (one batch): Upwork API-first
  observation · ShouldDispatchAfterCommit · switch-vs-match · Pest `->with()`
  datasets · Validator-in-Artisan-command · multi-tenancy checklist — all
  match W34 cards exactly. Coverage continuity between the fresh zone and the
  CMS pivot is now witnessed, not assumed.
- **Password rules per environment** (~4 mo standalone post) — VARIANT of two
  Feb cards (Password::defaults + starter-kit defaults); env-conditional closure
  `fn (): ?Password => app()->isProduction() ? Password::min(12)... : null`
  already captured. No new card.
- **`DB::prohibitDestructiveCommands(app()->isProduction())` standalone tip**
  (~4 mo, 456 likes) — VARIANT of the starter-kit defaults card; noted because
  the like-count shows community traction of the PRODUCTION-scoped idiom
  (extra weight for the T37/Skaven scope argument).
- `match()` every enum case, skip default arm (AppointmentStatus example) —
  **W34 card**, seen again ~1 week old (2026-08-12-ish). W34-zone entry confirmed.
- API Resource from plain array (AvailabilityResource example) — **W34 card**,
  seen again ~8 days old.

## Coverage map (live)
- Fresh zone (2026-08-19 → W34 top): covered (4 news posts).
- W34 zone (08-18 → CMS-Architect pivot, ~3–4 mo deep): covered by W34 report;
  2 DUP confirmations logged here.
- **GAP: CMS pivot (~May 2026) → ~7 months ago (~Jan 2026)** — skipped by majkee's
  jump to the historical batches; second batch ("early this year") may partially fill.
- Historical batch 1: ~7–11 months ago (~Sep 2025–Jan 2026) — 9 posts.
- Historical batch 2: **~7-months-ago cluster (~Jan 2026)** — 8 posts, ALL code
  tips, 0 dups. Dense, high quality.
- **⚠ FLOOR HYPOTHESIS FALSIFIED:** code tips confirmed at 9-months-ago depth
  (~Nov 2025) — the tip format predates majkee's ~March-2026 estimate. True floor
  still not reached.
- **Density observation (majkee):** regular static-tip cadence seems to START
  ~2026-01; older posts sparser. CAVEAT: the YouTube mobile app may thin or cap
  the deep Posts scroll — verify on desktop before treating sparseness as fact.

- Historical batch 3: **~6-months-ago cluster (~Feb 2026)** — 2 new posts
  (Blade::directive, scheduler callbacks) + 10 re-pastes of batch 2 (mobile
  12-image cap; re-pastes also surfaced a batch-2 transcription miss: `$touches`).
- Historical batch 4: **~Feb 2026 continued** — 12 shots, 10 posts (2 multi-screen
  merges): 6 tips + 4 news-parked. Terminal shot dated 2026-02-07 anchors the
  cluster. Starter-kit-defaults card = direct T37 evidence (official guard scope
  is `isProduction()`, narrower than Skaven's `!runningUnitTests()`).

- Historical batch 5: **~5-months-ago cluster (~Mar 2026)** — 12 shots, 10 posts
  (3 multi-screen merges), ALL taken. Anchor: McCreary tweet 2026-02-25. The
  AI-agent-readiness and Boost-fallback cards carry direct harness relevance.
  NOTE: this cluster sits just BELOW the CMS-pivot boundary zone — the
  Feb→May gap is now partially filled from both ends.

- Historical batch 6: **~4-months-ago cluster (~Apr 2026)** — 11 shots, 11 posts:
  8 taken · 2 variant-dups (Password-per-env, prohibitDestructive standalone —
  both reinforce the T37 scope argument) · 1 article pointer. Gap to the CMS
  pivot (~May) nearly closed.

- Historical batch 7: **W34-zone sweep** — 12 shots, 10 posts (2 merges):
  2 taken (Number::abbreviate, whereBelongsTo — W34 missed neither: these are
  IN-zone posts W34's 24 screens simply didn't include) · 1 package-roundup
  parked · 1 Boost variant (composer.json `--discover` nugget) · 6 exact DUPs
  confirming W34 coverage.

## RESUME PROTOCOL (cold-start insurance — read this block and continue)
A fresh session continuing this run needs, in order:
1. `README.md` (this scope's law: ritual, card format, pivot rule).
2. THIS FILE, fully — cards above = dedup base; Coverage map = boundaries.
3. W33 + W34 reports (`report/raw.laravel-daily-harvest.2026-W3{3,4}.md`) —
   the rest of the dedup base (W33: 1 card · W34: 17+4).
4. Protocol: majkee pastes screenshots in chat (mobile, batches ≤12; longer
   posts split across shots — MERGE them). Per post: transcribe → dedup vs all
   cards → freya cross-check (stack: L13/PHP8.5/Livewire4/MariaDB/Octane-
   RoadRunner/Skaven-CSS, no Tailwind; renew pipeline; ledger threads T37/T49/
   T54–T56) → verdict TAKEN/LEFT/DUP → write card INTO THIS FILE immediately →
   short ack (title + verdict only). Links: reconstruct canonical URLs for
   known repos; WebFetch to verify when valuable.
5. At close: update index.md row · freya value pass over ALL cards (grade:
   adopt-now / testing-space / future / irrelevant) · consumer handoff (T49→
   Atlas skills · T2→Houston study appendix · taste-branch lane for tests) ·
   JSONL substrate extraction to harvest/ (Delta method, W34 precedent) ·
   T37 journal addendum (starter-kit isProduction idiom) already queued.
6. Floor watch: harvest continues DOWN past ~Sep 2025 until posts stop being
   viable tip-shaped; last good post = floor pivot marker.

- Historical batch 8: **~2-months cluster (~Jun 2026)** — 12 shots, 11 posts
  (1 merge): 8 taken · 2 parked entries (installer pair, Lerd). **The
  laravel-lang card triggered a LIVE freya security check → CLEAN (ledger
  T57); side catch: composer audit now 12 advisories / 2 packages (guzzle +
  commonmark, both Aug 2026) — supersedes T43(a).**

- Historical batch 9: **~Jun 2026 continued** — 12 shots, 9 posts (3 merges):
  8 taken · 1 course pointer parked. Standouts: safe-context LLM pattern
  (→ freya T32/T41) · .env graveyard sweep (→ T44/T45 lineage) · security
  course lesson map for the supply-chain cluster.

- Historical batch 10: **~Jun–Jul 2026** — 12 shots, 10 posts (2 merges):
  6 taken · 4 parked. Standouts: Boost v2.4.9 changelog (one patch below OUR
  installed 2.4.10 — AGENTS.md detection change, Antigravity/Zed agents) ·
  image-sanitize middleware (real adopt candidate) · AI era-drift kernel.

- Historical batch 11: **~Jul 2026 → W34 fresh-end CONVERGENCE** — 12 shots,
  10 posts (2 merges): 2 taken (promptphp/intercept, DB::listen) · 3 variants
  absorbed · 5 W34 dups. **Coverage is now CONTINUOUS from 2026-08-19 back to
  ~Nov 2025.** Remaining unharvested: below ~Sep–Nov 2025 (floor hunt), if the
  app scroll reaches it.

## Run metadata — FINAL (closed 2026-08-19, majkee gavel)
- Screens processed: 130 (incl. re-pastes: laravel-scale ×1, batch-2 ×10, comments ×2)
- Tips taken: 69 · parked: 15 · dups/variants: 15
- Links verified live: laravel-scale · Laravel-Lite · AI-Workflows-For-Laravel (gh) ·
  laravel-lang attack advisories (WebSearch, 3 sources)
- **Side effects on freya during run:** T57 laravel-lang security check (CLEAN) ·
  composer-audit refresh (guzzle+commonmark highs → T43 lane) · T54 evidence
  hardened (Opus 4.8 Medium attribution)
- **Floor pivot: NOT REACHED — closed by operator decision.** Tips confirmed
  viable to ≥9 months (~Nov 2025). Follow-up (small, parkable): resume per the
  RESUME PROTOCOL block, dive below ~Sep–Nov 2025 until posts stop being
  tip-shaped; verify on DESKTOP whether the mobile app was capping the scroll.
- Substrate: chat-paste; JPG extraction from session JSONL to `harvest/`
  possible post-run (Delta method, W34 precedent) — parked, not required.
- Freya value pass: `freya/.dev/session/research/_inbox/laraveldaily-deep-backfill-freya-value.md`
