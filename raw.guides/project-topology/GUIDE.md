---
title: Project topology — the two repo shapes (flat default · sync/deploy twin by exception)
scope: project-topology
audience: operator + agent + builder
machine: both
verified: 2026-09-02
---

# Project topology — which shape a project takes, and why

_Serves `raw.canon/canon.project-topology.md` (the rule of record). Canon holds the
mandate; this guide holds the two templates and the reasoning. Drafted by @Atlas
2026-09-02 from majkee's ruling (nablarva unification, same day). Canon amendment
pending gavel._

## When I reach for this

- **Bootstrapping a project** → run the rule below, open the matching chapter, copy its
  template. Ten minutes, one decision.
- **Auditing an existing pair** (`<project>/` + `<project>.devenv/`) → the rule tells you
  whether the twin still earns its keep; `flat.md §Migration` is the collapse recipe.
- **Reading a project you don't know** → its `PROJECT.yaml` `harness.shape:` names the
  chapter that explains its git behaviour.

## The rule

| shape | when | chapter |
|---|---|---|
| **B — flat single repo** | **default.** One human writer, any number of machines/agents. | [`flat.md`](flat.md) |
| **A — sync/deploy twin** | **exception, earned** by one of two facts: (1) **multiple human writers** who need the harness versioned apart from the code (a client team, a foreign harness owner); (2) **authoring surface ≠ live tree** — the artefact deploys *into* a place that is not a repo (`~/ia-sync` → `~/.claude`, `~/.config/zsh`). | [`sync-deploy.md`](sync-deploy.md) |

If neither fact is present, the twin is tax. Number of machines is **not** a fact —
git already solves machines.

## Why flat won (majkee, 2026-09-02)

- **The origin was a team shape.** Sync/deploy was designed for the PHP client work
  where majkee shares code with other devs and each side builds its own harness — the
  harness needed a transport boundary so foreign hands never saw it. A personal project
  has no foreign hands.
- **The cycle was hunting its own tail.** Home + office on one tailscale net; majkee
  works from home *on the office host* (better performance) and on both boxes to save
  time. Every seat change meant `pull → sync.sh → commit → push` … `pull → deploy.sh` —
  on two repos. Holding that discipline by hand across hosts was the failure, not any
  single step. Plain `git pull` on one repo is the whole cross-host story.
- **The twin was already leaking.** applications-in-common's `sync.sh` never carried
  `.claude/hooks/` — the live tree had hooks the "harness git-home" never saw. A
  transport layer that must be taught every new folder is a second gitignore with
  worse tooling.
- **Precedents, dated:** ia-sync retired its `sync.sh` 2026-07-31 (the `rsync --delete`
  trap) · freya.devstudio's own finding — *sovereignty is single-writer + one-direction,
  not a separate repo* (`temple/legacy-wall.md`) · nablarva + nablarva.devenv + termbrana
  → one repo 2026-09-02 (`~/unikuklatrix/nablarva/docs/repo-unification.2026-09-02.md`)
  · applications-in-common collapsed the same day (devenv was byte-identical to live —
  zero content to harvest).

## Invariants — hold in BOTH shapes

- **Scope-group folder** even at n=1: `~/www/<scope-group>/<project>/` (canon mandate).
- **Authoring surface = the project.** Never author in a transport repo.
- **Physical paths live only in `temple-project-map.zsh`** (decisions 0003/0008) — no
  per-project `registry.json` path map in a flat repo; a twin keeps one only because its
  scripts resolve the app dir at runtime.
- **Secrets never enter git** — `.env`, keys, `*.credentials`; hygiene ignores are the
  floor of every `.gitignore`.
- **Branch `core`.** Flat projects may commit direct to `core`; parallel work =
  `git worktree`, not a second clone.
- **PROJECT.yaml declares the shape:** `harness.shape: flat | sync-deploy`.

## Manifest

- `GUIDE.md` — this door: the rule, the reasoning, the invariants.
- `flat.md` — chapter: shape B template (layout · gitignore · PROJECT.yaml block ·
  AGENTS.md paragraph · cross-host ops · migration from a twin).
- `sync-deploy.md` — chapter: shape A template (the four transport files · the cycle ·
  the gitignore harness block · known gaps · when it earns its keep).
