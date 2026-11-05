---
kind: cold-start-card
date: 2026-10-22
brand: codex
seat: Cartan
project: ia-sync
projects:
  - ia-sync
  - reposoma
root: ~/ia-sync
commit: 9a198ba (main)
task: Resume Cartan's G03 foundation-context handoff without changing the fixed G03 audit gate.
resume: cd ~/ia-sync && codex
model: terra
dedicated: Cartan
recommend: Read the live G03 RUNBOOK and STATUS first; this card supplies transfer pointers and scars only.
runbook: ~/ia-sync/.dev/session/germline-03-foundation-audit/RUNBOOK.md
pointers:
  - ~/ia-sync/.dev/session/germline-03-foundation-audit/STATUS.md
  - ~/ia-sync/.dev/session/germline-03-foundation-audit/raw/HANDOFF.cartan.g03-g06-exit-context.2026-10-22.md
  - ~/ia-sync/.dev/session/germline-06-full-audit/units/INTEGRATED.recommendations.md
  - ~/reposoma/.majkee/journal/2026-10-21.md
session_id: 01a145d5-eac1-7962-a8b0-fa19e5eb3ffa
rollout: ~/.codex/sessions/2026/10/16/rollout-2026-10-16T19-50-09-01a145d5-eac1-7962-a8b0-fa19e5eb3ffa.jsonl
effort: high
cli_version: 0.163.0
worktree: dirty outside G03; preserve without adopting
authority: Majkee gavels canon and new G03 action; Cartan owns only the repository-defined G03 STATUS pen.
leave: for more readers
---

# Germline-03 Cartan continuation

The live authority remains G03 `RUNBOOK.md` and `STATUS.md`. This card is a
continuity pointer, not a replacement runbook or a new work queue.

## First read sequence

1. Read the live G03 RUNBOOK and STATUS.
2. Read `raw/HANDOFF.cartan.g03-g06-exit-context.2026-10-22.md` in the G03
   bed.
3. If the successor needs the later-work context, follow its required order:
   G06 integrated recommendations, myShell journal §1.7, G06 reconciliation,
   then G06 STATUS CLOSE. Follow further unit or decision pointers only for a
   concrete G03 foundation question.

## Observed state at transfer

- G03's fixed gate has not changed. Its A2 mapping result remains an absence:
  `primitive-build`, `guide-author`, and `session-position` are all
  `none — ambiguous P8 provenance`.
- G06 is accepted and closed as an audit. Its decisions and C2 pilot are not
  automatic work for G03. In particular, Flight's `DEC.02 → DEC.04 → DEC.05
  → DEC.03` sequence is only a proposed gavel-review order.
- The G06 §1.7 qualifications are unincorporated in the decision files and
  must accompany any later qualification or execution discussion.
- The current repository worktree is dirty outside G03: Germline-04 RUNBOOK,
  STATUS, and raw handoff changes; a G04 close note; the Germline-07 bed; and
  `zsh/termbrana/`. Cartan did not author or alter those paths during this
  handoff.

## Operational scars

- Prefer current project files to elaborate journal-carrier history. The G03
  STATUS worktree header is historical, not a fresh worktree measurement.
- Never replace an unbound source mapping with a plausible analogue.
- A stamped read does not prove later retention, correct interpretation, or a
  recovery path. Keep retention, recovery, and indeterminate C2 outcomes
  separate; one passing arm is never universal runtime evidence.
- Do not create an empty `_bus`, receipt, or pilot merely to signal progress.
- Preserve external dirty work. Do not fold it into G03 or clean it as part of
  this continuation.

## First safe tool shot

```bash
cd ~/ia-sync && git status --short
sed -n '1,220p' .dev/session/germline-03-foundation-audit/RUNBOOK.md
sed -n '1,220p' .dev/session/germline-03-foundation-audit/STATUS.md
```

## Gate

Do not launch research, a compaction pilot, a bus exchange, a source change,
or a G03 gate rewrite from this card. A later action requires the governing
RUNBOOK/STATUS and an explicit Majkee authorization. No commit, push, deploy,
or broader worktree cleanup was performed here.
