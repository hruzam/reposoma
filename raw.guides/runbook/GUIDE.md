---
title: RUNBOOK builder — the session launcher
scope: runbook
audience: agent + operator + builder
machine: both
verified: 2026-09-17
---

# RUNBOOK builder — the session launcher

`what: the canonical shape of RUNBOOK.md, and the rule that delimits a session.`
`scope: STYLE + LAW only — vendor agnostic. Any brand authors and reads this shape.`
`companions: raw.guides/status/GUIDE.md (the position) · raw.guides/PAD/GUIDE.md (human sittings)`
`· raw.guides/bus/GUIDE.md (multi-seat exchange)`
`extends: res/token-economy.md (delegation shape · spend record) · res/cross-vendor-seat.md (instrument tuple · tunnel handle · enable layers) — both DRAFT, awaiting majkee gavel, 2026-09-03`
<<<<<<< Updated upstream
`extends: res/research.md (big-scope research gate — nablarva) · res/csharp-head-protocol.md (the cSharp protocol — head posture · transfer ritual · letter to successors) — both GAVELED by majkee 2026-09-03, protocol framing + successors letter 2026-09-04 (sessions fc-sync.oraculum.reverse-tunnel.cSharp · roster-reform-01-triad)`
=======
`extends: res/research.md (big-scope research gate — nablarva) · res/csharp-head.md (cSharp head posture · transfer ritual) — both GAVELED by majkee 2026-09-03 (session fc-sync.oraculum.reverse-tunnel.cSharp)`
>>>>>>> Stashed changes
`boundary: Sella governs primitive-BUILDING; this canon governs session SHAPE — different objects, neither wins; temple/precedence.md orders cross-domain collisions (0013, 2026-09-03)`
`revised: 2026-08-27 after triangulated audit (Fable · Janus · @Cartan/Codex) — HANDOFF name`
`retired before first use; STATUS.md carries the position. Authority model per majkee's gavel:`
`two files are allowed, two authorities are not.`

## Manifest

- `res/cross-vendor-seat.md` · chapter · DRAFT — cross-vendor seat instrument, tunnel handle, and enable layers
- `res/csharp-head-protocol.md` · chapter · GAVELED 2026-09-04 — cSharp protocol: head posture, transfer ritual, and letter to successors
- `res/help-tree.md` · chapter · [DRAFT — pending majkee's gavel, 2026-09-17] — in-TUI browsable help tree for session/runbook.py (`?` key), converged from the agentive-help phone-lookup pattern
- `res/fanout-turns.md` · chapter · GAVELED 2026-09-05 — full-session fan-out, coordination join, and cold recovery
- `res/presence-board.md` · chapter · GAVELED 2026-09-09 — advisory cross-session attachment records and detach boundary
- `res/research.md` · chapter · GAVELED 2026-09-03 — big-scope pre-RUNBOOK research gate
- `res/token-economy.md` · chapter · DRAFT — delegation shape and spend record
- `ast/` · static copy assets — `RUNBOOK.template.txt`; inert authoring source, never a session bed
- `raw/` · collected runbook substrate reached only by explicit path; not served by the resolver

## What a RUNBOOK is

**`RUNBOOK.md` is the session launcher** — what the gate is, who is working, and what each seat
is told. It is read once at start and rarely again.

It is not a plan, not a log, and not a state file. Everything the RUNBOOK says stays true for
the whole session. The moment a file needs updating as work proceeds, it is `STATUS.md`, not a
RUNBOOK. For the same reason the RUNBOOK carries **no `state:` field** — a mutable field in a
read-once file is a second state surface. Lifecycle is positional: outside an owning session
folder = inert authoring material, in the session folder = live, pruned = closed. The live
position lives in `STATUS.md` alone.

## The rule that delimits a session

> **One session = one gate.**

The gate is the single condition that closes the session. When it is met, the session dies and
its folder is prunable. If a scope has no gate, it is a **task inside** a session, not a session.

If the gate *changes* mid-flight: the session dies and a numbered sibling opens with the new
gate. Same law — a session never mutates its own gate.

Naming — siblings, never nesting:

```
<program>-<NN>-<phase>/
```

`<program>` groups related sessions and *is* the wrapper — no wrapper folder. `<NN>` is order.
`<phase>` names the gate.

```
checkout-01-cart          gate: cart passes acceptance
checkout-02-payment       gate: payment methods pass acceptance
checkout-03-shipment      gate: shipment methods pass acceptance
```

**Test before opening a folder:** write the `gate:` line. If you cannot, the session is not
delimited yet, and no amount of structure will fix that later.

## The golden rule — before any build

> **Reinventing the wheel? Isn't it already part of the harness by vendor, or a smart lifehack?**

Binding on every mechanism a session proposes, and blind to domain — paid client work and
personal projects follow the same law. Check the native surface first (`/help`, changelog,
existing shims/skills/applications); build only the delta; name the future native change that
would retire it.

At small scale this rule is a check inside authoring — the first RUNBOOK of a toolbox applies it
inline, and no research session exists for it. At BIG scale — a complex application, a large
task-group, a standalone system — the rule becomes a gate of its own **before any RUNBOOK
exists**: a research session in nablarva whose verdict is *worth reinventing, or not*. Wiring,
bounds, and the three checks: `res/research.md`.

## One authority — the seam with pulse.md

The project's `pulse.md` is a bounded **router**: active session slug, gate, and the exact
STATUS path. It carries no next action and no session narrative. `STATUS.md` is the **sole
doing-state for its gate**. (majkee gavel 2026-08-27; amends the prior "pulse = the only
doing-state" reading of flag L9.)

The seam test, mechanical, thirty seconds:

> **Would this line still be true and useful after the gate closes?** → it belongs in `flag.md`
> or `pulse.md`. **Does it die with the gate?** → it belongs in `STATUS.md`.

Why this is law and not preference: the live Termbrana bed carried three files each claiming
the next action (`status.md` 08-15, `pulse.md` 08-24, a CS card 08-24) — a fresh agent needed
undocumented precedence knowledge to resume. File count is the symptom; **duplicated authority
is the cause.**

## Authored where it lives

```
<project>/<session-root>/<program>-<NN>-<phase>/RUNBOOK.md    where it LIVES
```

An actual RUNBOOK is authored only in the owning project's declared session root. Temple carries
the doctrine and an inert copy source at `ast/RUNBOOK.template.txt`; it does not own sessions,
draft session beds, or project process state. Copy the asset into the new session folder, then
fill it there. Process state — position, bus, pads, evidence — stays with the project.

Legacy material elsewhere in reposoma is historical substrate, not an authoring target, template
registry, or exception to this rule.

## Structure

For a copy-ready skeleton, use `ast/RUNBOOK.template.txt`. The structure below remains the law;
the asset is only a convenience and must change with this section when their shapes diverge.

**Front-matter**

```yaml
goal:            # the point we meet at the end of the process
gate:            # the ONE condition that closes this session — STATUS.md carries it verbatim
participant_1:   # [agent-name, {brand, model, effort}, host]
participant_2:   # …one per seat, in order. Include the human when a PAD needs their hands.
```

Participant seat names are unique within one RUNBOOK; two incarnations of one agent are two
seats, and BUS filenames use the declared seat name.

Only the declared `status_owner` replaces STATUS; a verifier or witness attests the observed
effect in VERDICT `status_rewritten:` and does not rewrite STATUS unless it is also the
`status_owner`.

No `state:` field — see above. No mutable field of any kind belongs in this file.

<<<<<<< Updated upstream
A multi-session arc's head seat may carry a `head_note:` naming its **protocol** — the head
posture the arc runs under. Today exactly one is gaveled: the cSharp protocol (authors the
RUNBOOK and stays as navigator/status_owner): `res/csharp-head-protocol.md`. A protocol is
named for the posture, never for the seat that fills it; siblings open by promotion, never by
design.

A cSharp coordinating independent full CLI sessions in one decision uses
`res/fanout-turns.md`; ordinary in-window subagent delegation remains governed by
`res/token-economy.md`.
=======
A multi-session arc's head seat may carry a `head_note:` (the cSharp posture — authors the
RUNBOOK and stays as navigator/status_owner): `res/csharp-head.md`.
>>>>>>> Stashed changes

**`prompt-0`, `prompt-<N>`**

- `0` — the master prompt. The seat that owns the session.
- `N` — one per additional seat. Each agent reads its own numbered part plus the shared rules.

Every prompt is copy-pasteable: **absolute paths, no assumed working directory.** When two
seats run from different roots this is not optional — a relative path silently resolves against
the wrong tree.

**Known constraints and destructive holds.** Constraints known *at authoring time* — ownership
boundaries, forbidden operations, cross-session holds — live here, in the RUNBOOK, because they
are fixed. Constraints *discovered mid-session* land in `STATUS.md` under `holds:` (see the
STATUS GUIDE) — a read-once file cannot carry what is learned after the first read.

**`references`** — point, do not copy. Canon lives with the project; a RUNBOOK that reproduces
canon has forked it.

**No journal.** History lives in git. Doing-state lives in `STATUS.md`. A per-session journal
is a third log competing with both.

## The session file set

```
<program>-<NN>-<phase>/
    RUNBOOK.md            fixed    — the instruction (this guide)
    STATUS.md             present  — the position   (raw.guides/status/GUIDE.md)
    dock.md               scratch  — operator handwriting; uncanonical, prunable,
                                     never citable as truth (flag L9). STATUS never
                                     points into dock.
    pad.<N>-<scope>.md    live     — human sittings  (raw.guides/PAD/GUIDE.md)
    _bus/                 past     — the exchange    (raw.guides/bus/GUIDE.md);
                                     only when ≥2 seats
../GLOSS.<slug>.md        across   — the why (operator learning, session ROOT, not the bed)
                                     (raw.guides/gloss/GUIDE.md)
```

Only `RUNBOOK.md` and `STATUS.md` are mandatory. Everything else is born on need, never
pre-created. Filename case is **human ergonomics only** — uppercase sorts first in `ls` and
marks meta-files; no agent runtime loads any of these automatically (verified 2026-08-27,
@Epoch: auto-loading is exact-string match on reserved names, never a case heuristic). A
session file is read because a prompt points at it — so the prompts must point at it.

Case law (majkee, 2026-08-27): artifact names are uppercase in prose — RUNBOOK, STATUS, PAD,
POINT, RETURN, VERDICT. Disk case is exact and unchanging — `RUNBOOK.md`, `STATUS.md`,
`pad.*.md`, `_bus/`, `*.point.md`, `*.return.md`, `*.verdict.md`, `pulse.md`, `flag.md`,
`dock.md`.

## On gate closure

Promote what survives (evidence → the project's evidence home, results → commits or canon),
remove the session from `pulse.md`'s router line, prune the directory. PADs survive only when
they *are* the evidence artifact. A moved PAD leaves a one-line "moved, safe to delete" stub.

## Style laws

- Read once. If a section needs updating mid-session, it belongs in `STATUS.md`.
- Absolute paths in every prompt, always.
- One `gate:`. If you need two, you have two sessions.
- Point at canon, never reproduce it.
- Name the human as a participant when a PAD requires their hands — a RUNBOOK that hides its
  human dependency gets planned around, and the plan is wrong.
