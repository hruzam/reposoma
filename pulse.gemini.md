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
