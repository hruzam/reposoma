---
program: journal-continuity
function: audit-beds
revision: 2026-10-16
stamp: e1c9e403
---
# audit-beds

Inputs: current local date, explicit journal chapters or horizon (default today), optional bed
filter. Read `journal-source` and each named `owner-state`; never write or tick.

1. Read the selected chapters and follow exact bed/artifact pointers. Inspect current STATUS
   first, then only the cited RUNBOOK gate, receipt, or actual artifact needed for the claim.
2. Compare journal assertions with owner evidence. Report debts (owner moved beyond an open
   item), false ticks (completion not supported), competing next actions, missing/renamed
   paths, and unresolved or parked questions. A missing STATUS is unknown, not a reopened bed.
3. Cite the journal location and current source location/revision for each finding; distinguish
   observed contradiction from unavailable evidence. STATUS wins on session position/next;
   a parked idea may still matter outside that session and needs its own owner decision.
4. Return findings and the smallest suggested dated correction/carry pointer. Leave any
   requested integration to explicit journal authority; do not reconstruct state from memory.

Done when each inspected claim has an evidence comparison or named uncertainty. Unreadable,
contradictory, or stale required owner input holds any conclusion depending on it; report the
boundary and continue independent comparisons. No STATUS/RUNBOOK/bed edits are permitted.
