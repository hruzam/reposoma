<!-- PUBLISHED MIRROR · do not edit here · source: piql.dev/guides/piql.md · regenerate with: sync-guides -->

# piql — operator guide

_Your day-to-day guide to running piql. This is the front door; `piql-bus-usage.md` has the
wiring/config detail, the `session/` cards have the design history._

## What piql is
A private, CPU-only local assistant + orchestration bus on the office box (i5-12400, Manjaro, no GPU).
Today it does one job well: **`piql`** — a privacy-gated cloud assistant. Your text is scanned
*locally* (secrets / PII / client codenames redacted, hard secrets blocked) before anything reaches
the cloud (Claude). Reachable from home over the Tailscale mesh.

## Quick start
New terminal (or `source ~/.config/zsh/config.zsh`):
```zsh
piql "in one sentence, what is a mesh VPN?"     # gate → scrub → Claude → answer
echo "$text" | piql "review this"               # stdin works too
piql-doctor                                      # health check (9 checks)
```
- **stdout** = the answer (pipeable). Notices (redactions / blocks) go to **stderr**.
- **Exit codes:** `0` answered · `2` blocked by the gate (high-risk) · `1` tool broke.

## How it works (short version)
1. The gate (`bus/prefilter/`) scans your text — **deterministic** regex + a client denylist own the
   decision; gemma3:4b is an advisory layer that can only *add* redactions, never block.
2. Known secrets / IPs / emails / client codenames → masked (`[REDACTED:…]`). Hard secrets (private
   keys, DB URLs with creds) → **blocked** entirely.
3. Cleared text → `claude --print` → answer returned.
Net: clean prompts always pass, known secrets never leak, and the model's flakiness can't break it.

## Where everything lives (footprint)
- **Command:** `piql.dev/piql.env.zsh` (sourced from `~/.config/zsh/config.zsh`)
- **Bus:** `piql.dev/bus/prefilter/` (gate) · `piql.dev/bus/pip/` (cloud link) · `piql.dev/bus/piql-doctor.zsh`
- **Map of everything** (paths/services/ports): `~/.config/piql/registry.toml`
- **Models:** Ollama at `127.0.0.1:11434`, files in `/var/lib/ollama` (gate = `gemma3:4b`)
- **Reach from home:** Tailscale — `ssh office` (office = `100.126.182.111`, always-on)

`piql-doctor` verifies all of the above in one shot.

## Troubleshooting
- **`piql` blocked a prompt you think is clean** → check stderr for the category. The deterministic
  layer matched a pattern (e.g. something that looks like a key/IP) or there's a real hard secret. To
  see the raw verdict: `echo "your text" | bus/prefilter/prefilter.zsh`.
- **`piql-doctor` shows FAIL** → it names which: Ollama down (`systemctl status ollama`), port not
  bound, model missing (`ollama pull gemma3:4b`), or `claude` missing.
- **Claude Code "Auto-update failed: no write permission to npm prefix"** → fixed; `npm config get
  prefix` should be `~/.npm-global` (not `/usr`). If it regresses: `npm config set prefix ~/.npm-global`.
  **Never `sudo npm`.**
- **Can't reach office from home** → `tailscale status` (both online?), then `ssh office`. Office is
  always-on (sleep masked), so it should answer whenever it's powered.

## Current state & what's next
piql works end-to-end as a private gated assistant. Done: Tailscale mesh + always-on, Ollama
(loopback-only), gate v2 (deterministic-first), the `pip`/`piql` link, doctor + registry.
Next, when you want it:
- **Verify the gate's model layer** actually contributes (its latency looked suspiciously low).
- **Intent-router brick** (qwen3:1.7b) — once you wire a 2nd backend (e.g. cursor) worth routing to.
- **Optional:** migrate Claude Code to the native installer (drops npm from the loop).

## Deeper docs
- `guides/piql-bus-usage.md` — wiring, config, tests
- `session/bus/tasks/BRICK_01…` / `BRICK_02…` — the bricks' design + results
- `session/mesh-state.md` — cross-machine truth (the lighthouse)
- `session/plan/session.plan.md` + `pulse.md` — full plan + phase table (office-local)
