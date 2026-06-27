---
card: card.gemini-cli
brand: Google — Gemini CLI
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-27
half_life: ~1-2 weeks (nightlies daily; stable ~weekly)
half_life_days: 30
recheck:
  - https://geminicli.com/docs/changelogs/
  - https://github.com/google-gemini/gemini-cli         # releases + discussions
  - https://google-gemini.github.io/gemini-cli/ROADMAP.html
  - https://antigravity.google/docs/gcli-migration       # successor
verify_cmd: gemini --version
auth_survival: paid Gemini API key OR enterprise license   # see VOLATILE
---

# Gemini CLI — native build surface

## ⚠ VOLATILE — read first (sunset clock)
- **2026-06-18:** Gemini CLI + Gemini Code Assist IDE extensions STOP serving requests for
  Google AI Pro, Ultra, and free personal Code-Assist login. No grace period.
- **SURVIVES via paid Gemini / Gemini Enterprise Agent Platform API key, or enterprise Code Assist license.**
  ← imago's `selectedType: gemini-api-key` is on the surviving path.
- Successor: **Antigravity CLI** (`agy`) — Go, closed-source, single binary, async/background model.
  Keeps Skills, Hooks, Subagents, Extensions (as "Antigravity plugins"). Separate config tree
  `~/.gemini/antigravity-cli/`, separate auth. NOT 1:1 parity at launch.
  ⚠ LOW-CONFIDENCE: Gemini CLI v0.49.0 published 2026-06-25 (repo active); Antigravity as
  "successor" not confirmed via official Google announcement (2026-06-27). Re-verify.
- ACTION: confirm BOTH machines' `gemini` auth = API key (not personal Google login).

## Config home
- User/global: `~/.gemini/`      → settings.json, agents/, commands/, extensions/, skills/, GEMINI.md
- Project:     `<repo>/.gemini/`  (same shapes); workspace config wins on conflict.

## Native primitives
1. **Subagent** (preview 🔬) — `<~/.gemini|.gemini>/agents/<name>.md`. YAML frontmatter + body = system prompt.
   - Tool WILDCARDS: `*` (all), `mcp_*` (all MCP), `mcp_<server>_*` (one server). Isolated context + recursion guard.
   - Manage via `/agents`. Registration: first-wins, project-prioritized.
   - External (headless) invocation: `gemini "@<name> <task>"` — `@name` prefix in the
     prompt selects the agent. Equivalent of `claude --agent <name> "task"`.
   - Interactive invocation: `gemini` → then `/agents` TUI to switch seat.
   - Dead: `gemini -a <name>` (removed). Tested/dead: `GEMINI_AGENT=<name>` (no effect).
2. **Skill** — `skills/<name>/SKILL.md`  (SAME Agent Skills standard as Claude → portable).
3. **Custom command** — `commands/<name>.toml`  (TOML, not markdown) → `/name` or `/<ext>.name`.
   (`~/.gemini/commands/`, project `.gemini/commands/`.) Manage: `/commands`.
4. **Hook** — intercept/customize CLI behavior (supported in extensions).
5. **MCP** — `settings.json` `mcpServers{}` or `gemini mcp add|list|remove`. Per-server includeTools/excludeTools/trust, OAuth.
6. **Extension** (packaging unit) — `extensions/<name>/`: `gemini-extension.json` + GEMINI.md +
   commands/*.toml + skills/*/SKILL.md + agents/*.md + policies/*.toml. Use `${extensionPath}`.
7. **Policy Engine** — tiered `.toml` rules (extension rules = tier 2). Native replacement for hand-rolled param-allowlists.

## Context file
- `GEMINI.md` is native; `contextFileName` is configurable → point at `AGENTS.md` for cross-tool parity.

## Native strengths (vs Claude Code)
- **Model routing / automatic fallback** built in (your model/scan/synth triad partly absorbed).
- Plan Mode (+ research subagents), checkpointing/rewind, session export/import, sandboxing, trusted folders,
  headless mode, A2A remote subagents. Gemini 3 default; Gemma 4 via API default.

## VOLATILE / watch
- Versions move daily (stable ~v0.49x as of 2026-06-27). Antigravity CLI transition: LOW-confidence — re-verify.
- Subagents are PREVIEW → less stable than Claude's GA subagents.
- **`--allowed-tools` CLI arg and `tools.allowed` in settings.json are deprecated** (removal at v1.0).
  Migrate to Policy Engine: https://geminicli.com/docs/core/policy-engine/
  (Policy Engine = primitive #7 in Native primitives above.)

## Recommendation for LARVA
Keep CLI alive via API key. Mirror the portable skills corpus (read from the shared dir). Park an
Antigravity (`agy`) contingency note. Don't over-invest in Gemini-CLI-specific glue that `agy` may not honor 1:1.
