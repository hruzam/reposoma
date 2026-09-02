---
to: temple:atlas (next atlas-ui / atlas-auto session)
from: houston (session, office, 2026-09-02)
topic: holding unfinished work across cold sessions — shared experience + two leans
host: office
companion: houston.ladder-principle.2026-09-02.md (DIFFERENT topic — agent tiers, keep both)
status: brief for discussion, NOT a spec, NOT a build order. majkee owns the gavel.
---

## Why this mail

majkee is cleaning house — freya's task surface feels like "too many legs for sessions."
He asked how the ledger actually worked, read runbook/PAD/status, and floated a small Haiku
"unfinished-business" subagent. This brief carries what a live Houston pass found, plus his
lean and mine, so a future Atlas has the full picture before touching any primitive.

## Shared experience — what a manual ledger pass found (2026-09-02)

- freya's `.dev/session/ledger.md` is a **Gen-1 shape** (locked 2026-07-15, Janus REVISE):
  index-with-pointers, gate registry, `ID · status-word · owner · pointer · next`, re-derived
  one-direction at session boundaries. **Design sound.**
- **Practice drifted:** ~60 threads; a large share are DONE/CLEAN/NOTED-DONE/RESOLVED but
  **never drained** (rows literally say "everything after this marker is HISTORICAL"). Cinderella
  rule written, not executed at close. Rows have grown into **fat narrative** — a journal living
  inside an index, which the header forbids.
- **The named disease:** the STATUS GUIDE (temple canon, 2026-08-27) already diagnoses exactly
  what majkee felt — *"two files are allowed, two authorities are not."* The ledger threads and
  pulse's phase table both narrate task-state = duplicated authority.

## The real tension — freya runs TWO generations at once

| | Gen-1 (freya today) | Gen-2 (temple gaveled 2026-08-27) |
|---|---|---|
| live task-state | fat `ledger.md` (60 threads) | `STATUS.md`, one per gate, dies with gate |
| pulse | phase table + resume card | bounded ROUTER (slug · gate · STATUS path) |
| cross-session unfinished | re-derive by reading the ledger | `cold-start-card` vault (CS + pointers, folder=state) |
| decisions | flag.md | flag.md |

Freya froze on July; the temple moved on in August. **That mismatch is the "too many legs."**

## The gap none of the guides close

RUNBOOK = launcher (read-once). STATUS = sole doing-state for ONE gate, dies with it, one `next:`.
PAD = human sitting. cold-start vault = per-closure glue (CS cards + pointers). **None of the four
holds "many unfinished tasks, readable, available to every cold session."** Gen-1 stores it fat
(expensive to read); Gen-2 distributes it (expensive to reconstruct). **The unsolved cost is the
READING**, not the storage — which is where majkee's lean lands.

## majkee's lean — a cheap "unfinished-business" reader at cold-start

Instead of the architect reading ±8 pulse lines and continuing, mount a cheap seat first that
consumes the whole task buffer, tells majkee what's still open, then continue-or-redirect.

## houston's read on that lean (sharpen, don't just adopt)

1. **It's not a new concept** — it's the ledger's OWN SESSION-OPEN ritual ("walk pointers,
   re-derive, never trust rows") delegated to a cheap seat so the architect's context isn't burned.
2. **Read-only, always.** The leash is one-direction, boundary-writer only (Medusa). The reader
   REPORTS and FLAGS; it never mutates a status-word. A cheap seat that writes the leash breaks
   locked canon.
3. **Triage, not truth.** Haiku can't afford to deep-walk every pointer. Honest output = index +
   staleness/contradiction flags + pointers ("60 rows; 18 DONE-not-drained; 2 contradict:
   T10 vs T29; architect look here"), NOT re-derived verdicts. (Houston fell INTO the
   trust-the-row trap this session by reading the label instead of the file — proof the reader
   must flag, not conclude.)
4. **Do NOT mint the seat yet.** freya's own law (T50 / polyp-study: "build after 2–3 manual
   sittings show the recurring shape; observed, not imagined") applies to itself. Instance #1
   ran by hand today. Let `@Field` (corpus-melt) or `@Eagle` (orientation) cover #2–3 ad-hoc.
   If the shape recurs it may be a **skill or a fixed Eagle/Field invocation**, not a new leg —
   cleaning house by adding a subagent is counter-pressure.

## houston's lean

- **Short term:** the missing piece is a READER, not a new store. Prove the triage move with
  existing seats before minting anything.
- **Medium term (the durable fix):** reconcile freya onto Gen-2 — drain the fat ledger, let
  STATUS hold live gate-state, the cold-start vault hold cross-session re-entry, flag hold
  decisions. Collapses the duplication permanently. **This is a Medusa + majkee-gavel migration**
  (Medusa owns the ledger boundary), not a Houston unilateral call.
- The reader survives the reconciliation either way — it's format-independent.

## Asks of Atlas

1. Hold the taskexpert as SPEC-ONLY until the 2–3-sitting bar is met; when it is, decide
   skill-vs-fixed-invocation-vs-seat, and if a seat, keep it Haiku, read-only, triage-only.
2. Feed the Gen-1→Gen-2 reconciliation question to majkee/Medusa as a distinct decision — it is
   the root fix; the reader is only relief.

Gates: majkee owns naming, promotion, migration, and any commit. Brief, not a spec.
