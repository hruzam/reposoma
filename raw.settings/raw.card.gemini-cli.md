---
card: card.gemini-cli
brand: Google — Gemini CLI
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~1-2 weeks (nightlies daily; stable ~weekly) — line is PARKED, consider longer (see refresh delta)
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

## Refresh delta 2026-09-02
- **Stable release moved: v0.58.0 (2026-09-01)**, nightlies at v0.59.0 track (e.g.
  v0.59.0-nightly.20260902). Source: github.com/google-gemini/gemini-cli/releases. CONFIDENCE: H.
- **Local `gemini --version` (office, 2026-09-02) = 0.56.0** — two minor versions behind GitHub
  stable (0.58.0). Repo is still actively released; local install just hasn't pulled latest.
  CONFIDENCE: H (local truth given).
- **Antigravity CLI migration is COMPLETE for individual/free/Pro/Ultra users** — the June 18
  2026 cutoff has passed, confirmed no grace period, confirmed by google blog + multiple
  independent trackers. CONFIDENCE: H.
  Source: developers.googleblog.com/an-important-update-transitioning-gemini-cli-to-antigravity-cli/
- **Enterprise exception still holds**: Gemini Code Assist Standard/Enterprise license holders
  continue on Gemini CLI "indefinitely" with full support + latest models — no published
  end-of-life date found. CONFIDENCE: H.
- **No 1:1 feature parity confirmed still true** as of this pass — same caveat as prior card.
  CONFIDENCE: M (independent trackers, not primary Google doc).
- Crash bug #8609 (context-overflow on auto-switch) and the CLI stability matrix below were NOT
  re-verified this pass (line parked, proportionate-effort scope) — treat as inferred-stale,
  re-run stability triage if the CLI line becomes active again. CONFIDENCE: L (carried forward).

## ⚠ VOLATILE — read first (sunset + crash risk)

**Sunset (PAST — confirmed):**
- **2026-06-18:** Gemini CLI stopped serving requests for Google AI Pro, Ultra, and free personal
  Code-Assist login. No grace period. Already happened. Re-confirmed 2026-09-02.
- **SURVIVES via paid Gemini / Gemini Enterprise Agent Platform API key, or enterprise Code Assist license.**
  ← imago's `selectedType: gemini-api-key` is on the surviving path.
- ACTION: confirm BOTH machines' `gemini` auth = API key (not personal Google login).

**Antigravity CLI transition (CONFIRMED — HIGH confidence, migration now COMPLETE for non-enterprise):**
- Antigravity CLI is the primary platform for non-enterprise users as of this pass (2026-09-02).
- **What survives the migration:** Agent Skills, Hooks, Subagents, Extensions (as "Antigravity plugins").
  GEMINI.md survived; runtime did not.
- **Architecture change:** Go binary, closed-source, async/parallel agents, unified backend with Antigravity 2.0 desktop.
  Separate config tree: `~/.gemini/antigravity-cli/`. Still NOT 1:1 parity.
- **Enterprise exception:** Standard/Enterprise license holders continue on Gemini CLI with full support + latest models — no end-of-life date published for this track.
- **Gemini CLI repo still active**: stable v0.58.0 published 2026-09-01; nightly cadence continuing daily (v0.59.0 track).
- ACTION: Park an `agy` contingency; don't over-invest in Gemini-CLI-specific glue that `agy` may not honor 1:1.

**Known crash bug — context overflow on model auto-switch (GitHub issue #8609, status not re-checked this pass):**
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
- **Crash risk:** see bug #8609 in VOLATILE above. Manual `/compress` checkpoints are the only current mitigation (not re-tested this pass).

## Context file
- `GEMINI.md` is native; `contextFileName` is configurable → point at `AGENTS.md` for cross-tool parity.

## Native strengths (vs Claude Code)
- **Model routing / automatic fallback** built in (your model/scan/synth triad partly absorbed).
- Plan Mode (+ research subagents), checkpointing/rewind, session export/import, sandboxing, trusted folders,
  headless mode, A2A remote subagents. Gemini 3 default; Gemma 4 via API default.

## VOLATILE / watch
- Versions move daily (stable v0.58.0 as of 2026-09-01; nightly v0.59.0 track — check GitHub for latest).
- Subagents are PREVIEW → less stable than Claude's GA subagents. Recursion guard is a hard limit.
- **`--allowed-tools` CLI arg and `tools.allowed` in settings.json are deprecated** (removal at v1.0).
  Migrate to Policy Engine: https://geminicli.com/docs/core/policy-engine/
- **Antigravity CLI (`agy`)** is the confirmed successor and now the primary non-enterprise platform;
  enterprise end-of-life for Gemini CLI still not published.

## CLI stability matrix (carried forward from 2026-07-03 triage — NOT re-verified this pass)

Based on: triage.gemini-hang.2026-07-03.md + handoff.gemini-rebuild.addendum-hang.2026-07-03.md + report.gemini-fix-pass.2026-07-03.md.

| Use case | Safe? | Notes |
|---|---|---|
| Interactive UI session (short) | ✓ | < 20 turns, manual /compress |
| Interactive UI session (long) | ⚠ | Bug #8609: crash past ~50 turns |
| Headless one-shot (CLI -p < /dev/null) | ✓ | Stable; stdin regression fixed v0.49.0 (issue #6715) |
| Headless one-shot (REST API) | ✓✓ | Preferred — no TTY, no noise, no MCP init |
| Automated loop / agentic CLI | ⚠ | Token bloat, 503 cascade risk, 10-min agentic timeout |
| @agent in prompt (any scripted mode) | ✗ | Agentic loop — confirmed hang Class C (90s+, triage 2026-07-03); NEVER in scripts |
| Gemini 2.5-flash | ✓ | Recommended for CLI automation and headless scripts |
| Gemini 2.5-pro | ✓ | Recommended for thinking/advisor; accept auto-downgrade risk under load |
| gemini-3.5-flash (REST) | ✓ | HTTP 200 confirmed 2026-07-03; REST probe via key enumeration |
| gemini-3.5-flash (CLI agentic) | ⚠ | Agentic-first design; prefer REST for scripted use |
| Gemini 3.x other (CLI) | ⚠ | CLI instability reported 2026-06-27; agentic-first, timeout/silent-fallback risk |

Confirmed hang classes (empirical triage 2026-07-03, gemini v0.49.0):
- Class C (primary): `@agent` in prompt → agentic loop even with -p and < /dev/null; 90s timeout confirmed
- Class B: positional arg in $() without -p → immediate hang
- Class A (stdin blocking): fixed in v0.49.0 (< /dev/null still required as regression insurance)
- Class D (latent): curl without --max-time → network stall hangs indefinitely

Note on Gemini 3.x: matrix above references gemini-3.5-flash, which per card.gemini-models is
now the "legacy" Flash in the 3.x line (3.6/3.7-flash have since shipped) — re-run stability
triage if the CLI line becomes active again; do not assume 3.6/3.7-flash inherit the same
✓/⚠ marks untested.

Recommendation: REST-primary for all headless/scripted use. For any CLI invocation in scripts:
`timeout 180 gemini -p "..." < /dev/null`. Never use @agent-in-prompt in scripted paths.

## Recommendation for LARVA
Keep CLI alive via API key. Mirror the portable skills corpus (read from the shared dir).
Antigravity is confirmed AND now the primary track for non-enterprise use — treat `agy`
contingency as active, not speculative. GEMINI.md and Skills are portable;
Extension/command TOML format is the most likely migration friction point.
</content>
