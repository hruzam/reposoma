---
title: Monitor ↔ home and office — access track and directional verification
chapter-of: machine-monitor
---

# Access track

Use **ordinary OpenSSH over Tailscale**, continuing the existing home/office model.
Enrollment supplies network identity. Tailnet grants permit traffic. The destination's
sshd, authorized public keys and verified host key establish the login. Each layer
must pass; registering a key with GitHub does not authorize a login to a PC.

## Current checkpoint — 2026-11-12

Identities (node IDs, IPs, DNS) live only in `~/ia-sync/machines.json`; host and client
key fingerprints live only in `~/ia-sync/ssh/peers/`. This chapter records **directional
state only** — do not copy identities or fingerprints here.

- All three computers have published their peer keys in `~/ia-sync/ssh/peers/`.
- Monitor sshd is key-only and active; it trusts home's host key and authorizes home's
  client key.
- Office has verified monitor's and home's committed host fingerprints against live
  tailnet scans; it has not yet accepted monitor's keys (awaiting majkee go-ahead).

| Required direction | Last evidence | Remaining proof |
|---|---|---|
| monitor → home | Strict host trust passes; publickey authentication denied | home accepts monitor key; login receipt |
| home → monitor | Monitor listener verified; home client key accepted on monitor | home trusts monitor host key; login receipt from home |
| monitor → office | Office keys published; office has not accepted monitor's client key | office accepts monitor key; login receipt |
| office → monitor | Both sides published; monitor has not accepted office's client key | monitor accepts office key; login receipt |
| home → office | **Verified** — office sshd log, latest 2026-11-06; routine use via `tso` | none |
| office → home | **Verified** — receipt from office 2026-11-12 (`BatchMode`, strict host key → `hruzam`/`hruzam`); majkee confirms routine use | none |

Each direction requires its own origin-side login receipt. A successful ping or
accepted public key does not establish all six paths or the complete live policy.

## 1. Network identity and policy

`~/ia-sync/machines.json` records host identity. Query actual state with:

```sh
tailscale status
tailscale ping hruzam
tailscale ping hruzam-120922
```

## Requested network scope — three computers, all ports

Majkee clarified on 2026-11-12: **computer-based all ↔ all; devices need access
on request**. The candidate in
`~/ia-sync/zsh/.config/tailnet.access-controls.json` now reflects that scope.
It is not an automatically deployed or verified live policy.

Merge that candidate file into the CURRENT admin policy (the file is the only copy of
the hosts entry and the computer-to-computer grant; do not retype them here).

This permits all protocols and ports among the three computers in all six directed
paths. Phones/tablets have no standing grant. Their host aliases may remain as an
address book; aliases alone grant nothing. Device access must be requested and
scoped explicitly later. This also removes the old computers' wildcard access to
non-computer destinations. Other live ACLs/grants must be checked because allows
are additive; an existing broad allow could still permit device access.

Keep unrelated policy sections and the separate `ssh` section unchanged. That
section controls the Tailscale SSH product; the computers use ordinary OpenSSH.
The operator has been asked to merge this candidate in Admin → Access controls.
Live save/validation is pending; a repository commit or shell deploy does not apply it.

## 2. Prepare monitor's destination service

Source: `~/ia-sync/ssh/sshd.monitor.conf`.
Operator procedure: `~/ia-sync/install-pkgs/monitor-ssh.md`.
The drop-in permits public-key login as hruzam, rejects passwords and root login,
and uses OpenSSH's existing listen addresses. It does not install client keys or
change the firewall. Administrative commands require the operator's terminal.

Afterward, verify effective settings, not merely the file contents:

```sh
sudo sshd -t
sudo sshd -T | rg '^(pubkeyauthentication|passwordauthentication|kbdinteractiveauthentication|permitrootlogin|allowusers) '
systemctl is-active sshd
ss -lnt | rg ':22\b'
ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
```

Keep the public host-key fingerprint for trusted first-contact comparison on home
and office. A fingerprint collected only by unauthenticated ssh-keyscan is not
independent evidence of the server's identity.

## 3. Exchange public authorization, preserving local keys

Procedure (publish, accept a peer, receipt) lives only in `~/ia-sync/ssh/peers/README.md`.
Private keys, authorized_keys and SSH-agent sockets never enter either Git repository.
The older PCs are key-only, so do not enable password login to bypass a missing
authorization.

## 4. Use the existing shell and verify all directions

No new peer engine is needed. `system/base.zsh` already loads the commands;
`TAILSCALE_PEER` remains unset on monitor so the operator selects the peer explicitly.
Logical labels in machines.json are not automatically SSH aliases.

From monitor:

```sh
tsp hruzam.tail36b8ab.ts.net
tsp hruzam-120922.tail36b8ab.ts.net
```

From home and office after their trust/authorization is ready:

```sh
ssh hruzam@hruzam-mntr.tail36b8ab.ts.net
```

For each origin, verify the destination's host-key fingerprint through the trusted
channel before accepting it. Then record a fresh noninteractive receipt:

```sh
ssh -o BatchMode=yes -o StrictHostKeyChecking=yes -o ConnectTimeout=8 \
  hruzam@DESTINATION 'hostname -s; id -un'
```

Expected hostnames: `hruzam-mntr` / `hruzam` / `hruzam-120922`; expected user: hruzam.
Record all six directions independently, including home ↔ office. An outbound
login does not prove the reverse. Network permission does not authorize a public
key or start an application service.

`tso -t <peer>` additionally needs tmux and `agentive-door` on the destination;
monitor does not need local tmux merely to attach to a remote session. Browser,
SSHFS, remote Claude dispatch and PHP project execution remain separate choices.
In particular, the two-host SSHFS rescue path needs review before multi-peer use.

## Why this route

Three bounded Terra readers traced shell code, guide history and local readiness.
Houston's consult returned `stretches`: proceed with observed identities, live-policy
verification, ordinary OpenSSH continuity, host-owned changes and four directional
receipts. The consultation did not authorize broader network or PHP changes.

Evidence entrances:

- `~/ia-sync/journal.host-cleanup.md`, 2026-08-31 SSHFS investigation: plain sshd/keys
  were already working; Tailscale SSH was an unnecessary model change.
- `~/ia-sync/devices/galaxy-tab-a-2016/log.md`, 2026-08-21: Tailscale SSH disabled on
  both original PCs; historical hardening, not current live proof.
- `~/ia-sync/devices/_shared/termux-bootstrap.md`: historical home/office public
  host-key fingerprints and why new devices cannot password-pull keys.
- `~/ia-sync/zsh/system/tailscale.zsh`: explicit peer passes to ordinary ssh.
- `~/ia-sync/install-pkgs/harden-host.md`: original key-only SSH procedure, also
  containing database/firewall changes that must not be blindly applied to monitor.
- [Tailscale access grants](https://tailscale.com/docs/features/access-control/grants)
  and [Tailscale SSH](https://tailscale.com/docs/features/tailscale-ssh).
