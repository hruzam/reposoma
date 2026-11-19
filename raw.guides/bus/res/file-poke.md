---
title: File-poke — shared provisional peer coordination
chapter-of: bus
audience: operator + agent + controller
machine: both
verified: 2026-11-19
status: PROVISIONAL — operator-authorized shared bridge, Majkee 2026-11-19; in force within authorized coordination
lifetime: Development-limited; carry until a qualified replacement and explicit scope/retirement decision
development_line: ~/unikuklatrix/nablarva/.dev/session/relay-X.ledger.md
---

# File-poke — keep the work and the rhythm visible

Use this for already-authorized cooperation between resident CLIs, including Codex and Claude,
while the final coordination mechanism is being developed. It applies across sessions and
projects; it is not a VIST-only trial. Declare the controller, target bindings, write scopes and
reply/bell contract in the owning session. Before the first poke, the using RUNBOOK or POINT
must name the current recipient binding, authorized channel, RETURN path and completion-bell policy.
This chapter supplies a shared practice, not new
tool permissions, a delivery implementation or permission to start another writer.

**Write → poke → work → return → verify.**

## The small agreement

1. **Write the work first.** Use the existing [POINT/RETURN/VERDICT contract](../GUIDE.md).
   State the bounded task, absolute read/write paths, one owner per artifact, evidence expected,
   return path and completion-notification instruction. Make sure the chosen role can produce
   its assigned output. A pointer does not enlarge the recipient's authority.
2. **Poke once.** Send a short file pointer through an available, verified, authorized channel.
   Confirm the intended existing recipient; a stored ID or pane label alone is insufficient.
   Keep the substance in the file. A queued/sent notification is not proof of consumption.
3. **Read, then work within scope.** A worker owes the result named by its assignment, or a
   concrete blocked/uncertain outcome. For longer work, agree a check-in condition before going
   quiet. Do not silently substitute another executor, session or permission regime.
4. **Write the result before ringing back.** Report evidence and limits in the worker's own
   RETURN, then send the completion pointer when the assignment calls for it. An informational
   poke needs no echo. State completion-bell requirements explicitly; an ambiguous `ack: none`
   never silently cancels an assigned written RETURN. Respect an explicit no-completion-bell
   instruction. There is no acknowledgement-of-acknowledgement loop.
5. **The controller closes the edge.** Check the cited artifacts, record the VERDICT and update
   the one STATUS. A result file contains claims to verify; neither its presence, a quiet pane
   nor an idle transition proves accepted work. Preserve available, queued, submitted, consumed
   and verified as different observations.

For example, these are notification texts, not a new CLI command or event envelope:

```text
[poke p17] read /absolute/path/17.controller.point.md; follow its reply/bell instructions
[poke r17] read /absolute/path/17.worker.return.md; no echo
```

## Keep rhythm without a ping loop

The controller/waiting owner owns reconciliation. During longer active coordination, use a
finite check-in when useful: name the read scope, clock/threshold, output, expiry or maximum
check count and responsible seat. A file-only note may flag an aged unanswered POINT or an
unreviewed RETURN; account for terminal STOP/BLOCKED dispositions. It must not infer native
health or consumption from silence or file age.

At a check-in, read the actual outstanding obligation, then provide useful progress, a precise
blocker or a request for the missing decision. Do not repeatedly send empty reminders or
redispatch the work. Stop the check on completion, failure, transfer or an operator hold.
Automatic peer sends or actions need their own actual authority; a read-only timer authorizes
only its declared note. No permanent cron, daemon or watcher is required by this chapter.

## When the normal mechanism fails

A sender authorized to input to that recipient may use one labelled manual fallback after a
definite clean failure with no possible target input or accepted queue submission. First verify
the current foreground agent/native binding,
positively empty input and absence of an approval/dialog. A genuine native dim suggestion can
be empty; arbitrary faint text is not proof. If the checks fail, type nothing, wait at least
60 seconds, check once more, then leave the file if still blocked.

Use one ASCII line beginning `[manual ...]`, pointing at the file. Record the failure, target
checks/time, exact line and observed outcome. Count it as manual delivery, not success of the
failed mechanism. **Never fall back or switch carriers after an uncertain submission until
receipt reconciliation.** Preserve historical uncertain keys. A role/native permission limit
still applies; an authorized operator can be the manual sender when the agent cannot be.

These administrative coordination permissions do not qualify Nablarva's regulated room
transport, adopt VIST/receiver schemas or supersede project locks and operation-specific releases.

## Carry-forward and retirement

Every newly authored using RUNBOOK ends with a fixed pointer to this chapter and its development-line ledger,
under [RUNBOOK's carry-forward clause](../../runbook/GUIDE.md#provisional-coordination-carry-forward).
At closure, the head accounts for this temporary dependency in the line ledger and carries it
to the next using session while replacement remains unresolved. Closing a session or moving
hosts does not itself retire the shared chapter; current doing-state stays in STATUS.

The head of the session that qualifies the replacement owns the retirement proposal. Once the
replacement is evidenced and the responsible operator accepts its covered scope, that head:

- maps which bridge obligations the replacement actually covers, preserving unresolved ones;
- repairs or retires this chapter and its BUS manifest entry, and updates authoring/template
  references and future sessions in the same reviewed change;
- preserves enduring rules in their proper existing home, rather than deleting evidence or
  duplicating canon; records the disposition in the development-line ledger.

A new transport alone does not automatically replace result verification, authority boundaries
or coordination rhythm. Partial coverage means a smaller explicitly provisional remainder.
No automatic calendar deletion or indefinite forgotten carry-forward is implied: review the
dependency at each relevant development gate closure until it is explicitly disposed of.

**Never rewrite launched/frozen RUNBOOKs or historical evidence to perform this cleanup.**
An active session records changed applicability in its STATUS. When surviving references still
need this address, leave `file-poke.md` as a short **retired tombstone** naming the replacement,
effective decision and covered/remaining scope; keep its manifest entry marked retired. Delete
the chapter only after a recorded reference check shows no surviving users need that address.
Retaining an address for old records does not keep the provisional behavior in force.
