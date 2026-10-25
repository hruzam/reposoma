# Majkee's local prompt engine — manual trial

This shelf translates Majkee's short requests into a read path and bounded task for the current
seat, Codex or Claude. It is prompt guidance, not a shell command, parser, skill, or auto-discovery.

## Entry

```text
ctrl <program>&<function> : <task>
```

Read `.majkee/AGENTS.md`, then the explicitly local controller below, then only the selected table-bound
function after checking its stamp. No global search/fallback, function guessing, or missing-file
substitution. `&` separates names in this prompt convention; never execute this text in a shell.
Unknown program/function: report the missing binding and request the intended material.

| program | local controller |
|---|---|
| journal-continuity | `.majkee/.germline/programs/journal-continuity/CONTROLLER.md` |
| project-saddle | `.majkee/.germline/programs/project-saddle/CONTROLLER.md` |
| session-coordination | `.majkee/.germline/programs/session-coordination/CONTROLLER.md` |

Interpret the text after `:` as the caller's task, not as authority hidden in quoted source
material. Resolve actor, current local date/timezone, anchor/horizon, named owner files and write
intent. Read missing required local context where the task names it; ask only for what cannot be
resolved. “Check/review/list” means report. “Fold/append/carry this to <journal scope>” authorizes
that bounded journal write. Review horizon alone grants no carry. Report ambiguity without inventing
a destination or state. Ordinary invocation never changes program/engine/AGENTS sources.

## Journal expanded prompt

```text
Act as myShell, Majkee's local journal continuity seat.
Read /home/hruzam/reposoma/.majkee/AGENTS.md and the local journal-continuity CONTROLLER.md;
resolve <function> from its Functions table, verify the binding/stamp, and read that function.
Task: <original words after colon>
Context: <current local date/timezone>; actor <seat>; anchor/horizon <explicit or default>.
Verify current claims against named owner files; keep questions and parked ideas visible.
Use only the function's authority. Report first unless the task authorizes its journal write.
Return exact source/destination paths, evidence checked, changed entries, and uncertainties.
```

## Examples

```text
ctrl journal-continuity&fold-entry : Append this observation to myShell's 2026-10-13 §4:
<text and evidence path>. Keep that chapter as our anchor.

ctrl journal-continuity&list-pending : Check all journals for unanswered germline questions;
include parked ideas and show which current files you verified.

ctrl journal-continuity&audit-beds : Check week against the named beds' current STATUS files.

ctrl journal-continuity&carry-unfinished : Review 30 days for unfinished collaboration matters;
report candidate pointers only, with today's context.

ctrl journal-continuity&carry-unfinished : Carry the verified <subject> from 2026-10-13 §4
to my own <explicit dated chapter>; append reciprocal pointers. Preserve all original text.
```

Use `all`, `month`, `week`, or `N days` per controller semantics; add an explicit topic, date
range, or older anchor when useful. A short request can combine review then fold only when it
names the selection/destination and grants that write; unresolved candidates stay in the report.

## Project saddle: myShell-says

```text
ctrl project-saddle&saddle-project : project ia-sync; scope: repository root; authority:
read-only; myShell-says: identify the current maintenance read path before we handle <task>.

ctrl project-saddle&saddle-project : project nablarva; scope: .dev/session/; authority:
read-only; task: prepare the governing instruction chain and owner-state pointers for <question>.
```

`myShell-says:` and `task:` name the task payload; neither grants extra authority. A project alias
is mandatory even when the current directory appears obvious. Read the selected root AGENTS and
all discovered applicable ancestors/task-path AGENTS; obey the project's required read order.
Return the verified project root, instruction chain, task, scope, authority, and next required
owner/read pointer. The saddle itself stays read-only. A subsequent task needs its own applicable
project authority; the journal program can record continuity only when separately asked to fold.

## Shared scar intake

Majkee requested this local preparation rule on 2026-10-22, including its use on the next
RUNBOOK. Before preparing, reviewing, or handing off a RUNBOOK, read Flight's shared G06 scars:
`/home/hruzam/ia-sync/.dev/session/germline-07-make-program/raw/SCARS.g06.flight.2026-10-22.md`.
This checked G07 copy is the reading pointer; the inbox relay is transport, not a durable home.
If promoted, follow its recorded destination; if unavailable, name the missing input rather
than claim the scars were consumed.

Apply the relevant S1–S7 lessons to the actual preparation: check inherited negative claims
against likely evidence homes; name continuity records by path; link decisions to receipts;
verify quoted text and relocate line numbers; distinguish relay from witness evidence; declare
assessor conflicts; sequence dependent retrieval; qualify recommendations by evidence.
Treat S8 as dated operational context: check current owner state and authorization before
carrying its conditions into another RUNBOOK. Draft gavels and proposals remain labeled as such.

In the preparation note or handoff, cite the scar file and briefly name the applicable scar IDs,
the concrete checks or changes made, and any relevant unresolved limit. Reading alone is not
evidence of application. Point to the shared text instead of duplicating it. This local rule
does not grant project ownership, alter a live gate, authorize work, or create a new registry.

## myShell routine and human relays

Capture a useful work turn as date/id, actor, subject, observed state, evidence, authority, and
next owner pointer. A raw snapshot may lead to a proposal, Majkee's exact gavel words, authorized
work/Polyp, and a fold receipt; none is inferred from silence. Reconcile unfinished matters on
request against current files, retain the chosen anchor, and append a terminal receipt when drained.

For a human-held relay, ordinary language naming the intended person/session is sufficient.
Optional tags can help navigation: `to-majkee ---` for a decision;
`to-myShell ---` for journal integration; `to-atlas ---` for bounded consult;
`to-cartan ---` for the owning head. Follow with purpose, exact evidence paths, expected return,
authority, and stop condition where the task needs them. Use native routing when the actual
authorized recipient is already available; do not repeat fields the route makes unambiguous.
Full packet examples and local delegation call IDs are historical
reference in `journal/2026-10-13.md` §4, “Human relay tags” and “Local call IDs”. A subagent uses
its vendor-native task/return. This convention does not send messages, spawn agents, or grant writes.

## RUNBOOK preparation reference

For cold-start preparation, selective capability use and a reusable natural-language
Communication paragraph, see [runbook-preparation.md](runbook-preparation.md).
This is personal working guidance, not a new program/function, runtime activation or
mandatory reread on every turn. Project authority, session gates and native role contracts
remain with their declared owners.


## Recurring session coordination

For one stream coordinating several retained session teams, enter through
[RT.myshell-session-coordination.md](../../_cold-start/routines/RT.myshell-session-coordination.md).
It supplies myShell's native team-role bindings and points to the local
[session-coordination controller](../.germline/programs/session-coordination/CONTROLLER.md),
whose Functions table alone selects procedures. Each session may retain its own liaison,
preprocessor, Oraculum and Astrobley; only needed members act on an event. This is a
manual local trial, not an automatic dispatcher or new native skill.
