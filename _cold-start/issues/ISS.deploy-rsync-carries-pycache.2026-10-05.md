---
kind: issue-card
date: 2026-10-05
brand: claude
found_by: trajectory
project: ia-sync
root: ~/ia-sync
where: ~/ia-sync/deploy.sh (the ~/.config/zsh rsync leg)
defect: any python3 run from the compose tree (selftest, a probe, py_compile) leaves zsh/**/__pycache__/ behind, and deploy.sh's rsync carries that bytecode into the live ~/.config/zsh tree
assoc: [deploy, rsync, pycache, bytecode, zsh-leg, tunnel-codex, selftest, office, home, hygiene, low]
severity: low
pointers:
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/hotrun.headless.2026-10-03.md
  - ~/ia-sync/.gitignore   # __pycache__/ is ignored for GIT — rsync does not read .gitignore
---

## Observed

Three times during the BRICK-01 arc (2026-10-03/04): after running
`zsh zsh/ai/tunnel-codex.selftest.zsh` or `python3 -m py_compile` on the compose copy,
`bash deploy.sh --dry-run` listed `ai/__pycache__/tunnel-codex.cpython-314.pyc` as a file
that would travel to `~/.config/zsh/ai/`. Swept by hand each time before the real deploy.
`PYTHONDONTWRITEBYTECODE=1` on the invocation did not reliably prevent it (the selftest
spawns python via the zsh wrapper's `exec python3`; env inherits, yet a cache dir reappeared
once — cause not pinned).

## Consequence

Confirmed: stale bytecode lands in the live tree and shadows nothing (python prefers a newer
source), so no behavioural fault — but the live tree stops being a clean mirror of compose,
and a dry-run reader must mentally filter noise. Suspected: a `.pyc` from one Python minor
could linger across upgrades.

## Fix (known, not yet applied — majkee's hand on deploy.sh)

One line on the zsh rsync leg in `deploy.sh`:

```sh
--exclude '__pycache__/'
```

Optionally also `export PYTHONDONTWRITEBYTECODE=1` at the top of
`zsh/ai/tunnel-codex.selftest.zsh` so the common trigger stops producing the dir at all.
Verify: run the selftest on compose, then `bash deploy.sh --dry-run | grep pycache` → empty.

## Lifecycle

Assumed one-shot: once the exclude lands and the dry-run is clean, `mv` this card to
`archive/`. If bytecode shows up in a dry-run again after that, it was never one-shot —
fold to `routines/` keeping this name.
