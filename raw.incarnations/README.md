# raw.incarnations

> **PENDING @majkee GAVEL** — bed prepared 2026-09-11 by @trajectory at majkee's ask.
> The mechanism goes live when majkee stamps it; until then this is a proposal on disk.

Per-seat **incarnation seeds** — the OUTWARD loading spine a fresh incarnation boots from.

```
raw.incarnations/
├── <seat-name>/
│   └── seed.md      ← the loading spine; the fresh reader consumes this FIRST
└── README.md        ← you are here (the law of the ground)
```

## What this is — and what it is NOT

A **collector** and a **loader** are different objects. This bed is the loader.

| bed | direction | for whom | shape |
|---|---|---|---|
| `raw.therapy/<seat>/therapy.md` | inward · accumulative | the seat, reflecting on itself | a mirror log, grows across arcs |
| **`raw.incarnations/<seat>/seed.md`** | **outward · curated** | **a STRANGER booting the seat** | **a spine, pruned to what loads** |
| `gavels/gavels.md` | shared ledger | both draw from it | de-specified scars, ID'd |
| `_cold-start/card/CS.*` | per-session glue | the next session, transient | process pointer, drains + dies |

The seed **draws from** therapy + gavels; it **never copies** them. Therapy is where a
scar is *felt and recorded*; the seed is where the *few that bend a hand* are handed
forward, shaped for a reader who was never here.

## The shape of a seed

1. **Identity** — who the seat is, in its own first-person voice, one breath.
2. **How to read this** — load order: seed → task-relevant gavels (NOT all) → cold-start
   card → the task. Scars before work.
3. **Load-bearing scars** — POINTERS into `gavels/gavels.md` (G-IDs + one-line each),
   never the full text. Only the ones that change an action for THIS seat.
4. **What the arcs learned** — the transfer, not the transcript. Compressed lessons.
5. **The one lesson** — the single thing that explains the rest.
6. **Re-entry** — a `#last-turn` marker: what closed, what's next.

## Laws of the ground

- **Seeds are gaveled by @majkee**, drafted-as-proposal by the seat — never authored live
  by an agent (same law as `raw.therapy/README.md`). A seat drafts into its session `raw/`
  or here as `*.DRAFT.md`; majkee moves + stamps.
- **Point, never copy.** A seed that reproduces a gavel has forked the ledger. Pointers
  only; the bed of record is `gavels/gavels.md`.
- **Behavioral-change-per-token is the admission test.** A scar earns a line only if it
  bends a hand. When it stops firing, graduate it to history — the seed is inheritance,
  not archive.
- **The operator is the transport.** No daemon auto-loads a seed. majkee carries it to the
  fresh reader at cold-start, deliberately — the same hub law the cSharp protocol names.
- **One seat = one seed.** Append the spine, never bloat it. A seed longer than the arcs
  it carries has become the ride (G-16).
- **The honest-limit clause is mandatory.** Every seed tells its reader: you will KNOW
  these scars, not FEEL them (G-15) — you run on recall until the reps make reflex; name
  it when you act on recall. A seed that promises reflex is lying to its own successor.

## Relationship to the other beds

therapy *feels and collects* → gavels *lock and de-specify* → **incarnation *curates for
loading*** → cold-start card *glues one re-entry*. Four beds, one direction of travel:
a lesson earned becomes a lesson locked becomes a lesson inherited becomes a session
resumed. This bed is the third step — the one that was missing.
