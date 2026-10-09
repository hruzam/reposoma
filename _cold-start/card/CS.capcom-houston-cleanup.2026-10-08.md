---
kind: cold-start-card
date: 2026-10-08
brand: claude
seat: epoch
project: reposoma
root: ~/reposoma
task: Fix CapCom/Houston agent files — pin CapCom to claude-sonnet-5-5, remove the dangling spawn target, strip the retired houston.goal — then sweep the table for sibling drift
resume: claude --agent atlas-ui
model: sonnet
dedicated: atlas-ui
recommend: Atlas-ui edits on the table (~/ia-sync/claude/agents/), never live ~/.claude. Three small edits plus one grep sweep; confirm the goal-source replacement with majkee before writing (item c has one real design choice). Draft only — no ledger edits.
pointers:
  - ~/ia-sync/claude/agents/capcom.md
  - ~/ia-sync/claude/agents/houston.md
  - ~/ia-sync/claude/skills/goal/SKILL.md
  - ~/reposoma/temple/roster.md
  - ~/reposoma/temple/decisions/0006-model-effort-assignment.md
  - ~/reposoma/raw.settings/raw.card.autonomous-orchestrator.md
  - ~/reposoma/_cold-start/issues/ISS.guard-destructive-reads-dead-env-var.2026-10-08.md
  - ~/reposoma/raw.settings/raw.card.claude-code.md
---

Dropped by @Epoch after the 2026-10-08 stale-card refresh. majkee's three asks (a/b/c) plus one
open-ended "what did I miss" (d), blessing given to apply what is proposed. I could not commit
from this seat — `commit:` left for majkee, and the card exists cross-machine only after commit+push.

## Evidence in one paragraph (all disk-read 2026-10-08, not memory)

`~/.claude/agents/capcom.md` says `model: haiku`, `effort: low`, `color: cyan`, step 4 spawns
`subagent_type: "houston-devstudio-architect"`, and steps 1/4 plus the description read
`~/.claude/houston.goal`. `temple/roster.md:61` and decision 0006 A1 say CapCom = Sonnet·low.
`temple/roster.md:120` says the global `houston.goal` was retired 2026-06-17 (goals are per-project).
`houston.md` still carries `~/.claude/houston.goal` in its description. The live agent list has `houston`
but no `houston-devstudio-architect`. The edits belong on the TABLE; `deploy.sh` spreads them.

## Tasks, in order

**a. CapCom model → `claude-sonnet-5-5`.** Set `model: claude-sonnet-5-5` in capcom.md (keep
`effort: low`, `maxTurns: 20`, `permissionMode: acceptEdits`). Full model IDs are valid in subagent
frontmatter (sub-agents docs, live 2026-10-08). Two cautions for the record, neither blocks it:
1. Pinning an ID departs from the repo's own advice ("never hardcode dated strings, set a floor" —
   `raw.card.claude-code.md`). The alias `sonnet` resolves to Sonnet 5.5 on the Anthropic API since
   Claude Code v2.1.284, so the alias would track automatically; majkee asked for the ID, so honor it.
2. Run ONE headless/spawned CapCom after deploy to confirm the pin resolves (a Fable pin hit a 400 in
   headless — project memory; do not assume IDs are always safe).
Roster line 61 already reads "Sonnet · effort:low"; leave it. Whether a pinned ID needs a decision-0006
amendment (A2) is a ledger question — DRAFT it for majkee's gavel, do not edit the ledger.

**b. Remove the dangling spawn target.** capcom.md step 4 spawns `houston-devstudio-architect`. My
reading of "erase": replace it with the real global agent — `subagent_type: "houston"` — so CapCom can
still hand off. If majkee meant "delete the spawn step entirely", CapCom would stop being a gate that
launches anything; confirm which. ⚠ Before touching the name anywhere else: `houston-devstudio-architect`
may be a PROJECT-scoped variant (roster says freya has `-devstudio-` variants) — fix only the GLOBAL
capcom.md; grep the freya project before assuming the name is dead everywhere.

**c. Clean the retired goal file.** Remove `~/.claude/houston.goal` from capcom.md (description, step 1,
step 4 prompt) and houston.md (description line "reads ~/.claude/houston.goal for autonomous runs").
ONE DESIGN CHOICE for majkee: CapCom's whole loop is "read the goal → risk-rate it → ask to confirm →
spawn Houston". With the file gone it needs a goal source. My proposal (matches the harness rule that a
subagent-spawned agent gets its goal inline): CapCom takes the goal from its invocation prompt, asks the
operator if absent, and passes it inline in the Houston spawn prompt. Houston keeps `initialPrompt: Run
/goal ... read flag.md / session plan` (that already reads project files, not the global file). BEFORE
editing, read `~/ia-sync/claude/skills/goal/SKILL.md` — the 2026-06 template version of the `goal` skill
read `~/.claude/houston.goal`; if the skill still does, it needs the same cleanup. Keep the abort log
write to `~/.claude/houston.log` (that is a log, not the goal file) unless majkee says otherwise.

**d. What majkee may have missed (my proposals — each is optional; do 1–2 now, report 3–5):**
1. **Sweep for sibling drift** (cheap grep, table + live): `houston-devstudio-architect`, `houston.goal`,
   `claude-creator-auto` (retired name — current creator seat is `atlas-auto`), `project-explorer`
   across `~/ia-sync/claude/{agents,skills,hooks}` and `~/.claude/{agents,skills}`. Report hits; fix only
   in the two agent files above.
2. **Table-vs-live drift:** the guard-destructive issue showed live-only files exist. Diff
   `~/ia-sync/claude/agents/capcom.md` and `houston.md` against `~/.claude/agents/` before editing so the
   deploy does not clobber a live-only change.
3. **Pulse overlay looks stale (NOT atlas's file):** `pulse.claude.md` still carries "FABLE SUNSET
   (2026-07-07) — no Fable seat spawns by default" and its newest log entry is 2026-07-09, while project
   memory says Fable returned to the subscriber range 2026-08-01. Single-writer file (Houston/Flight) —
   surface it, do not edit. 
4. **Roster CapCom note after the pin:** none needed; but `raw.card.autonomous-orchestrator.md` carries a
   2026-10-08 "open conflicts" block listing exactly these three items. After the edits land, hand that
   block back to @Epoch (or Delta) to mark resolved — that card is raw.settings, not an Atlas surface.
5. **Houston's guard hook is moot:** per the issue card, houston.md lists no Bash tool, so its
   `PreToolUse[Bash]` guard never fires. Operator question already open in that issue (keep a Bash hook
   on Houston or move the guard). Do not decide here.

## Hygiene / debts
- Edits land on the table; `deploy.sh` must run to reach live `~/.claude/` on both hosts (the agents leg
  exists; the hooks leg was added 2026-10-08).
- This card: commit+push reposoma to make it cross-machine; drain to `archive/` when consumed.
- Verify after deploy: `grep -n "houston.goal\|houston-devstudio" ~/.claude/agents/capcom.md ~/.claude/agents/houston.md`
  returns nothing, and `grep -n '^model:' ~/.claude/agents/capcom.md` shows `claude-sonnet-5-5`.

## prompt-0

###### prompt

```text
You are @Atlas (atlas-ui). Read the card ~/reposoma/_cold-start/card/CS.capcom-houston-cleanup.2026-10-08.md
first, then do tasks a, b, c on the TABLE (~/ia-sync/claude/agents/capcom.md and houston.md) — never the
live ~/.claude. Before writing: read ~/ia-sync/claude/skills/goal/SKILL.md, diff table vs live for both
agent files, and confirm with majkee (1) that "erase" in task b means replace the spawn target with
`houston`, and (2) the goal-source replacement for CapCom (invocation prompt / ask operator / pass inline).
Then run the task d.1 and d.2 greps and report hits and drift. Draft any decision-0006 amendment for
majkee's gavel; do not edit the ledger. Do not edit pulse.claude.md (Houston/Flight single-writer).
```
