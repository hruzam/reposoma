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
_PARTIAL: archlinux.org/news/ + feed (titles/dates) and all five article bodies read via WebFetch (a summarizing model; no verbatim text); security.archlinux.org/advisory read for the first 100000 of 188082 chars only; raw.research/arch/draft/sources.jsonl and Manjaro announcement bodies NOT checked. Since last verify 2026-10-08. Live-fetched 2026-11-25 by @Epoch sibling (pass 2)._
- **Feed-vs-page verdict: genuine quiet, not a stale snapshot.** HTML news page lists newest item 2026-10-21; RSS lastBuildDate Wed, 21 Oct 2026 19:29:36 +0000 with the same top items. Two renderings agree: no Arch news items between 2026-10-21 and 2026-11-25 (~5 weeks). Caveat: fetches pass through a summarizing model and a 15-min cache. M-H
- **2026-10-21 php RCE (body read; author David Runge):** php < 8.5.12 and php-legacy < 8.3.36 affected; fixed in php >= 8.5.12 / php-legacy >= 8.3.36. CVE-2026-109618 and CVE-2026-109619 ("allow for remote code execution"). Systems publicly exposing a PHP application should upgrade immediately. Advisories ASA-202610-1 (php) and ASA-202610-2 (php-legacy), both Critical / arbitrary code execution on security.archlinux.org (confirmed in the advisory list, dated 21 Oct 2026). H (CVE ids are as given by the summarizer; verify on the advisory pages before citing externally)
- **2026-10-21 ca-certificates-mozilla (body read):** on 2026-10-20 it was revealed that several certificates of the eMudhra intermediate CA were compromised; they were removed/invalidated in ca-certificates-mozilla 3.131.1-1. Without the update the system is open to man-in-the-middle attacks; upgrade to >= 3.131.1-1 immediately. The article links a separate write-up of the incident (not read). H
- **2026-09-22 mkinitcpio >= 42 / TPM2-LUKS (body read; David Runge) — the card's 2026-10-08 detail is CONFIRMED:** from mkinitcpio 42-1 the systemd hook includes `systemd-pcrosseparator.service` (as systemd v261 intended); measurements for PCRs 0-7, 9 and 12-14 are affected. Users of the systemd hook who unlock LUKS depending on those PCRs must re-enroll the TPM2. Pinned PCR values: see `systemd-cryptenroll(1)` and the ArchWiki systemd-cryptenroll page; custom policy (with `systemd-pcrlock-make-policy.service` disabled): see `systemd-pcrlock(8)`. The article gives no concrete commands. H
- **2026-07-21 virtualbox-ext-vnc >= 7.2.12-2 (body read; Christian Hesse):** the extension was previously installed by a VirtualBox command from an install script, so pacman did not track its files; upgrade needs manual intervention. Options: (1) uninstall the package, upgrade, reinstall; (2) as root before upgrading `VBoxManage extpack uninstall 'VNC'`; (3) once `pacman -Syu --overwrite '/usr/lib/virtualbox/ExtensionPacks/VNC/*'`. H
- **2026-06-12 Active AUR malicious packages incident (body read; Campbell Jones):** high volume of malicious package adoptions/updates in the AUR; staff tracking malicious commits, working toward a permanent fix. No specific packages named. Possible impacts: cannot create AUR accounts, push updates, adopt/create packages. Advice: review all PKGBUILD and install-script changes before updating AUR packages; report suspicious commits via the aur-general mailing list. No resolution or all-clear in the post (incident notice only; no follow-up news item exists through 2026-11-25). H
- **security.archlinux.org/advisory (partial):** newest entries are ASA-202610-1 and ASA-202610-2 (21 Oct 2026, php / php-legacy, Critical); no advisory dated after 2026-10-21 seen in the portion read. The remaining visible entries are Jun/May 2025 (ASA-202506-10 libblockdev down to ASA-202505-13 varnish), which is an odd jump: either the page is partial/stale or sparsely rendered. The earlier 2026-09-02 log already flagged this feed as unreliable via WebFetch, so "no new advisories" is NOT established. Check in a browser before any major upgrade. L
- **Manjaro (card says only "Manjaro-adjacent"; no Manjaro source in `recheck:`):** forum.manjaro.org stable-updates category list (titles only; the page's dates are "activity" dates and are inconsistent with titles, so treat as M-L) shows newest "[Stable Update] 2026-11-23 - GNOME 51, Plasma 6.8, Cinnamon 6.8, COSMIC 1.11.0" and prior "2026-10-28 - Plasma 6.75, GNOME 50.5, COSMIC 1.9.0". No title mentions mkinitcpio 42, php, ca-certificates-mozilla or manual intervention; announcement bodies were NOT read, so whether Manjaro stable carries these Arch fixes (and any manual-intervention notes) is unverified. Manjaro is delayed behind Arch: the ca-certificates and php fixes may not yet be in stable; check `pacman -Qi ca-certificates-mozilla` locally. L
- Other items in the news page's latest ten: 2026-06-04 Leader Election Results; 2026-05-25 varnish renamed vinyl-cache; 2026-04-07 kea >= 1:3.0.3-6; 2026-04-05 iptables defaults to nft; 2025-12-20 NVIDIA 590 drops Pascal and lower. H (titles/dates)
- Kernel / pacman / systemd versions: the card makes no such claims; nothing to verify.
- verify_cmd (`grep -c '<item>'`): not run (no Bash). Feed read via WebFetch showed 10 items. L

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: archlinux.org/feeds/news, live-fetched 2026-10-08 by @Epoch. Security advisories feed NOT checked._
- **2026-09-22 — MANUAL INTERVENTION:** mkinitcpio >=42 with the systemd hook + TPM2-based LUKS unlock requires re-enrolling TPM2 (affects PCRs 0-7, 9, 12-14). See `systemd-cryptenroll(1)` (pinned values) / `systemd-pcrlock(8)` (custom policy). Relevant to this Manjaro-adjacent workstation only if TPM2 LUKS unlock is used. H
- Superseded 2026-11-25: two further items on 2026-10-21 (php >= 8.5.12 / php-legacy >= 8.3.36 RCE fix, CVE-2026-109618/109619, ASA-202610-1/-2; ca-certificates-mozilla >= 3.131.1-1 after the eMudhra intermediate-CA compromise); none since. The PCR 0-7, 9, 12-14 detail above is confirmed against the article body. H

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
