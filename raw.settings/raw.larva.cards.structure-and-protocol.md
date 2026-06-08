---
card: larva.cards.structure-and-protocol
kind: index + folder-structure recommendation + RELATIVE-card protocol
verified: 2026-06-02
covers: claude-code, gemini-cli, cursor-ide, claude-ai, gemini-gems
---

# LARVA v3 — brand cards: structure & protocol

## 1. What these cards are
Per-brand knowledge cards (`card.*`), one per surface, deliberately SPLIT (not one
distillate) so a RAG refresh agent can re-verify and rewrite each independently.
They are **RELATIVE**: volatile, decaying, refreshed by the recalibration researcher.

## 2. The RELATIVE-card protocol (how RAG treats them)
Every card carries a header:
- `verified:`   last date checked against reality.
- `half_life:`  rough decay window (Gemini CLI ~1-2 wk; others ~weeks).
- `recheck:`    canonical sources to re-verify from.
- `verify_cmd:` local truth check where one exists.

Rule for the RAG/refresh layer: confidence decays with (now − verified) / half_life.
Past one half-life with no refresh → mark low-confidence; do NOT let @Foreman emit
from a stale card without a re-check.

## 3. The self-refreshing triangle (the through-line)
- **Cards = mutable memory.**            (card.*)
- **Researcher = perception** — refreshes the cards.   (researcher.recalibration)
- **Foreman = action** — builds FROM the cards, never from model memory.  (Foreman.ai.agent-builder)

Closed loop: researcher → updates cards → Foreman reads cards → correct builds.
The researcher is also the manifesto's missing C→A elevator: a tool-level change
(Phase C fact) can climb back up to invalidate an architecture (B) or a dream (A).

## 4. Non-interfering folder structure (native per brand)
Brand homes never collide — each tool reads only its own home.

$HOME  (sync via `CLAUDE_CONFIG_DIR` → my-env-sync):
  ~/.claude/        agents/  skills/  commands/  settings.json  CLAUDE.md
  ~/.gemini/        settings.json  agents/  commands/*.toml  extensions/  skills/  GEMINI.md
  ~/.cursor/        mcp.json
  ~/.local/bin/     claude                 # binaries (XDG-respecting)

<project>/  (per OVUM — FO, freya, …):
  AGENTS.md                 # ONE lean cross-tool contract (all three read it)
  CLAUDE.md   GEMINI.md     # thin → point at AGENTS.md
  .claude/    agents/ skills/ settings.json .mcp.json
  .gemini/    commands/ skills/ extensions/
  .cursor/    rules/*.mdc  mcp.json

LARVA data  (NOT in brand homes — keeps them clean/native):
  ~/www/larva/      manuals, registries, CANONICAL cards
  ~/www/session/    briefs, _recalibration/<date>.md, scratch

## 5. The shared portable layer (the anti-bloat core)
- `SKILL.md` (Agent Skills open standard) + `AGENTS.md` are read by Claude Code,
  Gemini CLI, AND Cursor.
- Author skills ONCE under `~/.claude/skills/` (synced); Cursor reads them directly;
  Gemini references them via extension / contextFileName. One source, three consumers.
- Regimes (crtv / arch / krpth / hnst / mii) are SKILLS, invoked — never always-on JSON.

## 6. Master commands + the "invocation circle" — where, per brand
What loads when an agent is invoked (read order):
  AGENTS.md (always) → agent body (master prompt) → skills (on-demand by description)
  → MCP (capability) → hooks (deterministic guards)

- Claude Code: `claude --agent <name>`   · user commands `~/.claude/commands/*.md`
- Gemini CLI:  `gemini -a <name>`         · user commands `~/.gemini/commands/*.toml`
- Cursor:      open project · rules by activation mode · reads `~/.claude/{skills,agents}`

## 7. Secrets (load-bearing for sync)
Never inline keys. Export from `secrets.zsh` (`GEMINI_API_KEY`,
`GITHUB_PERSONAL_ACCESS_TOKEN`); reference as `${VAR}`. Ensure my-env-sync `.gitignore`
excludes credential files BEFORE syncing brand homes.

## 8. Card set
card.claude-code · card.gemini-cli · card.cursor-ide · card.claude-ai · card.gemini-gems
Builder: Foreman.ai.agent-builder · Researcher: researcher.recalibration
