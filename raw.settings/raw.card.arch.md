---
card: card.arch
brand: Research — Arch Linux workstation health (scope: arch)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~7 days
half_life_days: 7
recheck:
  - ~/reposoma/raw.research/arch/draft/sources.jsonl
  - https://archlinux.org/feeds/news/
  - https://security.archlinux.org/advisory
verify_cmd: "curl -s https://archlinux.org/feeds/news/ | grep -c '<item>'"
---

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: archlinux.org/feeds/news, live-fetched 2026-10-08 by @Epoch. Security advisories feed NOT checked._
- **2026-09-22 — MANUAL INTERVENTION:** mkinitcpio >=42 with the systemd hook + TPM2-based LUKS unlock requires re-enrolling TPM2 (affects PCRs 0-7, 9, 12-14). See `systemd-cryptenroll(1)` (pinned values) / `systemd-pcrlock(8)` (custom policy). Relevant to this Manjaro-adjacent workstation only if TPM2 LUKS unlock is used. H
- No other news items after 2026-09-02. H

# arch — synthesis log

Skill: `/refresh arch` · Data: `raw.research/arch/draft/sources.jsonl`
Substrate: `raw.research/arch/report/`

## 2026-09-02

**Lead:** Quiet 7-day window again — no manual-intervention notices, no in-window CVEs. Most recent arch-news item is still "virtualbox-ext-vnc >= 7.2.12-2 requires manual intervention" (2026-07-21) — the feed's own build-date is stalled at that same date, worth a manual check that the feed is still updating. arch-security remains unfetchable live: WebFetch returns the same June-2025 advisory set as the 2026-07-10 run (roundcubemail critical RCE topping the list) — confirmed static/stale, not a real "no new CVEs" signal. Direct browser check required before any major upgrade.

**Convergence:** none in window

**Quiet:** arch-news (most recent 2026-07-21)

**Feed flags:** arch-security (WebFetch still returns Jun 2025 data, unchanged since 2026-07-10 — JS-rendered/stale); arch-news (RSS build-date stalled at 2026-07-21)

**Manual-check:** arch-bbs-announce

---

## 2026-07-10

**Lead:** Quiet week on arch-news — no manual-intervention notices in 7-day window. Most recent news item is the AUR malicious package surge (2026-06-12); check current AUR status if you pull from AUR. arch-security cannot be reliably auto-fetched — WebFetch returns Jun 2025 advisory data only (JS-rendered page); visit security.archlinux.org directly before any major upgrade.

**Convergence:** none in window

**Quiet:** arch-news (most recent 2026-06-12)

**Feed flags:** arch-security (WebFetch returns Jun 2025 data — JS-rendered; auto-fetch unreliable; manual browser check required)

**Manual-check:** arch-bbs-announce

---

<!-- older runs appended below this line, newest first -->
