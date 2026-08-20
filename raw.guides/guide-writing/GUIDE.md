---
title: Guide writing & treatment — the single-surface law (B′ + skill-model taxonomy)
scope: guide-writing
audience: agent + operator + builder
machine: both
verified: 2026-08-20
---

# Guide writing — how every seat treats `raw.guides/`

_The full manual behind the `/guide` skill's 3-line writer law. Gaveled by majkee
2026-08-20 (session `REP.Offc.Atlas-fable.guides`); trace:
`~/ia-sync/_staging/dev-journal.guides.md`. Supersedes the loose
`raw.guides/guide-writing.md` (same session — dogfooded into its own slug)._

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

## The shape — folder-per-guide, 1:1 with the skill model

```
raw.guides/<slug>/GUIDE.md          ← the guide (fixed entry filename — the contract)
raw.guides/<slug>/<chapter>.md      ← optional chapters (fine taxonomy slices)
```

- **One topic = one slug.** Slug names are topic-specific (`remote-control`,
  `machine-home`, `temple-mail`) — **never generic buckets** (`machine`, `tooling`,
  `misc`). The failure mode this guards against: 15 broad folders each collecting
  unrelated "chapters" = the coarse-taxonomy hell with extra steps. If a slug's chapters
  stop belonging to one topic, that is two guides — split.
- **Chapters are the sip unit.** A long guide splits into chapter files inside its slug;
  `/guide <slug> <chapter>` reads exactly one. GUIDE.md stays the entry + map.
- **Fixed filename `GUIDE.md`** keeps the resolver hardcoded-simple and makes each slug
  folder one addressable document unit — the RAG-ready chunk shape.
- **Exception zones (grandfathered, do not force-migrate):**
  - *published mirrors* — `raw.guides/<project>/` folders per `guide-publishing`
    (one-way publish, banner, read-only here);
  - *legacy loose files* — pre-B′ top-level guides; migrate opportunistically on next
    real touch, never in bulk for its own sake.

No hand-maintained index — `/guide` derives the listing from disk + frontmatter each
call (derived-index principle: registers rot, derivation doesn't).

## Side documents — the manifest law (canonized 2026-08-20)

Everything inside a slug folder is one of **four classes**, and **GUIDE.md is the door
AND the manifest** — every sibling file must be named in a short `## Manifest` section
of its GUIDE.md, one line each (name · class · role):

| class | marker | canon relation |
|---|---|---|
| `GUIDE.md` | fixed name | canonical entry — authority for the slug's shape + claims of record |
| chapter (`*.md`) | frontmatter `chapter-of: <slug>` | subordinate detail; GUIDE.md points, never restates → conflict-free by construction |
| attachment (non-md) | no YAML possible → **manifest entry is its only registration** | evidence/artifact, not knowledge surface; the resolver never reads it |
| legacy | manifest-marked `legacy — superseded, do not follow` — or deleted outright (git history is the archive) | kept in place ONLY when it is the origin record of the guide's claims |

**Orphan rule:** a file in the slug folder not named in the manifest = **drift** — flag
it, don't silently adopt it. This is the audit's cheapest check and any cleanup pass's
protect-list. A slug with only GUIDE.md needs no manifest section at all.

## Frontmatter shape (required on every guide — and, per majkee's 2026-08-20 blessing, on every emitted document)

```yaml
---
title: <one line>
scope: <the slug>
audience: operator | agent | builder   # combine with +
machine: office | home | both
verified: YYYY-MM-DD
---
```

Volatile content (versions, CLI flags, vendor features) → full knowledge-card extras:
`half_life_days:` · `recheck:` (URLs) · `verify_cmd:`. Reference shape:
`remote-control/GUIDE.md`. The `/guide` staleness organ keys on these fields.
Chapters carry a light header: `title:` + `chapter-of: <slug>`.

## Writer rules (carried over from the retired zsh index convention — they held)

1. **Name by kind:** slug = the topic; chapters by their content. Attachments are listed
   in the owning GUIDE.md, never orphaned.
2. **Point, never copy:** file maps live in `AGENTS.md`, canon in `temple/`, engine truth
   next to the engine. Link — do not restate. (The old `ai.md` restated the map and
   rotted within a week.)
3. **Open with the process, not the inventory:** first section answers *"when do I reach
   for this and what do I type."*
4. **Trust disk over doc:** a guide describing code names its engine file; on conflict
   the code wins and the guide is the bug. (Scar: the remote-control card taught tmux
   for 5 days after the engine went tmux-free, 2026-08-15→20.)
5. **Commit reposoma the same session.** Under B′ there is no deploy net — an
   uncommitted guide does not exist on the other machine or in the RAG.

## How project agents treat guides

- **Read:** `/guide <slug>` (or direct path if you know it). Respect the staleness/mirror
  warnings the skill prepends.
- **Author (project-owned guide):** write it in YOUR project's `guides/`, then publish
  one-way into `raw.guides/<project>/` per `guide-publishing` (registry + `sync-guides`,
  banner auto-inserted). Never hand-edit the mirror.
- **Author (temple-wide or machine guide):** new slug folder here, `GUIDE.md`,
  frontmatter on, commit.
- **Engine-authoring docs are the exception:** docs that govern *modifying the
  executable layer* (zsh claviature grammar, engine-builder LAW, codex-relay contract)
  stay **table-side** next to the code they law-govern (rule 4 embodied). They are not
  in this surface; the stub in `~/.config/zsh/guides/` names them.
- **Discipline note for surgical-table sessions:** work happens on the table, but fresh
  *knowledge* the work produces is written HERE, not next to the code.
