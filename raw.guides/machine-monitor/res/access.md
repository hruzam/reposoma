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
- Monitor sshd is key-only and active, and authorizes both home and office client
  keys. Monitor’s SSH client trusts both peers' published host keys after matching
  live tailnet scans.
  Office's existing RSA client key needs no algorithm downgrade on monitor.
- Both monitor-origin SSH checks pass strict host verification and explicit
  monitor-key authentication. Four fresh checks were then **executed on their home
  or office origins** using default trust files, `BatchMode=yes` and strict host
  checking; monitor orchestrated and observed them over strict SSH. All six directed
  ordinary-SSH paths have exit-0 evidence. See
  `~/ia-sync/.dev/session/monitor-01-integration/raw/strict-peer-rechecks.2026-11-12.json`.

| Required direction | Execution and observation | SSH-path proof |
|---|---|---|
| monitor → home | Executed and observed on monitor; strict host check, explicit monitor key | exit 0 |
| home → monitor | Executed on home; monitor orchestrated/observed; default trust, strict BatchMode | exit 0 |
| monitor → office | Executed and observed on monitor; strict host check, explicit monitor key | exit 0 |
| office → monitor | Executed on office; monitor orchestrated/observed; default trust, strict BatchMode | exit 0 |
| home → office | Executed on home; monitor orchestrated/observed; default trust, strict BatchMode | exit 0 |
| office → home | Executed on office; monitor orchestrated/observed; default trust, strict BatchMode | exit 0 |

These receipts establish ordinary SSH login on each directed path at the test time;
they do not prove a project runtime or the whole access-policy scope.

## 1. Network identity and policy

`~/ia-sync/machines.json` records host identity. Query actual state with:

```sh
tailscale status
tailscale ping hruzam
tailscale ping hruzam-120922
```

## Saved network scope and device follow-up

Majkee requested an all-port mesh among the three computers, with devices accessing
them on request. He confirmed a control-plane save and supplied a host-local export.
The comparison in `~/ia-sync/.dev/session/monitor-01-integration/raw/policy-comparison.2026-11-12.json`
found the computer mesh grant, host aliases and separate Tailscale SSH section equal
to the intended candidate. This is a comparison of Majkee's supplied saved export,
not a direct API retrieval of current control-plane state.

The saved export also contains **standing TCP 22 access from tab and redmi to all
three computers**. That differs from the on-request device intent. Majkee deferred
the retain/narrow/remove choice to the existing
[`device-ssh-safety-audit.md`](/home/hruzam/ia-sync/.dev/_backlog/device-ssh-safety-audit.md);
no policy change was made for this finding. Network permission alone does not
authenticate an SSH user.

Keep three objects distinct: the repository candidate at
`~/ia-sync/zsh/.config/tailnet.access-controls.json`, the deployed nested copy at
`~/.config/zsh/.config/tailnet.access-controls.json`, and Majkee's saved control-plane
policy. The nested copy is inert and can be overwritten by a routine zsh deploy;
neither a shell deploy nor a Git commit applies control-plane policy. No refresh of
that inert copy is required for the verified shell commands. The export/proposal
contents stay host-local; use the comparison receipt above and the backlog item as
review entrances rather than reproducing policy text here.

## 2. Verify monitor's destination service

Source: `~/ia-sync/ssh/sshd.monitor.conf`.
Operator procedure: `~/ia-sync/install-pkgs/monitor-ssh.md`.
The installed drop-in permits public-key login as hruzam, rejects passwords and
root login, and uses OpenSSH's existing listen addresses. It does not install
client keys or change the firewall. Administrative commands require the operator's
terminal.

After a service/configuration change, recheck effective settings rather than only
the file contents:

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

## 3. Maintain public authorization, preserving local keys

Procedure (publish, accept a peer, receipt) lives only in `~/ia-sync/ssh/peers/README.md`.
All three computers have exchanged the current public peer keys; use that procedure
when a peer or key changes.
Private keys, authorized_keys and SSH-agent sockets never enter either Git repository.
The older PCs are key-only, so do not enable password login to bypass a missing
authorization.

## 4. Use the existing shell and verify all directions

No new peer engine is needed. `system/base.zsh` loads `tso` on monitor.
`TAILSCALE_PEER` remains unset there, but bare interactive `tso` offers home/office
from `machines.json`; `tso home` and `tso office` resolve logical labels through that
map. Explicit raw host/address targets still work, including noninteractively.
Other helpers such as `tsp` retain their own explicit-target behavior.

From monitor:

```sh
tso                         # choose home or office
tso home                    # logical name; also accepts office
tso -t office               # land in remote agentive tmux bed
tsp hruzam.tail36b8ab.ts.net
tsp hruzam-120922.tail36b8ab.ts.net
```

From home and office, ordinary explicit SSH remains available:

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
The six directions above have separate origin-side receipts; repeat a direction
after trust or access changes. An outbound login does not prove the reverse.
Network permission does not authorize a public key or start an application service.

On monitor, bare `tso` cancellation, EOF, invalid choice or a target-free call without a terminal
stops before ping/SSH. After its bounded ping, `tso` uses OpenSSH with
`ConnectTimeout=8` and `ConnectionAttempts=1` for plain and `-t` bed modes; a failed
ping may still proceed to SSH. These options bound connection establishment, not
an established interactive session. The shared files are deployed and verified on
all three hosts. Fresh-shell checks on home and office preserve their original
default peers and verify explicit monitor/bed routing with network calls mocked.
Real SSH-login evidence is recorded separately in the directional table above.
See cycle 09/12 (monitor), 14 (home) and 15 (office) RETURNs/VERDICTs under
`~/ia-sync/.dev/session/monitor-01-integration/_bus/` for deployment, backup,
verification and preserved local-work receipts.

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
- `~/ia-sync/zsh/system/tailscale.zsh`: monitor chooser, logical-target resolution
  and bounded ordinary SSH connection setup.
- `~/ia-sync/install-pkgs/harden-host.md`: original key-only SSH procedure, also
  containing database/firewall changes that must not be blindly applied to monitor.
- [Tailscale access grants](https://tailscale.com/docs/features/access-control/grants)
  and [Tailscale SSH](https://tailscale.com/docs/features/tailscale-ssh).
