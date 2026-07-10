---
scope: ollama-docs
sources_file: raw.research/ollama-docs/draft/sources.jsonl
output_path: raw.research/ollama-docs/report/raw.ollama-docs.<YYYY-MM-DD>.md
output_mode: snapshot
persist: ephemeral
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Ollama + Qwen local agent reference for ≤16GB RAM builds. CLI, API, Modelfile,
    tool calling, OpenAI compat, Qwen3 model catalog.
  related_scopes:
    - raw.research/openrouter/  (cloud model catalog — separate scope)
---

# Scope: ollama-docs

Snapshot of Ollama documentation and Qwen3 reference material. Invoked as `/refresh ollama-docs`.
No date filter (output_mode: snapshot). persist: ephemeral — local only.

Sections to compile: 16GB RAM shortlist table · Ollama CLI essentials · API endpoints ·
Modelfile syntax · Qwen3 family map · agentic use patterns · Arch Linux notes.

⚠ docs.ollama.com is the canonical home — raw github URLs deprecated:
  - modelfile.md → docs.ollama.com/modelfile (raw github 404s — renamed to .mdx)
  - api.md → docs.ollama.com/api (deprecated in-file)
  - envvars.md, openai.md → 404 on raw github; info at docs.ollama.com
  - docs.ollama.com/api → intro page only via WebFetch; use ollama-llms-txt to discover full endpoint deep-links

Skill: `/refresh ollama-docs`
