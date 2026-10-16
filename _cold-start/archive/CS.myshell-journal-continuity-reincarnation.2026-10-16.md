---
kind: cold-start-card
date: 2026-10-16
brand: codex
seat: myShell
project: reposoma
projects: [reposoma, ia-sync]
root: ~/reposoma
commit: 21aa5b7 (core)
task: Re-enter Majkee's personal continuity shelf and prepare, but do not open, the germline-03 audit frame.
resume: codex
model: sol
dedicated: myShell (Cartan)
recommend: Saddle explicitly onto ia-sync, then use only the requested Chapter 4 packet and current germline-03 inputs.
pointers:
  - ~/reposoma/.majkee/AGENTS.md
  - ~/reposoma/.majkee/engine/README.md
  - ~/reposoma/.majkee/.germline/programs/journal-continuity/CONTROLLER.md
  - ~/reposoma/.majkee/.germline/programs/project-saddle/CONTROLLER.md
  - ~/reposoma/.majkee/journal/2026-10-13.md
  - ~/ia-sync/.dev/session/germline-03-foundation-audit/raw/INPUTS.from-germline-02.md
  - ~/ia-sync/.dev/session/germline-03-foundation-audit/raw/SUBSTRATE.atlas.from-germline-02-close.2026-10-15.md
---

## Read first

1. `~/reposoma/.majkee/AGENTS.md` — myShell's personal continuity boundary and project-saddle rule.
2. `~/reposoma/.majkee/engine/README.md` — manual `ctrl <program>&<function> : <task>` grammar.
3. `~/reposoma/.majkee/.germline/programs/project-saddle/CONTROLLER.md` — verified project entry;
   then fire the preflight in prompt-0.
4. `~/reposoma/.majkee/journal/2026-10-13.md` §4 — the prepared context shelf. Select a labeled
   starting packet; do not consume its historical material wholesale.
5. The two germline-03 raw inputs above — the only present germline-03 substrate.

## Observed state

- Observed before this card was written: reposoma `core` at `21aa5b7`, clean; ia-sync `main`
  at `b71d10d`.
- Observed: `~/ia-sync/.dev/session/germline-03-foundation-audit/` contains the two raw input
  files above, but no `STATUS.md` and no `RUNBOOK.md`.
- Reported by germline-02 close substrate: germline-03 is audit-only and requires Majkee's
  separate authorization. This card does not supply it.
- The journal is a context shelf and continuity record. It never replaces the owning session's
  STATUS/RUNBOOK once such surfaces exist.

## prompt-0

###### prompt

```text
Act as myShell, Majkee's personal continuity seat. Read ~/reposoma/.majkee/AGENTS.md, then
~/reposoma/.majkee/engine/README.md. Use this manual preflight:

ctrl project-saddle&saddle-project : project ia-sync; scope: .dev/session/germline-03-foundation-audit/; authority: read-only; task: prepare the current instruction chain for this relay.

After READY, consult only the relevant labeled packet from ~/reposoma/.majkee/journal/2026-10-13.md §4
and the two declared germline-03 raw inputs. Report the current frame, missing authority, and
smallest safe handoff. Do not create a RUNBOOK/STATUS, open germline-03, alter a session bed,
or treat journal text as project truth without Majkee's separate authorization.
```

## First tool shot

```bash
sed -n '1,180p' ~/reposoma/.majkee/AGENTS.md
sed -n '1,220p' ~/reposoma/.majkee/.germline/programs/project-saddle/CONTROLLER.md
find ~/ia-sync/.dev/session/germline-03-foundation-audit -maxdepth 2 -type f -print | sort
```

## Folding starting prompts

- The 2026-10-13 Chapter 4 shelf is source material, not the default destination for a new
  launch. Before folding a newly written starting prompt, open the appropriate current-day
  journal file and create or locate myShell's own session chapter under its `---` scope.
- Use the current day-square shape from `~/reposoma/.majkee/AGENTS.md` and `README.md`.
  The 2026-10-13 Chapter 4 pattern is a valid historical reference and explicit anchor only
  when Majkee names it; do not silently copy its whole prompt shelf into a new day.
- Fold a new prompt only after its recipient, project saddle (where relevant), evidence paths,
  authority, and expected return are known. The journal records the launch packet/pointer;
  the owning session's STATUS/RUNBOOK remains its authority.

## Re-entry posture

- Classify Majkee's incoming turn before mutating shared files: **listen/think**, **prepare/
  propose**, or **act/fold/build**. An exploratory question is not a write request; answer it
  and show the smallest proposed fold before changing a durable surface.
- Prefer one direct answer and one next choice over adding another apparatus. If the action
  posture remains unclear, ask or hold; do not make Majkee carry a formal protocol merely to
  prevent my inference.

## Prompt-writing protocol

When inviting Cartan or Atlas, use a short declared packet, not a broad invitation to read a
pile of files. Saddle the project first when the prompt is project work, then name only the
smallest relevant sources.

```text
to-<cartan|atlas> ---
purpose: <one bounded outcome>
read first: <absolute or ~-anchored path(s)>
task: <one question or deliverable>
authority: <read-only / exact write scope; explicit exclusions>
return: <receipt/path and evidence expected>
stop: <gate, uncertainty, or non-authorized action>
```

`myShell` selects and folds the packet; the recipient verifies project truth and reports rather
than treating the invitation as permission to create a session, canon, loader, or deploy. The
recipient tag is a routing label, not an authority grant.

## Gates

- Majkee alone authorizes opening the audit-only germline-03 session and any new session
  STATUS/RUNBOOK.
- The project-saddle result is a read-only context receipt, never project-write authority.

## Done when

- The next incarnation has a checked ia-sync instruction chain, a selected source packet, and
  a precise report of whether Majkee has authorized the germline-03 opening.
- On consumption, move this card from `card/` to `archive/`; do not commit implicitly.
