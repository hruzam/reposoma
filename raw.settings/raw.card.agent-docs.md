---
card: card.agent-docs
brand: Research — Claude Code agent harness (scope: agent-docs)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
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

## 2026-09-02

**Lead:** Freshness anchor jumped from v2.1.220 (Jul 25) to v2.1.258 (Sep 1) — 38 versions in five weeks. Biggest shifts: subagent forking is now on by default (v2.1.232, inherits full conversation + prompt cache) and the MCP client moved to its v2 runtime by default (v2.1.232, SDK 2.0, protocol revision 2026-07-28, persistent `list_changed` streams). New `CLAUDE_CODE_SUBAGENT_MODEL_FORCE` (v2.1.257) forces every subagent onto one model regardless of frontmatter. New hook events `PreModelSwitch`/`PostModelSwitch` (v2.1.251) let you gate model switches. New `--restricted` CLI flag (v2.1.248) strips code-running tools and refuses `bypassPermissions` for locked-down sessions; `bypassPermissions` itself can no longer be set from project/local settings as of v2.1.257 (user/managed only, or `--permission-mode`). Claude Fable 5.1 (`claude-fable-5-1`) became the default Fable model (v2.1.257, 1M ctx, $10/$50/Mtok). Subagent memory paths are now concrete: `~/.claude/agent-memory/<agent-name>/` (user), `.claude/agent-memory/<agent-name>/` (project), `.claude/agent-memory-local/<agent-name>/` (local) — this substrate's first documentation of exact paths (was abstract "scope" language before). Skills gained `metadata`/`license`/`compatibility` frontmatter fields tracking the Agent Skills open spec, plus a hard-error restriction: uploads to claude.ai/Skills API only accept 6 spec-legal fields. `/design`, `/design-sync`, `/import [codex|gemini]`, `/claude-api cost-optimize`, `/list-agents` are new bundled commands. Auto memory now types its notes (`user`/`feedback`/`project`/`reference`) in frontmatter. Changelog fetch for this run was truncated below v2.1.232 — the v2.1.221–231 band is reconstructed from cross-references in other docs pages, not the primary changelog listing (lower confidence, flagged for re-fetch).

**Convergence:** n/a — single-domain tier-1 official docs scope, no cross-source convergence check applicable (see prior run note)

**Quiet:** none — all 8 sources returned content

**Feed flags:** claude-code-changelog (full listing exceeded single-fetch capture below v2.1.232; re-fetch with pagination next run for full v2.1.221–231 detail)

**Manual-check:** none

---

## 2026-08-01

**Lead:** Claude Sonnet 5 (v2.1.197, June 30) and Claude Opus 5 (v2.1.219, July 24) are live — Sonnet 5 is the current default with 1M context; Opus 5 replaces the default Opus model. Sub-agents now run in the background by default (v2.1.198) with a cap of 20 concurrent / 200 per session; nested subagent spawning is re-enabled to depth 3 (v2.1.219 reversed v2.1.217's disable). Skills gained `background`, `context: fork`, and full `yes/no/on/off/1/0` boolean support in frontmatter (v2.1.218); `context: fork` skills run in the background by default since v2.1.218. Permission mode default changed to "Manual" (v2.1.200); `AskUserQuestion` no longer auto-continues; sandbox hardened with `sandbox.network.strictAllowlist` (v2.1.219) and `sandbox.filesystem.disabled` (v2.1.216). Settings schema substantially expanded: `availableModels`/`enforceAvailableModels`/`fallbackModel`/`advisorModel`/`effortLevel`/`alwaysThinkingEnabled`/`fastMode` added; `claudeMd` key enables org-wide CLAUDE.md inline in managed-settings.json; 5-tier scope precedence fully documented. Auto memory enhanced: YAML frontmatter and HTML comments no longer count toward the 200-line/25KB MEMORY.md load limit (v2.1.211), and a `modified` ISO timestamp is written on every memory-file write (v2.1.214). `/verify` and `/code-review` no longer auto-invoked by Claude (v2.1.215). Changelog freshness anchor: v2.1.220 (July 25, 2026).

**Convergence:** none in window (first run — no prior substrates)

**Quiet:** none — all 8 sources returned content

**Feed flags:** none

**Manual-check:** none

---

<!-- older runs appended below this line, newest first -->
