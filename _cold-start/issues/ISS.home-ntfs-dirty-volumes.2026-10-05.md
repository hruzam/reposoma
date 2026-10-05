---
kind: issue-card
date: 2026-10-05
brand: codex
found_by: cartan
project: ia-sync
root: ~/ia-sync
where: ~/ia-sync (home host maintenance scope; NTFS volumes Pikczurouni and Data_M2)
defect: Home's Pikczurouni and Data_M2 NTFS volumes were inaccessible after a reported Linux reboot; read-only mounts restored access while ntfs3 recommends chkdsk for both.
assoc: [home, manjaro, ntfs3, dual-boot, windows, mount-failure, dirty-volume, read-only, chkdsk, ssd]
severity: med
pointers:
  - ~/ia-sync/machines.json
---

# Home NTFS volumes: access restored read-only, repair pending

## Observed — 2026-10-05, Europe/Prague (UTC+02:00)

First recorded in majkee's home-host troubleshooting conversation with @Cartan.
Operator reported two blocked partitions after a reboot within Linux on a Windows/Linux
dual-boot machine. Live checks identified host `hruzam`, `MACHINE_NAME=home`, Manjaro
(Arch-family), kernel `6.18.49-1-MANJARO`. This concerns live host storage, not a proven
defect in an ia-sync source file. Both affected volumes are on the Samsung SSD 860 QVO 1TB.

| Volume | Device at observation | NTFS UUID | Size |
|---|---|---|---|
| Pikczurouni | `/dev/sda4` | `542A7C172A7BF3F8` | 243.5 GiB |
| Data_M2 | `/dev/sda5` | `4E4ED4204ED4031F` | 687.4 GiB |

Kernel evidence from `journalctl -b -k`:

```text
2026-10-05T06:22:28+02:00 ntfs3(sda4): volume is dirty and "force" flag is not set!
2026-10-05T06:22:28+02:00 ntfs3(sda4): It is recommened to use chkdsk.
2026-10-05T06:34:37+02:00 ntfs3(sda4): It is recommened to use chkdsk.
2026-10-05T06:34:53+02:00 ntfs3(sda5): It is recommened to use chkdsk.
```

Confirmed: explicit dirty flag on Pikczurouni; chkdsk recommendation for both volumes.
Operator successfully mounted both read-only in their local terminal. Cartan independently
verified both mounts with `findmnt`, including a recheck at 06:48:43: filesystem `ntfs3`,
filesystem options `ro,uid=1000,gid=1000,iocharset=utf8`, mountpoints
`/run/media/hruzam/Pikczurouni` and `/run/media/hruzam/Data_M2`.

Unconfirmed: the initiating cause, Windows Fast Startup/hibernation, the extent of any
filesystem damage, and recurrence. Data_M2 had no explicit dirty-flag line in the captured
logs. Successful read-only mounting does not establish filesystem health or prove that
every file is readable. No repair or force-mount was performed.

## Verified workaround

Re-identify the volumes by label and UUID with `lsblk -f` before reusing device names after
a reboot. The commands that worked in the operator's local terminal were:

```bash
udisksctl mount -b /dev/sda4 -t ntfs3 -o ro
udisksctl mount -b /dev/sda5 -t ntfs3 -o ro
```

These provide temporary read-only access, including copying readable files elsewhere;
they do not clear the underlying condition or persist across reboot. Agent-side attempts
were blocked by local administrator authentication; the operator authenticated locally.

## Repair playbook — pending, not yet verified

1. Copy important readable files to separate storage before repair.
2. Boot Windows and identify the Windows drive letters for **Pikczurouni** and **Data_M2**
   by label and size; Linux device names do not determine Windows drive letters.
3. Close applications using those volumes. In an administrator terminal, run
   `chkdsk X: /f` and `chkdsk Y: /f`, substituting the two verified Windows drive letters.
   If Windows schedules a check, restart into Windows and let it finish before leaving.
   Save each final report, including any unresolved errors.
4. Restart into Manjaro and try normal mounts without `ro` or `force`. Verify the actual
   filesystem options with `findmnt`, inspect fresh NTFS kernel messages, and confirm
   ordinary file access plus a small disposable create/read/delete check on each volume.
   If either check remains unsuccessful, keep this issue unresolved and attach the output.

[Microsoft chkdsk reference](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk)
documents `/f` and scheduled checks. The [Linux NTFS3 documentation](https://cdn.kernel.org/doc/html/latest/filesystems/ntfs3.html)
discourages forcing a dirty volume. Windows Fast Startup is a possible contributor,
not the established cause here; investigate it if the condition recurs, using the
[NTFS-3G FAQ](https://github.com/tuxera/ntfs-3g/wiki/NTFS-3G-FAQ).

## Fold condition

Remain in `issues/` while repair and writable access are unverified. No deliberate parked
decision or known recurrence was recorded. Once both repairs and writable mounts pass,
record the evidence here; moving to `archive/` is majkee's separate per-card decision.
A later proven recurrence can justify a fold to `routines/`, also by operator decision.
