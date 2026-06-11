# Trusted-Source Study: Laravel Daily Repos · Laracasts · Community
### Applied to imago.cz (fantasy/sci-fi e-shop, Laravel storefront, Filament-bound admin)

Compiled: 2026-06-11. Companion to REPO-1 / REPO-2 blueprints.
Project context used: imago.cz — Laravel-written storefront for board games, books,
RPG, LARP/cosplay; social logins (Google, Seznam, Facebook, Discord), blog,
calendar, age-gated products, cart; legacy OpenCart admin being strangled into
Filament; modular monolith target.

---

## PART A — Source map with trust assessment

### A1. Laravel Daily GitHub org (github.com/LaravelDaily)

| Repo | What it is | Value for imago |
|---|---|---|
| **laravel-tips** (~6.5k★) | The canonical community tips collection (Eloquent, migrations, routing, collections, testing...) categorized in MD files | Best single corpus to mine for your researcher agent; also a model for how to structure your own internal tips file |
| **Laravel-Roadmap-Learning-Path** (~5.6k★) | Ordered topic list beginner→senior with links; also ships as `roadmap.sql` | Onboarding doc for officemates/junior devs; gap-analysis checklist for the team |
| **laravel-invoices** (~1.6k★, PHP) | PDF invoice generation, customizable parameters | Direct fit: order invoices for the e-shop (CZ legal fields go in custom template) |
| **Larastarters** | Starter-kit themes | Low relevance (frontend exists) |
| Roadmap example projects (Breeze/UI blog, Junior Challenge) | Reference implementations of "idiomatic simple Laravel" | Calibration baseline: what plain-vanilla Laravel looks like vs your modular monolith — useful when reviewing AI-generated code for over-engineering |

How to consume: don't paste laravel-tips into guidelines (it's huge → dilution).
Instead: clone it into Repo 2 under `research/corpora/laravel-tips/` and let the
researcher/manifest agents grep it on demand — it's already markdown, i.e. free
"skills" material. Cherry-pick max 5–10 tips into actual guidelines only when a
tip prevents a mistake your agents actually make.

### A2. Laracasts (laracasts.com)

The most important development: Laracasts pivoted hard into AI workflows in
2025–2026 and is now arguably the best *pedagogical* source for the Claude Code
side (where Laravel Daily is best for the Laravel-rules side).

Key resources:
- **laracasts.com/ai — "The AI Field Guide"** (free hub). Covers: preparing
  CLAUDE.md the way Anthropic recommends; organizing guidelines into rule MD
  files; Boost as guideline generator; skills as shareable one-command
  workflows; running multiple Claude agents concurrently in git worktrees.
- **Series: "Leveraging AI for Laravel Development"**. Concrete patterns:
  - *Commands* = markdown trigger files ("the Artisan command of Claude").
  - *Skills* = "field guides for your codebase — how we handle things in
    these parts" (≈ exactly your scope manifests).
  - *Subagents* = isolated context so exploration "doesn't clog up your main
    context window" (independent confirmation of the token-economy answer
    from Q1).
  - Taylor Otwell's **Laravel-optimized code-simplifier agent** — pull it in
    as a reviewer pass after feature generation.
- **Laravel From Scratch (2026 iteration, Laravel 12+)** — refreshed flagship;
  team onboarding.
- **AI-workflow episode series** — one workflow per episode, monthly.
- **Typesense + Laravel Scout course** — "wildly fast open-source search,
  integrates via official Typesense PHP client and Scout."

imago-specific: the Typesense course is the highest-value single item here.
A fantasy/sci-fi catalog (games, books, RPG systems, editions, languages) is
exactly the typo-tolerant, faceted-search use case Typesense/Scout targets —
and a self-hosted Typesense node fits a CZ shop better than Algolia pricing.

### A3. Spatie (spatie.be) — the conventions authority

- **spatie/guidelines-skills** (Apr 2026): their internal coding guidelines
  open-sourced as AI skills, distributed via the skills.sh ecosystem; works
  with Claude Code, Cursor, Codex, Copilot. Four skills, most relevant:
  `spatie-laravel-php` (PSR-12, typed properties, constructor promotion,
  early returns, controller naming, validation, Blade) and
  `spatie-version-control` (branch/commit/squash-merge conventions).
  Previously Boost-only (`spatie/boost-spatie-guidelines`); the skills.sh
  rebuild made it tool-agnostic.
- **spatie.be/guidelines/ai**: raw AI-optimized guidelines file +
  documented global install: download to `~/.claude/laravel-php-guidelines.md`
  and reference with `@~/.claude/laravel-php-guidelines.md` from global
  CLAUDE.md — i.e. zero per-repo cost, loaded by reference.
- Freek Van der Herten publishes his Claude Code setup (custom skills incl.
  package scaffolding from Spatie's skeleton) in his public dotfiles —
  a worked example for your Repo 2 `agents/` + `skills/` folders.
- Caveat from community review (dev.to, Apr 2026): Spatie's shipped skill
  duplicates content between SKILL.md and the guidelines file ("waste of
  tokens") and some rules are taste, not consensus (e.g. `?string` vs
  `string|null`). Lesson: audit any imported skill, delete duplication,
  override taste rules that clash with your codebase.

### A4. Wider community (trusted, sorted by signal)

- **Laravel News** (laravel-news.com) — release/ecosystem wire. Recent
  load-bearing items: Laravel Skills directory (skills.laravel.cloud,
  Feb 2026 — one-command installable skills); Boost package
  guideline/skill auto-discovery (Jan 2026); Spatie skills release coverage.
- **skills.sh ecosystem** — the emerging open standard for distributing agent
  skills across Claude Code/Cursor/Codex; this is where your own internal
  packages' skills could eventually be published privately/team-wide.
- **Official laravel.com blog/docs** — "AI Coding Tips for Laravel Developers",
  Boost docs, and "AI SDK vs Boost vs MCP: which tool do you need" (the
  cleanest statement of the guidelines/skills/MCP three-layer model).
- **Nuno Maduro** — `nunomaduro/essentials` (strict-by-default model/config
  hardening) and **Pow** (trims noisy output from AI-agent test runs — small
  but direct token saver, covered on Laravel Daily). 
- **Christoph Rumpel, Aaron Francis (database/perf), Laravel Podcast** —
  secondary; route through the researcher agent rather than guidelines.

---

## PART B — Convergence analysis (what ALL trusted sources now agree on)

Independent sources arriving at the same practice = high-confidence adoption
signal. Five such convergences:

1. **Three-layer knowledge model** — upfront guidelines (small) / on-demand
   skills / live MCP. Stated by: Laravel official blog, Boost docs, Laracasts
   field guide, Spatie's move to skills, Povilas's shrinking rule file.
   → You already implement this (Repo 1 table). No change.

2. **Skills are eating guidelines.** Spatie rebuilt from Boost-guidelines to
   skills; Laravel launched a skills directory; Boost added package-shipped
   skills; Laracasts calls them codebase field guides. The center of gravity
   for *stable situational knowledge* is now skills, with skills.sh emerging
   as the cross-tool distribution format.
   → Action: ship your internal composer packages' knowledge as
   `resources/boost/skills/` (per REPO-1 §3), and consider skills.sh format
   for cross-tool (Cursor teammates!) compatibility.

3. **Subagents/worktrees for context isolation.** Laracasts (subagents that
   "don't clog the main context", parallel agents in worktrees) confirms the
   Q1 architecture: heavy exploration in disposable contexts, conclusions
   only in the main session.
   → Action: add a `simplifier` reviewer agent (Taylor Otwell's port) to
   Repo 2 `agents/` next to boundary-reviewer.

4. **Conventions should be imported, then pruned — not written from scratch.**
   Everyone now starts from Spatie's or Povilas's rules and deletes. The
   community-review caveat applies: imported rule sets contain duplication
   and taste; audit before adopting.
   → Action: diff Spatie's `spatie-laravel-php` against your
   `10-php-laravel.md`; adopt only non-conflicting, mistake-preventing rules.

5. **Tests as the agent contract.** Povilas (mandatory Pest + Filament smoke
   tests), Spatie (every feature a Pest test, factories only, behavior not
   implementation), Laracasts (agents run/fix tests as workflow step). Tests
   are the convergent answer to "how do I trust autonomous output."

---

## PART C — Tips extracted, mapped to imago.cz

### C1. Storefront (exists, optimize)
- Homepage perceived vs actual speed: Livewire deferred loading for
  below-the-fold blocks (new arrivals, blog teasers, calendar) + classic
  N+1/caching pass with explicit invalidation (Laravel Daily, May–Jun 2026
  two-parter — built on a mock *gaming e-shop*, nearly your domain).
- Catalog search: Scout + Typesense (Laracasts course). Facets: category,
  game system, language, age rating; typo tolerance matters for fantasy
  titles ("Zaklínač"/"Witcher", transliterations).
- Auth: passkeys now default in starter kits via Fortify, retrofittable to
  existing projects (Laravel Daily, May 2026) — complements your existing
  Google/Seznam/Facebook/Discord social logins.

### C2. Commerce backbone
- Invoices: LaravelDaily/laravel-invoices for PDF generation; wrap in your
  own internal package with a Boost `core.blade.php` guideline documenting
  your CZ-specific fields (IČO/DIČ, EET-era leftovers if any) so agents
  never regenerate invoice logic ad hoc.
- Bulk catalog/data ops (OpenCart migration!): the 1M-row insert/upsert
  benchmarks (Laravel Daily, May 2026) — use query-builder `upsert`/
  insert-on-duplicate with chunked streaming to limit RAM; never
  Eloquent-per-row for migration jobs.

### C3. Risk
- Supply chain: after the laravel-lang attack — pin with composer.lock
  review on updates, `composer audit` in CI, prefer fewer/maintained
  dependencies; Povilas's "Practical Laravel Security: Packages, Secrets,
  Supply-Chain Attacks" course (May 2026) is the focused reference.
- Imported AI skills are dependencies too: same review discipline (see
  Spatie skill critique above) — a poisoned/sloppy skill steers every agent.

### C4. Workflow (Repo 2 additions)
- `agents/simplifier.md` — Laravel code-simplifier reviewer pass.
- `research/corpora/laravel-tips/` — cloned, grep-able by researcher agent.
- Global Spatie guidelines by reference (`~/.claude/` pattern) for personal
  machines; project rules stay the synced `.ai/guidelines/` (project wins
  on conflict).
- Pow for trimming agent test output; `nunomaduro/essentials` evaluated for
  the domain core (strict models surface AI-generated sloppiness early).

---

## PART D — Source registry (for the researcher agent's allowlist)

```yaml
tier1_official:
  - https://laravel.com/docs        # incl. /boost, /ai
  - https://laravel.com/blog
  - https://code.claude.com/docs
tier1_trusted:
  - https://laraveldaily.com        # + /post/my-cursor-rules-for-laravel
  - https://github.com/LaravelDaily # laravel-tips, roadmap, laravel-invoices
  - https://aicodingdaily.substack.com
  - https://laracasts.com/ai        # + series index
  - https://spatie.be/guidelines/ai # + spatie/guidelines-skills
  - https://laravel-news.com
tier2_route_via_researcher:
  - skills.sh / skills.laravel.cloud (audit every skill before install)
  - freek.dev + Freek dotfiles, nunomaduro repos, Aaron Francis
policy:
  - guidelines may cite ONLY tier1; tier2 findings land in research/ digests
  - every imported skill gets a dated audit note in adr/ or research/
```
