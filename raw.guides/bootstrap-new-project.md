---
verified: 2026-10-08
half_life_days: 90
---

# Stand up a team for a new project (from the temple)

`tier: raw.guides · the B-door procedure (the temple is the source; this is the steps)`
`audience: an architect agent (or the operator) starting a new project`
`date: 2026-06-17`

> Read the temple's `doctrine.md` first for the why. This is the how: from empty repo to a working
> team, smallest-first.

## Step 0 — mount and read state
Mount the temple as your global RAG. Read, in order: the project's `PROJECT.yaml` (the contract —
the one file you may assume exists) and its clean `pulse.md`. Do not scan the codebase; read the
contract's `docs.*` pointers.

## CLAUDE.md budget (before you write anything)

Project `CLAUDE.md` cap: **< 120 lines** (150 = red zone, context loss risk).
All CLAUDE.md files concatenate at session start — global + project + subdir — the
model receives the total. Harness per-file guidance is <200 lines each, but budget
is consumed cumulatively.

Rule: check combined line count before adding project instructions. If global is
already loaded (~30 lines), a new project CLAUDE.md should stay under ~90 lines to
keep the combined total safely under 120. Prefer `@path/to/file` imports over inline
expansion to pull content on demand rather than always-on.

*Official (code.claude.com/docs/en/memory, re-verified 2026-10-08; first verified 2026-07-02): the 200-line figure is
**per-file**, soft adherence recommendation, no hard truncation for CLAUDE.md. All files
still concatenate — cumulative load degrades adherence proportionally, but Anthropic does
not issue a combined cap; their mitigation is `.claude/rules/<name>.md` with `paths:` frontmatter
(load only when Claude reads matching files). The 120-line combined operating rule is the
temple's conservative engineering judgment, not officially mandated.*

*⚠ Do not conflate with MEMORY.md — that has a separate hard limit: 200 lines / 25KB truncation.*
*2026-10-08 additions (memory docs, live): a CLAUDE.md over 4 MiB is skipped entirely; a warning fires when the combined size of all loaded CLAUDE.md files exceeds a combined limit; `AGENTS.md` is read natively (v2.1.277) only when no `CLAUDE.md`/`CLAUDE.local.md` exists at or above the working dir, controllable by `instructionFiles` (`claude-md-or-agents-md` default · `claude-md-and-agents-md` · `claude-md` · `managed-only`; user/managed settings only); auto-memory notes carry `type: user|feedback|project|reference`. MEMORY.md limit re-confirmed: first 200 lines or 25KB. NOT re-checked: `agentctl` / `agentctl materialize` status (Step 3).*

## Step 1 — start with the four seats (doctrine §6)
**architect + challenger + researcher + implementer.** Plus a plan file, a flag/decisions ledger,
one compile-down gate, one adversarial pass before each lock. Do **not** pre-grant domain seats.

## Step 2 — write the contract
`PROJECT.yaml` (schema in `tools/agentctl.spec.md`): capability names not stack names, the verbs
agents resolve (`commands.*`), the doc entry points (`docs.*`), the requested agent set, the MCP
profile. Anything not in the contract is not promised.

## Step 3 — materialize (the gate)
Run `agentctl materialize` (or do it by hand at first): one sovereign source → the project's native
surfaces, with a lockfile + `verify` that fails CI on drift. Author canon in Tier S only; never
hand-edit a generated (Tier GW) file.

## Step 4 — grow by earning seats (doctrine §5)
Let load — not a planning whim — pull each new seat into existence: a deep core specialist, a domain
researcher, a deterministic-vs-agentive tool-builder split, a human-facing surface. Earn the
orchestrator and any multi-group split the same way: only at measured volume.

## Step 5 — keep the record
Per project: `plan` (what we're doing) · `flag`/`decisions` (what's locked) · `pulse` (volatile).
Lock the convergence; leave unverified mechanism conditional. Challenge before every lock.

## Optional patterns (earn before adding)

**Session continuity** — for projects that use a dev journal (`.dev/session/`): add
`session-handoff` + `track` skills to `.claude/skills/` (reference implementation: `fantasyobchod/.claude/skills/`).
For journal-free session recovery in any project, the global `/session-resume` skill derives the
project from CWD and asks before reading — no journal dependency, no hardcoded paths.

> The smallest team that ships one correct thing beats the complete team that ships an org chart.
