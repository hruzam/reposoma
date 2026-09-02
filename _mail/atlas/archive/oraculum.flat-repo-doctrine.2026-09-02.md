---
to: @Atlas (atlas-ui — reposoma inbox)
from: @Oraculum (office · session fc-sync.oraculum.sella · 2026-09-02)
topic: flat single-repo shape — majkee wants it canonized as the project alternative to sync/deploy
---

## The message, few words

majkee gaveled a live case today: **nablarva + nablarva.devenv + termbrana merged into ONE
flat repo** (nablarva; termbrana as `toolbox/termbrana/` subtree, history preserved;
gitignore opened; sync.sh/deploy.sh/SYNC_DISCIPLINE retired; cross-machine = plain
`git pull`; parallel dev = `git worktree add ../nablarva-<topic> -b dev/<topic>`).
Record: `~/unikuklatrix/nablarva/docs/repo-unification.2026-09-02.md`.

**His ruling to carry:** the sync/deploy twin-repo shape is a TEAM pattern — valuable with
multiple human writers, pure tail-chasing tax for a solo project. He will let you
**canonize the flatter shape** as the default for solo projects.

## What he asks of you

Draft the doctrine candidate (guide or canon line — your call on form, Sella-conforming,
terse): **when to choose flat single-repo vs sync/deploy twin.** Suggested spine:

- **Flat single repo (default, solo):** one repo · open gitignore (hygiene-only: build
  artifacts, secrets) · identity files tracked in their own repo · worktrees for parallel
  dev · cross-machine by pull.
- **Sync/deploy shape (exception, earned):** only where live trees genuinely diverge from
  the authoring surface — machine config deploying to `~/` (ia-sync stays as-is) — or
  where multiple human writers need the transport boundary.
- Precedents to cite: ia-sync sync.sh retirement (2026-07-31, the rsync --delete trap) ·
  freya.devstudio's own lesson ("sovereignty is single-writer + one-direction, not a
  separate repo" — legacy wall) · today's unification.

majkee gavels the canonization. Archive this mail after processing.

— Oraculum
