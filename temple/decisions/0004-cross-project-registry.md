# Decision Record — Cross-Project Lighthouse Registry: what locks

`status: LOCKED 2026-06-18 (gaveled by majkee)`
`date: 2026-06-18 · thread: cross-project navigation / sibling anchors`
`shape: ADR — context · decision · consequences · what-an-agent-does-differently`
`resolves: O5 (proposed) in decisions/index.md`

---

## Context

Sibling projects (subai.devenv ↔ reposoma.devenv share spectral · bus/`_mail` · X→Z; freya ← piql
lineage) need to navigate each other — or jump to a shared artifact — without scanning a repo. The
mechanism half-existed already: each project's `PROJECT.yaml` + `docs.*` + a tracked "Read first" file
(piql.dev's `mesh-state.md` is the model), and the `registry/projects/*` ad-hoc pointer cards. This locks
the named home + the rules. Plane 3 (binding/activation), doctrine §3b.

---

## Locked

**L1 — the home.** `registry/` in the meta-repo (plane 3). `registry/index.md` = the sibling map
(first on road) · `registry/<project>.md` = one thin **pointer beacon** per project (copy
`_beacon.template.md`) · `registry/README.md` = the spec.

**L2 — point, never copy.** A beacon holds *paths* to a project's own anchors (contract · architecture ·
decisions/flag · conventions · the lighthouse), never content. Past a screen = drifting toward a mirror;
trim it. This is the load-bearing invariant — every other rule reduces to it.

**L3 — one direction (Force 4).** A beacon is a project's public face in the meta-repo; siblings **read**
it, never write into another project's canon through it. A pointer can't carry canon backward; only a
copy can — which is *why* L2 is load-bearing.

**L4 — project-relative anchors only (§4.7 made structural).** No absolute or home-rooted (`~/`) paths
in a beacon or the index. A personal/machine layer is reached through its **decision record** (e.g. `0003`
for the zsh machine layer), never indexed directly. This converts §4.7 from a convention-to-remember into
a rule the spec enforces — the R1 "below-the-line" lesson: structure, not promise.

**L5 — siblings + shared layers.** `sibling-of:` + `shares:` (named shared-anchors) give a sibling
researcher the fast-jump to a shared artifact. A "Shared layers" section indexes cross-cutting *non-project*
lighthouses (the research harness; the machine layer via 0003) — pointers only, project-relative (L4).

**L6 — provenance.** `host:` (0003) + `updated:` on every beacon.

---

## The challenger's catch (Janus, before lock)

The first wiring indexed the machine layer by its absolute `~/.config/zsh/AGENTS.md` path — a direct
§4.7 / 0003 violation, on the registry's own "public face that siblings read" surface. Fixed by **L4**:
route through the 0003 ledger record (host-scoped, the surface allowed to name the path) and forbid `~/`
paths structurally. Second watch: **lock the convention, not the sibling-graph** — freya/piql edges stay
unverified until their beacons land.

---

## Consequences

- A sibling navigates a project (or finds a shared artifact) by reading **one beacon, never scanning**.
- `registry/projects/*` retire into beacons once freya + piql are reshaped.
- **Not a second knowledge system (Force 3):** a pure pointer index over the one source is a legitimate
  Plane-3 integration artifact, not parallel knowledge — true *only as long as L2 holds*.

---

## What an agent must do differently

- **To find a sibling:** read `registry/index.md` → the beacon → follow the anchor. Never grep another
  project's tree.
- **To register:** copy `_beacon.template.md` → `registry/<project>.md`, fill **pointers** (not content),
  add a row to `index.md`. Point, never copy.
- **Never** put a `~/` or absolute path in a beacon/index — route a personal/machine layer through its
  decision record.
