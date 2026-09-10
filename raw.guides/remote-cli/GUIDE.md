---
title: remote-cli — terminal-reach of living agent sessions (beds · doors · devices)
scope: remote-cli
audience: operator + any seat
machine: both
verified: 2026-09-10
half_life_days: 60
verify_cmd: "tmux has-session -t agentive && grep -c -- '--bed' ~/.config/zsh/system/tailscale.zsh"
---

# remote-cli — reach any living claude/codex session from any device

`what: ONE mechanism — the BED. Each host runs a tmux session named `agentive`; agent`
`sessions live in its windows (seats); every phone/PC window is a disposable VIEWPORT.`
`The bed is immortal, viewports are confetti — a dropped connection is a reflex, never`
`an incident. Born: ia-sync session codex-remote-control-cli-01-wrapper (gate PASSED`
`2026-09-10). Why it exists: Codex has NO vendor app-door — this is its prosthesis;`
`Claude's app-door is separate (→ /guide remote-control).`

## The map — origin → command → landing

| you are | you type | you land |
|---|---|---|
| 📱 Redmi (Termux) | `bed office` · `bed home` | that host's bed, last-active seat |
| 💻 any PC | `tso -t office` · `tso -t home` (any tailnet name) | that host's bed, **plain-shell seat** (the door) |
| 💻 any PC | `tso office` (no flag) | plain ssh login shell — no bed |
| 🖥 sitting at the host | `sh ~/ia-sync/devices/_shared/termux/bin/agentive-door` | own bed, plain-shell seat |
| 📱 phone, Claude only | Claude mobile app | app-door → /guide remote-control |

Inside any bed: run `claude` or `codex` on the spot, or hop seats — the session you
start OUTLIVES your connection.

## For idiot — exact commands, zero thinking

### 📱 mobile → office (the pocket door)
```
# in Termux:
bed office            # passphrase asked ONCE per phone boot, then never
# you're in. run what you need:
codex                 #   …or ~/.local/bin/claude
# leave (session keeps running):  tap DETACH   (= Ctrl+b d)
# come back later:                bed office   → same session, nothing died
```
Buttons above the keyboard: `S1–S4` hop seats · `PASTE` drops the Android clipboard
(the PTYRA voice loop) · `DETACH` leaves clean.

### 📱 mobile → home
```
bed home              # identical; first-ever contact asks host-key yes once
```

### 💻 pc → pc (home ⇄ office, and any future host)
```
tso -t office         # bed door on office — lands on an empty shell seat
tso -t home           # bed door on home
tso office            # WITHOUT -t: plain ssh, no bed (old behavior, unchanged)
```
Then just: `claude` or `codex` right there, or `Ctrl+b 1..4` to a running seat,
`Ctrl+b l` = jump to last-used seat, `Ctrl+b d` = leave, everything keeps running.

### 🖥 sitting at the machine itself
```
sh ~/ia-sync/devices/_shared/termux/bin/agentive-door    # bed, shell seat
tmux attach -t agentive                                  # bed, last-active seat
```

### ✅ the whole idea in one line
Start `claude`/`codex` **inside a bed** → kill the window / lock the phone / drop the
VPN → nothing dies → reattach from ANY device, the session is exactly where you left it.

## When it misbehaves (trouble ladder, top = most likely)

1. **`Connection timed out`** → phone/PC Tailscale is off. Phone: VPN icon must show;
   Tailscale app → Connect. HyperOS kills it in background → Battery saver **No
   restrictions** for Tailscale AND Termux, pin Termux in Recents.
2. **`Software caused connection abort`** → Android froze the old socket. Just retry —
   `bed` auto-retries connection failures 5× itself.
3. **Bricks/boxes instead of glyphs, flat colors** → the bed was born without UTF-8.
   Fix: `sh ~/ia-sync/devices/_shared/termux/bin/agentive-seed` on that host (empty bed
   may be killed first) — seed + door force `LANG=en_US.UTF-8`. Phone font is separate:
   `~/.termux/font.ttf` (JetBrainsMono NF, pushed 2026-09-10).
4. **Passphrase asked on every connect** → ssh-agent not held; run `bed <host>` (its
   bootstrap starts the agent, once per boot), don't hand-roll `ssh`.
5. **Landed inside a running TUI, feel stuck** → you're IN a session, `exit` goes to the
   agent, not the shell. `Ctrl+b d` detaches; phone: swipe from LEFT edge → NEW SESSION
   gives a local shell any time.
6. **Codex never asks approvals** → it's in automatic review; `/approvals` → asking
   mode. Law: approvals stay ON.
7. **Claude app door** → ONE cloud seat, last claimer wins; `/remote-control` inside a
   living session rebinds it. Never `--continue` for remote. → /guide remote-control.

## Add a host / add a device

- **New PC (e.g. the arch-mac):** joins the tailnet → `tso -t <its-name>` already works
  (any resolvable name). Registry row in `~/ia-sync/machines.json` + a case in
  `~/ia-sync/devices/_shared/termux/bin/bed` for the phone. Seed its bed once
  (`agentive-seed`). Zero new mechanism.
- **New device (phone/tablet):** bootstrap by PUSH flow only (devices never pull) →
  `~/ia-sync/devices/_shared/termux-bootstrap.md`; caged key in each PC's
  `authorized_keys` is the OPERATOR's paste (JIT law; classifier blocks agents there,
  correctly).

## Sources of truth (point, never copy)

- Wrapper + device usage: `~/ia-sync/devices/_shared/termux/README.md`
- Rail law (forced commands, read-only tablet): `~/ia-sync/devices/_shared/agentive-tmux.md`
- Provisioning law: `~/ia-sync/devices/_shared/termux-bootstrap.md`
- PC engine: `~/ia-sync/zsh/system/tailscale.zsh` (`_ts_session`, flag `-t|--bed`)
- Claude app-door: `/guide remote-control` · cross-host RC spawn: skill `/rc-launch`
- Codex cross-vendor table: `/guide tunnel` · ssh/db substrate: `raw.guides/reach/`
- Host registry: `~/ia-sync/machines.json` (add a machine = add a row; never key on IP)
