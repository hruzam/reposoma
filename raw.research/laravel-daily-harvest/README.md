# laravel-daily-harvest — scope

Turns manually-PrintScreened **Laravel Daily YouTube community-post tips** (text +
a code screenshot) into adoptable Laravel tip cards. Weekly cadence.

- `harvest/` — raw substrate. PNGs majkee drops, one folder per ISO week.
- `report/` — extracted value. One card-file per processed week.
- `index.md` — ledger of which weeks are processed.

No capture automation. The human drops PNGs; the agent (Claude or Codex) reads
them with vision and extracts.

## Layout

```
laravel-daily-harvest/
├── README.md          ← this file — the guide (start here)
├── harvest/           ← raw substrate: PrintScreens majkee drops
│   ├── README.md      ← drop-place note
│   └── 2026-W33/      ← one folder per ISO week
├── report/            ← extracted value: one card-file per processed week
│   └── raw.laravel-daily-harvest.2026-W33.md
└── index.md           ← ledger: which weeks are processed (week · screens · taken · left · date)
```

**Flow:** drop screenshots in `harvest/<week>/` → agent extracts → writes `report/<week>.md` → appends a row to `index.md`.

## Weekly ritual

1. **PrintScreen posts** → drop PNGs into `harvest/<ISO-week>/` (e.g. `2026-W33/`).
2. **Run agent:** "process harvest/<week>".
3. **Agent reads** each screenshot with vision, transcribes the code + the
   why-text, and judges valuable vs not.
4. **Any link visible in a shot** → agent WebFetches it and folds notes into
   the card.
5. **Agent writes** `report/raw.laravel-daily-harvest.<week>.md` and appends a
   row to `index.md`.

## Conventions

- Week naming is ISO-8601, zero-padded: `2026-W33`. The agent computes the
  current week; it is not hand-entered.
- Each tip is its own `###` card inside the report's `## Tips taken` section.
- A `## Left / parked` section holds posts that were seen but skipped —
  revisitable later (e.g. a year-end audit), not discarded.
- Report filename: `report/raw.laravel-daily-harvest.<ISO-week>.md`.
- Agent-agnostic: Claude or Codex can both run this recipe unmodified.

## Future ideas (parked — not needed now)

Current design: cards live as `###` sections inside the weekly report file
(~52 files/year, ~250 tip cards/year). Retrieval today = `grep` across `report/*.md`
+ the per-card `**Tags:**` line + the week ledger in `index.md`. That covers a few
hundred cards comfortably.

- **Tip-level catalog** — a flat, searchable index of *all* tips (title · tags · source ·
  week), separate from the weekly grouping. Worth building only when browsing the weekly
  files actually gets painful (likely year 2, a few hundred cards in) — not before.
  Solving an observed problem, not an imagined one.
- **Catalog format — open question, decide when we build it:** markdown (greppable, human-first) /
  JSON (machine-consumable, easy to regenerate from tags) / TOML (typed, config-friendly) /
  HTML (browsable). Not important now; noted so the choice is deliberate later.
- **Regeneration:** whatever the format, prefer a tiny script that rebuilds the catalog
  from the `**Tags:**`/`**Source:**` lines already in the reports — single source of truth
  stays the weekly cards, catalog is derived, never hand-maintained.
