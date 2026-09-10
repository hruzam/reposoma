---
to: @Houston (piql architect)
from: @Trajectory (office · ia-sync · 2026-09-10)
topic: device→PC ssh key rotated (both PCs) + Termux wrapper v0 live on Redmi
host: office
---

## What changed on the substrate

- Redmi device→PC ed25519 key ROTATED (old passphrase lost — recovery, operator-gaveled):
  new key material in the existing caged entries (forced `tmux new-session -A -s agentive`,
  from-pinned, no forwarding) on BOTH office and home `authorized_keys`. Restrictions
  byte-identical; backups `~/.ssh/authorized_keys.pre-rotation-2026-09-10` on both PCs.
- New passphrase set by operator on-device; `bin/bed` wrapper starts ssh-agent
  once-per-boot on the phone.
- Termux wrapper v0 deployed to Redmi (push flow, :8022): ~/bin/bed host picker
  (office/home slots from ia-sync/machines.json), extra-keys rows, Termux:Widget scripts,
  JetBrainsMono Nerd Font. `agentive` beds on BOTH PCs seeded to 4 windows +
  `window-size largest`.
- adb authorized from HOME host to the Redmi (USB debugging, one-time operator grant);
  Xiaomi input-injection toggle deliberately NOT enabled.
- No sshd/nginx/php/tailscale service config changed. No new listeners. Tailnet ACLs
  untouched.

## Relevant to piql

- The `agentive` tmux rail on office now carries live phone-driven Codex/Claude sessions
  routinely — if piql instruments office terminal sessions, expect a persistent tmux
  server with 5 windows and phone-geometry clients attaching/detaching often.
- Cross-vendor counter-signs are running over the tunnel shim (`tunnel-codex`) with a
  shared state at ia-sync/.dev/session/tunnel.state.json (git-excluded). Known shim
  limit: research-grade turns exceed its wait-window (v1 candidate).

## Open / deferred

- Old key material (`id_ed25519*.old` on phone) + the two pre-rotation backups: deleted
  after operator confirms stability.
- Termux:Widget app not yet installed (typed `bed <host>` is the path meanwhile).
- Home-side wrapper carry + 02-rc-anyhost / 03-home-relay siblings: promotion-gated.
- journal.host-cleanup.md entry deferred (file dirty under another session's ownership);
  operator sequences the commit.
