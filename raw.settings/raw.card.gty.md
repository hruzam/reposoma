---
card: card.gty
brand: Antigravity — agy CLI (gty)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~2-4 weeks (fast-moving CLI, weekly point releases)
half_life_days: 21
recheck:
  - https://github.com/google-antigravity/antigravity-cli
  - https://antigravitylab.net/en/articles/
verify_cmd: agy --version
auth_survival: API Key (ANTIGRAVITY_API_KEY / GEMINI_API_KEY) in env or settings; direct Gemini API key auth (no OAuth) since v1.1.13
---

# Antigravity CLI (gty) — native build surface

## Refresh delta 2026-09-02
- **VERSION GAP**: local `agy --version` = 1.0.10 (office); latest on GitHub = **1.1.24** (2026-09-02, active releases through Aug 19 → Sep 2). Local install is ~2 months / dozens of point-releases behind. Source: github.com/google-antigravity/antigravity-cli/releases. CONFIDENCE H.
- **Not merged INTO Gemini CLI — the reverse**: Google sunset Gemini CLI for individual users 2026-06-18; users migrated TO Antigravity CLI (agy), which absorbed Skills/Hooks/Subagents/Extensions as Antigravity plugins. The `gcli-migration` doc referenced on the gemini-cli card is this direction. agy is the surviving/dominant brand, NOT a folded-away side project. Source: developers.googleblog.com "Transitioning Gemini CLI to Antigravity CLI" (2026-05-19 announcement) + github.com/google-gemini/gemini-cli/discussions/27274. CONFIDENCE H.
- **Headless `-p`/`--print` bug largely fixed post-1.0.10**: v1.1.8 added `--output-format text/json/stream-json`; v1.1.18 fixed silent-empty-exit-0 on dropped stream (now surfaces error, non-zero exit); v1.1.20 fixed exit codes conflating benign tool errors with fatal failures. The addendum's `script -qec` wrapper workaround is likely unnecessary on current versions but IS still needed on local 1.0.10. Source: CHANGELOG.md (github.com/google-antigravity/antigravity-cli). CONFIDENCE H.
- **Config paths shifted**: global settings now `~/.gemini/antigravity-cli/settings.json` (moved out of `~/.gemini/settings.json`); MCP config now managed via `agy mcp add/remove/list/enable/disable` subcommands (v1.1.16) instead of hand-editing `mcp_config.json`; conversations moved to SQLite `.db` + `~/.gemini/antigravity-cli/cache/projects.json` (v1.0.4). Card's "Config home" section below is STALE. Source: CHANGELOG.md + inventivehq.com migration guide (2026). CONFIDENCE M.
- **Auth expanded**: v1.1.13 added direct `GEMINI_API_KEY` auth (no OAuth) via `modelProvider: "gemini"`; v1.1.10 added enterprise SSO (Workforce Identity Federation) + Application Default Credentials + proactive token refresh (fixes hourly sign-out pain the addendum doesn't mention). Source: CHANGELOG.md. CONFIDENCE M.
- **Verdict: MAINTAINED, actively — recommend KEEP + re-pull local install.** Cadence is roughly weekly point releases; half_life_days 21 stays appropriate given churn rate, possibly tighten to 14 given the local-vs-latest gap discovered this cycle.

## ⚠ Future Identity
-> Castor (Alpha Geminorum): To the naked eye, it looks like a single star in Gemini. In reality, it is a magnificent sextuple system organized as three distinct pairs of doublets orbiting a central barycenter.

## Config home (STALE — see delta above; re-verify next pass)
- Global config: `~/.gemini/antigravity-cli/settings.json` (moved from `~/.gemini/config/`)
- MCP config: managed via `agy mcp` subcommands; file still readable at `~/.gemini/antigravity-cli/mcp_config.json`
- Project-local config: `.agents/mcp_config.json`

## Primitives & Integration
1. **Model Support**: Gemini model line via API; `/model` arg switches + persists default (v1.1.22+).
2. **Environment Sanitization**: `agy` sanitizes environment variables before spawning subagents/MCP processes. All API keys and secrets must be explicitly declared in `env` blocks.
3. **Native Grounding**: prefer native Google Search grounding over heavy external search MCP servers to minimize context bloat.
4. **Headless Execution**: on local 1.0.10 the `-p`/non-TTY silent-exit-0 bug still applies — keep the `script -qec` workaround (see addendum). On 1.1.18+ this is fixed upstream; re-test once local install is updated.

## Governance
- Restrict API keys to "Gemini API only" in Google AI Studio to survive the June-19 key restrictions.
- Local install (1.0.10) is stale by ~2 months against upstream (1.1.24) — flag for update.
