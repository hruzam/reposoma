# program-pulse — the octopus task-line contract  `[CANON — ADR 0012]`

**One durable, hand-editable buffer the head writes, Vara runs, coders read, and the
human pulls from. Markdown, line-per-task, closed-set status. Not a new format — the
pulse-per-line, given a grammar.**

`date: 2026-07-16 · author: @Atlas · status: PROMOTED to canon via temple/decisions/0012-program-pulse-contract.md — gaveled @majkee 2026-07-16 (Houston-stamp delegated to @Atlas for this promotion). This file is the living spec; the lock lives in 0012. Append-only once locked (doctrine §1b — supersede, never edit).`

---

## Raison d'être (scope guard — added 2026-07-16, pilot-confirmed)
The octopus is for **semi-autonomous cheap multi-run with the operator OUT of the orchestrator
seat.** Operator-present work stays on the **direct head→coder path** (no buffer, no leash).
This is the line that keeps the machine from being *a bazooka on a fly*: do not loop a trivial,
operator-present task through the full buffer / Vara / Assay loop — the pilot measured one
5-line edit at ~40k through the full loop. Use the octopus when you want to **step out of the
chair** and let a batch run semi-autonomously; the @Assay gate + human-gate-on-error are the
substitute for the eyes you've removed.

## Why markdown (not JSON)

Consumers = head (LLM) · Vara (LLM) · coders (LLM) · **majkee (human, hand-edits)** ·
the trigger hook (machine, reads one field). Four of five favour markdown; the fifth
needs only the status token, which a fixed-position grammar makes greppable. JSON costs
~30–40% more tokens/line, breaks on hand-edit, diffs noisily. Markdown is already the
pulse substrate. **MD wins on every axis that matters here.**

## The line grammar

```
- [STATUS] <task-id> · <scope/slug> · owns: <file-globs> · gate: <assay|human|skip> · <one-line intent> · log: <pointer>
```

- `STATUS` — closed set, fixed position (position 1, bracketed) → one-line greppable.
- `task-id` — stable handle (T1, T2…). Never reused.
- `scope/slug` — the task's project scope. Lets ONE program span multiple projects; the
  coder/Vara reads *that* task's context fresh.
- `owns:` — the file-globs this task may write. **No two non-`done` lines may share a
  glob** — this is the parallel-write race guard, enforced before dispatch.
- `gate:` — who blesses completion. `assay` (spawn @Assay) · `human` (majkee reviews) ·
  `skip` (head's judgment, trivial change). Controls the token cost of verification
  per task — you don't pay the gate tax on a one-line fix.
- `log:` — pointer to the task's own drop-file (coder writes progress/errors here; the
  buffer line stays a single line).

## Status lifecycle (closed set)

```
issued ──▶ staged ──▶ review ──▶ done
             ▲            │
             └── FAIL ────┘        (Assay/human NOK → back to staged, coder reiterates)

any ──▶ parked     (living, carried to next session — NOT archived)
any ──▶ blocked    (waiting on brain/human — dead-man's-switch, never auto-proceeds)
```

- `issued`  — queued, not picked up.
- `staged`  — a coder holds it, in progress.
- `review`  — coder done; awaiting the declared `gate`.
- `done`    — gate PASS; committed (to a program/throwaway branch, never `core`, unless
  a human blessed a load-bearing path).
- `parked`  — still living, deferred, carried forward.
- `blocked` — waiting on brain/human input; **parks, does not guess forward.**

## Last-turn discipline (your point 2)

At session close: **archive `done` lines** (move to `program.pulse.archive.md`), **keep
`parked` and `blocked` lines living** in the buffer. The buffer stays small — only
open/living work. This IS the head's externalize-and-forget: closed work leaves the
context, living work persists as a single line.

## Pull gate (human decides batch size)

A planning session (head + brain) emits `issued` lines. **majkee decides how many** enter
a run:
- **1 issued line** → the head runs it directly. No Vara (she'd be redundant boot tax).
- **N issued lines** → **Vara runs the program** — holds the loop, dispatches coders in
  parallel (respecting `owns:` disjointness), collects checkpoints, keeps the head clean.

## Head ↔ `program.pulse.md` wiring (session ↔ buffer)

`program.pulse.md` is a **shared, persistent buffer** at the project root (sibling to the
other pulses; project-relative — no absolute path, 0004 discipline). It outlives any one
session. Each planning / execution session's head works from its own `session/<slug>/`
area and touches the buffer with exactly two ops:

- **add-to-line** — the head (with the brain) emits new `issued` lines into
  `program.pulse.md`. This is how a planning session deposits work.
- **pull-from-line** — the head reads / claims a line to run (`issued → staged`), routing
  by the line's `scope/slug`.

**Post-process reconciliation — the head keeps buffer authority.** Dispatch does NOT lock
the head out. After a run completes — or when an issue surfaces mid-run — the head may
**reconcile**: re-read the resulting lines, correct status, re-issue a reconfigured line,
split or merge tasks. The buffer's *shape* is owned by the head across the whole arc, not
frozen at dispatch. Vara only flips status *during* an N-batch run; the head owns
**add / pull / reconcile** *around* it. This is the concrete meaning of "1 task = head,
N tasks = Vara."

## The loop (per line, when Vara runs it)

```
Vara reads line → dispatches coder (by scope + task)
  coder works → drops progress to log: → returns report → Vara flips status
    finished  → status: review → release gate (Assay | human | skip)
      gate PASS → status: done → delegate commit to a Bash seat (Vara has no Bash)
      gate FAIL → status: staged → coder reiterates (held on line)
    error/help → status: blocked → surface to human; coder parks, does NOT guess
  3 consecutive fails on a line → Vara stops, marks reconfigure, surfaces to majkee
```

(Stop-criteria, advisor-on-stuck, and human-gate-on-error already live in Vara's
definition — this contract just gives them a line to write to.)

## Circuit breakers (non-negotiable before any headless run)

1. **Program-level token ceiling** — a hard budget on the whole run (Vara's `maxTurns`
   is per-agent, not per-program).
2. **Human gate at commit** for any load-bearing path. Auto-commit only to a program /
   throwaway branch. **Never auto-commit to `core`.**
3. **Dead-man's-switch** — a `blocked` line waits for human input; if none arrives it
   stays parked. It never auto-proceeds on a guess.
4. **Vara's "3 fails → stop"** stays.

## Promoted — and what's still next
- **Promoted to canon** as **ADR 0012** (`temple/decisions/0012-program-pulse-contract.md`),
  gaveled by @majkee 2026-07-16 via delegated Houston-stamp. This file is the living spec;
  0012 is the lock. Append-only once locked (doctrine §1b) — supersede, never edit.
- **Next cut (not built):** the **review-companion skill** — your "assistant reads with me
  what was done, we test together, or I alone." Walks a human through the `review` / `done`
  lines + logs. The last unbuilt piece of the octopus.
