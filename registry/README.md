# registry — the cross-project lighthouse (plane 3)

`tier: meta-repo · plane 3 (binding/activation) · the cross-project anchor index`
`rule: a beacon POINTS, never COPIES. one direction (Force 4). thin, or it's drifting.`

## What this is
The place a project leaves a **lighthouse beacon** so a *sibling's* architect or researcher can
navigate it — or jump straight to a shared artifact — by reading **one pointer file, never scanning
the repo**. Half of this already lives inside each project (its `PROJECT.yaml` + `docs.*` + a tracked
"Read first" lighthouse); this is the meta-repo **index** that ties them together and carries the
sibling-graph.

## Where
- `registry/index.md` — the sibling **map**. First on road: one line per project + the sibling-graph.
- `registry/<project>.md` — one **beacon** per project (copy `_beacon.template.md`).

## How to deposit a beacon (the architect, or their Atlas)
1. Copy `_beacon.template.md` → `registry/<project>.md`; fill the **pointers** (paths), not content.
2. Add your one-line row + sibling-links to `registry/index.md`.
3. Carry `host:` (decision 0003) + `updated:`. Done — siblings can now find you.

## The rules (the HOW — canon)
- **Point, never copy.** A beacon holds *paths* to the project's own anchors (contract · architecture ·
  decisions/flag · conventions · the lighthouse). Tempted to paste a doc? Link it. If a beacon grows
  past a screen, it's drifting toward a mirror — trim it.
- **One direction (Force 4).** A beacon is a project's PUBLIC face in the meta-repo. Siblings **read**
  it; no one writes into another project's canon through it.
- **Anchors, not scans.** Point to the contract + `docs.*` entry points — the project's own anchors —
  so a sibling reads the lighthouse, never greps the tree.
- **Siblings.** `sibling-of:` + `shares:` (named shared-anchors) let a sibling researcher jump straight
  to the shared artifact (e.g. `spectral`, the bus/`_mail` pattern, the `X→Z` method).
- **Provenance.** `host:` (0003) + `updated:` on every beacon.

## How to read (a sibling's architect / Epoch / whoever's clever enough)
`index.md` → the relevant beacon → follow the anchor. That's the whole search path — no repo scan.

> Each project owns its lighthouse; the registry only indexes the lights. **Point, never copy.**
