---
card: card.gemini-cli
brand: Google — Gemini CLI
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-02
half_life: ~1-2 weeks (nightlies daily; stable ~weekly)
half_life_days: 14
recheck:
  - https://geminicli.com/docs/changelogs/
  - https://github.com/google-gemini/gemini-cli/releases
  - https://google-gemini.github.io/gemini-cli/ROADMAP.html
  - https://antigravity.google/docs/gcli-migration       # successor (CONFIRMED)
verify_cmd: gemini --version
auth_survival: paid Gemini API key OR enterprise license   # see VOLATILE
---

# Gemini CLI — native build surface

## ⚠ VOLATILE — read first (sunset + crash risk)

**Sunset (PAST — confirmed):**
- **2026-06-18:** Gemini CLI stopped serving requests for Google AI Pro, Ultra, and free personal
  Code-Assist login. No grace period. Already happened.
- **SURVIVES via paid Gemini / Gemini Enterprise Agent Platform API key, or enterprise Code Assist license.**
  ← imago's `selectedType: gemini-api-key` is on the surviving path.
- ACTION: confirm BOTH machines' `gemini` auth = API key (not personal Google login).

**Antigravity CLI transition (CONFIRMED — HIGH confidence):**
- Official Google Developers Blog post, May 19 2026 (Dmitry Lyalin + Taylor Mullen):
  Antigravity CLI available to all users as of May 2026.
- **What survives the migration:** Agent Skills, Hooks, Subagents, Extensions (as "Antigravity plugins").
  GEMINI.md survived; runtime did not.
- **Architecture change:** Go binary, closed-source, async/parallel agents, unified backend with Antigravity 2.0 desktop.
  Separate config tree: `~/.gemini/antigravity-cli/`. NOT 1:1 parity at launch.
- **Enterprise exception:** Standard/Enterprise license holders continue on Gemini CLI with full support + latest models.
- **Gemini CLI repo still active** (v0.49.0 published 2026-06-25; v0.45.0 last on official changelog page).
  Stable release cadence unclear past June 2026 — re-verify.
- ACTION: Park an `agy` contingency; don't over-invest in Gemini-CLI-specific glue that `agy` may not honor 1:1.

**Known crash bug — context overflow on model auto-switch (GitHub issue #8609, open):**
- Long session on large-context model (e.g., 1M-token) accumulates history → CLI auto-switches
  to smaller-context model → accumulated context exceeds new model's cap → API error.
  Documented case: input 8.1M tokens > 1M cap → unrecoverable.
- `/compress` recovery ALSO fails: attempts `maxOutputTokens = ~100K`; API max = 65,536.
  Session becomes completely stuck — no recovery path available in the CLI.
- **Mitigation:** run `/compress` manually as a checkpoint every ~20–30 turns in long sessions.
  Use `/chat save` → `/clear` → `/chat resume` for hard branching. Don't rely on auto-compaction.

## Config home
- User/global: `~/.gemini/`      → settings.json, agents/, commands/, extensions/, skills/, GEMINI.md
- Project:     `<repo>/.gemini/`  (same shapes); workspace config wins on conflict.

## Native primitives
1. **Subagent** (preview 🔬) — `<~/.gemini|.gemini>/agents/<name>.md`. YAML frontmatter + body = system prompt.
   - Tool WILDCARDS: `*` (all), `mcp_*` (all MCP), `mcp_<server>_*` (one server).
   - **Isolated context loop:** subagent's intermediate tool calls (file reads, greps) are purged from
     the main session history. Orchestrator receives only the concise return summary. Context-clean by design.
   - **Recursion guard:** subagents CANNOT spawn sub-subagents. Prevents token cascade; hard limit.
   - Manage via `/agents`. Registration: first-wins, project-prioritized.
   - External (headless) invocation: `gemini "@<name> <task>"` — `@name` prefix in the
     prompt selects the agent. Equivalent of `claude --agent <name> "task"`.
   - Interactive invocation: `gemini` → then `/agents` TUI to switch seat.
   - Dead: `gemini -a <name>` (removed). Tested/dead: `GEMINI_AGENT=<name>` (no effect).
   - **Built-in codebase investigator subagent** added (recent stable): explores workspace + resolves
     relevant context to improve overall performance; invoked automatically.
2. **Skill** — `skills/<name>/SKILL.md`  (SAME Agent Skills standard as Claude → portable).
3. **Custom command** — `commands/<name>.toml`  (TOML, not markdown) → `/name` or `/<ext>.name`.
   (`~/.gemini/commands/`, project `.gemini/commands/`.) Manage: `/commands`.
4. **Hook** — intercept/customize CLI behavior (supported in extensions).
5. **MCP** — `settings.json` `mcpServers{}` or `gemini mcp add|list|remove`. Per-server includeTools/excludeTools/trust, OAuth.
6. **Extension** (packaging unit) — `extensions/<name>/`: `gemini-extension.json` + GEMINI.md +
   commands/*.toml + skills/*/SKILL.md + agents/*.md + policies/*.toml. Use `${extensionPath}`.
7. **Policy Engine** — tiered `.toml` rules (extension rules = tier 2). Native replacement for hand-rolled param-allowlists.

## Session hygiene (see card.session-hygiene for full comparative analysis)
- **Without subagents:** every prompt + response appended to running context. No isolation. Context rot inevitable on long sessions.
- **With subagents (preview):** isolated context loop; main session receives summary only. Mirrors Claude Code's clean pattern.
- **Shell-spawned isolated sessions:** orchestrator writes task to file → fresh `gemini` process via shell. Full context reload per spawn (expensive), but hermetically isolated.
- **Crash risk:** see bug #8609 in VOLATILE above. Manual `/compress` checkpoints are the only current mitigation.

## Context file
- `GEMINI.md` is native; `contextFileName` is configurable → point at `AGENTS.md` for cross-tool parity.

## Native strengths (vs Claude Code)
- **Model routing / automatic fallback** built in (your model/scan/synth triad partly absorbed).
- Plan Mode (+ research subagents), checkpointing/rewind, session export/import, sandboxing, trusted folders,
  headless mode, A2A remote subagents. Gemini 3 default; Gemma 4 via API default.

## VOLATILE / watch
- Versions move daily (stable ~v0.49x as of 2026-06-25; changelog page lags behind releases — check GitHub).
- Subagents are PREVIEW → less stable than Claude's GA subagents. Recursion guard is a hard limit.
- **`--allowed-tools` CLI arg and `tools.allowed` in settings.json are deprecated** (removal at v1.0).
  Migrate to Policy Engine: https://geminicli.com/docs/core/policy-engine/
- **Antigravity CLI (`agy`)** is the confirmed successor — timeline for Gemini CLI end-of-life for enterprise not yet published.

## Recommendation for LARVA
Keep CLI alive via API key. Mirror the portable skills corpus (read from the shared dir).
Antigravity is confirmed — start a contingency note for `agy` migration. Don't over-invest in
Gemini-CLI-specific glue that `agy` may not honor 1:1. GEMINI.md and Skills are portable;
Extension/command TOML format is the most likely migration friction point.
