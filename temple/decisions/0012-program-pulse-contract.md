# Decision Record — program-pulse: the octopus task-line contract

`status: GAVELED-BY-OPERATOR 2026-07-16 (@majkee), via a one-time Houston-stamp delegated to @Atlas for this promotion. Append-only once committed (doctrine §1b — supersede, never edit).`
`date: 2026-07-16 · host: home · author-seat: @Atlas (rn arch). Spec detail lives in raw.research/program-pulse.contract.claude.md (point-never-copy — pointed, not copied); this record locks the shape.`
`shape: light ADR — context · locked shape (L1–L8) · consequences · residual.`
`numbering: takes 0012 — 0011 is RESERVED for @Oraculum's in-flight draft (writer-partition-vendor-surfaces, in _mail/houston/inbox/), not yet a decision file. Skipping ahead avoids a ledger collision.`
`guards checked: 0004 (project-relative anchors, no ~/ in spec) · 0006 (model×effort — @Assay = Sonnet by role; executor mid-tier name still open) · point-never-copy (spec pointed).`

---

## Context

The "octopus" orchestration design (majkee, 2026-07-16 rn-arch session) reached the point
where the head + parallel coding tentacles needed a **spine**: a durable place to hold the
task line so the head can externalize-and-forget (the load-bearing discipline from the
measured token study, `raw.research/capabilities-economy-hygiene.claude.md`). Most of the
control loop already exists in `@Vara`'s definition (stop-criteria, file-race guard,
human-gate-on-error, advisor-on-stuck). What was missing was the **data substrate** those
behaviours write to. The operator's own framing — "pulse per line, states finished/staged/
issued, archive or park at last turn" — and the format analysis (below) converged on one
answer. This record locks the substrate.

---

## Locked (the shape)

**L1 — Format = structured markdown, not JSON.** Consumer analysis: head, Vara, coders (all
LLM) + majkee (human, hand-edits) favour markdown; the one machine reader (the trigger hook)
needs only the status token, which a fixed-position line-grammar makes greppable. JSON costs
~30–40% more tokens/line, breaks on hand-edit, diffs noisily. The buffer **reuses the pulse
substrate** — no new format, no new parser.

**L2 — Line grammar (one task = one line).**
`- [STATUS] <task-id> · <scope/slug> · owns: <file-globs> · gate: <assay|human|skip> · <one-line intent> · log: <pointer>`
`STATUS` is a closed token at position 1 → one-line greppable.

**L3 — Status lifecycle = closed set.** `issued → staged → review → done`, with `FAIL →
staged` (coder reiterates), and `parked` (living, carried forward) / `blocked` (waiting on
brain/human — **never auto-proceeds on a guess**) reachable from any state.

**L4 — `owns:`-disjointness = the parallel-write race guard.** No two non-`done` lines may
share a file-glob; enforced **before** dispatch. This is what makes parallel tentacles safe.

**L5 — Pull gate — the human decides batch size, and Vara is conditional.** A planning
session emits `issued` lines; majkee decides how many enter a run. **1 issued line → the
head runs it directly (no Vara — she'd be redundant boot tax). N issued lines → Vara runs
the program.** Vara is invoked by task count, not by default — she is not the goal and not
against it; she is the batch executor.

**L6 — Head ↔ buffer wiring.** `program.pulse.md` is a shared, persistent, project-root
buffer (project-relative, no absolute path — 0004). Each session's head works from
`session/<slug>/` and does **add-to-line** (emit `issued`) + **pull-from-line** (claim to
run). The head **retains reconciliation authority after the whole process** — on completion
or on a surfaced issue it may re-read, correct status, re-issue a reconfigured line, split/
merge. Vara flips status *during* an N-batch; the head owns add/pull/reconcile *around* it.

**L7 — Per-line gate = the writer's-blindness circuit breaker.** `gate: assay|human|skip`.
`@Assay` (`~/.claude/agents/assay.md`) is **Sonnet by role, not Haiku** — a cheap tester
that false-passes broken code manufactures false confidence and is worse than none. Cost is
opt-in per line (`skip` for trivial changes). Assay reads only `{task, coder-handoff,
changed files}` — fresh eyes, unpoisoned. Vara has **no Bash** → the `done`→commit step is
delegated to a Bash-capable seat.

**L8 — Circuit breakers (non-negotiable for any headless / autonomous run).**
(i) program-level token ceiling (Vara's `maxTurns` is per-agent, not per-program);
(ii) **human gate at commit** for any load-bearing path — auto-commit only to a program /
throwaway branch, **never `core`**;
(iii) dead-man's-switch — a `blocked` line waits for human input, never guesses forward;
(iv) Vara's existing "3 consecutive fails → stop".

**Last-turn discipline:** archive `done` lines (→ `program.pulse.archive.md`), keep `parked`
and `blocked` lines living. The buffer stays small — this IS the head's externalize-and-forget.

---

## Consequences

- **The octopus gets its spine.** The head's externalize-and-forget discipline now has a
  concrete surface to write to; long cross-scope sessions become survivable because the head
  holds only status lines, never the work.
- **New seat @Assay** is built (`~/.claude/agents/assay.md`) but **not yet wired** into
  `temple/roster.md` / `temple/system-map.md`. Wiring owed.
- **Open naming gavel:** the executor mid-tier drift — `Vector` (roster) vs `Hooke`
  (`vara.md` line 34, currently a ghost seat). Awaiting @majkee's one-word pick: **Div**
  (Atlas rec — operator-family coherence with Delta/Trajectory; "the Faraday hands" as lore)
  or **Faraday** (person on the seat). Vara's routing line needs the winner + a live file.
- **Token economy is grounded, not guessed** (`raw.research/capabilities-economy-hygiene.claude.md`):
  the octopus is a hygiene + parallelism play, NOT a token-saving one; boot tax ≈ ~10k/spawn;
  do not spawn under ~15–20k of real work.

---

## Amendment A1 (gaveled 2026-07-16 — @majkee · pilot-confirmed)

Two clauses added after the octo-launcher pilot ran the loop end-to-end (coder → @Assay
PASS → human activation, verified live). Append-only; L1–L8 unchanged.

**A1a — peripheries-home (extends L2/L6).** The pulse line is a *thin pointer*; a task's full
spec + peripheries live in its **task file** (`session/<slug>/tasks/<id>.md` — one file, three
layers: spec → log → handoff), **never on the line**. The line carries only the one-line intent
+ the pointer.

**A1b — raison d'être / scope guard.** The octopus is for **semi-autonomous cheap multi-run
with the operator OUT of the orchestrator seat.** Operator-present work stays on the **direct
head→coder path** (no buffer, no leash). Do not loop a trivial / operator-present task through
the full buffer · Vara · Assay loop — *a bazooka on a fly*; the pilot measured one 5-line edit
at ~40k through the full loop. The @Assay gate + human-gate-on-error are the substitute for the
eyes you've removed.

*Detail home: `raw.research/program-pulse.contract.claude.md` (point-never-copy).*

## Residual / next

1. **review-companion skill** — the human-review half ("assistant reads with me what was
   done, we test together, or I alone"). The last unbuilt octopus piece.
2. **Executor mid-tier naming gavel** (Div | Faraday) → then edit `vara.md` line 34 to the
   winner + create the live seat file. Retire both `Vector` and `Hooke` into it.
3. **Wire @Assay** into `roster.md` + `system-map.md`.
4. **0011 reserved** for @Oraculum's in-flight draft — numbering note carried so no collision.

*Notify: a list-only memo went to @Houston (`_mail/houston/inbox/atlas.program-pulse-promoted.2026-07-16.md`)
— he lists the lock, does not re-litigate (@majkee already gaveled).*
