---
title: Remote Access — Claude Code native Remote Control (tmux-free engine)
scope: remote-control
audience: operator
machine: both
verified: 2026-08-20
half_life_days: 42
recheck:
  - https://code.claude.com/docs/en/remote-control
  - https://github.com/anthropics/claude-code/releases
verify_cmd: claude --version
moved-from: "~/.config/zsh/guides/remote.md (2026-08-20) — content REWRITTEN against ai/rc.sh disk truth; the 2026-08-15 card still taught tmux while the engine had gone tmux-free the same day (trust-disk-over-doc scar)"
---

# Remote Access — Claude Code

## VOLATILE — read first

- Requires claude >= v2.1.51. Check: `claude --version`
- Requires Pro, Max, or Team plan. Remote Control is not available on Free tier.
- Engine truth: `~/.config/zsh/ai/rc.sh` (table: `~/ia-sync/zsh/ai/rc.sh`). **On any
  conflict between this guide and that script, the script wins and this guide is the bug.**

---

## The model — one live session, one cloud seat

`claude remote-control` exposes a session via an **outbound HTTPS bridge** (no inbound
ports) to Anthropic's relay; the phone/browser catches it at `claude.ai/code` or in the
Claude mobile app.

**Laws of the seat (learned the hard way, 2026-08-20):**
- The RC cloud bridge is **single-seat**. `/remote-control` run inside any client
  **rebinds** that one seat — last claimer wins, the previous holder drops.
- **Never use `claude --continue` for remote access.** It does not join the live
  session — it forks a NEW process rehydrated from the transcript. The moment someone
  claims the real RC seat, the fork is an orphan ("remote here lost").
- To make a device permanently catchable, pin it with the systemd approach below.

---

## The engine — `ai/rc.sh` (redesigned 2026-08-15, tmux-free)

Two launch modes, **neither uses tmux**; both survive ssh disconnect via `setsid nohup`
and register to your Claude account. LOCAL spawn only — cross-host dispatch is the
`/rc-launch` skill's job.

**MODE A — bare server (no preset flags):** `claude remote-control --name <rc>` — a
session FACTORY: connect from phone/browser and it spawns a NEW session in the project
dir; pick the agent inside. Catch URL: `…/code?environment=…`

**MODE B — preset agent/model/effort:** `claude [--agent A] [--model M] [--effort E]
--remote-control <rc>` — a specific INTERACTIVE session exposed to RC. Gets its pty
WITHOUT tmux via `script -qfc`. Catch URL: `…/code/session_…` This is what makes
"/rc-launch launch trajectory" literally true.

### Usage

```bash
rc.sh                        # list live RC sessions + registered/launchable projects
rc.sh status                 # same
rc.sh <project>              # MODE A — bare server (pick agent inside)
rc.sh <project> --agent A [--model M] [--effort E] [--name N]   # MODE B
rc.sh <project> stop         # stop (exact-pid kill — never a broad pkill)
```

- Defaults for mode B fill from `ai.json → remote-control.launch-defaults`
  (model=opus, effort, per-project agent).
- Launch log holds the catch URL: `~/.cache/rc/<project>.log` (`tail -f` if the URL
  hasn't printed yet).
- `claude` off the non-interactive PATH is handled (`_claude_bin` probes
  `~/.npm-global/bin` etc.) — headless/cross-host launches work.

### Registries (data in JSON; the script stays a clean executive)

| file | holds |
|---|---|
| `~/.config/zsh/registries/projects.json` | authoritative project → path (any project launches) |
| `~/.config/zsh/registries/ai.json` → `remote-control` | rc_name per project + launch-defaults |
| `~/.config/zsh/registries/hosts.json` | host-label → tailscale identity (cross-host dispatch) |

---

## Pinning a device — systemd always-on (Approach A)

A `Type=simple` user service runs `claude remote-control --name "<project>"` in the
project directory; restarts on failure; waits for `network-online.target`.

```bash
systemctl --user daemon-reload
systemctl --user enable --now claude-rc-<project>.service
loginctl enable-linger hruzam         # survive logout / start at boot
systemctl --user status claude-rc-<project>.service
journalctl --user -u claude-rc-<project>.service -n 50
```

Service files: `~/.config/systemd/user/`. If `claude` is not on the service PATH, set
`Environment=PATH=…` to include its install dir.

---

## `/rc-launch` skill — the phone front

Say e.g. "launch flight on nablarva at office". The skill gathers `{host, project,
agent, model, effort}` (host + project + agent required), checks reachability, then:
- **local** (host == this box): `bash ai/rc.sh <project> --agent … --detach`
- **remote** (cross-host): `ssh <user>@<tailscale_dns> -t 'bash ai/rc.sh <project> … --detach'`

If ssh fails, the skill reports the exact command tried — it does not fix auth.

---

## SSH fallback via Tailscale

No RC session pre-started and you need one:

```bash
tso                          # or: ssh hruzam@<tailscale-ip>
bash ~/.config/zsh/ai/rc.sh <project>        # detaches itself; prints catch URL
```

Then catch from the app / `claude.ai/code`. (No tmux step exists anymore.)

---

## Connecting from mobile

1. Claude app (iOS/Android) → **Code** tab.
2. **Connect to desktop** — QR or `claude.ai/code`.
3. The active RC session/environment appears; attach.

---

## Troubleshooting

**Connection dropped (idle):** the RC protocol has a ~10-minute network idle timeout.
Run `/remote-control` inside the session to reconnect — do NOT relaunch, and do NOT
`--continue` from another machine (fork trap, see the laws above).

**"Remote Control not yet enabled":** plan check — Pro/Max/Team required.

**Session shows running but unreachable:** the claude process inside may have exited —
`tail ~/.cache/rc/<project>.log`, then `rc.sh <project>` to reuse/relaunch.

**Two people/devices fighting for control:** by design — single seat. Decide who holds
it; the other watches via the app read-only or waits.

---

## Machine scope

Both machines run the same engine (deployed from the surgical table). Per-project
availability and rc names live in `ai.json`; paths in `projects.json` — extend the
registries, not the script.

---

## Manifest

| file | class | role |
|---|---|---|
| `remote-control-spawn.md` | legacy — superseded, do not follow | pre-rc.sh spawn notes (majkee's 2026-08-14/15 pty/glyph findings — the origin record the engine header cites) |
| `spawn-rc.sh` | legacy — superseded, do not follow | early spawner, absorbed into `ai/rc.sh` |
| `spawn-rc-term.sh` | legacy — superseded, do not follow | the proven real-pty spawner, absorbed into `ai/rc.sh` 2026-08-15 |
