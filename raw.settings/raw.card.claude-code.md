---
card: card.claude-code
brand: Anthropic — Claude Code (CLI)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-02
half_life: ~2-4 weeks (ships ~10 versions/month)
half_life_days: 30
recheck:
  - https://code.claude.com/docs/en/changelog        # generated from repo CHANGELOG.md
  - https://github.com/anthropics/claude-code
  - https://code.claude.com/docs/en/claude-directory
verify_cmd: claude --version
model_floor: claude-opus-4.x   # CONFIRM current string via changelog; do NOT hardcode dated strings
---

# Claude Code — native build surface

## Config homes (NOT XDG)
- User/global: `~/.claude/`        → applies to all projects (personal config).
- Project:     `<repo>/.claude/`   → commit to git; shared with team.
- Relocate all: `CLAUDE_CONFIG_DIR=<path>` → every `~/.claude` path moves under it. ← my-env-sync lever.
- Binary: `~/.local/bin/claude` (XDG). Config is NOT — `~/.config/claude/...` is NOT read.

## The five native primitives
1. **Subagent** (identity / master prompt) — `<.claude|~/.claude>/agents/<name>.md`
   - YAML frontmatter: name, description, model, tools, color, optional hooks/memory. Body = system prompt.
   - Resolution precedence: session > project > user > plugin.
   - Invoked by the main agent via the Task tool; own context window; returns a summary.
   - `run_in_background: true`, `max_turns: N`. Manage via `/agents`.
2. **Skill** (on-demand expertise) — `<.claude|~/.claude>/skills/<name>/SKILL.md`  (Agent Skills open standard)
   - Slash commands MERGED into skills: `.claude/commands/x.md` and `skills/x/SKILL.md` both create `/x`.
   - Auto-loads when description matches, or invoked as `/x`.
3. **Hook** (determinism) — in `settings.json` under `hooks`. Shell command on a lifecycle event (model can't skip).
4. **MCP** (capability) — `<repo>/.mcp.json` (project) or `claude mcp add` (user/project/local scope).
5. **Plugin** (packaging unit for a complex build) — bundles all of the above:
   `.claude-plugin/plugin.json` + skills/ + agents/ + commands/ + hooks/hooks.json + .mcp.json + bin/ (on PATH) + settings.json + output-styles/
   - Local test: `claude --plugin-dir <path>` (no global install; accepts .zip). Distribute via marketplace.

## Settings hierarchy
`~/.claude/settings.json` (global) → `<repo>/.claude/settings.json` (team) → `settings.local.json` (personal, gitignored). Hooks + permissions live here.
Precedence (high→low): Managed → CLI args → Local → Project → User.

## MCP scope (`.mcp.json`)
All applicable scopes are **merged** at session start (additive, not override):

| Scope | File | Notes |
|-------|------|-------|
| Managed (org-wide) | `managed-mcp.json` (system dir) | highest trust |
| User (global) | `~/.claude.json` | all projects |
| Project (team) | `<repo>/.mcp.json` | **repo root** — NOT inside `.claude/`; commit to git |
| Local (per-project) | `~/.claude.json` per-project key | `claude mcp add --scope local`; not committed |

Scope perspective mirrors agents/settings: CWD at session start determines which project `.mcp.json` loads.
`CLAUDE_CONFIG_DIR` relocates `~/.claude/` paths but does NOT move `<repo>/.mcp.json` (repo-rooted) or `~/.claude.json` (user MCP store).

## Always-on context (the "circle" at invocation)
AGENTS.md / CLAUDE.md (always) → subagent body → skills (on-demand) → MCP → hooks.
- CLAUDE.md merge: `~/.claude/CLAUDE.md` + `<repo>/CLAUDE.md` + subdir + `.claude/CLAUDE.md`.
- **AGENTS.md read as fallback** when no CLAUDE.md in a dir → one lean AGENTS.md = cross-tool contract; keep CLAUDE.md thin.
- Budget: ~150-200 instructions reliably followed; system prompt uses ~50 → keep contract < ~300 lines.
- **CLAUDE.md cap:** 200 lines per-file (soft, adherence degrades — no hard truncation). All files concatenate; cumulative load degrades proportionally. Official mitigation: `.claude/rules/<name>.md` with `paths:` frontmatter to load rules only when matching files are accessed.
- **MEMORY.md cap (different system):** hard 200-line / 25KB truncation — content beyond that is NOT loaded. Do not conflate with CLAUDE.md. *(source: code.claude.com/docs/en/memory, verified 2026-07-02)*

## Context loading by scope — agent perspective

**Invariant:** CLAUDE.md/settings.json/.mcp.json loading is **CWD-based, not agent-file-location-based.**
The agent receives whatever context stack was assembled from the working directory at session start.

| Scenario | Agent loads? | CLAUDE.md received | Settings / MCP |
|----------|-------------|-------------------|----------------|
| Global agent (`~/.claude/agents/`) in project folder | Yes — priority 4 | global + project stack | global + project (project overrides) |
| Project agent invoked **outside** its project folder | **No** — not scanned | — | — |
| Project agent in its own project folder | Yes — priority 3, wins over same-name global twin | global + project stack | global + project |

**Exception:** `--agents <JSON>` CLI flag injects any agent spec regardless of CWD (priority 2).
Context received = CWD stack at invocation — NOT the agent's original project.

*Synthesizing agents: read this section when reasoning about what context a subagent actually received,
or why an agent behaved as if it didn't know its home project's rules.*

## Hooks — 30 events (updated 2026-06-10); the ones you'll use
PostToolUse(Edit|Write)=format/lint · PreToolUse(Bash)=deny rm -rf/sudo · PreToolUse(Edit|Write)=scope-leash ·
SessionStart=inject context · SessionEnd=journal · UserPromptSubmit=enrich prompt · Stop/StopFailure=gate "done" ·
SubagentStart/Stop · TeammateIdle=lifecycle · PreCompact=backup transcript · PostCompact · PermissionRequest=auto-approve ·
Notification=Slack · TaskCreated/TaskCompleted · WorktreeCreate/WorktreeRemove · MessageDisplay ·
PostToolBatch · PostToolUseFailure · UserPromptExpansion · InstructionsLoaded · ConfigChange ·
CwdChanged · FileChanged · PermissionDenied · Elicitation/ElicitationResult · Setup · StopFailure.

Exit 0 = proceed; exit 2 = block. stdout injected as context only for UserPromptSubmit / UserPromptExpansion / SessionStart.

**Handler types (5):** `command` · `http` · `mcp_tool` · `prompt` · `agent` (experimental — spawns subagent as hook handler).

**BREAKING (v2.1.139):** `/dev/tty` no longer accessible from command hooks on macOS/Linux.
Use `terminalSequence` field instead (requires v2.1.141+).

**New env var in hooks:** `CLAUDE_EFFORT` — exposes current effort level to hook scripts.

## VOLATILE / watch
- Model strings rotate (Opus 4.x line). Never hardcode dated strings in agents; set a floor, verify via changelog.
- Moving fast: Agent Teams, dynamic workflows, background sessions (Ctrl+T pin), `--fallback-model`.
- Also in `~/.claude`: rules, workflows, auto-memory — exist, not yet load-bearing here; inspect before relying.

## Rate caps & fallback strategy (2026-06-10)

**Current status:** Good rate — ceiling not a day-to-day constraint. Token spend
can be used aggressively for big-brain tasks.

**Model tier as of 2026-06-10:**
Fable 5 (`claude-fable-5` / alias `"fable"`) > Opus 4.8 > Sonnet 4.6 > Haiku 4.5.

**Fallback ladder when Fable ceiling is hit:**
- Houston (planning loops) → route to Janus (Opus)
- Agol (continuous synthesis) → route to Janus (Opus)
- Janus (deliberation) → already Opus; no lower fallback needed
- Epoch (research) → stays Sonnet; not Fable-tier
- Trajectory (implementation) → stays Sonnet; not Fable-tier

**Practical rule:** same agent body, lower model tier. The agent's prompt does not
change when falling back — only the `model:` override changes at spawn time.

**Tokenizer note (from Opus 4.7+):** same text produces ~30% more tokens vs
pre-4.7 models. Recalibrate any hardcoded token budgets in prompts.

**`fallbackModel` setting** (`["sonnet", "haiku"]`) handles model *unavailability*,
not rate limits — these are separate concerns. Rate-limit fallback is operational
routing, not a settings.json field.

**advisorModel alias:** `"fable"` works from Claude Code v2.1.170+. Use full ID
`claude-fable-5` on older installs.

## Recommendation for LARVA
Thin agent shells; specialization in portable skills; model floor in ONE place per agent; pack a project
bundle (FO, freya) as a plugin only once stable. Sync `~/.claude` via CLAUDE_CONFIG_DIR → my-env-sync.
