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

## Refresh delta 2026-11-25
_PARTIAL: archlinux.org/news/ and archlinux.org/feeds/news/ read once each (titles + dates only); security.archlinux.org/advisory, raw.research/arch/draft/sources.jsonl and article bodies NOT checked. Since last verify 2026-10-08. Live-fetched 2026-11-25 by @Epoch sibling._
- **Feed-vs-page verdict: genuine quiet, not a stale snapshot.** HTML news page (dates shown) lists newest item 2026-10-21; RSS feed lastBuildDate is Wed, 21 Oct 2026 19:29:36 +0000 with the same top items in the same order. Two independent renderings agree, so there are no Arch news items between 2026-10-21 and 2026-11-25 (~5 weeks). Caveat: fetches pass through a summarizing model and a 15-min cache. M-H
- **NEW 2026-10-21 (two items, ~14:00 UTC; both missing from the card):** (a) "Update to php >= 8.5.12 and/or php-legacy >= 8.3.36 to prevent remote code execution"; (b) "Update to ca-certificates-mozilla >= 3.131.1-1 to prevent man-in-the-middle attacks". Only titles were read; the compromised-eMudhra-intermediates detail from the lead was NOT verified from the article body. Action if PHP or TLS trust is used: update both. H (titles/dates), body L
- **2026-09-22 mkinitcpio >=42 / TPM2-LUKS manual intervention:** title and date confirmed live ("Mkinitcpio >=42 requires manual intervention for TPM2-based unlocking of LUKS devices"). The card's detail (PCRs 0-7, 9, 12-14; systemd-cryptenroll / systemd-pcrlock) was NOT re-verified from the body. H (title/date), detail L
- **2026-07-21 virtualbox-ext-vnc >= 7.2.12-2 requires manual intervention** and **2026-06-12 "Active AUR malicious packages incident"**: both still present on the page with those dates. Article bodies not read. H (title/date)
- Other items in the page's latest ten: 2026-06-04 Leader Election Results; 2026-05-25 varnish renamed vinyl-cache; 2026-04-07 kea >= 1:3.0.3-6; 2026-04-05 iptables defaults to nft; 2025-12-20 NVIDIA 590 drops Pascal and lower. H
- **Manjaro:** card has no Manjaro source (no manjaro.org / forum stable-update thread in `recheck:`) and only calls the workstation "Manjaro-adjacent". Not verified. Note: Arch news applies to Manjaro only after its delay; check Manjaro stable-update announcements separately.
- Kernel / pacman / systemd versions: the card makes no such claims; nothing to verify.
- verify_cmd (`grep -c '<item>'`): not run (no Bash). Feed read via WebFetch showed 10 items. L

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: archlinux.org/feeds/news, live-fetched 2026-10-08 by @Epoch. Security advisories feed NOT checked._
- **2026-09-22 — MANUAL INTERVENTION:** mkinitcpio >=42 with the systemd hook + TPM2-based LUKS unlock requires re-enrolling TPM2 (affects PCRs 0-7, 9, 12-14). See `systemd-cryptenroll(1)` (pinned values) / `systemd-pcrlock(8)` (custom policy). Relevant to this Manjaro-adjacent workstation only if TPM2 LUKS unlock is used. H
- Superseded 2026-11-25: two further items on 2026-10-21 (php >= 8.5.12 / php-legacy >= 8.3.36 RCE fix; ca-certificates-mozilla >= 3.131.1-1 MITM fix); none since. H

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
