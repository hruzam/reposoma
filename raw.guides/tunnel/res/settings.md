---
chapter-of: tunnel
title: settings — the knob card (what you can set, what it means, how to send it)
audience: operator
verified: 2026-09-18 · codex-cli 0.154.0 · live probes via `codex sandbox` (zero quota, no turn spent)
---

# settings — the knob card

Reference card for every setting that shapes a tunnel thread: what it actually permits,
what it costs, and **which of the three routes can reach it today**. Companion to
`res/user-run.md` (which covers *when* to widen — this covers *what the knobs are*).

---

## The one-line mental model

**The sandbox governs WRITE and NETWORK. It does not govern READ.**

Verified: with `sandbox_permissions=[]` — no permissions granted at all — a sandboxed
process still read `/etc/os-release` and files in an unrelated repo. Read is global in
every mode. So "read from everywhere" is not something you switch on; it is the floor.
What you are ever deciding is **where it may write** and **whether it may reach the
network**.

---

## Card 1 — the three sandbox modes

| mode | write scope | network | read |
|---|---|---|---|
| `read-only` *(default, Law 2.4)* | **nothing** — not even `/tmp` | no | everywhere |
| `workspace-write` | workspace root **+ `/tmp` + `$TMPDIR`** | no *(default)* | everywhere |
| `danger-full-access` | everywhere | yes | everywhere |

**The `/tmp` nuance — both halves are true, and they are about different modes:**
- Under `read-only`, `/tmp` is **closed**. Verified: write → `Read-only file system`
  (kernel EROFS). This is what `user-run.md`'s "`/tmp` is not a door" means, and it holds.
- Under `workspace-write`, `/tmp` is **open by default** (`excludeSlashTmp` defaults to
  `false`). Verified: write to `/tmp` succeeded. So "let him write at least to `/tmp`"
  does not need a special setting — it is what `workspace-write` already gives you.

---

## Card 2 — the fine knobs (apply to `workspace-write`)

These are the knobs `user-run.md` never named. All verified live.

| knob | default | what it does | verified |
|---|---|---|---|
| `writable_roots` | `[]` | **extra absolute paths that become writable**, beyond the workspace root | write to `$HOME/.cache` was EROFS-blocked without it, succeeded with it |
| `exclude_slash_tmp` | `false` | set `true` to **close `/tmp`** while keeping the workspace writable | with `true`, `/tmp` write → EROFS |
| `exclude_tmpdir_env_var` | `false` | same, for `$TMPDIR` | not probed — schema-derived |
| `network_access` | `false` | set `true` to allow outbound network | default → DNS failure; `true` → `HTTP 200` |

### The correction this card exists to carry

`res/user-run.md` §"Sandbox escalation" states that work spanning several repos *"would
force `danger-full-access` to cover them all"*. **That is mechanically false as of
0.154.0** — `writable_roots` covers exactly that case: several named repos, each writable,
everything else still EROFS, no full-access escalation. Verified by probe C2/D2 above.

The *policy* half of that section may still stand (keeping multi-repo fan-out gated behind
verify→execute is a defensible house rule for its own reasons). But it should stand as a
**choice**, not as a mechanical necessity, because the mechanism does not force it.

---

## Card 3 — model · effort · identity

| setting | protocol home | what it buys | reachable via `tun` today? |
|---|---|---|---|
| `model` | `thread/start` **and** `turn/start` | model id; per-turn form switches model **mid-thread, memory intact** | `open --model` only (thread-birth, frozen) |
| `effort` | `turn/start` | reasoning effort **per turn** — no new thread, no memory loss | ❌ not reachable |
| `cwd` | `thread/start` / `turn/start` | workspace root → decides **which `AGENTS.md` loads** and what `workspace-write` covers | ❌ **never sent** — defaults to wherever the shim process was spawned |
| `developerInstructions` | `thread/start` | additive persona/brief at birth — replaces the "you are Cartan on X" first `send`, **at zero turn cost** | ❌ not reachable |
| `baseInstructions` | `thread/start` | replaces the base system prompt wholesale | ❌ — and **not advised**: it decouples the seat from Codex's own harness, which is the decorrelation the cross-vendor setup exists for |
| `personality` | both | enum `none \| friendly \| pragmatic`; gated by `Model.supportsPersonality` | ❌ tone only, not identity |
| `sandboxPolicy` | `turn/start` | per-turn sandbox override — see the warning below | ❌ **deliberately not wired** |

Legal `effort` values are model-advertised, not a fixed enum: each `Model` from
`model/list` carries `defaultReasoningEffort` + `supportedReasoningEfforts[]`. The shim
already calls `model/list` at `open`, so this catalog is obtainable at zero extra quota.

### ⚠ Sandbox is no longer strictly thread-birth-only

`GUIDE.md`, `res/user-run.md`, and the dev-journal all state that sandbox is fixed at
thread birth and that widening requires `close` → new thread → lost memory. That was
observed on **0.152.1**. On **0.154.0** `TurnStartParams.sandboxPolicy` exists:
*"Override the sandbox policy for this turn and subsequent turns."* Classic L8 weather.

**The gate is not broken:** only the *client* can send that param — the model cannot
re-sandbox itself. Law 2.4 holds. But exposing it on `send` would hand leash-loosening to
any Bash-capable seat, so the house rule is: **keep sandbox thread-birth-only by our own
policy, even though the protocol now permits per-turn.** A deliberate restriction, not a
missing feature.

---

## How to send settings — the three routes

### Route A — `tun` flags *(reachable today · coarse)*

```zsh
tun open --enable --sandbox workspace-write --model <id>
```

Only these two settings, only at `open`, only the coarse three-value enum. Every knob in
Card 2 and every row in Card 3 is out of reach here.

### Route B — `~/.codex/config.toml` *(reachable today · the real lever · GLOBAL)*

The shim spawns `codex app-server --stdio` as a child, so the thread inherits the user's
Codex config. This is the only route to the Card 2 knobs that needs **no shim change**:

```toml
sandbox_mode = "workspace-write"

[sandbox_workspace_write]
writable_roots        = ["/home/hruzam/ia-sync", "/home/hruzam/reposoma"]
network_access        = false
exclude_slash_tmp     = false
exclude_tmpdir_env_var = false
```

**The catch, and it is a real one:** this file is global to every Codex use on the machine
— the interactive `codex` resident (@Cartan), any `codex exec`, and the tunnel alike. It
is not per-tunnel and not per-vault. Widening here widens *everything*. Treat an edit to
it as a machine-layer change, not a tunnel setting.

**Correction (2026-09-18): global is not the only option.** `codex app-server` accepts
`-c key=value` (handshake-verified), and the shim spawns **one app-server per verb** with
no daemon — so a `-c` override is scoped to a single call. That makes per-vault settings
possible *without* editing this file, and makes spawn-level config effectively per-turn
config. `sandbox_workspace_write.writable_roots` has no `thread/start` equivalent at all,
so `-c` is the only route to a multi-root sandbox through this transport.

**Not yet wired:** the shim does not forward `-c` today, so this route requires the Route C
work below before it is usable. Note also that `-c profile="<name>"` is rejected (retired
config key) and `--profile` does not apply to `app-server` — Codex's own preset registry is
unreachable from this transport, which is why a house-side preset surface exists at all.

### Route C — protocol params *(not reachable today · needs shim work)*

`thread/start` accepts 16 params; the shim sends 3. `turn/start` accepts 17; the shim
sends 2. Per-vault settings (`effort`, per-turn `model`, `cwd`, `developerInstructions`)
all live here and require forwarding work in the shim before any terminal flag can reach
them.

**Compose-first — the shim is a deployed copy, never an authoring surface.** The live
`~/.config/zsh/ai/tunnel-codex.{py,zsh}` must never be edited in place. Any change to
Route C is cut on the surgical table and deployed outward (`SYNC_DISCIPLINE.md`, operator
gavel 2026-07-31):

```zsh
# 1. edit the source of truth
$EDITOR ~/ia-sync/zsh/ai/tunnel-codex.py     # and/or .zsh

# 2. zero-quota logic gate BEFORE deploying
zsh ~/ia-sync/zsh/ai/tunnel-codex.selftest.zsh    # expect 64/64 passed

# 3. dry-run the deploy, read every reported change
cd ~/ia-sync && bash deploy.sh --dry-run

# 4. deploy, then re-verify the LIVE copy + one live turn (L8)
bash deploy.sh
zsh ~/.config/zsh/ai/tunnel-codex.selftest.zsh
tun ask "ping"
```

The selftest is a fixture proof — it gates wiring, not the live protocol. Step 4's
`tun ask "ping"` is the only thing that proves the deployed shim still talks to a real
thread, and it is the one step in this list that spends quota.

---

## Verify your own posture

```zsh
tun status    # sandbox: {type, networkAccess} — the thread's actual mode
```

`ThreadStartResponse` also returns `instructionSources` — the environment-native paths of
the instruction files the thread actually loaded (i.e. which `AGENTS.md` gave the seat its
identity). **The shim currently discards it.** Until it is persisted, `tun status` cannot
tell you who the seat thinks it is.

---

## Evidence

Probe transcript (this chapter's factual basis), run 2026-09-18 on codex-cli 0.154.0 via
`codex sandbox` — zero quota, no ChatGPT turn spent:

| # | probe | result |
|---|---|---|
| 1 | read `/etc/os-release` + foreign repo, `sandbox_permissions=[]` | **allowed** — read is global |
| A | `workspace-write`, write inside workspace | allowed |
| B | `workspace-write`, write `/tmp` | allowed *(default)* |
| C2 | `workspace-write`, write `$HOME/.cache` | **EROFS blocked** |
| D2 | C2 + `writable_roots=["$HOME/.cache"]` | **allowed** |
| E/F | `workspace-write` network, default → `network_access=true` | DNS fail → `HTTP 200` |
| G | `read-only`, write `/tmp` | **EROFS blocked** |
| H | `workspace-write` + `exclude_slash_tmp=true`, write `/tmp` | **EROFS blocked** |

Mechanism underneath (Landlock + seccomp, why these are kernel refusals rather than model
compliance): `src/observation.sandbox-enforcement-mechanism.2026-09-17.md`.

**L8:** every value in this card is a dated observation on 0.154.0, not a pin. Re-run the
probes on any codex-cli upgrade before trusting them.
