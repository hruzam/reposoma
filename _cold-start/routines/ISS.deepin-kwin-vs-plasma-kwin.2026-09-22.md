---
kind: issue-card
date: 2026-09-22
brand: claude
found_by: trajectory
project: ia-sync
root: ~/ia-sync
where: office host (hruzam-120922) · pacman -Syu — deepin-kwin (dep of upgraded deepin-polkit-agent) conflicts with Plasma's kwin
defect: every pacman -Syu that bumps deepin-polkit-agent tries to pull deepin-kwin, which hard-conflicts with the kwin Plasma runs on, blocking the whole update until worked around or Deepin is evicted
assoc: [manjaro, pacman, deepin-kwin, kwin, plasma, deepin-screen-recorder, conflict, office, recurring]
severity: med
pointers:
  - ~/ia-sync/journal.host-cleanup.md
  - https://forum.manjaro.org/t/deepin-kwin-and-kwin-are-in-conflict/189378
  - https://forum.manjaro.org/t/deepin-package-conflicts-on-latest-stable-update/189165
origin: issue
recorded: 2026-09-22
---

Known-recurring issue, placed directly in `routines/` under issue-card path 1 (per majkee's
rule: issue = one-shot, routine = recurs regularly). Filename retains the first observed date
(office, 2026-09-22). @Epoch found this across multiple Manjaro forum threads spanning 2026-07
to 2026-08 — a standing hazard, not a one-time bump.

Symptom: `deepin-kwin-6.0.8-10 and kwin-6.7.4-7 are in conflict` (`deepin-kwin` declares
`Conflicts With: kwin kwin-x11`). Host runs Plasma (`kwin` required by `plasma-workspace`),
so kwin must stay.

Root cause (traced): `deepin-session`/`deepin-kwin` are NOT installed — they are *new*
packages the upgrade pulls in. The only explicitly-installed Deepin package is
**`deepin-screen-recorder`** (a screen-record app); it dragged in a 39-package Deepin desktop
as dependencies. Pull chain:
```
deepin-screen-recorder → deepin-tray-loader → deepin-daemon → deepin-application-manager
  → deepin-shell → deepin-polkit-agent → [upgraded] deepin-session-shell → deepin-session
  → deepin-kwin   (Conflicts: kwin)
```
So the upgraded `deepin-polkit-agent` now demands the session→kwin stack. The recorder and the
conflict are **inseparable** — you cannot keep the recorder and dodge the conflict. Recurs on
every `-Syu` that offers a `deepin-polkit-agent` bump, until Deepin is evicted.

## Recovery — two paths

### A. Quick workaround (unblocks the update; conflict returns next cycle)

```
sudo pacman -Syu --ignore deepin-kwin   # skip deepin-session/-shell/-polkit-agent when prompted
```

Holds `deepin-polkit-agent`/`-daemon`/`-session-ui` at old versions (partial-hold on the
Deepin slice only). This is what was run 2026-09-22.

### B. Permanent fix — evict Deepin (verified safe; removes the recorder)

Safety verified: `dtk6core/gui/widget`, `deepin-qt6integration`, `deepin-turbo`,
`deepin-image-editor` have **zero non-Deepin dependents** — eviction does not touch any
Plasma/Qt app. The tree has dependency cycles (daemon↔application-manager↔shell), so cascade,
not plain orphan cleanup:

```
# 1. cascade-remove the interdependent Deepin desktop cluster (10 pkgs, incl. the recorder):
sudo pacman -Rc deepin-polkit-agent
#    → deepin-screen-recorder, deepin-session-ui, deepin-polkit-agent, deepin-shell,
#      deepin-tray-loader, deepin-application-manager, deepin-daemon, deepin-api,
#      deepin-widgets, deepin-polkit-agent-ext-gnomekeyring
# 2. sweep ONLY the now-orphaned Deepin libs:
sudo pacman -Rns $(pacman -Qdtq | grep -iE 'deepin|^dtk')
```

If screen recording is still wanted: **OBS Studio** (recording) or **Spectacle** (stills) —
no Deepin footprint, no recurring conflict.

**WARNING:** do NOT run a blanket `sudo pacman -Rns $(pacman -Qdtq)` — the office orphan list
(44) includes non-Deepin packages (`cmake`, `electron39`, `kirigami2`, `linux-meta`,
`vulkan-headers`, …); a blanket sweep would remove those too. Scope the sweep to `deepin|^dtk`.

### Possible risks of the permanent fix (path B)

- Loses `deepin-screen-recorder` + `deepin-image-editor`; if you rely on them, install a
  replacement first — OBS Studio (recording) / Spectacle (stills).
- Verified low otherwise: the removed libs (`dtk6*`, `deepin-qt6integration`, `deepin-turbo`,
  `deepin-image-editor`) have **zero non-Deepin dependents** (checked 2026-09-22), and Plasma
  uses `polkit-kde-agent`, so dropping `deepin-polkit-agent` does not touch auth prompts.
- Reversible-but-costly: reinstalling any Deepin app later drags the whole desktop — and this
  conflict — back in.
- The one way it goes wrong: a blanket orphan sweep (see WARNING above). Scope to `deepin|^dtk`.

### Fold: routines/ → archive/ once solved forever

This card sits in `routines/` because path A only defers the conflict — it returns every
cycle. Path B is the **permanent solution**: once applied and a clean `pacman -Syu` is
confirmed, the root recurrence is eliminated, so **fold this card `routines/` → `archive/` as
solved-once** (majkee's call). That is the intended end state — a routine that carries a known
permanent fix is not meant to live in `routines/` forever; it graduates to `archive/` the day
the fix lands.
