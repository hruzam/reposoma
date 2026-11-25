---
title: Scheduled jobs — systemd user timers via ia-sync zsh/scheduled
scope: scheduler
audience: operator + agent
machine: both
verified: 2026-11-23
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
3. Runs `systemctl --user enable --now` on the timers only when `$MACHINE` is listed in
   `SCHEDULED_ENABLE_HOSTS` (default `office`). Other hosts get the units installed, timer not enabled.

No `--delete`: a file removed from ia-sync stays deployed. Remove old deployed files by hand.

## Policy

- One writer host for anything that writes into a tracked repo: `office`. A second writer
  creates an untracked same-name file and aborts the other host's `git pull --ff-only`.
- A job never commits. A human or agent commits and pushes its output.
- Home runs no timer by design; use the interactive command there.

## How to add a job

1. Write the script and a `.service` (oneshot) and `.timer` into ia-sync `zsh/scheduled/`.
   Point `ExecStart` at the deployed path under `~/.config/zsh/scheduled/`.
2. If the timer should run on another host, add that host to `SCHEDULED_ENABLE_HOSTS` in `deploy.sh`.
   Mind the single-writer policy above.
3. Deploy (dry-run first, see the helper). Commit ia-sync.
4. Verify the real trigger, not the script by hand: `res/verify-trigger.md`.
5. Add the job to the Jobs table and the Manifest here, and commit reposoma the same session.

## Status — 2026-11-23

- Office timer fired Mon 11-23 09:00, and again on manual start at 20:23:59; exit 0.
  BUT `ExecStart` is still `~/.config/zsh/ai/harness-check.zsh` and the mail is named
  `zsh.stale-settings-cards-2026-11-23.md` (dated). That is the OLD script and unit.
- New layout (`zsh/scheduled/`, deploy leg `deploy_scheduled_units`) is prepared in ia-sync,
  uncommitted, not yet deployed.
- Home: no timer, by design.

## Manifest

- `res/harness-check.md` · chapter · owner @Epoch · the stale-settings-cards checker (`harness-stale`, the action loop)
- `res/verify-trigger.md` · chapter · the 0009-L5 rule, the dead-path tale, verify-after-deploy procedure

## Pointers

- `zsh/scheduled/README.md` in ia-sync (deploy + enable policy)
- `~/.config/zsh/AGENTS.md`
- `raw.guides/guide-writing/GUIDE.md` (guide law)
- `raw.guides/temple-mail/GUIDE.md` (mail surface)
- `_mail/README.md`
