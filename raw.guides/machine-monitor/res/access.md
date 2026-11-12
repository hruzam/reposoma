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

- Monitor is enrolled and online: node `n7msXDoqQ621CNTRL`, IPv4 `100.80.107.66`,
  DNS `hruzam-mntr.tail36b8ab.ts.net`. Home and office are now online; node IDs match
  `~/ia-sync/machines.json`.
- Home self-published its public keys in ia-sync commit `1881c9e`. Its ED25519 host
  fingerprint matches the live tailnet scan exactly, ending `WmRB0` (zero); the old
  `WmRBO` historical text was a transcription error. Monitor accepted home's host
  key and client public key, preserving a backup of its existing known_hosts.
- Monitor's key-only sshd is active/enabled. Public host fingerprint:
  `SHA256:XcMUK2B+Geq55COSYl3jwjXrOzm56QMlR2R78QkpTk8`.
  Monitor now has an authorized_keys entry for home; no private key was transferred.
- Monitor published its own host and client public keys in pushed ia-sync commit
  `73c4b53`, correcting the malformed scan-derived monitor known_hosts entry.
  Follow `~/ia-sync/ssh/peers/README.md`; accept only a committed host key that matches
  the actual tailnet peer. Publication alone installs nothing on the receiving host.
- Monitor → home passes strict host-key verification and reaches authentication,
  then returns `Permission denied (publickey)`. Home still needs to accept monitor's
  published client key. No successful monitor↔peer login is claimed yet.
- Office peer-key files have not been published at this checkpoint. Home's reported
  reposoma divergence (one local commit and ten incoming) was left untouched.

| Required direction | Last evidence | Remaining proof |
|---|---|---|
| monitor → home | Strict host trust passes; publickey authentication denied | home accepts monitor key; login receipt |
| home → monitor | Monitor listener verified; home client key accepted on monitor | home trusts monitor host key; login receipt from home |
| monitor → office | Office online; peer keys not published | published keys, trust, authorization, login receipt |
| office → monitor | Office online; monitor keys published | reciprocal peer acceptance; login receipt |
| home → office | Historical route only; both online now | current login receipt |
| office → home | Historical route only; both online now | current login receipt |

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

In the CURRENT admin policy, add monitor to the existing `hosts` object:

```json
"monitor": "100.80.107.66"
```

Replace the old computer-to-wildcard and standing Android grants with:

```json
{"src": ["office", "home", "monitor"],
 "dst": ["office", "home", "monitor"], "ip": ["*"]}
```

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

On each source machine, inspect the public key being selected by SSH and its
fingerprint (for example `ssh-keygen -lf ~/.ssh/id_ed25519.pub`). Keep private keys
on their originating host. Use an already trusted session or the operator's local
terminal to append the verified public key to the destination account's
`~/.ssh/authorized_keys`, preserving all existing entries and restrictions.
Directory mode must be 700 and authorized_keys mode 600, owned by that account.

The four authorizations are explicit:

| Destination | Authorize the public key from |
|---|---|
| home | monitor |
| office | monitor |
| monitor | home and office |

If home and office use the same public key, verify that fact; one matching entry
then suffices on monitor. Do not assume it from shared usernames or GitHub access.
Use local temporary files or the operator's clipboard for key exchange. Private
keys, authorized_keys and SSH-agent sockets never enter either Git repository.

The older PCs were hardened to key-only login, so a fresh monitor cannot necessarily
bootstrap with ssh-copy-id: it first needs an already authorized route or the
operator at the destination. Do not enable password login simply to bypass that gap.

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
