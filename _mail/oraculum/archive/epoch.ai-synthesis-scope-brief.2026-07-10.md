# epoch → oraculum: ai-synthesis scope — tool or project?
date: 2026-07-10
from: epoch
to: oraculum
status: UNREAD

## What exists (context)

We built a `/refresh <scope>` skill that fetches AI/LLM news sources and produces
a briefing + substrate file. Current `ai-news` scope has 15 sources across:
- research-depth: newsletters (Import AI, Interconnects, Raschka, Cameron Wolfe, The Batch…)
- papers: HuggingFace Daily Papers (~17/day, community-upvoted arXiv)
- policy-governance, czech-scene, cross-discipline

Each run produces:
- `raw.research/ai-news/report/raw.ai-news.<date>.md` — substrate
- `raw.settings/raw.card.refresh.ai-news.md` — synthesis run log

## The idea

Cross-reference synthesis: find which papers/topics appear in 2+ independent
sources within the same window. The intersection = highest signal — what multiple
communities independently converged on. This is qualitatively different from any
single source's output.

Example: if Import AI covers a paper AND HuggingFace Daily Papers upvotes it AND
Interconnects references it — that paper is the week's signal, not noise.

## The hinge question

**Stateless per run** → skill or small script
- Fetch all sources in one session, compare in-session
- No memory between runs; can only cross-reference what was fetched THIS run
- Simple, no storage, fits inside the existing `refresh` skill as a synthesis step
- Limitation: misses slow-burn signal (paper cited in week 1, discussed in week 3)

**Persistent state between runs** → new project, own storage
- Each run appends to a store (SQLite? JSONL log?)
- Cross-reference looks back N weeks, not just this session
- Catches slow-burn: topic appears weakly across 4 weeks = rising signal
- Requires: schema, storage layer, query logic, possibly a new scope or project

## What Epoch cannot decide

- Whether slow-burn detection matters enough to justify the storage layer
- Whether this is a standalone tool (fits in `~/.config/zsh/ai/`) or a project
  with its own registry beacon, devenv, pulse
- Whether Color should model the cross-reference math first (frequency weighting,
  decay functions, deduplication of same paper cited under different titles)

## What Epoch asks Oraculum

1. Stateless or persistent? What does the problem structure require?
2. If persistent: tool in machine layer or new project?
3. Is Color warranted before any implementation (formal model of the signal math)?
4. Any blind spot in the problem framing above?

## Relevant paths

- Skill: `~/.claude/skills/refresh/SKILL.md`
- Scope config: `~/reposoma/raw.research/ai-news/draft/README.md`
- Sources: `~/reposoma/raw.research/ai-news/draft/sources.jsonl` (15 sources)
- Substrate example: `~/reposoma/raw.research/ai-news/report/raw.ai-news.2026-07-10.md`
- Card: `~/reposoma/raw.settings/raw.card.refresh.ai-news.md`
