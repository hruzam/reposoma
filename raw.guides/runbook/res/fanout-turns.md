---
title: cSharp fan-out turns — full-session coordination without a fourth BUS kind
chapter-of: runbook
---

# cSharp fan-out turns

Use this chapter only when one persistent cSharp head coordinates at least two independent full
CLI sessions opened from one decision. In-window subagents are not full-session fan-out; their
delegation stays under `res/token-economy.md`.

## Coordinates and authority

`cycle: NN` orders one POINT → RETURN → VERDICT exchange. Optional `turn: NN` groups the cycles
opened by one head decision. Exactly one coordination turn may be open in a session: one open
turn, one `join_when:`, and one singular `next:`. Cycle and turn numbers may interleave because
they order different things; history is never renumbered to make them align.

The RUNBOOK declares the unique seats, head, and `status_owner`. STATUS owns the open turn and
its present obligations. BUS remains past-tense receipts. A human may relay an absolute POINT
path verbatim, but transport supplies no delivery or read claim.

## Open and dispatch a turn

The head writes every POINT for the decision, then replaces STATUS before relay. STATUS carries
one bounded `delegated:` row for each current branch, exactly one `join_when:`, a content-sensitive
`recovery_probe:`, and one `next:`/`expected:` pair.

A `delegated:` row has exactly `cycle`, `to`, `turn`, and `awaiting`. `awaiting` is `return`, which
implies the POINT's `to:` seat, or `verdict <seat>`, which names the witness. The field carries no
timestamps, sent/acknowledged claims, progress notes, or recommendations. Facts that constrain
the gate belong in `holds:`; other narration belongs nowhere in STATUS.

The receiver resolves its declared RUNBOOK seat before work. If POINT `to:` or the seat encoded
by `return_to:` differs from that seat, it stops before work and reports the mismatch; the
outstanding STATUS row remains true. The carrier never repairs or reinterprets the POINT.

## Verify branches

Each RETURN remains bound to its cycle and POINT path; it does not echo a trusted `turn:` claim.
The named witness verifies content and writes the cycle's single VERDICT. If the witness is not
the `status_owner`, `status_rewritten: deferred: turn NN` may name only the currently open turn.
Only the owner replaces STATUS. If the referenced turn has already joined, the VERDICT uses
`no + reason` or defers to the then-open turn; it never points at a closed join.

ACCEPT, STOP, and BLOCKED are terminal branch dispositions. REVISE closes the cycle but does not
satisfy the branch: the head opens one linked corrective cycle in the same turn and replaces
that branch's observable `join_when:` obligation with the corrective cycle. No old receipt is
edited or renumbered.

A STOP or BLOCKED VERDICT may use `return: none + reason` only when no RETURN exists. It verifies
the absence, records why the cycle cannot receive a RETURN, and closes no other branch. ACCEPT
and REVISE require an actual RETURN. If a RETURN later appears for a cycle closed through this
exception, the old cycle remains closed and receives no second VERDICT; the head opens a new
numbered cycle to assess the new information.

## Join

A turn joins only when the `status_owner` checks the current `join_when:` obligations against
the POINT, RETURN where required, and terminal VERDICT contents, then replaces STATUS with the
verified present position. The replacement removes the joined turn's `delegated:` and
`join_when:`, advances `checkpoint:` with evidence pointers, resolves or retypes live `holds:`,
and provides one new `next:`/`expected:` pair. That verified STATUS replacement is the join.

Join is not a fourth BUS artifact, a specialized VERDICT, or a requirement that the replacement
share a repository commit with the receipts. Repository commit policy remains the owning
repository's separate law.

## Cold recovery and late artifacts

During an open turn, `recovery_probe:` reads every STATUS row and reconciles its coordinates and
seats with the POINT, any RETURN, and the VERDICT's `cycle`, `turn`, `return`, `disposition`, and
`status_rewritten:` contents. A VERDICT on disk while STATUS still says `awaiting: verdict` is
ordinary interrupted-head partial state. Disk beats stale STATUS, but the recovering head names
the difference before replacing the snapshot; it does not edit another writer's receipt.

Late artifacts never overwrite history. Information arriving after its turn joined is assessed
through a new numbered cycle and carried into the current STATUS as curvature or a hold when it
still affects the gate. `deferred: turn NN` may refer only to the turn open when that VERDICT is
authored.

## Boundary and retirement

This mechanism introduces no scheduler, inbox, read-state, delivery promise, mutable BUS file,
specialized join receipt, fourth BUS kind, vendor invocation syntax, or runtime implementation.
The chapter is the sole home of full-session fan-out operations; RUNBOOK, BUS, and STATUS expose
only authority, schema, and routing seams.

A native durable cross-session join that preserves equivalent sovereign receipts retires this
file-plane delta. Until then, the file plane coordinates full sessions across windows, hosts, or
vendors without pretending that native subagent fan-out and human relay are the same mechanism.
