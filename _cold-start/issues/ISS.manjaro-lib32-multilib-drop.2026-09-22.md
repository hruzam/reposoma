---
kind: issue-card
date: 2026-09-22
brand: claude
found_by: trajectory
project: ia-sync
root: ~/ia-sync
where: office host (hruzam-120922) · pacman -Syu — audit 4.2.1 blocked by dropped lib32-audit
defect: Manjaro dropped lib32-audit/lib32-pam/lib32-libcap from multilib, so audit 4.2.1 could not upgrade until the dead 5-package lib32 island was removed
assoc: [manjaro, pacman, multilib-drop, lib32-audit, partial-upgrade, office, one-shot, resolved]
severity: med
pointers:
  - ~/ia-sync/zsh/archx/ARCH_UPDATE_GUIDE.md
  - ~/ia-sync/journal.host-cleanup.md
  - https://forum.manjaro.org/t/cant-update-breaks-dependency-lib32-audit/190011
---

Observed live on office (hruzam-120922) 2026-09-22 during `sudo pacman -Syu`. RESOLVED the
same session; recorded as a fix-manual in case it recurs on home (different lib32 footprint).
One-shot per majkee's rule (issue = one-shot; the recurring deepin-kwin half of the same
transaction is filed as a routine — see footer).

Symptom: `installing audit (4.2.1-1) breaks dependency 'audit=4.1.4' required by lib32-audit`.

Mechanism: NOT multilib lag — Manjaro **removed** `lib32-audit`, `lib32-pam`, `lib32-libcap`
from multilib entirely (`pacman -Si` returns nothing for them; @Epoch confirmed via forum
thread 190011, confidence M). `core` advanced `audit` to 4.2.1; `lib32-audit` pinned
`audit=4.1.4` exactly, so the transaction could not resolve. Waiting never fixes it — the
packages are gone, not delayed.

Verified before acting: the dead set is a self-contained 5-package island (`-Rsc --print`
cascade): `lib32-audit ← lib32-pam ← lib32-libcap`, plus orphaned `lib32-libnsl` +
`lib32-libtirpc`. Nothing outside it depends on the chain; the other 72 `lib32-*` packages
are untouched; `steam`/`wine` not installed. (`transcode`, named in the forum thread, was
not installed here — drop it from the command.)

## Fix (applied 2026-09-22, confirmed working)

```
sudo pacman -Rsc lib32-audit      # removes exactly the 5-pkg dead island
sudo pacman -Syu                  # audit upgrades cleanly
```

One-shot per machine. If it recurs on **home**, verify the island there first
(`pacman -Rsc --print lib32-audit`) before running — home's lib32 dependents may differ.

Non-issue ruled out: a mid-diagnosis `-Rsc --print` threw `invalid or corrupted package`
naming stale *pre-upgrade* versions of `deepin-pw-check`/`qt6-multimedia`/`ffmpeg4.4`; a full
scan showed **1669/1669 local db entries intact**. NOT db corruption — do not chase a pacman
db repair.

---
Filed 2026-09-22 to `_cold-start/issues/`. The deepin-kwin blocker from the same `-Syu` is the
RECURRING half and is filed separately at
`~/reposoma/_cold-start/routines/ISS.deepin-kwin-vs-plasma-kwin.2026-09-22.md`. This card is
resolved (one-shot, fix applied) — ready for majkee to fold to `archive/`.
NOTE for majkee: ia-sync `AGENTS.md` "Known issues" still points at the OLD
`~/reposoma/_issues/` path; disk shows `_cold-start/` is the active vault. Doc drift flagged,
not fixed.
