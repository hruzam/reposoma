# _bus builder — the session's verified multi-seat exchange

`what: the canonical shape of _bus/ — numbered POINT · RETURN · VERDICT cycles.`
`scope: STYLE + LAW only — vendor agnostic. Transport and notification are out of scope.`
`companions: raw.guides/runbook/GUIDE.md (the session) · raw.guides/status/GUIDE.md`
`(the present position)`
`born: only when a session has two or more active seats. Never pre-create an empty bus.`

## What _bus is

**`_bus/` is the session's past-tense exchange.** A POINT delegates one bounded cycle, a RETURN
reports the responding seat's work, and a VERDICT records independent verification and the
cycle's effect on the gate.

The bus is not doing-state, a chat transcript, an inbox, or a notification mechanism. Current
position lives only in `STATUS.md`. The session and its participants are defined by
`RUNBOOK.md`.

## Disk contract

```text
<session>/_bus/NN.<seat>.<kind>.md
```

- `NN` is the zero-padded cycle sequence. Sequence lives in the filename.
- `<seat>` is the writer. Direction is visible without opening the file.
- `<kind>` is exactly one of `point`, `return`, or `verdict`.

Example:

```text
_bus/
    01.oraculum.point.md
    01.cartan.return.md
    01.oraculum.verdict.md
```

There is no inbox, archive, unread marker, cursor, or read-state. Files remain in cycle order
until the session closes and the folder is pruned. Filename presence does not prove that a
claim was read or verified; only the VERDICT closes that edge.

## File ownership and cycle economy

1. **Single writer per file.** Never edit another seat's POINT, RETURN, or VERDICT.
2. **One file per direction per cycle.** Amend before handing off; after handoff, correction is
   a new numbered cycle, not a second RETURN or a suffix swarm.
3. **No file per step.** Commands and observations are fields inside one RETURN.
4. **No bus for one seat.** A single-seat session writes STATUS and evidence directly.
5. **No hidden transport.** A runtime, human, or project mechanism may point a seat at the next
   filename, but `_bus/` itself promises no doorbell or watcher.

## POINT — bounded assignment

A POINT is terse and executable. It contains:

```yaml
cycle: <NN>
from: <seat>
to: <seat>
scope: <one bounded task>
paths: <absolute read/write paths and ownership boundary>
gates: <forbidden operations and approvals>
done_when: <observable completion conditions>
return_to: <absolute NN.<seat>.return.md path>
```

Add exact commands or references only when the responding seat needs them. Do not include a
project narrative or copy canon into the POINT. A task that cannot be bounded by paths, gates,
and done-when is not ready to enter the bus.

## RETURN — six fields, all mandatory

The responding seat writes exactly one RETURN with these six headings:

```markdown
## 1. Files changed
<path + nature of each change; "none" is valid>

## 2. Commands and outcomes
<exact command + exit/result for every verification-relevant command>

## 3. Evidence paths
<artifact, diff, report, or output path supporting the claims>

## 4. Mismatches discovered
<documentation/map versus disk/behavior; "none" is valid>

## 5. Recommended next task
<one bounded recommendation; this does not replace STATUS.next>

## 6. Remaining uncertainty
<what is still unverified; "none" is valid, silence is not>
```

Field 6 is mandatory because omitted uncertainty is indistinguishable from forgotten
uncertainty. A recommendation in field 5 is advice to the verifying seat; it becomes current
work only if that seat writes it into STATUS.

## Curvature rule

> **When a map and the observed artifact disagree, the disagreement is the artifact. Name it,
> verify both sides, and never flatten it to the tidier version.**

Curvature includes a stale instruction, a report contradicted by the diff, a command whose
observed result differs from its expected result, or two runtime views that disagree. Record it
in RETURN field 4 and carry its verified disposition into the VERDICT. A mismatch is not an
embarrassment to edit away; it is information about the connection between two frames.

## Verifying a RETURN

**A RETURN is a set of claims and pointers, never evidence by itself.** The receiving/verifying
seat checks the cited artifacts before accepting it.

Verification, in order:

1. resolve every cited path and inspect the actual diff or artifact,
2. compare changed files with the POINT's ownership boundary,
3. rerun safe checks in proportion to risk, or state why a check cannot be rerun,
4. compare each stated command outcome with available output and repository state,
5. test every reported mismatch against both descriptions, and
6. preserve unverified claims as uncertainty — never upgrade them by repetition.

If evidence is missing, inaccessible, or mutable without a stable pointer, the claim is
`UNVERIFIED`. If disk contradicts the RETURN, the observed contradiction is recorded as
curvature. The verifier does not silently fix the artifact while verifying it; a fix is a new
cycle with its own POINT.

## VERDICT — what closes a cycle

The seat that verifies the RETURN writes one VERDICT. It contains:

```yaml
cycle: <NN>
point: <absolute or session-relative POINT path>
return: <absolute or session-relative RETURN path>
verified_by: <seat · date · host when relevant>
disposition: <ACCEPT | REVISE | STOP | BLOCKED>
gate_effect: <advanced | unchanged | closed, with durable evidence pointer>
status_rewritten: <yes | no + reason>
```

Then three sections:

```markdown
## Claim verification
| RETURN claim | cited evidence | observed result | CONFIRMED / REFUTED / UNVERIFIED |

## Curvature
<every disagreement and its disposition; "none" is valid>

## Uncertainty disposition
<where each remaining uncertainty went: next cycle, durable issue/evidence home, or accepted
limit; "none" is valid>
```

A cycle is closed only when the VERDICT:

- checks the RETURN against cited artifacts,
- names all curvature rather than smoothing it away,
- gives one disposition,
- states how the verified result affected the gate,
- disposes of every remaining uncertainty, and
- confirms that STATUS was rewritten to the new present position, or explains why the cycle is
  BLOCKED and STATUS could not advance.

The VERDICT records a past transition. It must not grow a second next-action list; `STATUS.next`
remains the only current next action.

## On session closure

Promote evidence and decisions that outlive the gate, remove the session from the project pulse
router, and prune the session directory according to the RUNBOOK GUIDE. Do not transplant `_bus/`
into a permanent mail archive merely because it contains history. Durable facts graduate to
their own homes; the exchange dies with the gate.

## Style laws

- Number cycles in filenames; do not invent read-state.
- One writer and one file per direction per cycle.
- POINT scopes; RETURN reports; VERDICT verifies. Do not mix their jobs.
- Exact commands and absolute paths; no assumed shell state.
- Bare claims are never evidence, including claims made by another agent.
- `none` is explicit. Silence is incomplete.
- The bus appears at two seats and disappears with the session.
- Preserve artifact case in prose: RUNBOOK, STATUS, PAD, POINT, RETURN, and VERDICT. Preserve
  exact disk case in paths and filename kinds: `RUNBOOK.md`, `STATUS.md`, `pad.*.md`, `_bus/`,
  `*.point.md`, `*.return.md`, and `*.verdict.md`.
