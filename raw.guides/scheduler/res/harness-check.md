---
title: Harness check — settings-card and guide freshness checker (harness-stale)
chapter-of: scheduler
---

<!-- chapter owner: zsh maintainer — pending assignment by majkee -->

# Harness check — freshness checker

## What it is

`zsh/scheduled/harness-check.zsh` (deployed to `~/.config/zsh/scheduled/`) keeps knowledge
cards fresh. It scans two sets:

- settings cards `~/reposoma/raw.settings/raw.card.*.md` (threshold = `half_life_days`, default 30 if absent);
- guides `~/reposoma/raw.guides/*/GUIDE.md` that carry BOTH `verified:` and `half_life_days:`.
  Guides lacking `half_life_days:` are skipped (`[-] Skipping ...`).

It computes days since `verified:` and flags anything past its limit as STALE.

## Registry config

Path: `~/.config/zsh/registries/ai.json`. The checker reads two keys:

```json
{
  "native-primitives-update-pattern": "~/reposoma/raw.settings/raw.card.*.md",
  "mail-inbox-dir": "~/reposoma/_mail/toAll/inbox/"
}
```

- `native-primitives-update-pattern` — glob of settings cards to check (`~/` keeps it portable).
- `mail-inbox-dir` — where the stale alert lands.

The same file holds other keys (e.g. `remote-control`); the checker ignores them.

## Interactive check: `harness-stale`

```bash
harness-stale        # = harness-check.zsh --debug
```

One line per item: `FRESH` / `STALE`, verified date, elapsed vs limit, and the would-be mail path.
Interactive runs never write the mail unless the job path runs it.

## The alert

Mail: `~/reposoma/_mail/toAll/inbox/zsh.stale-settings-cards-<ISO-week>.md`
(`<ISO-week>` = `date +%G-W%V`, e.g. `zsh.stale-settings-cards-2026-W47.md`).

- Body is deterministic: same stale set → same bytes.
- Skip-if-unchanged: an existing identical file is not rewritten; the log says `unchanged`.
- Best-effort `git -C ~/reposoma pull --ff-only` runs first; failure is ignored.
- The job never commits. It spawns no research. It writes the alert only.
- One-writer rule: only the office host runs the timer (see scheduler GUIDE). A second writer
  creates an untracked same-name file and aborts the other host's `git pull`.

## When a card goes stale — the action loop

1. Open `~/reposoma/_mail/toAll/inbox/zsh.stale-settings-cards-<ISO-week>.md`.
2. Run the card's verification command and/or visit its recheck links.
3. Confirm whether anything actually changed (versions, flags, breaking changes).
4. Set the card's `verified:` to today.
5. Run `harness-stale` and confirm `FRESH`.
