---
program: journal-continuity
function: fold-entry
revision: 2026-10-16
stamp: 9456ec9a
---
# fold-entry

Inputs: supplied text/task, actor, current local date, explicit anchor if any, evidence paths,
and authority to fold. Reads `journal-source`/`owner-state` only where claims require checking;
writes only `destination`. If no explicit anchor, use `journal/<current-date>.md`.

1. Read the destination and identify the caller's chapter/scope. Create the file if absent;
   add an own scope/chapter if missing, without changing another writer's text or numbering.
2. Check factual completion/live-action claims against their cited artifact. Preserve uncertain
   material as a question, reported claim, parked idea, or discrepancy; never invent evidence.
3. Append the supplied material, date, actor, and compact evidence/owner pointer. Use the existing
   chapter style; use this initial shape when needed:
   ```text
   ---
   session : <session-name> (<runtime · seat · carriage>)
   ---
   # N. <topic> (bed: <absolute path if applicable>, head: <seat>)
   - [x] <done thing> · <verified evidence>
   - [ ] <step/unfinished matter> · <where its exact owner state lives>
   **Continue here:** <owner pointer or re-entry action>
   ```
   Include only applicable lines. If the subject cannot be placed, append own `## unsorted`
   block and say so. In a reserved process-snapshots magazine, append a fresh snapshot/relay;
   “drain” means append a carried/closed receipt, unless Majkee explicitly requests deletion.
4. Return exact file/chapter, appended event, evidence checked, and any unverified claim.

Done when the own-scope append is readable and earlier text is preserved. Missing text, ambiguous
scope/ownership, or missing write authority: return a draft and the exact missing input; no write.
