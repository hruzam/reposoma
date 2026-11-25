---
title: Harness check — settings-card and guide freshness checker (harness-stale)
chapter-of: scheduler
---

<!-- chapter owner: @Epoch (gaveled by majkee 2026-11-25). Truth lives in ia-sync zsh/scheduled/harness-check.zsh — on conflict the code wins and this chapter is the bug (guide-writing rule 4). Re-verify against the script whenever it changes. -->

# Harness check — freshness checker

## What it is

`zsh/scheduled/harness-check.zsh` (deployed to `~/.config/zsh/scheduled/`) keeps knowledge
cards fresh. It scans two sets under one root — the live `~/reposoma` for `harness-stale`, the
job's own clone for the timer (see *The alert*):

- settings cards `raw.settings/raw.card.*.md` (threshold = `half_life_days`, default 30 if absent);
- guides `raw.guides/*.md` and `raw.guides/*/*.md` (depth 2) that carry BOTH `verified:` and
  `half_life_days:`. Others are skipped (`[-] Skipping ...`). A guide without `card:` is named by
  its path: `<dir>/GUIDE.md` → `<dir>`, `<dir>/<name>.md` → `<dir>/<name>`, top-level `<name>.md`
  → `<name>`; brand defaults to `guide:<card>`.

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
- `mail-inbox-dir` — where the stale alert lands (must end in `/inbox`; its sibling `archive/`
  is checked too).

Both values must sit under `~/reposoma/`: the timer rewrites that prefix onto its own clone and
refuses to run if it cannot.

The same file holds other keys (e.g. `remote-control`); the checker ignores them.

## Interactive check: `harness-stale`

```bash
harness-stale        # = harness-check.zsh --debug
```

One line per item: `FRESH` / `STALE`, verified date, elapsed vs limit, and the would-be mail path
(in the job's clone). Scans the live `~/reposoma`. Interactive runs never write, commit or fetch.

## The alert

Mail: `_mail/toAll/inbox/zsh.stale-settings-cards-<ISO-week>.md` on `origin/core`
(`<ISO-week>` = `date +%G-W%V`, e.g. `zsh.stale-settings-cards-2026-W47.md`). It reaches your
`~/reposoma` by an ordinary `git pull`.

The timer publishes from its own clone, `~/.local/share/harness/reposoma-mail` (override
`HARNESS_MAIL_REPO`; created by ia-sync deploy.sh on the scheduled host). It never touches the
live `~/reposoma` — no pull, no write. Per run:

1. Guards (read-only; abort on failure): clone exists, is not the live tree, is its own git
   toplevel, has the same `origin` URL as `~/reposoma`; a `flock` keeps runs from overlapping.
2. `fetch` (3 tries, 60 s apart; all fail → exit 1), then `reset --hard origin/core` + `clean -fdq`
   — inside the clone only.
3. This week's file already in `_mail/toAll/inbox/` or `_mail/toAll/archive/` → exit 0,
   `already published`. Once per ISO week; an archived alert is never resurrected.
4. Zero stale → exit 0, no file, no commit.
5. Else write it, commit that one path (`_mail: stale-settings-cards <week> (harness, <host>)`,
   clone-local identity), `push origin HEAD:core`. Rejected → back to 2, 3 attempts; all fail → exit 1.
   The unit retries a failed run (`Restart=on-failure`, 15 min, at most 6 starts a day).

- Body is deterministic: same stale set → same bytes (no timestamp, no host in the body).
- It spawns no research. It writes the alert only.
- One writer host: only office enables the timer (see scheduler GUIDE).

## When a card goes stale — the action loop

1. `git -C ~/reposoma pull`, then open `~/reposoma/_mail/toAll/inbox/zsh.stale-settings-cards-<ISO-week>.md`.
2. Run the card's verification command and/or visit its recheck links.
3. Confirm whether anything actually changed (versions, flags, breaking changes).
4. Set the card's `verified:` to today.
5. Run `harness-stale` and confirm `FRESH`.
