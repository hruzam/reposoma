---
title: Verify a scheduled job — the trigger rule and the post-deploy procedure
chapter-of: scheduler
---

# Verify a scheduled job

## The rule (0009-L5)

For any script with a trigger (systemd / git hook / cron), done = **the trigger fires and
produces its artifact**. A hand-run of the script is not verification. Close the loop with
`systemctl --user start <unit>` and `journalctl`, or a test commit on the watched path.

## Cautionary tale — the dead-path bug

`harness-check.zsh` was moved from `fresh/` to `ai/`, but `harness.service` kept pointing at the
old path. The timer fired, the service failed silently, and the checker never ran. It was found
only by inspecting the unit. The move had been "verified" by a hand-run of the script; the
trigger was never exercised.

## How to verify a scheduled job after deploy

Run on the host where the timer is enabled (office).

```bash
systemctl --user list-timers --all
```
Expected: `harness.timer` listed with a `NEXT` Monday 09:00 and a `LAST` time.

```bash
systemctl --user cat harness.service | grep ExecStart
```
Expected: `ExecStart=/bin/zsh /home/<you>/.config/zsh/scheduled/harness-check.zsh`.
If you see `.../.config/zsh/ai/harness-check.zsh`, the old unit is still deployed; the deploy was not applied.

```bash
systemctl --user start harness.service
systemctl --user status harness.service --no-pager | head -12
```
Expected: a oneshot shows `inactive (dead)` and `status=0/SUCCESS`. That is fine.

```bash
journalctl --user -u harness.service -n 15 --no-pager
journalctl --user -u harness.service --since today --no-pager
journalctl --user -u harness.service --no-pager -g 'published|nothing|ERROR'
journalctl --user -u harness.service --no-pager | grep -E 'published|nothing|ERROR'
journalctl --user -u harness.service --no-pager -o cat
journalctl --user -u harness.service -p err --no-pager
journalctl --user -u harness.service --since '10 min ago' --no-pager
```
Notes: `-g` takes a regex and needs journalctl built with PCRE2. `-o cat` strips the metadata prefix.

Expected lines:
- `harness-check: published _mail/toAll/inbox/zsh.stale-settings-cards-<YYYY>-W<NN>.md (<n> stale) → origin/core at <sha>` (first run of the week: committed + pushed from the job's clone)
- `harness-check: already published: zsh.stale-settings-cards-<YYYY>-W<NN>.md exists on origin/core (inbox or archive) — nothing to do` (any later run that week)
- `harness-check: no stale cards for <YYYY>-W<NN> — nothing published`
- `harness-check: ERROR: …` (guard refused, fetch failed 3×, or push failed 3×; the unit retries every 15 min, max 6 starts a day)

## Symptom → meaning

| Symptom | Meaning |
|---|---|
| `ExecStart` shows `.../ai/harness-check.zsh` | Old unit still deployed; deploy not applied |
| Mail named `zsh.stale-settings-cards-<YYYY-MM-DD>.md` (dated) | Old script still running |
| `published …-<YYYY>-W<NN>.md … → origin/core` | Alert committed + pushed from the clone; `git pull` to see it |
| `already published: …` | This week's file is on origin (inbox or archive); no commit |
| `ERROR: mail clone missing: …` | Clone `~/.local/share/harness/reposoma-mail` absent; run ia-sync deploy.sh on office |
| `ERROR: fetch from origin failed 3 times` | Network/auth down; live tree untouched; unit retries |
| `status=203/EXEC` or missing script | Dead path in `ExecStart`; the trigger does not reach the script |
| No `NEXT` in `list-timers` | Timer not enabled on this host |

## Home host

Home runs no timer by design. Verify there only with `harness-stale` and
`systemctl --user cat harness.service`. Do not `enable` the timer on home.
