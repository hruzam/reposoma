# HANDOFF builder — the session's live position

`what: the canonical shape of HANDOFF.md — one per session folder, present tense, overwritten.`
`scope: STYLE + LAW only — vendor and project agnostic. WHERE a session folder lives belongs to`
`the consuming project's rules; this guide owns the file's shape and its tense.`

## What a HANDOFF is

**`HANDOFF.md` is the session's live position.** It answers three questions for whoever arrives
next — human or agent, this hour or next week:

1. Where are we?
2. What is the single next action?
3. What is blocking it, if anything?

It is **not** a log. It is overwritten, not appended. Its whole value is that reading it takes
thirty seconds and leaves you oriented.

## The tense table — why this file exists and the others do not cover it

A session folder holds up to four kinds of file, and they are separated by **tense**. Get this
wrong and they collapse into each other.

| file | tense | who writes | read |
|---|---|---|---|
| `RUNBOOK.md` | **fixed** — the instruction | author, once | at start |
| `HANDOFF.md` | **present** — the position | whoever advances the gate | constantly |
| `_bus/` | **past** — what was exchanged | each seat, own files | on handoff |
| `pad.<N>-<scope>.md` | **live** — the sitting | operator pastes into it | during a sitting |

## When NOT to reach for a HANDOFF

- **History of what happened** → git. Never grow the HANDOFF to hold it.
- **Project-wide doing-state** → the project's `pulse.md`. That is the single canonical
  doing-state; a HANDOFF is *session-scoped* and must not compete with it.
- **Handing a bounded task to another seat** → a `_bus/` POINT, not the HANDOFF.
- **Re-entering a session that already died** → a cold-start card, volatile, in the operator's
  mail inbox.

## Anatomy

**Front-matter — the machine contract.**

```yaml
gate:        # verbatim from RUNBOOK.md — the one thing that closes this session
state:       # fresh | running | blocked | tests | finished
owner:       # the seat currently holding it
next:        # exactly ONE action
blocked_by:  # omit entirely when not blocked
updated:     # YYYY-MM-DD · who
```

**Body — four headings, none optional except Blocked.**

```markdown
## Where we are
Three to five lines, present tense. State, not narrative.

## Next
The one action. If it is a command, make it copy-pasteable — full paths, no `cd` assumption.

## Blocked
What is blocking, and precisely what unblocks it. Name the person or condition.
Omit this heading entirely when nothing is blocked.

## Gate checklist
The RUNBOOK's gate, itemised, ticked. This is how you know the session may close.
```

## The laws

1. **Present tense.** If a sentence describes what *happened*, it belongs in git or the bus.
2. **Overwrite, never append.** A HANDOFF that grows is a journal, and a journal here forks the
   project's `pulse.md`. Pulse forks reliably orphan one branch.
3. **`next` holds exactly one action.** If three things are next, one is next and the other two
   belong in `RUNBOOK.md`. A HANDOFF with a to-do list is a plan, not a position.
4. **Last writer, not single writer.** Whoever advances the gate updates it. This is the one
   file in the session that is deliberately not single-writer — which is why it must stay small
   enough that a full rewrite is cheaper than a merge.
5. **`gate:` is copied verbatim from `RUNBOOK.md`.** If you cannot fill that field, the session
   is not delimited yet — fix the delimitation before opening the folder.
6. **It dies with the session.** Task-scoped, prunable without ceremony, never citable as canon.

## How a machine reads it

The front-matter is the contract; the prose is for humans. A bus or dashboard greps `state:`
and `next:` and needs nothing else. Because the fields are fixed and the filename is fixed,
a hardcoded loader can find every open session in a tree without parsing prose:

```bash
grep -l '^state: running' */HANDOFF.md
```

If a pure-JSON view is ever needed, **generate it** from the front-matter. Never hand-maintain
two copies of one state — that is a fork with extra steps.

## Placement + naming (pointer, not law)

```
<session-root>/<program>-<NN>-<phase>/HANDOFF.md
```

The consuming project owns `<session-root>` (in a temple-style project this is typically
`.dev/session/`). `<program>` is the prefix that groups sibling sessions; `<NN>` is order;
`<phase>` names the gate. **Siblings, never nesting** — the same rule the PAD guide sets.

One session = one gate. If a scope has no gate, it is a task inside a session, not a session.

## Migration hazard — read before renaming anything

In session beds authored **before 2026-08-27**, a lowercase `handoff.md` means the session's
**design and assignment** — the artefact now called `RUNBOOK.md`. That is the *opposite tense*
from this file.

Therefore: **rename as a pair or not at all.**

```
handoff.md  →  RUNBOOK.md        (the instruction)
status.md   →  HANDOFF.md        (the position)
```

Doing one without the other leaves two handoff-shaped files with inverted meanings in one
folder. And do not rename inside a bed whose gate is still open — changing a filename while a
handoff is pending is how work gets lost.

## Style laws

- Short enough to read in thirty seconds. If it is longer, the session is too big.
- Present tense, always.
- Copy-pasteable commands, absolute paths, no assumed shell state.
- One `next`. Always exactly one.
- Say "blocked by majkee" plainly when that is true. A HANDOFF that hides a human dependency
  gets planned around, and the plan is wrong.
