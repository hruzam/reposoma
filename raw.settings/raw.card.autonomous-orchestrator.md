---
card: card.autonomous-orchestrator
brand: LARVA — Houston / CapCom (autonomous orchestration layer)
kind: knowledge-card · RELATIVE (build-time reference for claude-creator-auto)
verified: 2026-10-08
half_life: ~months (harness-coupled; recheck when hooks or permissionMode API changes)
half_life_days: 60
recheck:
  - raw.card.claude-code.md          # hooks event list, permissionMode values
  - raw.claude-agents.harness.*.md   # frontmatter schema
surface_type: Claude Code agent (filesystem + subagent spawning + hooks)
---

## Refresh delta 2026-10-08

_Checked by @Epoch against `~/.claude/agents/houston.md` + `capcom.md` (runtime truth), `raw.card.claude-code.md` (refreshed today) and the live hooks docs. **This card is a build-time DESIGN TEMPLATE for an autonomous orchestrator pair. The runtime Houston/CapCom have diverged from it (on purpose or by drift). The template blocks below were NOT rewritten** — read this block for what runtime is._

- **Houston, runtime (houston.md, H):** architect / phase-planner, not an autonomous goal runner. `model: opus`, `effort: high`, `maxTurns: 50` (template: 100), `permissionMode: bypassPermissions`, tools `Read, Grep, Glob, Write, Agent` (template adds Bash + Edit; runtime description: "Does not run shell or write application code"), `color: orange` (template: red), NO `memory:` line (template: `memory: user`), same Stop log hook + `guard-destructive.sh` PreToolUse(Bash) (inert in practice — Houston has no Bash tool), `initialPrompt: "Run /goal. If no goal is set, read the project's locked decisions and session plan (flag.md, session/plan/session.plan.md), establish current state, then wait for instructions."` (template: `"/goal"`).
- **CapCom, runtime (capcom.md, H):** `model: haiku` (template: sonnet), `effort: low` (template: medium), `maxTurns: 20`, `permissionMode: acceptEdits`, tools `Read, Write, Agent`, `color: cyan` (template: orange), no `memory:` and no `initialPrompt` (the loop lives in the body).
- **⚠ Open conflicts for the operator — NOT edited:** (1) decision 0006 A1 and `temple/roster.md` record CapCom as Sonnet·low, but `capcom.md` says haiku (agent files are runtime truth per the user's rule; the ledger disagrees). (2) `capcom.md` step 4 spawns `subagent_type: "houston-devstudio-architect"`, which is NOT in the current agent list (only `houston` is) — the spawn would fail or hit a stale name. (3) Both agent files still read `~/.claude/houston.goal`; per Field's audit of `temple/roster.md` (not re-read by Epoch) the global goal file was retired 2026-06-17 in favour of per-project goals.
- **Harness facts changed since 2026-06-06 (live docs, H):** subagents CAN nest — default **3 levels** since v2.1.219 (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`), so "Subagents cannot spawn subagents" in §Known constraints is stale; 20 concurrent subagents cap. Hook exit codes: 0 success, 2 blocking, **any other code incl. 1 is non-blocking and the action proceeds** — so "exit 1 = error (treated as allow)" below still holds. NEW since v2.1.288: a PreToolUse/PermissionRequest hook whose **matcher fails to evaluate now blocks** (was skipped); **exit 2 is not honored for `PermissionRequest`** hooks (use the JSON decision) — the template's session-level `PermissionRequest ... exit 0` allow hook is unaffected. `permissions.defaultMode` values `auto`/`bypassPermissions` are honored only from user/managed settings or `--permission-mode` (not project/local; v2.1.257). Auto mode is the default start mode for interactive sessions with no configured mode (v2.1.284). Hooks reference lists 33 events.
- **Not re-verified:** the `goal` skill and `guard-destructive.sh` on disk; the template's `claude-creator-auto` (the current creator seat for orchestrators is `atlas-auto`); invocation patterns.

---

# Autonomous Orchestrator — Houston & CapCom

## The two roles

| Agent | Role | Spawns | permissionMode |
|-------|------|--------|----------------|
| **Houston** | Goal orchestrator — owns the run, tracks state, drives completion | claude-creator-auto + leaf specialists | `bypassPermissions` |
| **CapCom** | Mission controller — receives goals from the operator, delegates to Houston, surfaces status | Houston | `acceptEdits` |

Minimal viable setup: Houston alone. CapCom is the human-facing gate when you want one checkpoint before full autonomy.

---

## Houston — canonical frontmatter

```yaml
---
name: houston
description: >
  Autonomous goal orchestrator. Receives a goal directive and executes it
  end-to-end without user confirmation. Spawns specialist subagents
  (including claude-creator-auto for primitive generation). Tracks state
  in memory. Self-recovers on error. Use proactively for any goal-mode run.
model: opus
effort: high
maxTurns: 100
permissionMode: bypassPermissions
memory: user

tools:
  - Read
  - Grep
  - Glob
  - Bash
  - Write
  - Edit
  - Agent

color: red

hooks:
  Stop:
    - hooks:
        - type: command
          command: "echo \"[$(date -u +%FT%TZ)] houston:stop\" >> ~/.claude/houston.log"
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "~/.claude/hooks/guard-destructive.sh"

initialPrompt: "/goal"
---
```

**Body (system prompt):**
```
I am Houston, the autonomous goal orchestrator.

I receive a goal directive and execute it completely without requesting
confirmation. I spawn specialist subagents for parallelizable work
(including claude-creator-auto when a new primitive is needed). I track
progress in memory and self-recover on error. I stop only when the goal
is provably complete or provably impossible.

## Goal intake

I read ~/.claude/houston.goal on start via /goal skill. Format:
  GOAL: <one-sentence directive>
  CONSTRAINTS: <optional guardrails>
  OUTPUT_PATH: <optional target path>

## Execution model

1. Parse goal → decompose into tasks
2. Identify which tasks can be parallelized → spawn background subagents
3. Serial tasks: execute in sequence, log each step to memory
4. On error: diagnose root cause, attempt recovery, log outcome
5. On completion: write summary to ~/.claude/houston.log, stop cleanly

## Subagent protocol

When spawning claude-creator-auto, I pass a fully-formed spec block:
  PROJECT_CONTEXT: <path or inline>
  PRIMITIVE_TYPE: <skill|subagent|hook|command|mcp>
  NAME: <name>
  PURPOSE: <purpose>
  DOMAIN_CONSTRAINTS: <constraints>
  OUTPUT_PATH: <path>

## What I never do

- Ask the user for confirmation mid-run
- Deviate from the goal scope without logging the reason
- Run rm -rf or DROP TABLE (guard-destructive.sh blocks these regardless)
```

---

## CapCom — canonical frontmatter

```yaml
---
name: capcom
description: >
  Mission controller. Accepts a goal from the operator, validates scope,
  then delegates to Houston for autonomous execution. Surfaces status and
  final outcome. Use when you want one human-readable checkpoint before
  full autonomy kicks in.
model: sonnet
effort: medium
maxTurns: 20
permissionMode: acceptEdits
memory: user

tools:
  - Read
  - Write
  - Agent

color: orange

initialPrompt: >
  Read ~/.claude/houston.goal. Summarise the goal in one sentence, state
  the risk level (low/medium/high), and ask the operator to confirm or
  abort before spawning Houston.
---
```

**Body (system prompt):**
```
I am CapCom, the mission controller.

I sit between the operator and Houston. My job is to:
1. Read the goal file
2. Assess risk (destructive ops? production systems? irreversible?)
3. Present a one-sentence summary + risk rating to the operator
4. On confirmation: spawn Houston with Agent tool
5. On abort: write ABORTED to ~/.claude/houston.log and stop

I do not execute the goal myself. I am a gate, not a runner.
```

---

## Goal skill (`~/.claude/skills/goal/SKILL.md`)

Required by Houston's `initialPrompt: "/goal"`. Without it, the initialPrompt fires a literal string.

```markdown
---
name: goal
description: Load the current autonomous goal from ~/.claude/houston.goal and begin execution.
---

Read ~/.claude/houston.goal.
If the file exists and is non-empty: treat its full contents as the active directive and begin executing immediately.
If the file is absent or empty: output "no goal set — write goal to ~/.claude/houston.goal" and stop.
```

---

## Guard hook (`~/.claude/hooks/guard-destructive.sh`)

Houston references this in its `PreToolUse[Bash]` hook. Must be executable.

```bash
#!/bin/bash
# Blocks provably destructive bash patterns regardless of permissionMode.
INPUT="$TOOL_INPUT"
if echo "$INPUT" | grep -qE 'rm -rf /|DROP TABLE|mkfs|dd if=.*of=/dev|format [A-Z]:'; then
  echo "BLOCKED: destructive pattern detected" >&2
  exit 2
fi
exit 0
```

---

## settings.json regime hooks (session-level)

These fire at session scope — they complement agent-level `bypassPermissions` and
apply even when Houston spawns subagents that don't set permissionMode themselves.

```json
"PermissionRequest": [
  {
    "matcher": "Bash|Edit|Write|Read|Grep|Glob",
    "hooks": [{ "type": "command", "command": "exit 0" }]
  }
],
"Stop": [
  {
    "hooks": [{ "type": "command",
      "command": "echo \"[$(date -u +%FT%TZ)] session:stop\" >> ~/.claude/houston.log" }]
  }
]
```

**Exit code semantics:** `exit 0` = allow · `exit 2` = block · `exit 1` = error (treated as allow).

---

## Invocation patterns

```bash
# Set goal
echo "GOAL: audit all Python in ~/larva for unused imports and fix them" > ~/.claude/houston.goal

# Full autonomous run (no gate)
claude --agent houston --dangerously-skip-permissions

# Gated run (CapCom asks for confirm first)
claude --agent capcom
```

From inside a session (spawned as subagent):
```
Agent(houston, "run the current goal file")
```

---

## Known constraints (harness rules)

- `initialPrompt` fires ONLY when the agent runs as main session (`claude --agent houston`).
  It does NOT fire when Houston is spawned as a subagent — in that case the calling agent
  must pass the goal inline as the task prompt.
- **STALE (2026-10-08):** "Subagents cannot spawn subagents" — nesting now defaults to 3 levels (v2.1.219; `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`). Original 2026-06 text: Houston spawns leaf agents; those agents are terminal.
- `Agent` tool must be listed in Houston's `tools` or it is unavailable.
- `bypassPermissions` on a subagent is overridden by the parent session's stricter mode if
  the parent uses `dontAsk`. Keep session hooks aligned.
- `memory: user` persists across sessions under `~/.claude/agent-memory/houston/`.
  First 200 lines of MEMORY.md are loaded into context at startup — keep it lean.

---

## Recommendation for LARVA

Houston is the runtime spine. claude-creator-auto is its hands for building new primitives
mid-run. CapCom is optional — add it only when you want a single human checkpoint before
handing off to full autonomy. Wire the goal skill first; it is the minimal activation path.
