*"This is a clean my, invocable skill for `freya-dev.researcher-architect`?"*
Crad: `research-buffer.freya-dev.researcher-architect.md`
### The 20% gap → skill-ready edits
| Current brief element | Adjustment for GEM skill (`skill.pattern-scout.md`) |
|----------------------|-----------------------------------------------------|
| Claude Code queries (`.claude/`, `CLAUDE.md`) | Add parallel **Cursor-IDE queries**: `.cursor/rules/*.mdc`, `AGENTS.md`, `mcp.json`, `hooks.json`, `filename:hooks.json "afterFileEdit"` |
| Assumes CLI execution (`gh search code`) | GEM is read-only web chat → skill **outputs search queries for @majkee to run**, or navigates RAG registry only. Add: *"If execution needed, draft query + flag `[requires-execution]`"* |
| "INTERESTING REPOS" evaluative guidance | Distill to a **checklist** the skill can apply: `☑ production repo ☑ ≤3mo active ☑ PHP/Laravel ☑ multi-agent pattern` |
| No explicit RAG-first step | Add: *"Before external search, check `freya/dev/RAG/_personas/layer-librarian.md` + relevant slice. If found, cite; if not, proceed to GitHub scout."* |
| Internal persona refs (`@Vega`, `@Houston`) | Replace with factory names: `freya-dev.researcher-architect`, `freya-dev.main-architect` |


# Cursor rules
filename:00-base.mdc OR filename:AGENTS.md "globs"
path:.cursor/rules/ filename:`*.mdc` "alwaysApply"

# MCP + hooks
filename:mcp.json "mcpServers" "read"
filename:hooks.json "afterFileEdit" OR "stop"

# Laravel + Cursor combo
filename:AGENTS.md laravel "cursor"
filename:mcp.json php "database" "read-only"

```
### Boundaries
- Freya-bound research only. Escalate cross-project landscape to `dev.deep-researcher`.
- GEM cannot execute searches → output queries for @majkee, or navigate RAG only.
- Volatile claims (Cursor versions, MCP limits) → verify ≤6 weeks or mark `[unverified · training-era]`.

### Output drop
`freya/dev/session/<id>/reports/pattern-<slug>.md`
Manual vector stamp: `vector: research · status: pending-review · stamp: YYYY-MM-DDTHH:MM`