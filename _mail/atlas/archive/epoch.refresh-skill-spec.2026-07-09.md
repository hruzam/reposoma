# epoch → atlas: `refresh` skill — unified fetch-substrate-card process
date: 2026-07-09
from: epoch
to: atlas
status: UNREAD

## Why this exists

Research session with majkee surfaced that `fetch-agent-docs`, `fetch-ollama-docs`,
`fetch-qwen-docs` are all hardcoded instances of the same process:

  fetch sources → write substrate file → synthesize → update card

The process is now normalised under ONE skill (`refresh`) + ONE convention
(`raw.research/<scope>/README.md` defines the variable part per scope).
Existing `fetch-*` skills are the OLD pattern — tombstone them after migration.

## Skill: `refresh`

**Path:** `~/.claude/skills/refresh/SKILL.md`
**Invocation:** `/refresh <scope>`
**No default scope** — scope is mandatory; if omitted, list available scopes
from `ls ~/reposoma/raw.research/` and ask.

**Steps the skill executes:**
1. Read `~/reposoma/raw.research/<scope>/README.md`
   → get: `sources_file`, `output_path` (substrate), `card`, `window_days`, `output_mode`
2. Read `sources_file` (JSONL) → list of sources with `url`, `title`, `domain`, `tags`
3. Fetch each source (WebFetch) — RSS feed or web page
4. Filter by recency (`window_days`, default 7); for docs scopes: no filter (full fetch)
5. Write raw substrate file to `output_path` (dated, e.g. `raw.<scope>.<YYYY-MM-DD>.md`)
6. Synthesize substrate → structured output grouped by `domain` tag
7. Emit in-session briefing + note which sources returned nothing
8. Prompt operator: update `verified:` in card? (do not auto-write card — operator confirms)

**Tools needed:** Read, WebFetch, Write

## Files to create (build in this order)

### 1. `~/reposoma/raw.research/ai-news/README.md`

```yaml
scope: ai-news
sources_file: raw.research/ai-news/sources.jsonl
output_path: raw.research/ai-news/raw.ai-news.<YYYY-MM-DD>.md
card: raw.settings/raw.card.refresh.ai-news.md
output_mode: briefing
window_days: 7
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Live AI/LLM news feeds — newsletters, practitioners, Czech scene.
    NOT research citations (those live in raw.research/harness/source-catalog.jsonl).
  related_scopes:
    - raw.research/agent-docs/   (docs migration — future)
    - raw.research/ollama-docs/  (docs migration — future)
    - raw.research/qwen-docs/    (docs migration — future)
```

One paragraph body: what this scope is, what it is NOT, pointer to skill + card.

### 2. `~/reposoma/raw.research/ai-news/sources.jsonl`

```jsonl
{"id":"import-ai","url":"https://importai.substack.com/feed","title":"Import AI","author":"Jack Clark","domain":"research-depth","tier":1,"tags":["research","weekly","cutting-edge"],"note":"Co-founder of Anthropic; detailed weekly research analysis"}
{"id":"interconnects","url":"https://www.interconnects.ai/feed","title":"Interconnects","author":"Nathan Lambert","domain":"research-depth","tier":1,"tags":["rl","rlhf","open-models"],"note":"Cross-validated: Raschka + Ruder both recommend"}
{"id":"ahead-of-ai","url":"https://magazine.sebastianraschka.com/feed","title":"Ahead of AI","author":"Sebastian Raschka","domain":"research-depth","tier":1,"tags":["ml-papers","practitioners"],"note":"Cross-validated: Lambert + Ruder both recommend"}
{"id":"deep-learning-focus","url":"https://cameronrwolfe.substack.com/feed","title":"Deep (Learning) Focus","author":"Cameron Wolfe","domain":"research-depth","tier":1,"tags":["research","cross-validated"],"note":"Strongest cross-validation: Raschka + Lambert + Diamant"}
{"id":"the-gradient","url":"https://thegradientpub.substack.com/feed","title":"The Gradient","domain":"research-depth","tier":1,"tags":["research","practitioners"],"note":"Cross-validated: Raschka + Ruder"}
{"id":"latent-space","url":"https://www.latent.space/feed","title":"Latent.Space","author":"swyx","domain":"tools-releases","tier":1,"tags":["ai-engineering","agents","infra"],"note":"Cross-validated: Raschka + Lambert"}
{"id":"nlp-news","url":"https://newsletter.ruder.io/feed","title":"NLP News","author":"Sebastian Ruder","domain":"research-depth","tier":1,"tags":["nlp","monthly"]}
{"id":"ai-normal-tech","url":"https://www.normaltech.ai/feed","title":"AI as Normal Technology","author":"Narayanan+Kapoor","domain":"policy-governance","tier":1,"tags":["critical","sober-lens"],"note":"AI Snake Oil authors — Lambert recommends"}
{"id":"ai-guide-humans","url":"https://aiguide.substack.com/feed","title":"AI: A Guide for Thinking Humans","author":"Melanie Mitchell","domain":"policy-governance","tier":1,"tags":["limitations","critical"],"note":"Cross-validated: Raschka + Lambert"}
{"id":"prg-ai","url":"https://prg.ai/en/feed","title":"prg.ai","domain":"czech-scene","tier":1,"tags":["czech","national-platform","monthly"]}
{"id":"rychlofky","url":"https://rychlofky.substack.com/feed","title":"Rychlofky #TYDEN","domain":"czech-scene","tier":2,"tags":["czech","weekly","digest"]}
{"id":"ceciletamura","url":"https://x.com/ceciletamura","title":"Cecile G. Tamura","author":"Cecile Tamura","domain":"tools-releases","tier":2,"tags":["community","ploutos-ai"],"note":"X-only — no RSS; WebFetch profile page or note as manual-check"}
{"id":"ismail-sojal-medium","url":"https://0xsojalsec.medium.com/feed","title":"Md Ismail Sojal","author":"Ismail Sojal","domain":"tools-releases","tier":2,"tags":["ai-security"],"x":"https://x.com/0x0SojalSec","note":"Medium RSS available; X handle for real-time"}
```

### 3. `~/reposoma/raw.settings/raw.card.refresh.ai-news.md`

Follow `raw.settings/card.template.md` exactly for frontmatter shape.

```yaml
card: card.refresh.ai-news
brand: Research — AI/LLM news watch (scope: ai-news)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-09
half_life: ~8 weeks
half_life_days: 56
recheck:
  - ~/reposoma/raw.research/ai-news/sources.jsonl
  - https://www.interconnects.ai/recommendations
  - https://magazine.sebastianraschka.com/recommendations
  - https://newsletter.ruder.io/recommendations
verify_cmd: "cat ~/reposoma/raw.research/ai-news/sources.jsonl | wc -l"
```

Body: one-line per source (id · title · author · domain · tier · note).
Wiring line: `skill: /refresh ai-news · data: raw.research/ai-news/sources.jsonl`.

### 4. `~/.claude/skills/refresh/SKILL.md`

The generic skill runner. Key design constraints:
- Scope is MANDATORY — if missing, list `raw.research/` subdirs and ask
- Path construction: `~/reposoma/raw.research/<scope>/README.md`
- Graceful-fail: if scope README missing → say so, list available scopes
- Output grouped by `domain` field in sources.jsonl:
  order: research-depth → tools-releases → policy-governance → czech-scene → (other)
- Footer in every briefing:
  - Sources with no items in window (stale signal)
  - X-only / manual-check sources (cannot auto-fetch)
  - Card update prompt: "Run `/refresh <scope>` again after verifying — or update card manually"
- Does NOT auto-write card — operator confirms before card `verified:` date is touched

## Migration: existing fetch-* skills

After this skill is verified working (majkee confirms on first `/refresh ai-news` run):

| Old skill | New scope folder to create | Action |
|-----------|---------------------------|--------|
| `fetch-agent-docs` | `raw.research/agent-docs/` | tombstone old skill |
| `fetch-ollama-docs` | `raw.research/ollama-docs/` | tombstone old skill |
| `fetch-qwen-docs` | `raw.research/qwen-docs/` | tombstone old skill |

Migration = separate Atlas task; do NOT block the current build on it.
Scope READMEs for docs scopes: `output_mode: snapshot`, no `window_days` filter.

## Build order

1 → 2 → 3 → 4

Skill last — it references paths established by 1 + 2 + 3.
Before writing the skill, read `card.template.md` in raw.settings to confirm
current frontmatter shape (it may have drifted since this mail was written).

## Open: Chris KE (Facebook)

One followed profile not yet resolved — Facebook-only, identity unconfirmed.
Majkee is observing. Add to sources.jsonl when/if confirmed. Stub row:
`{"id":"chris-ke","url":"PENDING","title":"Chris KE","domain":"tools-releases","tier":3,"tags":["facebook-only","unverified"],"note":"Identity unconfirmed — majkee observing"}`
Do NOT add until majkee confirms.
