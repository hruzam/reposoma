---
scope: ai-news
sources_file: raw.research/ai-news/draft/sources.jsonl
output_path: raw.research/ai-news/report/raw.ai-news.<YYYY-MM-DD>.md
card: raw.settings/raw.card.refresh.ai-news.md
output_mode: briefing
window_days: 7
persist: ephemeral
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Live AI/LLM news feeds — newsletters, practitioners, Czech scene.
    NOT research citations (those live in raw.research/harness/source-catalog.jsonl).
---

# Scope: ai-news

Periodic briefing on AI/LLM developments — research depth, tooling releases, policy,
and Czech scene. Sources are RSS feeds and web pages pulled by `/refresh ai-news` and
filtered to the last `window_days` days. Output is a structured in-session briefing
grouped by domain; no output file is auto-committed (persist: ephemeral).

This scope is NOT for research citations or cross-measurement findings — those live in
`raw.research/harness/source-catalog.jsonl`. It is also NOT a snapshot of docs pages;
docs scopes (agent-docs, ollama-docs, openrouter) use `output_mode: snapshot` and
`persist: ephemeral` or `canonical` per scope README.

Skill: `/refresh ai-news`
Card: `raw.settings/raw.card.refresh.ai-news.md`
