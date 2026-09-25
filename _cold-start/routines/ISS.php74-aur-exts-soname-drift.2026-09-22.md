---
kind: issue-card
date: 2026-09-22
brand: claude
found_by: trajectory
project: ia-sync
root: ~/ia-sync
where: office host (hruzam-120922) · native AUR php74 stack (/usr/lib/php74/modules/*.so) vs system-library soname bumps
defect: after a pacman -Syu bumps a shared-lib soname (ICU, net-snmp, openssl), the AUR-built php74-* extensions linked to the old soname stop loading until the whole php74 split PKGBUILD is rebuilt — invisible to apps that don't use the broken ext, fatal to those that do
assoc: [manjaro, pacman, yay, aur, php74, icu, soname-drift, partial-upgrade, ext-intl, office, recurring]
severity: med
pointers:
  - ~/ia-sync/journal.host-cleanup.md
  - ~/ia-sync/zsh/archx/ARCH_UPDATE_GUIDE.md
origin: issue
recorded: 2026-09-25
---

Known-recurring issue, placed directly in `routines/` under issue-card path 1 (recurring, per
majkee's rule: issue = one-shot, routine = recurs regularly). First seen office 2026-09-22,
resolved 2026-09-23. A clean example of the class: a routine with a known permanent playbook,
filed so the next occurrence is a lookup, not a re-derivation.

## Mechanism

`php74` on office is **native PHP 7.4 (EOL) built from the AUR** — one big split PKGBUILD that
produces ~60 packages (`php74` core + `php74-fpm` + every `php74-<ext>`). `pacman -Syu` updates
the **system/repo** libraries (ICU, net-snmp, openssl, …) but **never touches AUR packages**.
When a system update bumps a library's **soname** (`libicuio.so.74 → .78`, `libnetsnmp.so.40 →
.45`, …), the still-`-old` php74 extensions that link the vanished soname fail to load —
`php74-intl` (ICU) and `php74-snmp` (net-snmp) are the usual first casualties.

Deceptive symptom: **the site can still work.** FantasyObchod (OpenCart) loads fine because it
doesn't use `intl`, so `php74-fpm` "active" + site up does NOT mean the stack is whole. Apps
that hard-require the broken ext DO fatal: **Freya** declares `ext-intl` (both `imago_cz` +
`freya` composer.json) and calls it at runtime (`PhoneNumberFormatter`, `cart_manager`,
Newsletter `Subscribe`, `Helpers`).

**Home is immune** — home runs php74 in Docker (`php74-composer`), which bundles a matching ICU
inside the container, so system-lib soname drift never reaches it. This routine is **office-only**.

## Detect

```bash
/usr/bin/php74 -m 2>&1 | grep -ic "unable to load"     # >0  → an extension isn't loading
/usr/bin/php74 -m 2>&1 | grep -i  "unable to load"     # names the broken .so + missing soname
pacman -Q | grep '^php74' | grep -c ' <ver>-<oldrel>$' # count php74 pkgs still at the old pkgrel
```

## Recovery — the permanent fix: rebuild once, install the whole split from cache

1. **Rebuild the split once.** Building ANY one member rebuilds the whole php74 PKGBUILD:
   ```bash
   yay -S php74-intl
   ```
   - The build runs PHP's test suite — lines like `PASS … [*_error.phpt]` are **passing tests,
     not errors**. Success = `==> Finished making: php74 <ver>`. A real failure is `==> ERROR:`.
   - A long build looks frozen when piped (`| tee` block-buffers output AND hides prompts). If
     you want a log, use `script -q -c "yay -S php74-intl" /tmp/i.log` (interactive + logged,
     unbuffered) — never a pipe.
2. **Install the whole split from the build cache — no recompile:**
   ```bash
   sudo pacman -U $(pacman -Q | grep '^php74' | grep -E ' <ver>-<oldrel>$' | awk '{print $1}' \
     | while read p; do echo ~/.cache/yay/php74/$p-<ver>-<newrel>-x86_64.pkg.tar.zst; done)
   ```
   - **Target ONLY the stale ones** (`grep ' <ver>-<oldrel>$'`). Do NOT map every `php74*`
     package: `php74-imagick` is a SEPARATE package at its own version (`3.7.0-x`), so building
     its `<ver>-<newrel>` path does not exist — and `pacman -U` is **atomic**, so one missing
     path rolls back the entire transaction (0 installed). That is the trap that wastes a cycle.
3. **Restart FPM:** `sudo systemctl restart php74-fpm`
4. **Verify:**
   ```bash
   echo "still old: $(pacman -Q | grep '^php74' | grep -c ' <ver>-<oldrel>$')"   # want 0
   /usr/bin/php74 -m 2>&1 | grep -ic "unable to load"                            # want 0
   ```
   Then reload the app that needs the ext (Freya) to confirm end-to-end.

## Don't reach for Docker first

The tempting "worst case = do what home does (Docker)" is NOT the first move. Verified
2026-09-23: PHP 7.4's `intl` compiled cleanly against ICU 78 — no EOL-PHP/ICU wall. The Docker
migration is warranted only if a future rebuild genuinely fails to compile (a real
`==> ERROR:`), not merely because the installed `-old` extensions don't load. Rebuild first.

## Worked example (first occurrence)

2026-09-22 `pacman -Syu` moved ICU 74→78 and net-snmp 40→45; the AUR php74 stack stayed at
`7.4.33-5`, so `intl.so` (needed `libicuio.so.74`) and `snmp.so` (needed `libnetsnmp.so.40`)
stopped loading. FantasyObchod kept working (no intl); Freya would have fataled. Fixed 09-23:
`yay -S php74-intl` built the split to `7.4.33-11` clean against ICU 78, then
`sudo pacman -U ~/.cache/yay/php74/*-7.4.33-11-*.pkg.tar.zst` (stale-only) + FPM restart →
0 at `-5`, 0 load errors, `intl.so → libicuio.so.78`. Full narrative:
`~/ia-sync/journal.host-cleanup.md` OFFICE 2026-09-22 entry.
