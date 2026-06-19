---
card: card.cursor-ide
brand: Cursor (IDE; runs Claude / GPT / etc. models)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-02
half_life: ~weeks (Cursor 3 line)
half_life_days: 30
recheck:
  - https://docs.cursor.com
  - https://www.cursor.com/changelog
  - https://forum.cursor.com        # feature reality vs docs
---

# Cursor IDE — native build surface

## Config homes
- Project rules: `<repo>/.cursor/rules/*.mdc`
- Global MCP:    `~/.cursor/mcp.json`   ; project MCP: `<repo>/.cursor/mcp.json`
- Cross-tool contract: `<repo>/AGENTS.md` (read as fallback)
- Legacy single file `.cursorrules` still works (avoid for new work).

## Native primitives
1. **Rule** (`.mdc` = markdown + YAML frontmatter) — FOUR activation modes:
   - `alwaysApply: true`   → every request (keep < ~200 words; it's a token tax).
   - `globs: src/**`       → auto-attaches when matching files are touched.
   - `description: "..."`  → agent pulls it in when relevant (Agent-Requested).
   - no frontmatter        → manual `@rule-name`.
   - ← glob/description modes are the NATIVE scope-leash for an over-reaching agent:
     bind tight scopes to file globs instead of fighting it in prose.
2. **Sub-agents / Custom Modes** (Cursor 3) — IDE-bound agent profiles.
3. **Agent Skills** — `SKILL.md` (same open standard).
4. **Cursor Hooks** (Cursor 3) — lifecycle interception.
5. **Background Agents** (cloud) + **BugBot** — async long-running work.

## CROSS-ECOSYSTEM (key)
- Cursor can LOAD skills/agents placed under `~/.claude/{skills,agents}` → your shared
  Claude skills corpus is consumed by Cursor directly. One source, three consumers.

## Surfaces
- Tab (autocomplete) · Cmd+K (inline edit) · Chat · Composer/Agent (the loop: reads files, edits, runs terminal, loops).

## CAVEAT / watch
- Binding a specific `.mdc` to ONE custom mode is weak — `alwaysApply` rules apply across modes.
  Don't treat Cursor modes as fully isolated agents.
- Local models (Ollama/LM Studio) possible but materially weaker on multi-file Composer work; cloud is the real path.

## Recommendation for LARVA (freya/fo studio)
Author the FO/freya rule-set as scoped `.mdc` (globs per layer) + a lean AGENTS.md. For the existing
frontend → a "know-your-code" indexing pass (@Codebase) before agent edits. Reuse the shared
`~/.claude/skills` corpus rather than duplicating.
