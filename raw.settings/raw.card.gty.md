---
card: card.gty
brand: Antigravity — agy CLI (gty)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-19
half_life: ~2-4 weeks (new CLI evolving rapidly)
half_life_days: 21
recheck:
  - https://github.com/google-antigravity/antigravity-cli
  - https://antigravitylab.net/en/articles/
verify_cmd: agy --version
auth_survival: API Key (ANTIGRAVITY_API_KEY / GEMINI_API_KEY) in env or settings
---

# Antigravity CLI (gty) — native build surface

## ⚠ Future Identity
-> Castor (Alpha Geminorum): To the naked eye, it looks like a single star in Gemini. In reality, it is a magnificent sextuple system organized as three distinct pairs of doublets orbiting a central barycenter.

## Config home
- Global config: `~/.gemini/config/mcp_config.json` or `~/.gemini/antigravity-cli/mcp_config.json`
- Project-local config: `.agents/mcp_config.json`

## Primitives & Integration
1. **Model Support**: Gemini 3.5 Flash and Ultra lines via API.
2. **Environment Sanitization**: `agy` sanitizes environment variables before spawning subagents/MCP processes. All API keys and secrets (e.g., `GEMINI_API_KEY`, `ANTIGRAVITY_API_KEY`) must be explicitly declared in the `env` blocks of configuration files.
3. **Native Grounding**: Gemini models support native Google Search grounding. Prefer native grounding over heavy external search MCP servers (e.g. context7, Brave, Serper) to minimize system context bloat and failure surfaces.
4. **Headless Execution Workarounds**:
   - `agy` has a known bug under non-TTY environments where `-p`/`--print` outputs empty content with exit code 0.
   - Workaround: wrap commands using `script -qec 'agy -p "your prompt"' /dev/null` and verify output is non-empty.
   - OAuth tokens do not persist across Linux headless sessions. For headless/scripted runs, prioritize restricted API keys.

## Governance
- Restrict API keys to "Gemini API only" in Google AI Studio to survive the June-19 key restrictions.
