---
card: card.agent-docs
brand: Research — Claude Code agent harness (scope: agent-docs)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-08-01
half_life: ~30 days
half_life_days: 30
recheck:
  - ~/reposoma/raw.research/agent-docs/draft/sources.jsonl
  - https://code.claude.com/docs/en/changelog
verify_cmd: "curl -s https://code.claude.com/docs/en/changelog | grep -c 'v2\.'"
---

# agent-docs — synthesis log

Skill: `/refresh agent-docs` · Data: `raw.research/agent-docs/draft/sources.jsonl`
Substrate: `raw.research/agent-docs/report/`

## 2026-08-01

**Lead:** Claude Sonnet 5 (v2.1.197, June 30) and Claude Opus 5 (v2.1.219, July 24) are live — Sonnet 5 is the current default with 1M context; Opus 5 replaces the default Opus model. Sub-agents now run in the background by default (v2.1.198) with a cap of 20 concurrent / 200 per session; nested subagent spawning is re-enabled to depth 3 (v2.1.219 reversed v2.1.217's disable). Skills gained `background`, `context: fork`, and full `yes/no/on/off/1/0` boolean support in frontmatter (v2.1.218); `context: fork` skills run in the background by default since v2.1.218. Permission mode default changed to "Manual" (v2.1.200); `AskUserQuestion` no longer auto-continues; sandbox hardened with `sandbox.network.strictAllowlist` (v2.1.219) and `sandbox.filesystem.disabled` (v2.1.216). Settings schema substantially expanded: `availableModels`/`enforceAvailableModels`/`fallbackModel`/`advisorModel`/`effortLevel`/`alwaysThinkingEnabled`/`fastMode` added; `claudeMd` key enables org-wide CLAUDE.md inline in managed-settings.json; 5-tier scope precedence fully documented. Auto memory enhanced: YAML frontmatter and HTML comments no longer count toward the 200-line/25KB MEMORY.md load limit (v2.1.211), and a `modified` ISO timestamp is written on every memory-file write (v2.1.214). `/verify` and `/code-review` no longer auto-invoked by Claude (v2.1.215). Changelog freshness anchor: v2.1.220 (July 25, 2026).

**Convergence:** none in window (first run — no prior substrates)

**Quiet:** none — all 8 sources returned content

**Feed flags:** none

**Manual-check:** none

---

<!-- older runs appended below this line, newest first -->
