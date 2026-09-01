---
title: Shape A — sync/deploy twin (exception, earned)
chapter-of: project-topology
---

# Shape A — sync/deploy twin

Two repos: `<project>/` (code; harness authored here but gitignored) and
`<project>.devenv/` (harness git-home + transport). Reach for it **only** on one of the
two facts in `GUIDE.md §The rule` — foreign human writers, or a live tree that is not a
repo. Live exemplar of the second fact: `~/ia-sync` (`deploy.sh` → `~/.claude`,
`~/.config/zsh`).

## Layout

```
~/www/<scope-group>/<project>/            code · harness authored here, gitignored
~/www/<scope-group>/<project>.devenv/     harness git-home
├── claude/     AGENTS.md CLAUDE.md GEMINI.md rules/ skills/ agents/ settings.local.json
├── dev/        flag pulse PROJECT.yaml session/ _mail/ …
├── sync.sh     stage-OUT  app → repo   (allowlist + sync.deny + secret scan)
├── deploy.sh   stage-IN   repo → app   (no --delete, overwrites only)
├── sync.deny   never-sync manifest (secrets, noise)
├── registry.json         host-keyed app_dir map (scripts resolve it via $MACHINE_NAME)
├── template.registry.md  how to add a host
└── SYNC_DISCIPLINE.md    the invariant below
```

Naming exact: `<project-name>.devenv`. Same scope-group folder as the project.

## The `.gitignore` harness block (in the **app** repo)

```gitignore
# harness — authored here, transported via <project>.devenv
AGENTS.md
CLAUDE.md
GEMINI.md
.dev/*
.claude/
```

## The cycle — every host change, both directions

```
arrive:  cd <p>.devenv && git pull --rebase origin core && bash deploy.sh
leave:   cd <p>.devenv && git pull --rebase origin core && bash sync.sh \
         && git add -A && git commit -m "sync: $(date +%F) $MACHINE_NAME" && git push
plus:    the app repo's own pull/commit/push
```

**Invariant: pull before sync, always.** Sync without pull overwrites the other host.
**Deploy caution:** `deploy.sh` overwrites the app-side harness with the repo snapshot —
never run it while the app side is ahead of the last sync. This ordering, held by hand
across two hosts and two repos, is the tax that retired the shape for solo work.

## Known gaps — read before trusting the twin

- **Allowlist blindness.** `sync.sh` copies only what it enumerates. A new harness
  folder (`.claude/hooks/` on applications-in-common, 2026-07→09) is silently never
  carried until someone edits the script. The gitignore and the allowlist must be kept
  in lockstep by hand.
- **`rsync --delete` legs** (rules/, skills/) delete in the repo what was deleted
  locally — correct, but one wrong path argument empties a tree (ia-sync scar,
  2026-07-31).
- **Two histories for one project.** Harness commits are `sync: <date>` snapshots —
  no narrative; the app repo carries the real story.
- **`registry.json` duplicates `temple-project-map.zsh`.** Tolerated only because the
  scripts need a runtime path lookup; keep the keys per-host and never edit another
  host's key.

## When it earns its keep — the two facts, restated as tests

1. Is there a second **human** who writes to the code repo and must *not* receive (or
   must not be able to break) the harness? → twin.
2. Does the artefact's live location lack a `.git` of its own (`~/.claude`,
   `~/.config/zsh`, a server document root)? → twin (or an ia-sync-style deploy repo).

Neither → `flat.md`.

## Origin record

Precedents that wrote the shape: fantasyobchod · psdvsSys · freya · applications-in-common
(2026-06/07). Canon of record: `raw.canon/canon.project-topology.md` (gaveled
2026-07-14, amendment 2026-09-02 pending).
