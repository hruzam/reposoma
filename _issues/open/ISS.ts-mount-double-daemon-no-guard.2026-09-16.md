---
kind: issue-card
date: 2026-09-16
project: ia-sync
root: ~/ia-sync
where: ~/ia-sync/zsh/system/tailscale.zsh (_ts_mount)
defect: ts-mount does not guard against a second sshfs daemon stacking on the same mountpoint
found_by: trajectory
brand: claude
pointers:
  - ~/ia-sync/zsh/system/tailscale.zsh
  - ~/ia-sync/journal.host-cleanup.md
---

Observed live on home 2026-09-16 while chasing the sublime-zombie-tsmount diagnosis: two
full sshfs daemon pairs (`fusermount3` + `sshfs`) were running simultaneously for the same
peer (`hruzam-120922`) and the same mountpoint (`~/mnt/hruzam-120922`) — one ~2 days stale,
one ~1h13m old. `/proc/mounts` only ever shows one mount line, so `_ts_mount`'s own
`/proc/mounts` idempotency check (`already mounted: $mnt`) did not catch the second daemon;
it must have raced or been invoked while the first daemon's mount hadn't yet registered, or
survived past an unclean session end without `ts-umount` ever running.

Consequence, confirmed: a process doing I/O through the mount can end up wedged in D-state
against whichever daemon it happened to open the file through, and a plain SIGTERM to that
daemon can be silently absorbed (see `ISS.` — not yet filed — the ts-mount-kill SIGKILL-
escalation fix committed the same session, `zsh/system/tailscale.zsh` commit `b0d001c`).
The double-daemon state itself is what enabled that confusion — killing the "obvious" sshfs
pid didn't visibly help until the actual stale one was also found and killed.

Not yet triaged into a fix (hence `open/`, not `parked/`) — no operator call made on whether
`_ts_mount` should reject/warn on a second daemon for the same peer+mountpoint, or whether
`ts-umount`/`ts-mount-kill` should sweep ALL matching daemons for a peer rather than just
the ones `pgrep` happens to return first.

First flagged: `~/ia-sync/journal.host-cleanup.md`, HOME — 2026-09-16 entry ("ts-mount rescue
+ zombie-sweep fixture"), under "Also noticed, out of scope, flagging only" is the wrong
line — this defect was actually noticed under the ts-mount-kill live-test narrative later in
the same entry, not the zombie-count aside. Cross-check the journal entry directly if this
summary drifts.
