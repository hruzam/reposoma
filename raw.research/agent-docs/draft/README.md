---
scope: agent-docs
sources_file: raw.research/agent-docs/draft/sources.jsonl
output_path: raw.research/agent-docs/report/raw.agent-docs.<YYYY-MM-DD>.md
card: raw.settings/raw.card.agent-docs.md
output_mode: snapshot
persist: canonical
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Claude Code agent harness reference — sub-agents, settings, hooks, MCP, memory,
    skills, commands. Primary substrate for Zenith and Atlas sessions.
    All docs.anthropic.com/en/docs/claude-code/* URLs now 301 to code.claude.com.
  related_scopes:
    - raw.research/ai-news/       (AI/LLM news — separate scope)
    - raw.research/ollama-docs/   (local agent docs — separate scope)
    - raw.research/openrouter/    (cloud model catalog — separate scope)
---

# Scope: agent-docs

Snapshot of Claude Code agent harness documentation. Invoked as `/refresh agent-docs`.
No date filter (output_mode: snapshot — full fetch). persist: canonical — tracked
cross-machine; substrate files stay in version control.

Compiles: YAML frontmatter fields · tool restrictions · permission modes · memory modes ·
hooks structure · MCP syntax · skills · inheritance · CLI flags · plugin restrictions ·
minimal + full annotated examples.

⚠ All docs.anthropic.com/en/docs/claude-code/* URLs 301 to code.claude.com.
Do not use old domain in sources.

Skill: `/refresh agent-docs`
Card: `raw.settings/raw.card.agent-docs.md`
