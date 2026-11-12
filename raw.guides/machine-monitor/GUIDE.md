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

Monitor is a third computer in the verified home/office/monitor SSH mesh. The six
requested repositories—nablarva, nabla-lab, vacuole, applications-in-common,
pajdulium-web and pajdulium-studio—were cloned and verified clean on `core` at
the physical paths in `~/ia-sync/zsh/registries/projects.json` (session
`~/ia-sync/.dev/session/monitor-01-integration/raw/clone-verification.2026-11-12.json`).
This restores tracked Git history, not ignored state or project runtime readiness.
PHP installation and project runtime startup remain deferred to majkee. No local
PHP, database, web server or Docker stack was started for this integration.

## Verified local inventory

Observed 2026-11-12 unless identified as operator intent:

| Item | Observation |
|---|---|
| OS | Manjaro Linux, x86_64; kernel 6.18.55-1-MANJARO |
| CPU | Intel Core i3-5005U, 2 cores / 4 threads |
| RAM | MemTotal 12,151,568 KiB, approximately 11.6 GiB |
| Storage | sda 223.6 GiB; sda1 EFI; sda2 Btrfs root/home; about 209 GiB available at inventory |
| Swap | None observed; memory-pressure protection remains to be assessed |
| Present | OpenSSH client, Git, rsync, zsh, Python 3, curl, tmux |
| Missing from command lookup | zellij, PHP, Composer, Docker, Node.js, npm |
| Access tools | Tailscale 1.102.5 and jq 1.8.2 installed by operator; tailscaled running, enrolled |
| SSH identity | Local ed25519 keypair exists; private material stays local |
| Git access | Authenticated pulls verified for ia-sync/main and reposoma/core after public-key registration and selecting the existing unlocked local SSH agent. |
| Git author configuration | Configured locally in ia-sync and reposoma using the public address explicitly supplied by majkee on 2026-11-12; email accounts were not accessed. |
| Initial shell | Manjaro defaults; empty ~/.config/zsh; no MACHINE_NAME |

RAM and missing PHP resemble home. They are **not identity evidence for home**.
Use the registered hostname and, once enrolled, the actual Tailscale node ID.
The initial Git authentication failure was resolved after public-key registration
and selection of the existing unlocked local SSH agent. New agent sessions must
inherit a working SSH_AUTH_SOCK; do not hardcode its ephemeral path in portable files.

## Shell source and installation

Portable source is owned by monitor in `~/ia-sync/zsh/config.monitor.zsh` and
`~/ia-sync/zsh/zshrc.monitor`. Live destinations are `~/.config/zsh/config.zsh`
and `~/.zshrc`. The bootstrap preserves the existing Manjaro prompt, declares
`MACHINE_NAME=monitor`, and adds user executable directories without PATH duplicates.
It intentionally loads no home/office PHP or project scopes.

Monitor now loads the shared signposts: `ai/base.zsh` (including Jev/tools),
`experimental/base.zsh`, `session/base.zsh`, `archx/base.zsh` and
`system/base.zsh` (including remote-cli). `RB_ROOT` points to ia-sync's session
shelf. Project-specific scopes, PHP engines and `TAILSCALE_PEER` remain unset.
Bare `tso` offers home or office from `machines.json`; explicit logical names and
raw host/address targets work, including leading `-t` for the remote tmux bed.
Cancel, EOF, invalid selection or a target-free call without a terminal makes no
connection. Both SSH modes use an eight-second connection timeout and one attempt;
an established interactive session has no overall timeout. The shared keyboard's
unavailable PHP aliases are removed on monitor. Home/office defaults passed isolated
tests; deployment of the new shell source on those peers is not certified.

From a fresh terminal:

```sh
zsh-deploy-check     # preview shell-only deployment; inspect every listed change
ai-help
exp-list            # list available experimental bricks; does not execute them
rb-board
archx-help
sysmon
ts-help
remote-help
```

The aliases live in `zsh/system/keyboard.zsh`; the engine is
`~/ia-sync/deploy.sh --zsh-only`. Before these aliases are installed, preview with:

```sh
bash ~/ia-sync/deploy.sh --zsh-only --dry-run
```

Review the dry-run list and back up changed shared bricks before any write.
`zsh-deploy` / `bash ~/ia-sync/deploy.sh --zsh-only` copies the whole zsh tree;
its rsync leg does **not** make per-file backups of every shared brick. Use an
exact-file copy when only selected files are approved. A routine shell-only deploy
can overwrite the nested, inert `~/.config/zsh/.config/tailnet.access-controls.json`
copy; it does not apply Tailscale control-plane policy. Plain `bash ~/ia-sync/deploy.sh`
is broader still, including agent/runtime surfaces; it remains excluded while
unrelated live settings drift is unresolved. Deployment host resolution and project-map
generation work with jq or Python 3. The `tso` peer resolver uses Python 3. The accepted seven-file and later one-file
deployments, with backup/rollback receipts, are in the session's cycle 09 and 12
RETURNs and VERDICTs.

Builder contract: `~/ia-sync/zsh/guides/guide-for-builder.md`, Architecture rules.
The initial .zshrc backup is `~/.zshrc.bak-monitor-20261112-043027`; the pre-brick
shell tree is `~/.config/zsh.backup-monitor-bricks-20261112-043831`.

Command loading does not prove external dependencies or project runtimes are ready.
The shared startup prints the existing Gemini-parked and substrates-loaded notices.
No model/API request, experiment execution, peer connection or package install is
part of loading these bricks. GitHub SSH access is verified with the existing unlocked local SSH agent.

## Tailnet and SSH readiness

Tailnet identity (node ID, IP) lives only in `~/ia-sync/machines.json`; peer host and
client keys live only in `~/ia-sync/ssh/peers/`. Monitor sshd is public-key-only
(source `~/ia-sync/ssh/sshd.monitor.conf`).

Follow [the access track](res/access.md) for current direction-by-direction evidence,
policy changes, key-only monitor service preparation, public-key exchange and tests.
Use ordinary OpenSSH over Tailscale, continuing the existing home/office model.

## Project runtime remains a decision

Before running a cloned project, verify its host pin, runtime, ignored local state
and web binding. Choose browser access, an SSH tunnel or remote execution according
to that project. Local development hostnames and loopback-bound web servers do not
become remotely reachable merely by joining the tailnet. Do not start services,
publish ports, or copy project secrets as part of host registration.

Zellij, Docker, Node and PHP remain workload choices, not bootstrap requirements.
The existing office presence records are historical/shared declarations; their
remote paths do not certify local projects or active sessions on monitor.

Current integration position: `~/ia-sync/.dev/session/monitor-01-integration/STATUS.md`.

## Manifest

- `res/access.md` · chapter · monitor ↔ home/office setup track, evidence and directional acceptance
