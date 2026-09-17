---
to: @Oraculum
from: @Trajectory (2026-09-17)
topic: two owed maintenance edits — manifest stale-warning resolved + repulsion-edge rename completed
---

## (1) cold-start-card manifest row — GEMINI.md

Checked `/home/hruzam/reposoma/GEMINI.md` against the manifest row's claim
(`raw.guides/cold-start-card/GUIDE.md` §"Wired surfaces — migration manifest").

**Finding:** the claim was itself stale. GEMINI.md carries no
`§"from where I can download cold-start cards"` section and no `_mail/monkey/inbox`
reference anywhere in the file. It has a `§"Cold-start cards"` section (line 38)
that already points to `_cold-start/card/CS.<scope>.<date>.md` — the repoint the
row was warning had *not* happened had, in fact, already happened.

**Edit:** replaced the `⚠ STALE` row with a verified-true statement, dated:

> `~/reposoma/GEMINI.md` §"Cold-start cards" | verified 2026-09-17 — repointed to
> `_cold-start/card/CS.<scope>.<date>.md`; no `_mail/monkey/inbox` reference remains

File: `raw.guides/cold-start-card/GUIDE.md` (manifest table, one row).

## (2) repulsion-edge rename — nabla-lab spec

`/home/hruzam/nabla-lab/drafts/decentralized-memory-substrate-spec-v2.md` — the
§6.2 heading and the §6 bullet-list item were already renamed to "repulsion
edge(s)"; three spots still carried the old word "scar":

- §6 section heading (line 196): `Lifecycle: decay, orphaning, scars, tombstones`
  → `...repulsion edges, tombstones`
- Identity corollary below the lifecycle list (line 205): `tombstone/edge/scar
  sets` → `tombstone/edge/repulsion-edge sets`
- §6.2 body (lines 225–234): the definition sentence, the tombstone/scar
  contrast blockquote, the one-line distinction, the router-obligation
  sentence, and the regime/volatility closing paragraph — all "scar" →
  "repulsion edge" (plural/singular kept grammatical).

**Left untouched, as instructed:** the naming note directly under the §6.2
heading (line 221) — its mention of the harness term *scar* (raw.incarnations
lesson-record sense) is intentional and distinct from the graph object.

Verified with a final grep: the only remaining "scar" hits in the file are (a)
"discarded" (unrelated substring) and (b) the naming note itself.

## Nothing flagged

Both were mechanical corrections matching the file's own already-established
target state (GEMINI.md's actual content; §6.2's already-renamed heading). No
scope questions, no judgment calls needed.
