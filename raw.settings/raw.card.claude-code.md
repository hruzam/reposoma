---
card: card.claude-code
brand: Anthropic — Claude Code (CLI)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-02
half_life: ~2-4 weeks (ships ~10 versions/month)
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

## Always-on context (the "circle" at invocation)
AGENTS.md / CLAUDE.md (always) → subagent body → skills (on-demand) → MCP → hooks.
- CLAUDE.md merge: `~/.claude/CLAUDE.md` + `<repo>/CLAUDE.md` + subdir + `.claude/CLAUDE.md`.
- **AGENTS.md read as fallback** when no CLAUDE.md in a dir → one lean AGENTS.md = cross-tool contract; keep CLAUDE.md thin.
- Budget: ~150-200 instructions reliably followed; system prompt uses ~50 → keep contract < ~300 lines.

## Hooks — 17 events total; the ones you'll use
PostToolUse(Edit|Write)=format/lint · PreToolUse(Bash)=deny rm -rf/sudo · PreToolUse(Edit|Write)=scope-leash ·
SessionStart=inject context · SessionEnd=journal · UserPromptSubmit=enrich prompt · Stop/StopFailure=gate "done" ·
SubagentStart/Stop·TeammateIdle=lifecycle · PreCompact=backup transcript · PermissionRequest=auto-approve safelist · Notification=Slack.
Exit 0 = proceed; exit 2 = block. stdout injected as context only for UserPromptSubmit / UserPromptExpansion / SessionStart.

## VOLATILE / watch
- Model strings rotate (Opus 4.x line). Never hardcode dated strings in agents; set a floor, verify via changelog.
- Moving fast: Agent Teams, dynamic workflows, background sessions (Ctrl+T pin), `--fallback-model`.
- Also in `~/.claude`: rules, workflows, auto-memory — exist, not yet load-bearing here; inspect before relying.

## Recommendation for LARVA
Thin agent shells; specialization in portable skills; model floor in ONE place per agent; pack a project
bundle (FO, freya) as a plugin only once stable. Sync `~/.claude` via CLAUDE_CONFIG_DIR → my-env-sync.
