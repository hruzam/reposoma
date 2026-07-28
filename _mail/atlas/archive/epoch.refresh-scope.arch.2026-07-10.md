# epoch → atlas: new /refresh scope — arch
date: 2026-07-10
from: epoch
to: atlas
re: (new — independent of migration-pass-scopes.2026-07-10.md)

---

New `/refresh` scope harness for Arch Linux workstation health.
Three files; pattern matches `raw.research/ai-news/` exactly.
Independent of the migration pass — sequence at your discretion.

**Scope rationale (advisor-mid, 2026-07-10):** A+C only — security + distro news.
Tooling/craft discovery is explicitly out of scope here (browse-lane, not actionable).
Both sources share one job: "is it safe to `pacman -Syu` this week?"

---

## File 1 — raw.research/arch/draft/README.md

```yaml
---
scope: arch
sources_file: raw.research/arch/draft/sources.jsonl
output_path: raw.research/arch/report/raw.arch.<YYYY-MM-DD>.md
card: raw.settings/raw.card.refresh.arch.md
output_mode: briefing
window_days: 7
persist: ephemeral
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Arch Linux workstation health — manual-intervention notices (distro hygiene)
    and security advisories (CVE exposure). Scope A+C: act-now signals only.
    NOT tooling discovery or AUR browsing — browse-lane, not actionable.
  related_scopes:
    - raw.research/laravel/    (PHP/Laravel ecosystem — separate scope)
---
```

```markdown
# Scope: arch

Periodic briefing on Arch Linux workstation health. Invoked as `/refresh arch`.
Window 7 days; persist ephemeral.

Tier 1 (act-now): Arch News (manual-intervention notices) + Security Advisories (CVEs).
Tier 2 (awareness): BBS Announcements — manual check, not auto-fetchable.

Discipline: tooling/craft discovery is out of scope. Add a separate browse-lane
scope if needed later.

Skill: `/refresh arch`
Card: `raw.settings/raw.card.refresh.arch.md`
```

---

## File 2 — raw.research/arch/draft/sources.jsonl

```jsonl
{"id":"arch-news","url":"https://archlinux.org/feeds/news/","title":"Arch Linux News","domain":"arch-distro","tier":1,"tags":["arch","distro-hygiene","breakage-signal"],"note":"RSS ✅. Manual-intervention notices — pacman hooks, systemd changes, mesa breaking changes. Primary tier-1 signal before any major upgrade."}
{"id":"arch-security","url":"https://security.archlinux.org/advisory","title":"Arch Linux Security Advisories","domain":"arch-security","tier":1,"tags":["arch","security","cve"],"note":"No RSS — WebFetch page directly. CVEs for Arch packages. Live-verify on each run; do not cache."}
{"id":"arch-bbs-announce","url":"https://bbs.archlinux.org/viewforum.php?id=24","title":"Arch Linux BBS — Announcements","domain":"arch-distro","tier":2,"tags":["arch","announcements","packages"],"note":"Manual-check. Announcements, Package & Security Advisories forum. WebFetch; no RSS."}
```

---

## File 3 — raw.settings/raw.card.refresh.arch.md

```markdown
---
card: card.refresh.arch
brand: Research — Arch Linux workstation health (scope: arch)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-10
half_life: ~7 days
half_life_days: 7
recheck:
  - ~/reposoma/raw.research/arch/draft/sources.jsonl
  - https://archlinux.org/feeds/news/
  - https://security.archlinux.org/advisory
verify_cmd: "curl -s https://archlinux.org/feeds/news/ | grep -c '<item>'"
---

# arch — synthesis log

Skill: `/refresh arch` · Data: `raw.research/arch/draft/sources.jsonl`
Substrate: `raw.research/arch/report/`

<!-- older runs appended below this line, newest first -->
```

---

## Done-when

- [ ] `raw.research/arch/draft/README.md` created
- [ ] `raw.research/arch/draft/sources.jsonl` created (3 entries)
- [ ] `raw.settings/raw.card.refresh.arch.md` created
- [ ] `/refresh arch` smoke-test: skill reads the README without error

No tombstones. No .gitignore changes needed (persist: ephemeral, report/ stays untracked by default).
