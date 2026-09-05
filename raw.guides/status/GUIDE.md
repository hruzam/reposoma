---
title: STATUS builder — the session's bounded recovery snapshot
scope: status
audience: agent + operator + builder
machine: both
verified: 2026-09-05
---

# STATUS builder — the session's bounded recovery snapshot

`what: the canonical shape of STATUS.md — one present-tense position per session gate.`
`scope: STYLE + LAW only — vendor agnostic. Any brand writes and resumes this shape.`
`companions: raw.guides/runbook/GUIDE.md (the fixed launcher) · raw.guides/PAD/GUIDE.md`
`(human sittings) · raw.guides/bus/GUIDE.md (multi-seat exchange)`
`gaveled: 2026-08-27 (majkee) after triangulation by Fable · Janus · @Cartan/Codex.`

## What STATUS is

**`STATUS.md` is the sole doing-state for one session gate.** It says what is observably true
now, what may have been interrupted, and the one action that advances the gate next. It is read
throughout the session and dies when the gate closes.

The authority boundary with project `pulse.md` and the one-session-one-gate law live in
`raw.guides/runbook/GUIDE.md`. Point there; do not reproduce a second authority model here.

## The seam test

Janus's mechanical test decides which side owns a line:

> **Would this line still be true and useful after the gate closes?** → `flag.md` or the
> `pulse.md` router. **Does it die with the gate?** → `STATUS.md`.

Apply the test to every update. A durable decision, product fact, or evidence result does not
become safe merely because STATUS mentions it; promote it to its real home and leave a pointer.

## The 03:00 standard

Power fails halfway through the next action. A fresh agent with zero session context opens the
folder. In thirty seconds, STATUS must let that agent:

1. resolve the host and exact worktree,
2. identify the last verified checkpoint,
3. see what action may have run partially,
4. run a **read-only recovery probe** that distinguishes “never started” from “partially ran,”
5. respect every live hold, and
6. take exactly one safe next action with an observable success condition.

File presence alone is not a recovery probe. LarvaTmux carried a stale-tap trap: the `.tap` file
could exist while the pane pipe was dead, so the PAD checked `#{pane_pipe}` directly before
continuing. If STATUS cannot support that class of cold resume, it is incomplete regardless of
how polished its prose is.

> When `delegated:` is present, `recovery_probe:` reconciles each row against the corresponding
> POINT, any RETURN, and the contents—not mere presence—of any VERDICT, following
> `raw.guides/runbook/res/fanout-turns.md`.

## Anatomy — fixed fields

Keep the file short enough to read in thirty seconds. These fields are all mandatory; `none` is
a value, while silence is ambiguity.

```yaml
updated: <YYYY-MM-DD HH:MM zone>
writer: <seat · vendor>
host: <machine identity>
worktree: <absolute repo · branch · HEAD · clean | dirty paths>
gate: <verbatim from RUNBOOK.md>
checkpoint: <last verified fact · durable evidence or commit pointer>
in_flight: <none | action that may be partially applied + observable side effects>
recovery_probe: <exact read-only check + how to interpret its outcomes>
holds: <none | every current destructive, ownership, or cross-session constraint>
next: <exactly one action; absolute command or unambiguous human action>
expected: <observable result that proves next succeeded>
```

`worktree:` names dirty paths, not merely “dirty.” `checkpoint:` is one current safe edge, not a
`Done` section. `in_flight:` describes uncertainty honestly; do not convert “unknown” into
“probably completed.” `expected:` is evidence the next writer can check, not an intention.

### Optional full-session fan-out fields

`delegated:` — optional only while one full-session coordination turn is open; one row per
current branch. Each row has exactly `cycle`, `to`, `turn`, and `awaiting`; `awaiting` is
`return` or `verdict <seat>`. Semantics: `raw.guides/runbook/res/fanout-turns.md`.

`join_when:` — optional and exactly one while that turn is open; it names the observable cycle
obligations whose verified contents permit the owner to replace STATUS. Semantics:
`raw.guides/runbook/res/fanout-turns.md`.

`next:` remains singular during fan-out and names the next verification or the join, never the
workers' task list.

## The crash-safe update edge

Before a non-idempotent or externally visible action, rewrite `in_flight:` to name the action
and its possible side effects. If power fails before the action starts, `recovery_probe:` proves
that; if it fails halfway through, the same probe exposes the partial state.

After the action:

1. run the stated verification,
2. promote any durable result to its real evidence or canon home,
3. rewrite `checkpoint:` to the verified edge,
4. set `in_flight: none`, and
5. replace `next:` and `expected:` with the single new pair.

An update is not complete while STATUS describes an action that has already crossed its
verification edge.

## Replacement law

> **Bounded replacement snapshot, not a chronological journal.**

This semantic law replaces the proposed mechanical “never append” prohibition. Append behavior
is not observable from the prose, and forbidding it does not prevent two stale summaries from
duplicating authority. The live Termbrana `status.md` was added in one transport commit, not
appended, yet its past-tense `Done` section was initially mistaken for an append-law violation.

Rewrite the whole snapshot because the friction is useful. A `holds:` line survives only when
the writer retypes it as still true. When its retiring condition passes, it is not retyped, and
it is gone. The same friction removes stale blockers, dirty paths, and recovery warnings instead
of letting them accrete by inertia.

History lives in git, `_bus/`, PADs, and promoted evidence. STATUS may point to that history; it
does not retell it.

## Tense separation

| file | tense | writes | read |
|---|---|---|---|
| `RUNBOOK.md` | **fixed** — goal, gate, prompts, authored constraints | author, once | at start |
| `STATUS.md` | **present** — position and recovery edge | whoever advances the gate | constantly |
| `dock.md` | **scratch** — disposable handwriting | operator or seat | only when useful |
| `pad.<N>-<scope>.md` | **live** — human sitting and raw receipt | operator with driver | during sitting |
| `_bus/` | **past** — multi-seat exchange | one writer per file | at handoff/verification |

The old HANDOFF guide's useful laws survive here: present tense, exactly one next action,
thirty-second readability, and a last-writer update model. The filename `HANDOFF.md` does not;
it was retired before first use because lowercase `handoff.md` already means design/assignment
in existing beds.

## dock.md boundary

**STATUS never points into `dock.md`.** An actionable dock item is copied into the next STATUS
snapshot with a durable evidence pointer, or it remains explicitly disposable. A dock reference
would make uncanonical handwriting a hidden prerequisite for recovery.

Do not assume scratch absorbs pressure merely because it exists. Nablarva's `dock.md` was
gaveled on 2026-08-02 and still contains only its seven-line header: zero entries. The convention
must remain safe when a tired operator writes directly into STATUS or nowhere at all.

## Why the fields have teeth — observed failures

- **Competing next actions:** Termbrana session 02 had `status.md` dated 2026-08-15 pointing
  first to the runtime PAD, project `pulse.md` dated 2026-08-24 inserting README review before
  that PAD, and `CS.termbrana-readme.2026-08-24.md` carrying a third re-entry order. A fresh
  reader needed undocumented precedence knowledge. Two files are allowed; two authorities are
  not.
- **A hold that could destroy a precondition:** larvaTmux `stream.md` recorded `do_not:` rules
  and the protected order `T1 → T3 → teardown → signal K2`. That is a live `holds:` entry until
  T3 retires it, not history to be discovered after teardown.
- **A lying artifact:** larvaTmux `pad.3-interference.md` checked real pane-pipe state because a
  stale tap file could fake liveness. That is the model for `recovery_probe:`: test the mechanism,
  not the convenient residue.

## Style laws

- Present tense. Narratives and completed-task lists do not belong here.
- One `next:` and one matching `expected:`. A list of next actions is a plan.
- `gate:` is verbatim from RUNBOOK. If it changes, the session closes and a sibling opens.
- Every command is copy-pasteable: absolute path, no assumed working directory.
- Name human ownership plainly. A hidden human dependency gets planned around.
- Name uncertainty plainly. `none` is valid; omission is not.
- Point to durable evidence. Never cite STATUS itself as product truth.
- Rewrite after every verified transition and before yielding the seat.
- Preserve artifact case in prose: RUNBOOK, STATUS, PAD, POINT, RETURN, and VERDICT. Preserve
  exact disk case in paths: `RUNBOOK.md`, `STATUS.md`, `pad.*.md`, `_bus/`, `pulse.md`,
  `flag.md`, and `dock.md`.
