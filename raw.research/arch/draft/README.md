---
scope: arch
sources_file: raw.research/arch/draft/sources.jsonl
output_path: raw.research/arch/report/raw.arch.<YYYY-MM-DD>.md
card: raw.settings/raw.card.arch.md
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

# Scope: arch

Periodic briefing on Arch Linux workstation health. Invoked as `/refresh arch`.
Window 7 days; persist ephemeral.

Tier 1 (act-now): Arch News (manual-intervention notices) + Security Advisories (CVEs).
Tier 2 (awareness): BBS Announcements — manual check, not auto-fetchable.

Discipline: tooling/craft discovery is out of scope. Add a separate browse-lane
scope if needed later.

Skill: `/refresh arch`
Card: `raw.settings/raw.card.arch.md`
