# Guide — spawn a headless remote-control Claude session

> **GRADUATED 2026-08-15** → the survivor was cut into the zsh layer: engine
> `~/ia-sync/zsh/ai/rc.sh` (generalized, agent-aware, cross-host) + the `/rc-launch`
> skill + registries (`projects.json` · `hosts.json` · `ai.json` launch-defaults).
> This guide and its scripts remain as the proving-ground provenance; `spawn-rc-term.sh`
> and `spawn-rc.sh` are retired in favor of the engine.

> Scope: `remote-control`. Script: `spawn-rc.sh`.
> Provenance: applications-in-common session, majkee mobile-driven, 2026-08-14.
> First working run: `~/unikuklatrix/nablarva`, agent `flight`, model `opus`.

## The problem it solves

`claude --remote-control` starts an **interactive** session. When launched from a
context with **no controlling terminal** — an agent's Bash tool, cron, `ssh -T`, a
mobile relay — claude detects no TTY, silently falls back to `--print`, and dies:

```
Error: Input must be provided either through stdin or as a prompt argument when using --print
```

So a plain `claude … --remote-control &` from a headless context never registers a
session. It looks like a flag problem; it's a **TTY** problem.

## The fix

Wrap the launch in `script -qec`, which allocates a pseudo-TTY. `setsid` detaches it
so it survives the caller. The interactive session then boots normally and registers
with Remote Control — attachable from a phone or another client.

```bash
cd <dir> && setsid script -qec "claude --agent <agent> --model <model> --remote-control" <log> >/dev/null 2>&1 &
```

## Normalized usage

```bash
spawn-rc.sh <dir> [agent] [model]
#   agent default: flight     model default: opus
```

- The log file stays **empty** — that's expected. Interactive TUI output is terminal
  control sequences, not plain text.
- Verify with: `pgrep -f 'claude --agent <agent> .* --remote-control'`
- Stop with:   `pkill -f 'claude --agent <agent> .* --remote-control'`

## Gotchas that bit us

| Symptom | Cause | Fix |
|---|---|---|
| dies asking for prompt/stdin | no TTY → falls back to `--print` | wrap in `script -qec` |
| `--remote-controll` unknown flag | typo, one trailing L | `--remote-control` |
| model won't resolve (`claude-opus-4-8`) | non-existent model string | use alias `opus` or a valid dated full name |

---

# Field-proven: `script` was a dead end — the mux is the real bridge

> Recorded 2026-08-14, majkee at home over tailscale, office = `hruzam-120922`.
> Full arc lives in this session; distilled here. Sibling script: `spawn-rc-term.sh`.

## What we predicted vs what happened

- **Predicted:** `spawn-rc.sh` (the `script -qec` PTY wrap) gives a session reachable
  "from any host in a terminal."
- **Outcome — refuted for the terminal case, holds only for Remote Control.**
  `script` fakes a PTY but throws away the reattach handle: the session is reachable
  through the Remote Control client (any host) but **never** in a terminal — not even
  locally. `--resume` can't help: it is machine-local and reopens a *transcript* as a
  new local process, it does not attach to a live process on another host.

## The reshape — mux as the life, everything else a viewport

`tmux` allocates a **real** pty, so `claude --remote-control` pairs (no `--print`
fallback) **and** keeps a reattach handle, needs no display, and survives disconnect.
One session, three viewports:

- **Remote Control** — claude.ai URL, any host, no terminal.
- **home→office ssh** — `ssh <office> -t 'tmux -2 attach -t rc-<slug>'` — a living
  terminal, cross-host. **This is the leg `script` could never give.**
- **konsole** — optional viewport on the office desktop (needs display injection).

Use `spawn-rc-term.sh` (mux) as default. `spawn-rc.sh` (`script`) is kept only as the
minimal "just pair with Remote Control, no terminal wanted" launcher.

## The gotchas that actually bit us (in order)

| # | symptom | cause | fix |
|---|---|---|---|
| 1 | headless launch dies asking for prompt/stdin | no TTY → `--print` fallback | give it a real pty (mux, not `script`) |
| 2 | script aborts before printing its report | `set -o pipefail` + `grep` no-match in `URL="$(…)"` | append `\|\| true` to best-effort captures |
| 3 | RC url never captured | claude's full-screen TUI uses the **alternate screen**; `capture-pane` can't see the startup line | demote url to best-effort; `status off` helps it survive |
| 4 | `ssh … publickey` + `no pty` | the `!ssh` ran **on office** via a keyless, TTY-less tool shell — not from home | run ssh from a **real home terminal** |
| 5 | tailscale SSH not authing | cap advertised but **`RunSSH=false`** — server not running | `tailscale set --ssh`, or authorize the home key in `~/.ssh/authorized_keys` |
| 6 | glyphs missing (spinner, prompt pointers, mini logo) even when home==office font | ssh drops the locale over the hop → tmux attaches **`client_utf8=0`** → wide glyphs stripped. NOT a font problem. | attach with **`tmux -u`** (forces UTF-8); also `allow-passthrough on` for the logo |

## Rendering polish folded into the script

`terminal-overrides ",*:Tc"` (truecolor) · `default-terminal tmux-256color` ·
per-session `status off` · attach with `tmux -2`. Turns the "ugly but running"
first attach into a clean full-pane app.
