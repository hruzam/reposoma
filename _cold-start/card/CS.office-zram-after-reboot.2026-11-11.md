---
kind: cold-start-card
date: '2026-11-11'
brand: codex
seat: Cartan
project: ia-sync
root: ~/ia-sync
commit: 3854bcc (main)
task: After the operator reboots office, verify the running kernel and help complete zram swap for CLI memory headroom.
resume: codex -C ~/ia-sync 'Read ~/reposoma/_cold-start/card/CS.office-zram-after-reboot.2026-11-11.md and continue the office zram setup with me.'
model: sol
dedicated: Cartan
recommend: Verify the post-reboot module tree first; reuse and revalidate the existing office sheet, with the operator entering sudo locally.
pointers:
- ~/ia-sync/AGENTS.md
- ~/ia-sync/SYNC_DISCIPLINE.md
- ~/ia-sync/journal.host-cleanup.md
- ~/ia-sync/.dev/session/zram-guard-office/pad.1-zram-office.md
- ~/reposoma/_cold-start/issues/ISS.office-no-swap-memory-stall.2026-10-01.md
- ~/ia-sync/pulse.md
session_id: 01a1ccad-dcf6-7080-8a99-c851981d21eb
rollout: ~/.codex/sessions/2026/11/11/rollout-2026-11-11T23-15-08-01a1ccad-dcf6-7080-8a99-c851981d21eb.jsonl
cli_version: codex-cli 0.167.0
session_cli_version: 0.167.1
session_model: gpt-6.1-sol
effort: high
host: office (hruzam-120922)
upstream: origin/main
worktree_tracked: dirty; many unrelated edits and deleted session links pre-existed this task; preserve them
worktree_ignored: 160 ignored entries reported by bonded capture; filenames only, contents not inspected
authority_may_write: Requested reboot handoff card; continue bounded zram assistance with the operator under ia-sync rules.
authority_gated: No autonomous reboot, sudo password handling, unrelated service shutdown, commit, push, or broad deploy.
runtime_boundary: 'At handoff: full filesystem access, approval policy never; this does not confer root privileges. Recheck next session.'
---

## Read first

1. Follow the ia-sync orientation and sync discipline pointers; preserve its dirty tree.
2. Read the office zram sheet for the implementation and the existing issue for prior stalls.
3. Read the newest journal entry for completed resource cleanup. This task has no STATUS or
   RUNBOOK: the zram directory contains only the setup sheet. The shell happened to be in
   ~/ia-sync/.dev/session/guide-model-01-law; that is not the owner of this maintenance task.

## Observed state

- Observed before reboot, 2026-11-11: office fingerprint /usr/bin/php74 exists; about
  15.4 GiB physical RAM; no swap or zram; zram-generator not installed.
- Still running 7.1.3-1-MANJARO since 2026-09-22 01:48:36. Its module directory is
  missing and `modinfo zram` fails. Installed linux71 is 7.1.13-2; its module directory,
  kernel image and initramfs exist. Also installed module trees: 6.12.108 and 6.18.49.
  Inferred: reboot into an installed kernel should remove the module-loading blocker;
  verify rather than assume. No reboot was performed by this session.
- `sudo -n true` reports a password is required. Operator must enter sudo in a real
  terminal; never request the password in chat. Local package metadata offers
  zram-generator 1.2.1-1; refresh assumptions against the installed version at execution.
- Existing proposal: logical zram size ram / 2 (about 7.7 GiB), zstd, priority 100,
  systemd managed at boot. This is logical swap capacity, not immediately reserved RAM.
  Compression uses CPU and cannot guarantee against memory exhaustion. No zram config,
  packages, sysctls or swap devices were changed.
- zswap parameter is currently Y, but with no swap backing it provides no swap capacity.
  Revalidate whether to disable zswap for a zram-only setup; do not blindly copy old tuning.
- Completed: operator explicitly requested all tmux sessions closed. Stopped default,
  ovitmugen, and isolated pc-trial-j6j1id09 servers; do not reconstruct those sessions.
- Completed: `balooctl6 disable` plus `systemctl --user stop kde-baloo.service`.
  Verified Indexing-Enabled=false and service inactive; existing index preserved.
  Before: idle, 369452 indexed files, 1.28 GiB index, about 325 MiB private process RAM.
  Use `balooctl6 enable`, wait for Idle/no pending content, then disable for manual refresh.
  A temporary before-copy of the Baloo config was made; it may disappear on reboot.
  Reversal is available through the native enable command.
- Available RAM rose from about 7.4 GiB initially to about 9.9 GiB after cleanup;
  values fluctuate. CPU profile remains power-saver; balanced was suggested only.
  MariaDB/PHP, Docker, Ollama and network services were left running.
- Session authored the 2026-11-11 resource-cleanup entry in the already-dirty journal.
  Other existing edits are not this session's work. No staging or commits performed.
- Registry curvature: temple-project-map resolves reposoma to ~/reposoma, but its
  generated project map lacks ia-sync. The card retains the established ia-sync project
  name and directly verified root; do not repair the registry as part of zram work.

## Repair queue

1. Verify post-reboot host, kernel/module match, zram support, memory and any existing swap.
   If already configured by another seat, inspect before changing anything.
2. Revalidate the existing sheet against the new kernel and current generator docs;
   use it to assist the operator with privileged install/configuration/activation.
   Avoid a broad system upgrade or deploy for this bounded setup. Swappiness tuning is
   optional and should be chosen explicitly after considering zswap and actual behavior.
3. Verify the live device, compression, swap priority and boot configuration; journal the
   actual outcome. A later reboot is needed to prove automatic activation, not just configuration.
   The old sheet's UNDO is historical guidance: swapoff can be disruptive under pressure,
   so check memory headroom before rollback.

## First tool shot

```sh
hostname -s
ls /usr/bin/php74
uname -r
uptime -s
ls -ld "/usr/lib/modules/$(uname -r)"
modinfo -F filename zram
free -h
swapon --show
zramctl
pacman -Q zram-generator
```

Before reboot, missing module directory/module/package is expected. After reboot, the
running kernel must have its matching module directory and a loadable zram module before
activation proceeds. These commands are read-only.

## Gates

The user asked for this post-reboot continuation card. Reboot timing belongs to the operator;
installation requires local sudo. Keep changes scoped to zram and its evidence, preserve
unrelated work, and use native system tools rather than creating a new management layer.
The card is saved locally and survives reboot; cross-machine visibility requires a separately
authorized commit and push in reposoma. No active goal tool or plan was used in this session.

## Done when

`swapon --show` and `zramctl` show the intended active zram swap with zstd, approximately
half RAM logical capacity and priority 100; systemd setup succeeds; actual configuration
and verification are recorded in the journal. Report boot activation as unverified until
observed after a subsequent reboot. Archive this CS card when consumed; handle the existing
issue card under its own lifecycle, never silently move another seat's card.

## prompt-0

###### prompt

```text
Cartan, continue my office zram setup after reboot. Read this card and the existing
~/ia-sync/.dev/session/zram-guard-office/pad.1-zram-office.md. First verify the host,
running kernel/module match and current swap state. Help me complete the bounded setup;
I will enter sudo locally. Preserve the dirty repo and the completed Baloo preference.
```
