---
title: Shape B — flat single repo (default)
chapter-of: project-topology
---

# Shape B — flat single repo

One repo carries code **and** harness. Cross-host = `git pull`. No transport scripts.

## Layout

```
~/www/<scope-group>/<project>/
├── AGENTS.md · CLAUDE.md (@AGENTS.md) · GEMINI.md   ← tracked
├── .claude/   rules/ skills/ agents/ hooks/ settings.json   ← tracked
├── .dev/      PROJECT.yaml flag.md pulse.md session/ _mail/ …   ← tracked
├── .gitignore ← hygiene only (below)
└── <code>
```

Exactly the file set a twin would hold in `<project>.devenv/claude/` + `dev/` — the
same files, just at home.

## `.gitignore` — hygiene only

```gitignore
# secrets — never
.env
.env.*
*.key
*.pem
*.credentials

# noise
*.log
*.bak
*.bak-*
*.tmp
.DS_Store

# runtime / build artefacts — per project
# target/  node_modules/  vendor/  <pin stores>  <media drop-places>
```

Nothing from the harness. If you find yourself adding `.dev/*` or `.claude/` here you
are rebuilding the twin by hand — stop and read `GUIDE.md §The rule`.

**`.claude/settings.local.json`:** Claude Code's *personal* file — keep it untracked
(the CLI ignores it by convention). Anything that must travel — hooks, shared
permissions — belongs in `.claude/settings.json`, tracked.

## `PROJECT.yaml` block

```yaml
harness:
  shape: flat            # one repo; harness tracked in place; cross-host = git pull
  authoring: project
```

## `AGENTS.md` paragraph (replaces "Harness transport")

```
## Repo shape
Flat single repo (`raw.guides/project-topology/flat.md`). Harness + code in one git
home; cross-host = `git pull --rebase` / `git push` on `core`. Parallel or risky work:
`git worktree add ../<project>-<topic> -b dev/<topic>` — never a second clone.
```

## Cross-host operations

| do | command |
|---|---|
| arrive on a host | `git pull --rebase origin core` |
| leave a host | `git add -A && git commit -m "<host>: <one line>" && git push` |
| parallel topic | `git worktree add ../<project>-<topic> -b dev/<topic>` |
| dirty tree on arrival | it is yours from last time — commit or stash, then pull |

There is no "deploy" step. There is no "sync" step. `$MACHINE_NAME` in the commit line
is the only provenance you need (decision 0003).

## Migration — twin → flat (the recipe that ran twice, 2026-09-02)

1. **Verify live wins:** `diff -rq <p>.devenv/dev <p>/.dev` and `…/claude <p>/.claude`.
   Expect zero content diffs (live had already won every sync). Anything *only in the
   devenv* is a stale snapshot or a file `sync.sh` carried that the app didn't — decide
   per file, expect none.
2. **Secret scan the live harness** before opening the gitignore (the twin's `sync.sh`
   patterns: `api[_-]key`, `secret`, `password`, `BEGIN.*PRIVATE`, `sk-`, `ghp_`,
   `tskey-`). Zero hits or stop.
3. **Open the gitignore** to the hygiene set above.
4. **Rewire the words:** `AGENTS.md` (harness line + Repo shape) · `PROJECT.yaml`
   (`harness.shape`) · `flag.md` — *append* a superseding decision, never edit the old
   one · pulse (drop sync cadence lines) · registry beacon `repo:` line.
5. **Commit the harness into the project repo** — one commit, named as the migration.
6. **Retire the devenv:** GitHub repo archived or deleted (content is byte-identical to
   live, history is sync snapshots only); local clone quarantined to `/tmp/` for a week,
   then gone. Never `rm -rf` the same day you merge.
7. **Machine layer:** grep `~/ia-sync` for `<project>.devenv` — path maps and
   breadcrumbs must name the project, not the twin.
8. **Every other host — the first pull after the merge.** The other box still holds the
   harness as *untracked* files; `git pull` will refuse ("untracked working tree files
   would be overwritten"). Do NOT `reset --hard` (it overwrites silently — any home-only
   edit dies). Recipe:
   ```
   git fetch origin
   mkdir -p /tmp/<p>.harness.$(date +%F)
   mv .dev .claude AGENTS.md CLAUDE.md GEMINI.md /tmp/<p>.harness.$(date +%F)/
   git pull --rebase origin core
   diff -rq /tmp/<p>.harness.$(date +%F)/.dev .dev     # + .claude — expect zero
   ```
   Anything **only** in `/tmp` = work that host never synced → copy back, commit.
   Then quarantine that host's `<p>.devenv` clone too (step 6 applies per host).
