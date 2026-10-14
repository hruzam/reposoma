---
kind: cold-start-card
date: 2026-10-14
brand: codex
seat: cartan
project: ia-sync
projects: [ia-sync, reposoma]
root: ~/ia-sync
runbook: ~/ia-sync/.dev/session/germline-02-guide-model-law/RUNBOOK.md
commit: 2d6e14a (main)
task: Prepare the reviewed germline-02 program-law and GUIDE-book proposal.
resume: cd ~/ia-sync && codex
model: terra
dedicated: cartan
recommend: Wake Cartan in Medusa posture with RUNBOOK.md prompt-0; STATUS.md is the sole live doing-state.
pointers:
  - ~/ia-sync/.dev/session/germline-02-guide-model-law/STATUS.md
  - ~/ia-sync/.dev/session/guide-model-01-law/raw/RECONCILIATION.germline-02-guide-model-law.2026-10-13.md
  - ~/ia-sync/.dev/session/guide-model-01-law/raw/SOURCE-ACCOUNTING.germline-02-guide-model-law.2026-10-14.md
  - ~/ia-sync/.dev/session/guide-model-01-law/raw/RETURN.atlas.germline-02-reconciliation.2026-10-14.md
  - ~/ia-sync/.dev/session/guide-model-01-law/raw/INSIGHT.atlas.germline-load-graph.2026-10-14.md
  - ~/reposoma/.majkee/journal/2026-10-14.md
  - ~/reposoma/_cold-start/archive/CS.guide-model-01-law.cartan-head.2026-10-13.md
---

## Read first

1. This card, then the reconciliation and source-accounting files.
2. Atlas RETURN and INSIGHT; distinguish working planning gavels from still-open final gavels.
3. `~/reposoma/raw.guides/runbook/GUIDE.md`, applicable manifest chapters,
   `~/reposoma/raw.guides/runbook/ast/RUNBOOK.template.txt`, and
   `~/reposoma/raw.guides/status/GUIDE.md`, as required by Octopus.

Never read `~/ia-sync/.dev/session/guide-model-01-law/raw/hypotheses.reconcile-only.md`.

## Observed state

- The old guide-model launcher is historical evidence only. Its old STATUS, PROGRAM, and
  canonical RUNBOOK targets are absent; its staged material remains preserved in the old bed.
- The new bed's RUNBOOK.md and STATUS.md now parse and are the authoritative planning controls.
  This card is a transfer pointer only; it carries no competing next action.
- Working planning direction is accepted for this gate; it is not authorization to alter live
  `raw.guides/`, `germline/`, vendor skills, deployments, or agent cards.

## First tool shot

```sh
cd ~/ia-sync && git status --short
sed -n '1,220p' .dev/session/germline-02-guide-model-law/STATUS.md
rg -n '^state:|^## Accepted|^## Open gavel|^## Outside' \
  .dev/session/guide-model-01-law/raw/RECONCILIATION.germline-02-guide-model-law.2026-10-13.md
test -f .dev/session/germline-02-guide-model-law/RUNBOOK.md
test -f .dev/session/germline-02-guide-model-law/STATUS.md
```

## Gates

- Majkee alone gavels final naming, the skills/programs boundary, enforcement home, visibility
  details, and BACKGROUND disposition.
- Do not install v3, copy staged payloads, deploy, commit, push, convert guides, rewire agents,
  or spawn an executor.

## Done when

- Follow STATUS.md; do not treat this transfer pointer as a replacement for it.
