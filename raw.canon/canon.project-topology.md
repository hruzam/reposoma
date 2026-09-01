# canon.project-topology — the project shapes (flat default · sync/deploy twin by exception)

`status: GAVELED 2026-07-14 (majkee) · AMENDED 2026-09-02 (majkee gavel: flat is the default for solo; twin by exception) · drafted by atlas · scope: every new buildable project`
`consumers: new-project bootstrap (tabled skill C) · all bootstrap sessions · registry discipline`

## The two shapes

A buildable project takes one of two shapes — **B · flat single repo (default)** or
**A · sync/deploy twin (exception, earned: foreign human writers, or live tree ≠ repo)**.
Rule, reasoning, templates: `raw.guides/project-topology/GUIDE.md`. Number of hosts is
not a reason — git solves hosts. The twin, shape A, is the **pair**:

1. **`<project>/`** — the codebase repo. Process + agentive harness are **authored
   here** (AGENTS.md · CLAUDE.md · `.dev/` · `.claude/` · `.mcp.json` as applicable)
   but **gitignored** — the app repo never carries the harness.
2. **`<project>.devenv/`** — the harness git-home + cross-machine transport:
   `sync.sh` (stage-OUT: allowlist + `sync.deny` + secret-scan gate) ·
   `deploy.sh` (stage-IN, no --delete) · `registry.json` (host-keyed paths) ·
   `SYNC_DISCIPLINE.md` (pull-before-push invariant).

## Placement — MANDATE

The pair lives together inside **one scope-group folder** — never loose in `~/www`
root:

```
~/www/<scope-group>/<project>/
~/www/<scope-group>/<project>.devenv/
```

A scope-group holds siblings sharing an owner or domain:
`imago_cz/` (client Imago: freya + fantasyobchod) · `psdvs/` (org) ·
`ovum/` (temple infrastructure) · `elements-factory/` (UI playground).

**Open the group folder even at n=1 — n grows.** A bootstrap without a scope-group
is a **stop-item**, not a style preference. Receipt: the 2026-07-14
applications-in-common relocation — retrofitting cost a full executor run and
8 pointer rewires; the group folder at birth costs one `mkdir`.

## Rules that travel with the pattern

- **Authoring surface = project app-side.** Never author in the devenv — that
  conflates git-home with authoring surface.
- **Physical root paths live ONLY in `temple-project-map.zsh`** (decisions 0003/0008).
  Registry beacons carry `path:`; `registry/index.md` never does.
- **Naming exact:** `<project-name>.devenv` — no variants.
- **Branch:** devenv follows the project's branch convention (`core`).
- **Deploy caution:** `deploy.sh` overwrites app-side harness with the repo snapshot —
  never run it when the app-side is ahead of the last sync. Sync first.

## Recorded shapes

- **nablarva** — flat (2026-09-02; three repos → one, `docs/repo-unification.2026-09-02.md`).
- **applications-in-common** — flat (2026-09-02; devenv retired — byte-identical to live, zero harvest).

- **reposoma** — the meta-repo; the temple is the exception by nature (no project-flow).
- **vacuole** — `~/vacuole`, methods project, no devenv yet.
- **piql.dev** — precursor pattern, predates this canon.

## Precedents that earned this canon

fantasyobchod · psdvsSys · freya · applications-in-common (four authored-in-place
bootstraps, 2026-06/07). The pattern was observed before it was written — canon
follows practice, per temple law.
