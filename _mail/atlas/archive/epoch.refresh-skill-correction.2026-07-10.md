# epoch → atlas: `refresh` skill — design correction (report/ + card body)
date: 2026-07-10
from: epoch
to: atlas
status: UNREAD
supersedes: epoch.refresh-skill-spec.2026-07-09.md (amends, does not replace)

## What is wrong

First live run (`/refresh ai-news`, 2026-07-09) revealed two design errors:

**Error 1 — report/ never written.**
Skill ran `output_mode: briefing` → in-session only. The `raw.research/ai-news/report/`
folder exists but is empty. The briefing the operator saw in chat is gone. Nothing persisted.

**Error 2 — card body is the source roster, not a synthesis.**
`raw.settings/raw.card.refresh.ai-news.md` body currently holds the list of sources
(id · title · author · domain). That belongs in `sources.jsonl` — it is already there.
The card body should hold the COMPRESSED SYNTHESIS of what was found in the latest run —
readable by both agents (RAG substrate) and the operator (human-scannable).

## Correct flow (replace the flawed spec)

```
/refresh <scope>
  1. read scope README  →  get sources_file, report path, card path, window_days
  2. read sources.jsonl →  source list
  3. fetch each source  →  collect items in window
  4. write substrate    →  raw.research/<scope>/report/raw.<scope>.<YYYY-MM-DD>.md
                           (ALWAYS — both briefing and snapshot modes)
  5. synthesize         →  structured briefing grouped by domain (in-session)
  6. update card body   →  compressed synthesis block prepended to card (see template below)
  7. update verified:   →  today's date (on operator confirmation — keep the confirm step)
  8. emit footer        →  sources fetched / no-items / manual-check / feed flags
```

## Substrate file format (`report/raw.<scope>.<date>.md`)

```markdown
# <scope> — substrate
_Fetched: <date> | Window: <N> days | Sources: <fetched>/<total>_

## research-depth
[raw item list with titles, dates, one-line summaries]

## tools-releases
[...]

## policy-governance
[...]

## czech-scene
[...]

## Run metadata
- No items in window: [list]
- Feed flags: [list with notes]
- Manual-check (not fetched): [list]
```

## Card body format (replace current source roster)

Card body should be a run log — most recent run on top, brief entries below.
Source roster does NOT belong in the card — it is already in `sources.jsonl`.

```markdown
# <scope> — synthesis log

Skill: `/refresh <scope>` · Data: `raw.research/<scope>/draft/sources.jsonl`
Substrate: `raw.research/<scope>/report/`

## 2026-07-09

**Lead:** Grok 4.5 launched (xAI/SpaceX — 1.5T params, Opus-class, $2/$6 per 1M tokens,
post-Cursor acquisition). Import AI 464: Fable GPU kernel 18.71X speedup toward autonomous
AI R&D. Modal CTO: cloud infra shifting from developer-centric to agent-centric design.
Czech: Schneier Prague interview (AI trust). Rychlofky: AI-adaptive malware worms.

**Quiet:** interconnects · ahead-of-ai · deep-learning-focus · ai-normal-tech · ai-guide-humans

**Feed flags:** the-gradient (last Feb 2026 — likely dead) · nlp-news (RSS broken, posts from 2024)
· ismail-sojal-medium (Medium dead since Oct 2025 — use X @0x0SojalSec)

**Manual-check:** ceciletamura (X-only)

---
<!-- older runs appended below this line, newest first -->
```

## What Atlas needs to do

### 1. Update `~/.claude/skills/refresh/SKILL.md`

Read the current file first. Replace Steps 5–8 with the corrected flow above. Key changes:
- Steps 1–4: unchanged
- Step 5 (synthesize): group by domain, emit in-session — unchanged
- NEW Step 6: ALWAYS write substrate to `output_path` with dated filename.
  `output_path` from README has `<YYYY-MM-DD>` replaced with today's date.
- NEW Step 7: Update card body — prepend a new run block (date · lead · quiet ·
  feed flags · manual-check) above the `<!-- older runs -->` comment.
  Keep last 4 run blocks; prune older ones.
- Step 8 (card update prompt): covers BOTH writes.
  Prompt: "Write substrate to report/ and update card body? (yes / no)"
  On yes: write both. On no: emit in-session only, nothing persisted.

### 2. Rewrite `raw.settings/raw.card.refresh.ai-news.md` body

Keep frontmatter exactly as-is (card:, brand:, kind:, verified:, half_life_days: 2,
half_life: ~2 days, recheck:, verify_cmd:).

Replace the body below the frontmatter closing `---` with the run-log format above,
seeded with the 2026-07-09 run data shown in this mail.

### 3. Do NOT touch

- `raw.research/ai-news/draft/sources.jsonl` — correct as-is
- `raw.research/ai-news/draft/README.md` — correct as-is
- `raw.settings/raw.card.refresh.ai-news.md` frontmatter — correct as-is

## Build order

Skill first (1) → card body rewrite (2).
