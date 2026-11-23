# Scheduler check

## Timers on this host

```bash
systemctl --user list-timers --all
```

Lists each user timer with its next and last run.

## ExecStart path check

```bash
systemctl --user cat harness.service | grep ExecStart
```

Good: `.../.config/zsh/scheduled/harness-check.zsh`. Old `.../ai/harness-check.zsh` means the deploy is not applied.

## Start the job now

```bash
systemctl --user start harness.service
```

Runs the job once; this is the trigger test.

## Status

```bash
systemctl --user status harness.service --no-pager | head -12
```

A oneshot shows `inactive (dead)` and `status=0/SUCCESS` when fine.

## Journal — last run

```bash
journalctl --user -u harness.service -n 15 --no-pager
```

Last 15 lines of the job's output.

## Journal — today

```bash
journalctl --user -u harness.service --since today --no-pager
```

## Journal — grep filter

```bash
journalctl --user -u harness.service --no-pager -g 'Released|unchanged|Error'
journalctl --user -u harness.service --no-pager | grep -E 'Released|unchanged|Error'
```

`-g` needs PCRE2; the pipe works everywhere.

## Expected output

Good: `Released stale cards alert: ...-<YYYY>-W<NN>.md` or `Stale cards alert unchanged: ...`.
Old: a dated name `zsh.stale-settings-cards-2026-11-23.md` means the old script is still running.

## Dry-run deploy before the real deploy

```bash
~/ia-sync/deploy.sh --dry-run
```

Reports every change without writing. Flag taken from the `deploy.sh` header (`--dry-run` / `-n`).

## Delete the old script

```bash
rm ~/.config/zsh/ai/harness-check.zsh
```

Only after the new service has run once. Delete on each host by hand; deploy has no `--delete`.

## Where the docs live

`/guide scheduler` and `raw.guides/scheduler/res/`.

Full guide: `raw.guides/scheduler/GUIDE.md`
