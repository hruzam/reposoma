---
title: Monitor host — bootstrap, inventory and remote access readiness
scope: machine-monitor
audience: operator + agent
machine: monitor
verified: 2026-11-12
half_life_days: 30
recheck:
  - https://tailscale.com/docs/install/linux
  - https://tailscale.com/docs/features/tailscale-ssh
verify_cmd: "hostname -s; free -h; command -v tailscale jq ssh php; zsh -ic 'print -r -- $MACHINE_NAME'"
---

# Monitor

Use this guide when entering or preparing `hruzam-mntr`, the new third machine.
`mntr` means **monitor**; logical identity is `monitor`. Majkee confirmed this on
2026-11-12. It is independent of both home and office.

Start with:

```sh
hostname -s                       # hruzam-mntr
zsh -ic 'print -r -- $MACHINE_NAME' # monitor after shell bootstrap
cat ~/ia-sync/machines.json
```

Read `~/ia-sync/AGENTS.md` and the newest `journal.host-cleanup.md` entry before
maintenance. Source and deploy discipline: `~/ia-sync/SYNC_DISCIPLINE.md`.

## Current role and boundaries

The host is being prepared as a possible monitoring/access device. Running PHP
projects remotely on home or office is under consideration; majkee will decide
later. PHP installation is explicitly deferred to majkee. No local PHP, database,
web server, Docker stack, project path mapping or remote service execution is
established by this bootstrap. A browser or SSH client can access a remote PHP
application without a local PHP runtime, once networking and authorization work.

## Verified local inventory

Observed 2026-11-12 unless identified as operator intent:

| Item | Observation |
|---|---|
| OS | Manjaro Linux, x86_64; kernel 6.18.55-1-MANJARO |
| CPU | Intel Core i3-5005U, 2 cores / 4 threads |
| RAM | MemTotal 12,151,568 KiB, approximately 11.6 GiB |
| Storage | sda 223.6 GiB; sda1 EFI; sda2 Btrfs root/home; about 209 GiB available at inventory |
| Swap | None observed; memory-pressure protection remains to be assessed |
| Present | OpenSSH client, Git, rsync, zsh, Python 3, curl |
| Missing from command lookup | Tailscale, jq, tmux, zellij, PHP, Composer, Docker, Node.js, npm |
| SSH identity | Local ed25519 keypair exists; private material stays local |
| Git access | Agent-session `git pull --rebase origin main` failed: publickey authentication; ssh-askpass executable unavailable |
| Git author configuration | Configured locally in ia-sync and reposoma using the public address explicitly supplied by majkee on 2026-11-12; email accounts were not accessed. |
| Initial shell | Manjaro defaults; empty ~/.config/zsh; no MACHINE_NAME |

RAM and missing PHP resemble home. They are **not identity evidence for home**.
Use the registered hostname and, once enrolled, the actual Tailscale node ID.
Git authentication failure does not establish whether the key is unregistered,
locked, or unavailable to this session; resolve that before claiming sync works.

## Shell source and installation

Portable source is owned by monitor in `~/ia-sync/zsh/config.monitor.zsh` and
`~/ia-sync/zsh/zshrc.monitor`. Live destinations are `~/.config/zsh/config.zsh`
and `~/.zshrc`. The bootstrap preserves the existing Manjaro prompt, declares
`MACHINE_NAME=monitor`, and adds user executable directories without PATH duplicates.
It intentionally loads no home/office PHP or project scopes.

`~/ia-sync/deploy.sh` resolves `machines.json` using jq or Python 3. A full deploy
also changes agent/runtime surfaces; inspect its dry run before choosing that scope.
The initial installation copied only these two shell files; the original .zshrc
backup is `~/.zshrc.bak-monitor-20261112-043027`. A fresh interactive PTY shell
reported `monitor` without startup errors; installed bytes match source. The
no-jq resolver passed checks for all three hosts, an unknown host and an override.
The bootstrap is recorded in local commits. No push occurred: GitHub SSH
authentication remains unresolved. The operator-provided Git author configuration
does not authorize or establish access to an email account.

## Tailnet and SSH readiness

Monitor is not enrolled. Its `tailscale_id` and `tailscale_ip` in `machines.json`
are null deliberately. Do not invent an IP, reuse a peer's node ID, or assume the
new host has a MagicDNS name before enrollment.

Known peer records, **repository evidence, not live reachability verification**:

| Peer | Tailnet DNS | IPv4 | SSH user |
|---|---|---|---|
| office | hruzam-120922.tail36b8ab.ts.net | 100.126.182.111 | hruzam |
| home | hruzam.tail36b8ab.ts.net | 100.110.27.60 | hruzam |

Identity source: `~/ia-sync/machines.json`; existing remote dispatch records:
`~/ia-sync/zsh/registries/hosts.json`. Monitor is not a remote dispatch target yet.
That registry needs a monitor entry only after its real tailnet DNS and inbound
access role are established.

Remaining steps, **not performed by this bootstrap**:

1. Install Tailscale and jq using the Manjaro package manager. Review the full
   system transaction; avoid a partial rolling-release upgrade. Typical command:
   `sudo pacman -Syu tailscale jq`.
2. Start the daemon: `sudo systemctl enable --now tailscaled`.
3. Enroll with `sudo tailscale up`; majkee completes the login in the intended
   existing tailnet. Account/admin access and policy permissions are not yet verified.
4. Inspect `tailscale status --json` and `tailscale ip -4`. Record actual Self.ID,
   Self.HostName, Self.DNSName and IP; update monitor's machine record from evidence.
5. Test `tailscale ping hruzam-120922` and `tailscale ping hruzam`. Confirm the
   peer identities against the recorded IDs before trusting the connection.
6. Establish SSH authorization separately. For ordinary OpenSSH, monitor's public
   key must be accepted on each destination, the SSH service reachable, and the
   host-key fingerprint verified through a trusted channel. Keep private keys local.
   Tailscale connectivity alone does not authorize an SSH login.
7. Test interactive SSH to each peer. Do not automatically disable host-key checking:
   `ssh hruzam@hruzam-120922.tail36b8ab.ts.net` and
   `ssh hruzam@hruzam.tail36b8ab.ts.net`.

Tailscale SSH is an alternative with destination-side setup and tailnet SSH policy;
ordinary SSH over the tailnet does not require enabling Tailscale SSH on monitor.
See the [Linux installation documentation](https://tailscale.com/docs/install/linux)
and [Tailscale SSH documentation](https://tailscale.com/docs/features/tailscale-ssh).
No inbound monitor service, routing advertisement or exit-node role is configured.

## Project access remains a decision

After connectivity works, select an actual project and verify its current owner
host, path, runtime and web binding there. Choose browser access, an SSH tunnel,
or remote shell execution according to that project. Local development hostnames
and loopback-bound web servers do not become remotely reachable merely by joining
the tailnet. Do not start services, publish ports, or copy project secrets as part
of host registration.

Optional later tools: tmux for persistent remote sessions; jq for existing shell
helpers. zellij, Docker, Node and PHP are workload choices, not bootstrap requirements.
The existing office presence records are historical/shared declarations; their
remote paths do not certify local projects or active sessions on monitor.
