---
kind: cold-start-card
date: 2026-09-16
brand: claude
seat: atlas-ui
project: reposoma
root: ~/reposoma
commit: 7ae9e56 (core)
task: Ptyra 3-regime consolidation + journal CLI hand + meeting GUIDE playground; next = Codex journal fold via flatter subagent + run meeting scenario 02
resume: claude --agent atlas-ui
model: sonnet
dedicated: atlas-ui (Claude-side follow-ups); Cartan for the Codex journal-fold spawn (cross-runtime)
recommend: Fold the Codex journal via an EPHEMERAL default subagent pointed at the shared skill.journal.md — do NOT build a persistent Codex agent (Codex identity is ephemeral-first; see the Cartan pointer).
pointers:
  - ~/reposoma/pulse.atlas.md
  - ~/reposoma/raw.guides/meeting/GUIDE.md
  - ~/reposoma/raw.vendor-neutral-agents/ptyra/README.md
  - ~/reposoma/.majkee/journal/2026-09-16.md
  - ~/reposoma/raw.guides/sella/raw/codex-spawns-temporary-helperFile.ByMajkeeCartan.md
---

# CS · ptyra + meeting playground (2026-09-16)

Session closed clean, no live gate/STATUS bed — this card carries its own next-action queue.

## Done today (Claude-side)
- **Ptyra** → single source of truth `raw.vendor-neutral-agents/ptyra/` (PTYRA.md, PTYRA.knowledge.md,
  skill.stenograph.md, skill.journal.md, README). Duplicates removed (chatGPT-agents, a nablarva
  session copy, top-level PTYRA.md).
- **JOURNAL regime (C)** added to the Claude.ai Ptyra-AC master prompt (dispatcher + A/B/C split files).
- **`@ptyra-ac-journal`** (Haiku, `.claude/agents/`) — the CLI journal hand; verbs `fold` / `pending`;
  writes only inside `~/reposoma/.majkee/journal/`. `.majkee/jornal` → `journal` (typo fixed).
- **Meeting** graduated flat file → GUIDE bed `raw.guides/meeting/` (served by `/guide meeting`).
  Protocol v2 (chair-hand-off binding + echo rule; collision parked) + briefing contract + diagnostics.
  Vacuole (`src/`) stocked: recipe template + 6 scenarios (01 capture [blocked: needs 2nd device],
  02 untested, 03 chair-blind, 04 side-swap, 05 context-parity, 06 ground-truth).

## Pending (order matters)
1. **Commit** scenarios 03–06 + shelf update + this card (uncommitted on `core`).
2. **Run meeting scenario 02 ("untested?")** — runnable on the current two-voice setup; probes premature
   convergence (the format's primary risk).
3. **Codex journal fold — the flatter-subagent approach** (see `recommend:` + the Cartan pointer):
   spawn a Codex `default` subagent, `fork_turns: none`, model Luna/Terra medium; instruct the CHILD to
   *read `~/reposoma/raw.vendor-neutral-agents/ptyra/skill.journal.md` in full and follow it*, then fold
   an artifact into `~/reposoma/.majkee/journal/<day>.md`, append-only. **No persistent Codex agent** —
   catalog presence ≠ activation; the skill must be named in the child's task. Harden into a cataloged
   Codex `SKILL.md` only if the ad-hoc read proves flaky.
4. **Unblock scenario 01 (capture/scribe)** once the special stenographer device is added → then it seats
   Ptyra REGIME B · STENOGRAM as a silent scribe and turns "who won" from impression into measurement.
5. Optional: **@Epoch** check on Claude.ai custom-skill upload gates.

## One lesson
Codex identity ≠ Claude identity. Claude side = **persistent named subagent** (`@ptyra-ac-journal`).
Codex side = **ephemeral in-conversation spawn**; name the skill in the child's task + tell it to read the
full SKILL.md. Model / role / skill are independent choices. Single source of truth (`skill.journal.md`)
serves both — edit the source, never a rendering.
