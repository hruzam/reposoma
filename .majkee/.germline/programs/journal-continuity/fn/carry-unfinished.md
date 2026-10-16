---
program: journal-continuity
function: carry-unfinished
revision: 2026-10-16
stamp: 10577337
---
# carry-unfinished

Inputs: current local date/timezone, source anchor or explicit horizon, optional topic/bed,
proposed destination journal file/chapter, and explicit carry/fold authority. Read `journal-source`
and current `owner-state`; write only authorized source/destination journal scopes.

1. Read the selected old chapters (or `all | month | week | N days`) and later receipts in scope.
   Consider open checkboxes, pending/deferred/parked/unanswered prose, “continue”, and named
   sessions/beds as soft hints; age and exact keywords do not decide relevance.
2. Check each proposed active claim against current named STATUS/RUNBOOK/artifact, using today's
   context even when the source remains the 13th. Distinguish still actionable, parked/unanswered,
   resolved, stale/conflicting, and unknown. Keep source and current evidence pointers visible.
3. Default to a report of candidate pointers and uncertainties. If no explicit carry/fold write
   request, stop there. Require named source and destination scopes before mutation; never
   choose a new day merely because the calendar changed. Missing owner evidence holds active
   claims; a source-only question can be carried explicitly as unverified, without asserting work.
4. For an authorized selection, check for an existing matching carry receipt, then append a
   dated pair with one shared human-readable reference (date + subject/source heading):
   - source own-scope receipt: `CARRIED TO <destination file#heading> · <reference>`;
   - destination own-scope receipt: `CARRIED FROM <source file#heading> · <reference>` plus
     concise classification and current owner/evidence pointer. Preserve the original entry.
   Never copy full procedures, live commands, or backlog bodies. Same source/destination
   chapter: report “anchor retained”; no self-carry needed. No duplicate pair on repeated input.
5. Verify both pointers resolve; return their paths/chapters and any uncarried matter. If only
   one append succeeds, report the incomplete pair and exact missing half; do not claim completion.

Done when the report is complete or the explicitly selected pair exists. No move, deletion,
automatic closure, tick, bed edit, or revival of a closed session follows from a carry. If the
old entry belongs to another writer, add an own adjacent scope receipt instead of editing theirs.
