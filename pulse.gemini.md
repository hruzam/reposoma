# pulse.gemini — Gemini-stack status log (the Gemini lead / Vega writes · everyone reads)

Newest on top. Houston: `cat pulse.vega.md` to see where Vega is.
*(Seeded by Houston at bus setup, 2026-06-19, migrating Vega's prior pulse note — Vega owns it now.)*

## [2026-06-19] Cleaned up toxic global MCP config.
- Renamed `~/.agents/mcp_config.json` → `.bak`. It was binding the filesystem MCP to the wrong project path (`reposoma.dev`) and loading `context7`, violating the new Orby/Astrobley no-search-MCP specs.

## [2026-06-19]
- Cleaned up legacy Gemini configuration. Archived legacy `~/.gemini` + `~/.config/gemini` →
  `raw.gemini.bckp/dot_gemini_legacy`. Wiped `~/.gemini` to bare minimum for a green-field start.
  **WARNING (Houston/Atlas):** rebuilding the Gemini seats — no stale training data, no legacy MCP
  (toxic until verified); fresh harness; minimal MCP bridges.
- Refined the mail protocol (inbox/archive + `toAll/` + ask-first). Confirmed runtime = **legacy Gemini
  CLI** → agents build at `~/.agents/agents/` (not agy). Ready for Atlas.

## [2026-06-19] Vega: Subagent Configuration Overrides
*   Hardcoded `model` and `temperature` into the YAML frontmatter of the Gemini subagents to prevent manual override on every run:
    *   **Astrobley:** `gemini-1.5-flash` | temp `0.2`
    *   **Orby:** `gemini-1.5-flash` | temp `0.3`
    *   **Vega:** `gemini-1.5-pro` | temp `0.4`

## [2026-06-19] Vega: Subagent Date Anchoring
*   Added the **RECALIBRATION RULE** to Orby and Vega's system prompts.
*   They are now instructed to determine the date via the `currentDate` context and treat all version/model data as stale, mimicking Claude's Atlas behavior.
*   Updated the model strings to `gemini-3.1-pro-preview` per the new 2026 reality.

## [2026-06-19] Vega: Model String Recalibration
*   Read the `gemini-agents-scaling` report. The 1.5 and 2.0 model lines are officially dead/deprecated as of June 2026.
*   Upgraded **Astrobley** to `gemini-3.5-flash` (the 2026 workhorse for agentic coding loops).
*   Upgraded **Orby** and **Vega** to `gemini-3.1-pro` (the deep-think powerhouse for research and synthesis).

## [2026-06-19] Vega: Task for Astrobly
*   Read the `_mail/vega/inbox/houston.astrobley-task.recalibration-freshness-script.2026-06-19.md`.
*    