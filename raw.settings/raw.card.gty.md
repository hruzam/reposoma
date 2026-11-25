---
card: card.gty
brand: Antigravity — agy CLI (gty)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~2-4 weeks (fast-moving CLI, weekly point releases)
half_life_days: 21
recheck:
  - https://github.com/google-antigravity/antigravity-cli
  - https://antigravitylab.net/en/articles/
  - https://github.com/google-antigravity/antigravity-cli/releases
  - https://antigravity.google/docs/cli/gcli-migration
  - https://antigravity.google/docs/changelog
verify_cmd: agy --version
auth_survival: API Key (ANTIGRAVITY_API_KEY / GEMINI_API_KEY; note GEMINI_API_KEY disables remote-control/usage commands, exit 2) or ADC (AGY_ADC_AUTH) / enterprise gateway; OS-keyring token migration offered on first launch
---

## Refresh delta 2026-11-25
PARTIAL: releases page 1 only (1.5.17–1.5.8); 1.5.7 down to 1.3.2 (incl. all 1.4.x) NOT checked; antigravity.google/docs/changelog CLI entries NOT reached (page 511k chars, first 100k read); `agy --version` not run. Bump NOT verified.
_Since last verify 2026-10-08. Sources live-fetched 2026-11-25 by @Epoch sibling: github.com/google-antigravity/antigravity-cli/releases, antigravity.google/docs/cli/gcli-migration, antigravity.google/docs/changelog, antigravitylab.net/en/articles/. Release pages print day+month only (this fetch saw no year; a sibling pass saw "2025" on some 1.5.x entries — a page typo; the sequence follows the card's Oct 1.3.x line, so 2026, M)._
- **Latest `agy` 1.5.17 (Nov 25)**; card's 1.3.1 (Oct 7) is ~14+ point releases behind (1.5.17 vs 1.3.1; intermediate 1.3.2–1.5.7 not itemized). docs/changelog also lists CLI v1.5.16 as newest at read time (cache lag). H (year M)
- **Models:** Gemini 4 Hydrogen + Carbon via `GEMINI_API_KEY` (1.5.8, Nov 13; Hydrogen also with `AGY_ADC_AUTH`/enterprise gateways); Gemini 4 Neon (Low/Med/High/XHigh) via `GEMINI_API_KEY` (1.5.12, Nov 19) and `AGY_ADC_AUTH`/enterprise gateways (1.5.13, Nov 19). Enterprise/ADC Orchestrator default: Carbon (High) plans, Hydrogen (High) executes (1.5.10). Orchestrator planner/executor default effort `high` (1.5.15). Release page states NO single default model (not stated). Hydrogen as "default model of the Antigravity agent" comes from the API changelog (sibling lead, not re-read here). Source: GitHub releases; App changelog dates Neon Nov 18, Hydrogen Nov 12, Carbon Nov 10, Argon Oct 13. H / default-model M
- **Plan gating:** Neon available on eligible paid consumer plans and Gemini Enterprise (App changelog; whether it applies to CLI not stated). antigravitylab (Nov 23, summary only) says Google AI Pro users may see Gemini 4 "Unavailable" depending on plan line (Starter Quota vs Google AI Pro). L/M
- **Headless / script-affecting (check your wrappers):**
  - `--remote-control` and `--remote-agent` exit code **2** when `GEMINI_API_KEY` is the auth (1.5.12); `/remote-control`, `/voice`, `/record` hidden. H
  - With `GEMINI_API_KEY`, `/usage`, `/quota`, `/credits` hidden; in `-p` runs they exit 2 (1.5.11). H
  - `--output-format json|stream-json` reports `SUCCESS` for runs that succeed after retries (1.5.13). antigravitylab (Nov 24) still reports an unattended run showing ERROR with correct output when final summary stream drops: judge by content, not status (M). H/M
  - `-r` / `--resume` alias for `--conversation` (1.5.16). `--remote-agent` gains `plan` mode (1.5.14). H
  - Default mode for `--remote-agent` now asks before each file edit (1.5.10, behavior change). H
- **Behavior changes:** Auto mode (default Agent Mode) reads outside workspace without approval (1.5.14); no longer asks for outside-workspace writes in version-controlled repos or append-only changes (1.5.16). Terminal sandbox blocks `~/.config` / `XDG_CONFIG_HOME` (1.5.10) — relevant to any wrapper writing config there. Saved conversations no longer pruned to 500 (1.5.15, breaking). `pluginControls.pluginsDisabled` keeps built-in plugins (1.5.16). HTTP MCP custom headers sent only to the configured origin (1.5.9, security). H
- **Config paths (CONFLICT, now partly resolved):** migration doc (live) lists: global MCP `~/.gemini/config/mcp_config.json`; workspace MCP `.agents/mcp_config.json`; global skills `~/.gemini/skills/` or `~/.gemini/antigravity-cli/skills/`; workspace skills `.agents/skills/` (was `.gemini/skills/`, manual move); context `~/.gemini/GEMINI.md`, workspace `GEMINI.md` + `AGENTS.md`; no settings-file path named. Release notes add: skills also discovered in `~/.agents/skills` (`~/.gemini` wins on collision, 1.5.16); conversations at `~/.gemini/antigravity-cli/conversations` (1.5.16); `settings.json` exists (keys `showThinking`, `orchestrator`; path not stated); protected sensitive files include `mcp_config.json` (1.5.17). The card's `~/.gemini/antigravity-cli/mcp_config.json` is NOT confirmed by either live source; treat as unverified, prefer `agy mcp` subcommands. H (doc statements) / path of settings.json L
- **Auth:** first launch offers to move session tokens into the OS keyring (migration doc). Proactive Google OAuth refresh + pre-stream 401 retry (1.5.17 per sibling lead; not in the page-1 summary I read, M). MCP OAuth requests `offline_access` (1.5.17). `AGY_ADC_AUTH` env enables ADC (1.5.13). `GEMINI_API_KEY` mode still works but loses remote-control/usage commands (above). H
- **Other:** `AGY_CLI_AUTO_COMPACT_OVERRIDE` (token count, K/M, or %) (1.5.15); `/thinking` (1.5.14); `agy acp` forwards subagent permission requests (1.5.16); `agy plugin validate` accepts .zip/URLs (1.5.11); `run_workflow` tool for everyone (1.5.9); Enterprise prepaid-wallet-empty stops retries (1.5.17). H
- **Not verified:** 1.3.2–1.5.7 notes (incl. any 1.4.x breaking changes); CLI entries of antigravity.google/docs/changelog; settings.json path; whether `--json-schema` strictness (1.2.14) changed; headless `script -qec` workaround status on a current install; local version (not run).

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: github.com/google-antigravity/antigravity-cli/releases, live-fetched 2026-10-08 by @Epoch (release year not shown on page; inferred). Local `agy --version` not run._
- **Latest 1.3.1** (Oct 7): `/diff` ←/→ between files, n/N across files; fixes `/rewind` in long conversations, Windows plugin install/uninstall, `/tasks` showing only shell cmds. H
- **1.3.0** (Oct 6): default Verbosity `high`→`medium` (tool calls/thoughts grouped into summaries); `/diff` file view j/k now moves line cursor. Behavior change. H
- **1.2.17** (Oct 5): announcement cards above prompt (Esc dismiss); Windows sandbox no longer needs admin. **1.2.16** (Oct 3): image generation runs via built-in `image-generator` subagent. H
- **Script-breaking (older, 1.2.14):** `--json-schema` now rejects plain text / bare type names / missing schema files with exit 1. H
- Versions between 09-02 and 1.2.14 not itemized (L).

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
- Global settings: `settings.json` (path UNVERIFIED 2026-11-25; earlier note said `~/.gemini/antigravity-cli/settings.json`)
- MCP config: managed via `agy mcp` subcommands; global file per migration doc `~/.gemini/config/mcp_config.json` (the older `~/.gemini/antigravity-cli/mcp_config.json` is UNVERIFIED as of 2026-11-25)
- Project-local config: `.agents/mcp_config.json`

## Primitives & Integration
1. **Model Support**: Gemini 4 Hydrogen/Carbon (1.5.8) and Neon (1.5.12/1.5.13) selectable via `/model` and `--model`; `/model` arg switches + persists default (v1.1.22+).
2. **Environment Sanitization**: `agy` sanitizes environment variables before spawning subagents/MCP processes. All API keys and secrets must be explicitly declared in `env` blocks.
3. **Native Grounding**: prefer native Google Search grounding over heavy external search MCP servers to minimize context bloat.
4. **Headless Execution**: on local 1.0.10 the `-p`/non-TTY silent-exit-0 bug still applies — keep the `script -qec` workaround (see addendum). On 1.1.18+ this is fixed upstream; re-test once local install is updated. Caveat 2026-11-25: unattended runs may still report status ERROR with correct output (stream loss on final turn; 1.5.13 fixed retry-then-success only); `--remote-control/--remote-agent` exit 2 under `GEMINI_API_KEY`.

## Governance
- Restrict API keys to "Gemini API only" in Google AI Studio to survive the June-19 key restrictions.
- Local install (1.0.10, last seen) is stale against upstream 1.5.17 (2026-11-25) — flag for update.
