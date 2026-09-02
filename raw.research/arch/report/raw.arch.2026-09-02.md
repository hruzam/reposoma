# arch — substrate
_Fetched: 2026-09-02 | Window: 7 days | Sources: 2/3_

## arch-distro

**Arch Linux News** (arch-news) — No items in 7-day window (2026-08-26 → 2026-09-02).
Most recent published: "virtualbox-ext-vnc >= 7.2.12-2 requires manual intervention" (2026-07-21, 43 days ago) — uninstall/reinstall the VirtualBox VNC extension, or pacman with file-overwrite permission, to resolve upgrade conflicts.

Feed itself shows no build activity since 2026-07-21 (last-build-date stalled at that date) — flag as possible feed staleness, not just a quiet news week.

## arch-security

**Arch Linux Security Advisories** (arch-security) — No items in 7-day window.
⚠ Feed flag persists from 2026-07-10 run: WebFetch still returns advisory dates anchored to June 2025 (14+ months stale) — same entries as last run (ASA-202506-1 through ASA-202506-10, roundcubemail critical RCE topping the list). Confirms this is a static/JS-rendering fetch limitation, not a live "no new advisories" signal. Direct browser visit to security.archlinux.org/advisory required for accurate current CVE state.

## Run metadata
- No items in window: arch-news (most recent 2026-07-21), arch-security (feed flag — stale WebFetch, see above)
- Feed flags: arch-security (WebFetch returns Jun 2025 data only, unchanged since 2026-07-10 — JS-rendered page; cannot auto-fetch reliably); arch-news (RSS build-date stalled at 2026-07-21, worth a manual check that the feed itself is still updating)
- Manual-check (not fetched): arch-bbs-announce
