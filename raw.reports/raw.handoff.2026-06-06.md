---
kind: session-handoff
date: 2026-06-06
topic: autonomous orchestrator — Houston / CapCom
status: card written, agents NOT yet on disk
---

## What was done this session

1. **Explored the orchestration gap** — `claude-creator-auto` references Houston and CapCom
   as orchestrators but neither agent exists yet on disk.

2. **Wrote the raw.card** →
   `/home/hruzam/reposoma/raw.settings/raw.card.autonomous-orchestrator.md`
   - Full Houston + CapCom frontmatter + system prompt bodies
   - Goal skill definition (`~/.claude/skills/goal/SKILL.md`)
   - Guard hook (`~/.claude/hooks/guard-destructive.sh`)
   - settings.json regime hooks (session-level PermissionRequest + Stop)
   - Invocation patterns + known harness constraints
   - Format matches existing raw.cards (card: / kind: / verified: / recheck:)

## What is NOT done yet

- Houston agent not written to `~/.claude/agents/houston.md`
- CapCom agent not written to `~/.claude/agents/capcom.md`
- Goal skill not written to `~/.claude/skills/goal/SKILL.md`
- Guard hook not written / not chmod +x
- settings.json regime hooks not added
- User's intent: these should be emitted by `claude-creator-auto` using the raw.card
  as its injection context — NOT hand-written by assistant directly

## User's stated intent

The raw.card is the input substrate for their builder system. `claude-creator-auto`
(or a future Houston run) will consume the card and emit the actual agent files.
The assistant should NOT write the agent files directly — wait for the user to
trigger the build pipeline.

## Next session entry point

Resume with: "build Houston and CapCom from the raw.card using claude-creator-auto"
Or: discuss whether the goal skill and guard hook should be written manually first
as bootstrapping prerequisites (since Houston needs them to run autonomously).
