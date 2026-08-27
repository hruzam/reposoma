# RUNBOOK builder — the session launcher

`what: the canonical shape of RUNBOOK.md, and the rule that delimits a session.`
`scope: STYLE + LAW only — vendor agnostic. Any brand authors and reads this shape.`
`companions: raw.guides/handoff/GUIDE.md (the position) · raw.guides/PAD/GUIDE.md (human sittings)`

## What a RUNBOOK is

**`RUNBOOK.md` is the session launcher** — what the gate is, who is working, and what each seat
is told. It is read once at start and rarely again.

It is not a plan, not a log, and not a state file. Fix that in your head first: everything the
runbook says stays true for the whole session. The moment a file needs updating as work
proceeds, it is a `HANDOFF.md`, not a runbook.

## The rule that delimits a session

> **One session = one gate.**

The gate is the single condition that closes the session. When it is met, the session dies and
its folder is prunable. If a scope has no gate, it is a **task inside** a session, not a session.

Naming — siblings, never nesting:

```
<program>-<NN>-<phase>/
```

`<program>` groups related sessions and *is* the wrapper — no wrapper folder is needed. `<NN>`
is order. `<phase>` names the gate.

```
checkout-01-cart          gate: cart passes acceptance
checkout-02-payment       gate: payment methods pass acceptance
checkout-03-shipment      gate: shipment methods pass acceptance
```

Not one session with three scopes. Not three unrelated sessions. One program, three numbered
siblings. This is the same law the PAD guide sets: *split into sibling folders rather than
nested when a sitting grows.*

**Test before opening a folder:** write the `gate:` line. If you cannot, the session is not
delimited yet, and no amount of structure will fix that later.

## Drafted here, lives there

```
~/reposoma/_runbook/<project>/<slug>/     the DRAFTING BENCH
<project>/<session-root>/<program>-<NN>-<phase>/RUNBOOK.md    where it LIVES
```

A runbook may be drafted in the bench before a session exists — that is what the bench is for,
and it is where an authoring agent works. **Promotion into the session folder is what makes it
live.** After promotion the bench copy is a template, never a second state store.

Process state — position, bus, pads, evidence — belongs in the session folder with the project,
**never in the bench.** Pulling process data out of a project into a central hub is how projects
lose their own memory.

## Structure

**Front-matter**

```yaml
goal:            # the point we meet at the end of the process
gate:            # the ONE condition that closes this session — copied into HANDOFF.md verbatim
state:           # fresh | deferred | running | tests | finished | prod.testing | indexed
participant_1:   # [agent-name, {brand, model, effort}, host]
participant_2:   # …one per seat, in order. Include the human when a pad needs their hands.
```

**`prompt-0`, `prompt-<N>`**

- `0` — the master prompt. The seat that owns the session.
- `N` — one per additional seat, in order. In a multi-agent session **each agent has its own
  numbered part**, and reads only that one plus the shared rules above it.

Every prompt is copy-pasteable: absolute paths, no assumed working directory. When two seats run
from different roots, this is not optional — a relative path silently resolves against the wrong
tree.

**`references`**

Point, do not copy. Canon lives with the project; the runbook cites it. A runbook that reproduces
a project's canon has forked it.

**No journal.** History lives in git. Doing-state lives in the project's `pulse.md` — the single
canonical file. A per-runbook journal is a third log competing with both, and pulse forks
reliably orphan one branch.

## The session file set

```
<program>-<NN>-<phase>/
    RUNBOOK.md            fixed    — the instruction (this guide)
    HANDOFF.md            present  — the position   (raw.guides/handoff/GUIDE.md)
    pad.<N>-<scope>.md    live     — human sittings  (raw.guides/PAD/GUIDE.md)
    _bus/                 past     — the exchange, ONLY when ≥2 seats
```

Four kinds, separated by tense. Optional folders — `raw/`, `res/`, `scr/` — are born only when
something needs them, never pre-created.

`_bus/` carries `NN.<seat>.<kind>.md` where kind ∈ {point, return, verdict}. Sequence lives in
the filename; there is no inbox and no read-state. One file per direction per cycle, single
writer each. Fixed names mean a loader can find the exchange without parsing prose.

## Migration hazard

In beds authored **before 2026-08-27**, a lowercase `handoff.md` holds the session's design and
assignment — the artefact this guide now calls `RUNBOOK.md`. Renaming is a **pair operation**:

```
handoff.md  →  RUNBOOK.md      (the instruction)
status.md   →  HANDOFF.md      (the position)
```

Do one without the other and two handoff-shaped files with inverted tenses share a folder. And
never rename inside a bed whose gate is still open.

## Style laws

- Read once. If a section needs updating mid-session, it belongs in `HANDOFF.md`.
- Absolute paths in every prompt, always.
- One `gate:`. If you need two, you have two sessions.
- Point at canon, never reproduce it.
- Name the human as a participant when a pad requires their hands — a runbook that hides its
  human dependency gets planned around, and the plan is wrong.
