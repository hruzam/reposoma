# epoch → atlas: new /refresh scope — laravel
date: 2026-07-10
from: epoch
to: atlas
re: (new — independent of migration-pass-scopes.2026-07-10.md)

---

New `/refresh` scope harness for the Laravel / PHP ecosystem.
Three files; pattern matches `raw.research/ai-news/` exactly.
Independent of the migration pass — sequence at your discretion.

**Scope rationale (Epoch research, 2026-07-10):**
Tier 1: laravel-news (daily hub) + laravel-daily (Korop, weekly craft).
Tier 2: stitcher-io (PHP language evolution / Tempest) + freek-dev (Spatie ecosystem, AI-in-Laravel).
Special watch: `laravel/mcp` + `laravel/boost` are moving fast (v0.8.2 shipped 2026-07-03).

**freek-dev note:** RSS URL unverified — attempt `freek.dev/rss` on first run;
flag as feed-error and fall back to WebFetch `freek.dev` if broken.

---

## File 1 — raw.research/laravel/draft/README.md

```yaml
---
scope: laravel
sources_file: raw.research/laravel/draft/sources.jsonl
output_path: raw.research/laravel/report/raw.laravel.<YYYY-MM-DD>.md
card: raw.settings/raw.card.refresh.laravel.md
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
---
```

```markdown
# Scope: laravel

Periodic briefing on the Laravel / PHP ecosystem. Invoked as `/refresh laravel`.
Window 7 days; persist ephemeral.

Tier 1: laravel-news (daily hub) + laravel-daily (Korop, weekly craft).
Tier 2: stitcher-io (Brent Roose — PHP language evolution, Tempest) +
        freek-dev (Freek Van der Herten / Spatie — 300+ packages, AI-in-Laravel).

Note: freek-dev RSS URL unverified at scope creation. Skill will attempt
`freek.dev/rss` on first run; flag as feed-error if broken.

Skill: `/refresh laravel`
Card: `raw.settings/raw.card.refresh.laravel.md`
```

---

## File 2 — raw.research/laravel/draft/sources.jsonl

```jsonl
{"id":"laravel-news","url":"https://feed.laravel-news.com","title":"Laravel News","domain":"laravel-ecosystem","tier":1,"tags":["laravel","php","packages","daily"],"note":"RSS ✅. Main ecosystem hub — daily news, package releases, community links. 50K+ subscribers."}
{"id":"laravel-daily","url":"https://laraveldaily.com/feed","title":"Laravel Daily","author":"Povilas Korop","domain":"laravel-ecosystem","tier":1,"tags":["laravel","weekly","craft","tutorials"],"note":"RSS ✅. Weekly newsletter + daily tips. Korop active through Laracon India 2026."}
{"id":"stitcher-io","url":"https://stitcher.io/feed","title":"Stitcher.io","author":"Brent Roose","domain":"php-language","tier":2,"tags":["php","modern-php","tempest","language-evolution"],"note":"RSS ✅. JetBrains PHP Advocate. PHP Annotated source. Tempest framework author. 14K subscribers."}
{"id":"freek-dev","url":"https://freek.dev/rss","title":"freek.dev","author":"Freek Van der Herten","domain":"laravel-ecosystem","tier":2,"tags":["laravel","spatie","php","ai","packages"],"note":"RSS ⚠️ — URL unverified; fallback to WebFetch freek.dev if broken. Spatie co-owner. 300+ packages. 'Laravel, PHP and AI' angle. CONFIDENCE:M"}
```

---

## File 3 — raw.settings/raw.card.refresh.laravel.md

```markdown
---
card: card.refresh.laravel
brand: Research — Laravel / PHP ecosystem (scope: laravel)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-10
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

<!-- older runs appended below this line, newest first -->
```

---

## Done-when

- [ ] `raw.research/laravel/draft/README.md` created
- [ ] `raw.research/laravel/draft/sources.jsonl` created (4 entries)
- [ ] `raw.settings/raw.card.refresh.laravel.md` created
- [ ] `/refresh laravel` smoke-test: skill reads the README without error
- [ ] freek-dev RSS status noted in card Feed flags on first run

No tombstones. No .gitignore changes needed (persist: ephemeral).
