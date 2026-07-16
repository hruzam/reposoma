---
card: card.cursor-ide
brand: Cursor (IDE; runs Claude / GPT / etc. models)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-16
half_life: ~2-3 weeks (Cursor 3 line; moving fast)
half_life_days: 21
recheck:
  - https://www.cursor.com/changelog
  - https://releasebot.io/updates/cursor
  - https://forum.cursor.com        # feature reality vs docs
---

# Cursor IDE — native build surface

## Config homes
- Project rules: `<repo>/.cursor/rules/*.mdc`
- Global MCP:    `~/.cursor/mcp.json`   ; project MCP: `<repo>/.cursor/mcp.json`
- Cross-tool contract: `<repo>/AGENTS.md` (read as fallback)
- Legacy single file `.cursorrules` still works (avoid for new work).
- **Customize page** (v3.9 Jun 22): consolidated view for plugins, skills, MCPs, and subagents. Marketplace leaderboard for popular integrations.

## Native primitives
1. **Rule** (`.mdc` = markdown + YAML frontmatter) — FOUR activation modes:
   - `alwaysApply: true`   → every request (keep < ~200 words; it's a token tax).
   - `globs: src/**`       → auto-attaches when matching files are touched.
   - `description: "..."`  → agent pulls it in when relevant (Agent-Requested).
   - no frontmatter        → manual `@rule-name`.
   - ← glob/description modes are the NATIVE scope-leash for an over-reaching agent:
     bind tight scopes to file globs instead of fighting it in prose.
2. **Sub-agents / Custom Modes** (Cursor 3) — IDE-bound agent profiles.
   - **Cloud Subagents** (`/in-cloud`): spawn in isolated VMs for long-running or
     parallel work (fix CI, investigate issues). Local workspace stays clean — the isolated
     VM is the context boundary. Configured via `.cursor/environment.json` (reusable snapshots).
3. **Agent Skills** — `SKILL.md` (same open standard).
4. **Cursor Hooks** (Cursor 3) — lifecycle interception. v3.11 added 5 new cloud agent hook events
   (observe conversation elements: prompts, responses, thinking).
5. **Background / Cloud Agents + BugBot** — async long-running work; cloud agents triggerable via
   GitHub (5 trigger types: issue comments, PR review comments, PR review submissions, review thread
   updates, workflow completions) and Slack emoji-reactions (v3.8+).
   `/automate` skill creates automations in plain language from within an agent session (v3.8).
   **BugBot improved (July 2026):** 3x faster, 22% cheaper, finds 10% more bugs per review; 90% of runs complete in under 3 minutes.

## CROSS-ECOSYSTEM (key)
- Cursor can LOAD skills/agents placed under `~/.claude/{skills,agents}` → your shared
  Claude skills corpus is consumed by Cursor directly. One source, three consumers.
- **Team MCPs (v3.10, Jun 30):** admins configure MCP servers once, distribute across cloud agents, IDE, and CLI.
  Team marketplaces now support org groups alongside SCIM directory groups.

## Surfaces
- Tab (autocomplete) · Cmd+K (inline edit) · Chat · Composer/Agent (the loop: reads files, edits, runs terminal, loops).
- **Cloud Agents** — `/in-cloud` for isolated VM execution.
- **Side Chats (v3.11, Jul 10):** open parallel agent conversations via `/side`, `/btw`, or the plus button.
  Each side chat is a full agent session (reads files, runs commands, edits) but stays separate from the main thread.
  Durable — threads persist alongside the main conversation.
- **Agent Transcript Search (v3.11):** search across agent transcripts via Cmd+K in Agents Window; Cmd+F within a single conversation.
- **iOS app (Public Beta v3.9, Jun 29, paid plans):** full agent launching, voice input, remote session control (Remote Control),
  PR management from mobile. Live Activities and push notifications for agent status. Cloud agents directed from phone.

## Context window — session hygiene (see card.session-hygiene for full analysis)
- Effective available window = **< 50% of advertised** (system prompt + codebase index + history + auto-included files eat the rest; Cursor does not publish breakdown).
- By the 50th tool call, conversation history alone can exceed 150K tokens — re-sent every turn.
- Mode switch (Cmd+. / Ctrl+.) = **fresh context window** (confirmed). Continuity lost; cost resets. Hard boundary, not a handoff.
- Real-world: same workflow = 12% daily usage cap in Claude Code vs **80% in Cursor** (InfoQ, Apr 2026).
- MAX mode: removes context truncation + raises tool-call cap to 200. Pricing by plan: Individual = model API rate (no surcharge); Teams = model API rate + $0.25/M Cursor Token Rate on non-Auto requests; legacy = model API rate + 20% surcharge. Does NOT change per-turn accumulation.

## CAVEAT / watch
- Binding a specific `.mdc` to ONE custom mode is weak — `alwaysApply` rules apply across modes.
  Don't treat Cursor modes as fully isolated agents.
- Local models (Ollama/LM Studio) possible but materially weaker on multi-file Composer work; cloud is the real path.
- Context mechanics (how Cursor constructs the window per turn) are NOT fully documented publicly. The numbers above are practitioner-measured — treat as approximate.
- **Computer use tool** enabled by default for automations (v3.8).

## Recommendation for LARVA (freya/fo studio)
Author the FO/freya rule-set as scoped `.mdc` (globs per layer) + a lean AGENTS.md. For the existing
frontend → a "know-your-code" indexing pass (@Codebase) before agent edits. Reuse the shared
`~/.claude/skills` corpus rather than duplicating. For long agentic tasks: prefer `/in-cloud`
(isolated VM) over long Composer sessions to avoid context accumulation.
Side Chats (v3.11) are now the preferred pattern for parallel investigation threads — use instead of
spawning multiple full Composer sessions.
