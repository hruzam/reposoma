---
program: journal-continuity
function: list-pending
revision: 2026-10-16
stamp: 6fc4b914
---
# list-pending

Inputs: current local date, horizon (`all | month | week | N days`, default today), optional
topic/bed/anchor. Read `journal-source`; optionally inspect named `owner-state`. No writes.

1. Enumerate actual dated source files in the requested window; report dates, supplementary
   files, and limits. An explicit older chapter is valid even outside the default window.
2. Collect candidates from open checkboxes and prose suggesting pending, unanswered, deferred,
   parked, or “continue”; also inspect named sessions/beds for unfinished context. These are soft
   discovery hints, not required labels. Include plausible unlabeled ideas with uncertainty.
3. Read later receipts/carry pointers in scope before calling an item unfinished. Group related
   mentions with source pointers; preserve distinct questions even when their bed is closed.
4. Return grouped source/date/chapter, brief matter, observed journal wording/state, current
   owner/source pointer, and verification status. Separate checked-current from journal-only,
   stale/conflicting, parked, and unknown; these are findings, not an authoritative backlog.

Done when scope and uncertainty are visible, with paths for every candidate. Never close/tick,
reorder journal text, or assert an exhaustive live list from checkboxes alone. If inputs/files
are missing, return the available partial inventory and what was not inspected.
