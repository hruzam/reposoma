---
title: Guide writing & treatment — the single-surface law (B′)
scope: temple
audience: agent + operator + builder
machine: both
verified: 2026-08-20
---

# Guide writing — how every seat treats `raw.guides/`

_The full manual behind the `/guide` skill's 3-line writer law. Gaveled by majkee
2026-08-20 (session `REP.Offc.Atlas-fable.guides`); trace:
`~/ia-sync/_staging/dev-journal.guides.md`._

## The law

- **Executable / deployed → surgical table (`~/ia-sync`). Knowledge / readable → temple
  (`~/reposoma`).** Guides do not execute; they live HERE, single home, single read
  surface. The old `~/.config/zsh/guides/` is a pointer stub + deployable config
  artifacts only.
- Motive (why B′ won): pre-guide substrates (`raw.research/` etc.) already live in the
  temple — one repo carries the whole `research → synthesis → guide` pipeline; reposoma
  is the pre-RAG corpus — a guide written elsewhere is RAG-invisible; and one home
  deletes the mirror-staleness coupling a cross-vendor audit flagged (@mirror REVISE,
  2026-08-20).

## Where a guide goes (one guide per scope folder)

| scope folder | holds |
|---|---|
| _(top level)_ | temple-wide conventions (this file, `guide-publishing.md`, bootstrap/intake/onboarding) |
| `machine/` | per-box operator guides (home/office profiles, services, remote-control, keyboard…) — direct-edit, no banner |
| `reach/` | pc↔pc / cross-machine, project-agnostic (SSH, Tailscale, tunnels, DB reach) |
| `<project>/` | that project's published guides (e.g. `piql/`) — **read-only mirrors**, banner-marked |
| `PAD/`, `remote-control/`, `codex-builder-user/`, … | topic scopes; add a new folder when a topic earns ≥1 guide |

No hand-maintained index — `/guide` derives the listing from disk + frontmatter each
call (derived-index principle: registers rot, derivation doesn't).

## Frontmatter shape (required on every guide — and, per majkee's 2026-08-20 blessing, on every emitted document)

```yaml
---
title: <one line>
scope: <folder name, or "temple">
audience: operator | agent | builder   # combine with +
machine: office | home | both
verified: YYYY-MM-DD
---
```

Volatile content (versions, CLI flags, vendor features) → full knowledge-card extras:
`half_life_days:` · `recheck:` (URLs) · `verify_cmd:`. Reference shape:
`machine/remote.md`. The `/guide` staleness organ keys on these fields.

## Writer rules (carried over from the retired zsh index convention — they held)

1. **Name by kind:** `guide-<topic>.md` = how-to · `<machine>.md` = machine profile ·
   `toolbox.<tool>.md` = tool usage. Attachments are listed in the owning guide, never
   orphaned.
2. **Point, never copy:** file maps live in `AGENTS.md`, canon in `temple/`, engine truth
   next to the engine. Link — do not restate. (The old `ai.md` restated the map and
   rotted within a week.)
3. **Open with the process, not the inventory:** first section answers *"when do I reach
   for this and what do I type."*
4. **Trust disk over doc:** a guide describing code names its engine file; on conflict
   the code wins and the guide is the bug. (Scar: `remote.md` taught tmux for 5 days
   after the engine went tmux-free, 2026-08-15→20.)
5. **Commit reposoma the same session.** Under B′ there is no deploy net — an
   uncommitted guide does not exist on the other machine or in the RAG.

## How project agents treat guides

- **Read:** `/guide <name>` (or direct path if you know it). Respect the staleness/mirror
  warnings the skill prepends.
- **Author (project-owned guide):** write it in YOUR project's `guides/`, then publish
  one-way into `raw.guides/<project>/` per `guide-publishing.md` (registry +
  `sync-guides`, banner auto-inserted). Never hand-edit the mirror.
- **Author (temple-wide or machine guide):** write it directly here in the right scope
  folder, frontmatter on, commit.
- **Discipline note for surgical-table sessions:** work happens on the table, but fresh
  *knowledge* the work produces is written HERE, not next to the code. The table's
  README carries the same one-line reminder.
