# raw.card.agents.addendum — MCP config locations (verified 2026-06-11)

`status: raw / pending-merge`
`verified: 2026-06-11, official docs (code.claude.com, cursor.com)`
`merge-target: actuality file — MCP / tooling section`
`supersedes: any prior assumptions about mcp.json placement`

---

## Verified native MCP config paths

| Path | Claude Code CLI | Cursor IDE + Cursor CLI (`cursor-agent`) |
|---|---|---|
| `<repo>/.mcp.json` | ✅ project scope — committed, team-shared; approval prompt on first use (`claude mcp reset-project-choices` to reset) | ❌ not read natively |
| `<repo>/.cursor/mcp.json` | ❌ | ✅ project scope — committable; wins over global on name clash |
| `~/.claude.json` | ✅ user scope (all projects) **and** local scope (default, keyed per project path) | ❌ |
| `~/.cursor/mcp.json` | ❌ | ✅ global scope (`%USERPROFILE%\.cursor\mcp.json` on Windows) |
| `<repo>/.claude/mcp.json` | ❌ **does not exist** — invalid path, never create | ❌ |

**Pitfalls (hard rules):**
- `~/.claude.json` is a FILE in home dir, NOT inside `~/.claude/` directory.
- Claude Code scope precedence: local > project > user. Files supplement, not replace.
- Cursor project file must be exactly `.cursor/mcp.json` — no variants.
- Cursor CLI has no separate MCP file: shares IDE config; manage via `/mcp list|enable|disable`. Its `cli-config.json` = permissions/settings only, NOT MCP servers.
- Cursor CLI also auto-loads `.cursor/rules/`, `AGENTS.md`, `CLAUDE.md` from repo root.

## freya-specific consequence

Received root `.mcp.json` is the **Claude Code** convention — invisible to Cursor despite team using Cursor. Expect a `.cursor/mcp.json` twin in repo or per-dev (Boost installer generates per detected tool). Local setup rule: same `mcpServers` payload in **both** `<repo>/.mcp.json` (Claude Code) and `<repo>/.cursor/mcp.json` (Cursor), minus the macOS-only `herd` entry on Linux hosts.
