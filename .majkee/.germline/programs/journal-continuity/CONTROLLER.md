---
program: journal-continuity
revision: 2026-10-16
stamp: 96a5974b
scope: personal .majkee trial; uncanonical; no deploy
---
# journal-continuity

Job: keep Majkee's journal usable for re-entry, unfinished matters, and human relays.
This is a local trial using the PG-r3 package shape, not an installation of global law.

## Shared invariants

- Read `.majkee/AGENTS.md`; use README's day-square meaning and SHM's collaboration contract.
- The journal records observations, questions, parked ideas, receipts, and pointers. A bed's
  current STATUS owns position/next; RUNBOOK owns its sequence. Reading them acquires no pen.
- Write only inside `.majkee/journal/` when the requested function and task authorize a write.
  No commit, push, deploy, source-program change, session-bed edit, or automatic promotion.
- Append only in the caller's own chapter/scope. Preserve existing lines and other writers.
  Corrections, closure receipts, and carry pointers are new dated entries, never silent rewrites.
- Point rather than restate live instructions. Check active claims against named current files.
  Age or a closed bed alone does not dispose of an unanswered question or parked idea.
- Tick only from evidence (commit, receipt, STATUS edge); read-only review never ticks for Majkee.
  Keep exact gavel words separate from interpretation. Keep secrets out of entries.
- Today's date is context, not a rollover instruction. Default fold destination is today;
  an explicit old anchor such as `journal/2026-10-13.md` §4 stays valid until Majkee changes it.

## Requires and model roles

Caller supplies task, selected function, actor, current local date/timezone, and relevant anchor,
horizon, paths, or carry destination. Available capabilities: read named journal/source files;
write the authorized journal scope only. This procedure grants no tool capability or authority.

Roles: `journal-source` = exact dated files/chapters read; `owner-state` = named current
STATUS/RUNBOOK or actual artifact with path and observed revision/receipt where available;
`destination` = caller-authorized journal file/chapter. Missing/unreadable owner state is a finding,
not evidence that work is open or done. Contradictory required inputs hold the affected write.

Horizon: `all` = all dated entries, including dated raw/newspaper files; `week` = current local
date plus six preceding dates; `month` = current local date plus 29 preceding dates (rolling
30-day window); `N days` = today plus N−1 preceding dates, N positive. An explicit date range
or source chapter overrides the window. Report actual dates/files and omissions; future-dated
entries are flagged and excluded unless named. Missing dates do not mean missing obligations.

## Functions

| function id | occasion | file binding | expected stamp | result |
|---|---|---|---|---|
| fold-entry | capture authorized text/snapshot/relay | fn/fold-entry.md | 9456ec9a | dated appended entry and path |
| list-pending | inspect a horizon for unfinished matters | fn/list-pending.md | 6fc4b914 | sourced candidate list; no writes |
| audit-beds | compare journal claims with current files | fn/audit-beds.md | e1c9e403 | evidence-backed discrepancies; no writes |
| carry-unfinished | review and explicitly carry verified pointers | fn/carry-unfinished.md | 10577337 | report, or reciprocal journal pointers |

Load only the selected table binding; require matching program/stamp before its procedure runs.
Missing file, stamp mismatch, or unknown id: report expected/observed path and token; hold, no fallback.
Controller plus selected function and named inputs suffice; no other function is a prerequisite.

myShell may use a small snapshot: date/id · actor · subject · observed state · evidence · authority
· next owner/pointer. This describes a journal event, not a second session state machine. Human
relay tags and native subagent boundaries are in `engine/README.md`; they grant no authority.
