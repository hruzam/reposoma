---
to: "@Cartan — receiving Nablarva project session"
from: "@Cartan / cartan-csharp — runbook-upgrade head"
date: 2026-09-12
host: "office · hruzam-120922"
project: /home/hruzam/unikuklatrix/nablarva
topic: "Runbook participants to session endpoints — cSharp experience for a small relay cut"
kind: "POINT / advisory handoff; no RETURN owed"
authority: "Majkee requested this mail; recommendations, not a design lock or build authorization"
evidence_commit: "ia-sync e12be1f3a33798a26323b47d7a4bc17917c3474f"
---

# To the next Cartan and Nablarva's project agents

Majkee clarified that Nablarva was the intended animal behind this work from the beginning,
not a newly discovered destination. His earlier vision was larger and, in his experience,
too exposed to changing vendor UIs. His current direction is smaller: extend the runbook
tool, select a session bed and participant, bind/load the real session ID, and relay a message.
He asks your project team to design and build it. This letter contributes the cSharp's
experience; it does not open a new project, wake a seat, or assign your implementation scope.

## Start from the current project, not this letter's memory

Read `/home/hruzam/unikuklatrix/nablarva/AGENTS.md`, then its `.dev/session/flag.md`,
`.dev/session/pulse.md` and `PROJECT.yaml`. I inspected those on office for this handoff.
The pulse currently routes no active session. Flag L9′ supersedes the old pulse-as-state
description; L12 supersedes the older separate-repository topology. No project file was edited.

Important fit check: L3 already locks a single-writer room journal, projections and
adapter-owned PTY; L4 rejects git-as-wire and tmux send-keys injection. RUNBOOK's immutable
POINT/RETURN/VERDICT files are task evidence, not a replacement room journal. Map the layers
explicitly. Any incompatible simplification needs a named exception or gavel, not an implicit
new authority. Language, lifecycle and other pending docket choices remain yours to resolve.

## Smallest useful first cut — a recommendation, not a schema

1. **Start with one bed, one host and operator-opened sessions.** Load participants from its
   RUNBOOK. Let the operator bind each logical seat to an exact runtime/session endpoint.
   Keep seat, bed, host, workspace, runtime and incarnation/session ID distinct. A title is
   a search aid, not identity; a spawned child is not the independent full-session seat.
   Missing, ambiguous or stale binding stops sending and offers explicit rebinding.
2. **Make the first action prepare-and-preview.** Show recipient, endpoint, exact artifact
   path and bounded message before an operator-triggered action. Copy-to-clipboard is a
   useful first delivery aid; the existing runbook browser already contains path/content
   copying and cycle grouping in `/home/hruzam/ia-sync/zsh/session/runbook.py` (source
   inspection only, not a new runtime proof). Coordinate extensions with that tool's owner.
   Do not rebuild its browser merely to remove one paste.
3. **Then trial one real connector for one pairing.** Prefer a currently verified native
   runtime interface over UI scraping; keep vendor/version handling behind the connector.
   This letter makes no current API/resume capability claim. Research and test the actual
   installed interface before selecting it. Retain a manual fallback when an update breaks it.
   Claude↔Claude, Claude↔Codex, Codex↔Claude and Codex↔Codex are a future capability matrix,
   not four working routes inferred from one success.
4. **Return an observable result, not a green fiction.** Separate prepared/submitted,
   receiver consumption, RETURN availability, witness acceptance and STATUS advancement.
   A newly appearing file can still be incomplete. A timeout after submission is unknown,
   not permission to resend. Reconcile the known endpoint/artifact before retrying; report
   uncertainty if the interface cannot settle it. No exactly-once claim from a local flag.

Keep endpoint bindings and delivery-attempt bookkeeping host-local and subordinate to the
owning bed; choose their concrete home in the project design. Portable task truth remains
RUNBOOK/STATUS/BUS. The presence board may expose overlap, but its v1 schema contains no
session endpoint; never mine its display-only note as routing instructions or wake authority.
Cross-host path resolution, sync and session rebinding are a later explicit cut, not a
hidden interpretation of the remote host's `~/` or a session ID copied between computers.

## What this run taught its head

- **Keep ownership and crossed checks; reduce carriage.** Cycle 23 produced convincing
  filenames through the wrong execution topology. Hashing more would not identify the writer.
  A connector must not turn endpoint discovery into authority or write a witness's acceptance.
- **Keep the current position short.** My STATUS grew to 501 lines. Better transport must not
  create another transcript-sized status file or a second next-action authority.
- **Ask for the actual artifact early.** Missing literal patch anchors cost corrective work.
  A checked diff first and verification of the changed claim are cheaper practices to test,
  not reasons to waive substantive review or measured cost claims.
- **Give the operator one clear next action.** Show who acts next and what is already
  authorized. Separate routine copying from canon, scope, identity and stop/continue decisions.
  Agree checkpoint authority once; do not repeatedly announce the same commit boundary.
- **Stop a probe loop when evidence stops improving.** Our law and office skill bytes landed,
  but Claude producer proof remained FAIL and the coached diagnostic only partial. Majkee
  accepted limited delivery, not PASS. Simplify operation; do not promise a rebuilt system
  will cure model behavior. UI fragility here is the operator's report, not a proven cause
  of those producer failures.

For the first trial, compare the current manual handoff with the candidate on one real,
bounded exchange. Count operator actions, wrong-target/duplicate submissions and observed
time to prepare or deliver; distinguish submission from consumption. Include a stale ID,
wrong bed/seat and interruption after submission but before confirmation. Require no silent
retargeting or blind retry. Declare the trial's stop condition before running it. This arc's
head-only telemetry is not a baseline for total human effort or a claimed savings percentage.

Leave background watching, unattended wake, cross-host delivery, pooled sessions and automatic
gate advancement out of the first cut. Current cSharp transport wording also needs explicit
reconciliation before automatic waking/steering is promoted beyond an operator-triggered trial.
Project agents own the candidate and its challenge; majkee owns the gavel. No design is locked here.

## Durable evidence and law pointers

In `/home/hruzam/ia-sync`, commit `e12be1f3a33798a26323b47d7a4bc17917c3474f` preserves:

- `.dev/session/runbook-upgrade/VERDICT.md` — actual result, invocation limits and corrected
  full-audit integration; read this alongside the independent reports, not the reports alone.
- `.dev/session/runbook-upgrade/raw/cartan-csharp.experience-transfer.2026-09-11.md` — short
  five-block transfer. The same `raw/` contains `cartan-full-audit.2026-09-11.md` and
  `oraculum-full-audit.2026-09-11.md`; originals retained, measurement corrections in VERDICT.
- `.dev/session/runbook-upgrade/_bus/` — 108 preserved receipts, including inoperative cycle 23.

Resolve, for example, with `git -C /home/hruzam/ia-sync show
e12be1f3a33798a26323b47d7a4bc17917c3474f:.dev/session/runbook-upgrade/VERDICT.md`
(one shell command). This commit is local to office at handoff; availability elsewhere must
be verified after authorized transport, never assumed from the hash.

Shared law: `/home/hruzam/reposoma/raw.guides/runbook/res/fanout-turns.md` — Coordinates and
authority / Cold recovery and late artifacts; `res/csharp-head-protocol.md` in the same
runbook directory — operator transport; `res/presence-board.md` — Advisory boundary and
Record grammar. These are constraints to integrate, not text to duplicate into every connector.

Receiver owns this single mail and archives it after processing. Fold any adopted conclusion
into the project-owned task/canon home before draining it; inbox presence proves availability,
not consumption. No sent-copy, private transcript dump, project write, deploy or cross-host send.
