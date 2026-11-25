---
title: Scheduled jobs — systemd user timers via ia-sync zsh/scheduled
scope: scheduler
audience: operator + agent
machine: both
verified: 2026-11-25
half_life_days: 30
verify_cmd: systemctl --user list-timers --all
---

# Scheduled jobs — systemd user timers

## When to reach for this, and what to type

You add, inspect, or verify a timed job (a script that runs on a schedule).

```bash
systemctl --user list-timers --all            # what is scheduled, when it last/next ran
systemctl --user cat harness.service | grep ExecStart   # which script the unit runs
systemctl --user start harness.service        # run it now (the trigger test)
journalctl --user -u harness.service -n 15 --no-pager   # its last output
```

The full verify procedure is in `res/verify-trigger.md`. Operator helper: `.majkee/helpers/scheduler-check/HELP.md`.

## Jobs

| Job | Unit | Enabled on | Schedule | Script (deployed path) | Source |
|---|---|---|---|---|---|
| harness | `harness.service` + `harness.timer` | office only | Mon 09:00, `Persistent=true` | `~/.config/zsh/scheduled/harness-check.zsh` | ia-sync `zsh/scheduled/` |

## How a job is deployed

ia-sync `deploy.sh` → `deploy_scheduled_units`:

1. Copies `zsh/scheduled/*.service` and `*.timer` to `~/.config/systemd/user/`.
2. Runs `systemctl --user daemon-reload`.
3. Only when `$MACHINE` is listed in `SCHEDULED_ENABLE_HOSTS` (default `office`): creates the
   harness mail clone if missing (`git clone --branch core <origin of ~/reposoma>
   ~/.local/share/harness/reposoma-mail`, clone-local `user.name`/`user.email`), then runs
   `systemctl --user enable --now` on the timers. Other hosts get the units installed, timer not enabled.

No `--delete`: a file removed from ia-sync stays deployed. Remove old deployed files by hand.

## Policy

- A job never writes into a live working tree. A job that publishes into a tracked repo does it
  from its own clone (`~/.local/share/harness/reposoma-mail` for harness; deploy.sh creates it on
  `SCHEDULED_ENABLE_HOSTS`): fetch → reset → write → commit → push.
- The job commits only its own file, only from its own clone (option C, gaveled 2026-11-25):
  once per ISO week, skipped if the file is already in `_mail/toAll/inbox/` or `archive/`.
- Home and monitor run no timer by design; use the interactive command there.

## How to add a job

1. Write the script and a `.service` (oneshot) and `.timer` into ia-sync `zsh/scheduled/`.
   Point `ExecStart` at the deployed path under `~/.config/zsh/scheduled/`.
2. If the timer should run on another host, add that host to `SCHEDULED_ENABLE_HOSTS` in `deploy.sh`.
   Mind the single-writer policy above.
3. Deploy (dry-run first, see the helper). Commit ia-sync.
4. Verify the real trigger, not the script by hand: `res/verify-trigger.md`.
5. Add the job to the Jobs table and the Manifest here, and commit reposoma the same session.

## Status — 2026-11-25

- Office runs the new layout: `ExecStart` = `~/.config/zsh/scheduled/harness-check.zsh`, ISO-week
  mail name. W48 is published (`_mail/toAll/inbox/zsh.stale-settings-cards-2026-W48.md`).
- Option C is deployed on all three hosts (ia-sync `577951b`). Office has the clone
  `~/.local/share/harness/reposoma-mail` and the timer is enabled, next run Mon 11-30 ~09:06.
  On a manual `systemctl --user start harness.service` it logged `already published` (no commit),
  and the live `~/reposoma` was byte-identical before and after.
- Home and monitor: units installed, timer not enabled.
- First real publish: Mon 11-30 (W49), the first week with no file yet.

## Manifest

- `res/harness-check.md` · chapter · owner @Epoch · the stale-settings-cards checker (`harness-stale`, the action loop)
- `res/verify-trigger.md` · chapter · the 0009-L5 rule, the dead-path tale, verify-after-deploy procedure

## Pointers

- `zsh/scheduled/README.md` in ia-sync (deploy + enable policy)
- `~/.config/zsh/AGENTS.md`
- `raw.guides/guide-writing/GUIDE.md` (guide law)
- `raw.guides/temple-mail/GUIDE.md` (mail surface)
- `_mail/README.md`
