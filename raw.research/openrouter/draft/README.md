---
scope: openrouter
sources_file: raw.research/openrouter/draft/sources.jsonl
output_path: raw.research/openrouter/report/raw.openrouter.<YYYY-MM-DD>.md
card: raw.settings/raw.card.openrouter.md
output_mode: snapshot
persist: ephemeral
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    OpenRouter model/agent catalog — available models, free tiers, rates, API.
    Replaces fetch-qwen-docs with a broader roster. New scope (no prior baseline).
  related_scopes:
    - raw.research/ollama-docs/  (local model catalog — separate scope)
    - raw.research/ai-news/      (AI/LLM news — separate scope)
---

# Scope: openrouter

Snapshot of OpenRouter model catalog and API documentation. Invoked as `/refresh openrouter`.
No date filter (output_mode: snapshot). persist: ephemeral.

Card run-log: focus on what changed — new free-tier models, removed models, rate limit changes.
After first confirmed run, check if triangle.md needs a model-availability row updated.

⚠ openrouter.ai/models and /models?q=:free are JS-rendered — no content via WebFetch.
  Use /docs/models (API docs) for model discovery.
⚠ openrouter.ai/announcements 404s — use /blog instead.

Skill: `/refresh openrouter`
Card: `raw.settings/raw.card.openrouter.md`
