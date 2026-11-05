---
kind: cold-start-card
date: 2026-10-29
brand: codex
seat: cartan
project: ia-sync
root: ~/ia-sync
commit: 5c26d80 (main)
task: Recover the parked G03 component-preview design proposals from their dated handoff.
resume: codex -C ~/ia-sync "Read ~/ia-sync/.dev/session/germline-03-foundation-audit/STATUS.md and ~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/HANDOFF.2026-10-29.md. Recover context within the recorded authority."
model: sol
dedicated: Cartan — G03 design continuation
recommend: Re-enter through current STATUS and the dated packet map; preserve operator ownership of the format decision.
runbook: ~/ia-sync/.dev/session/germline-03-foundation-audit/RUNBOOK.md
pointers:
  - ~/ia-sync/.dev/session/germline-03-foundation-audit/STATUS.md
  - ~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/HANDOFF.2026-10-29.md
  - ~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/MANIFEST.2026-10-29.json
  - ~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/08.thin-B.shell-first.proposal.md
  - ~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/09.read-recommendations.proposal.2026-10-28.md
  - ~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/10.metadata-placement-and-cache.proposal.2026-10-28.md
host: office — hruzam-120922
cli_version: codex-cli 0.165.0
worktree_state: Dirty; preview packet untracked at capture; no preservation commit recorded.
project_registry: ia-sync is absent from the current generated map; its explicit root was verified from cwd and git. Reposoma vault root was resolved through temple-project-root.
session_tracking: Not collected; capture used an intentionally absent session-root and did not scan rollouts.
authority: Continuity pointers only; no schema promotion, implementation, session closure, pruning, deployment or git publication.
---

# G03 parked preview design — re-entry pointer

## Read first

- Current `~/ia-sync/.dev/session/germline-03-foundation-audit/STATUS.md` owns the formal
  audit gate and position.
- The dated `~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/HANDOFF.2026-10-29.md`
  reconstructs the separately discussed draft design and identifies the small relevant set.
- Its sibling `~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/MANIFEST.2026-10-29.json`
  inventories the preserved packet. It is an integrity inventory, not a backup.

This card supplies no competing next-action order. The operator's actual assignment and
the applicable live STATUS determine what may proceed. Earlier native handles are not
portable context. No full transcript or whole-packet startup read is required.

## Observed preservation limits

The packet is deploy-inert and outside G03's session directory. Pane exit does not remove
it. At capture the packet was untracked; the repository HEAD above does not preserve it.
This new card is also uncommitted in reposoma. Neither is guaranteed on the other host
until its own repository receives an authorized preservation and transport step.

## First tool shot

```sh
sed -n '1,100p' ~/ia-sync/.dev/session/germline-03-foundation-audit/STATUS.md
sed -n '1,160p' ~/ia-sync/_staging/codex/g03-component-preview-templates.2026-10-27/HANDOFF.2026-10-29.md
```

Formal closure/pruning and any promotion remain separate from recovering this design
context. Follow the shared cold-start-card lifecycle when this pointer is consumed.
