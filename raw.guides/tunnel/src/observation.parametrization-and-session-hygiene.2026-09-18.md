# observation — tunnel parametrization ceiling + session-hygiene facts

`class: dev-layer observation (uncanonical, sella-src pattern) · driver: Trajectory (home ·`
`session home.trajectory.tunnel) · date: 2026-09-18 · codex-cli: 0.154.0 · all probes`
`zero-quota (codex sandbox / app-server handshake only — no ChatGPT turn spent)`

## 1. The vendor's preset registry is structurally unreachable from the tunnel

Codex has a native preset mechanism — `[profiles.*]` in `config.toml`, selected with
`--profile`. **The tunnel cannot use it.** Two independent closures, both verified:

- The binary's own error string enumerates where `--profile` applies: *"`codex`, `codex
  exec`, `codex review`, `codex resume`, `codex queue`, `codex archive`, `codex delete`,
  `codex unarchive`, `codex mcp`, `codex sandbox`, `codex debug prompt-input`."*
  **`app-server` is absent from that list** — and the tunnel spawns
  `codex app-server --stdio`.
- Passing the profile as a config key fails too:
  `-c profile="x"` → *"legacy `profile = …` config is no longer supported; use `--profile`."*

Consequence: a house-side preset surface is **not** re-inventing the vendor's wheel. The
vendor's wheel does not reach this transport. (This is the justification bar from the
operator's own "avoid registries until pain justifies" rule — the pain is structural.)

## 2. But `-c key=value` DOES work on app-server — and that is the keystone

Verified by JSON-RPC `initialize` handshake against a spawned app-server:

| spawn | result |
|---|---|
| `app-server --stdio` (baseline) | HANDSHAKE-OK |
| `+ -c model_reasoning_effort="low"` | **HANDSHAKE-OK** |
| `+ -c sandbox_mode="workspace-write"` | **HANDSHAKE-OK** |
| `+ -c profile="<name>"` | FAILS (see §1) |

### The architectural consequence — no-daemon turns spawn-config into turn-config

The shim spawns **one app-server subprocess per verb invocation** (no daemon, by design).
Therefore a `-c` override is scoped to exactly one verb call — which means:

- **Per-vault settings without touching global `config.toml`.** This retires the "Route B
  is global, it widens everything on the machine" caveat in `res/settings.md`.
- **Spawn-level config is effectively per-turn config.** `-c model_reasoning_effort="high"`
  on a single `send` applies to that turn only. Effort control needs no `turn/start`
  param work at all.
- `sandbox_workspace_write.writable_roots` has **no** `thread/start` equivalent (that param
  is the bare `SandboxMode` enum), so `-c` is the *only* route to a multi-root sandbox
  through this transport.

⚠ **Unverified half:** the handshake proves app-server *accepts* these keys. It does NOT
prove a born thread *honors* `writable_roots`/`network_access` — that needs one live turn
(L8). Do not write this into canon as fact before that turn is spent.

## 3. Session hygiene — what `close` really does

`close` is local-only: *"removes tunnel.state.json; re-arms the Law 2.4 gate… does not
clean codex-side state."* The state file is the only holder of the threadId.

| action | outcome |
|---|---|
| `open` with state intact | **same** thread resumed |
| `close` → `open` → `send` | **new** thread born |
| — | nothing ever auto-selects a "last" session; there is no such memory |

**The state file path IS the thread's address.** Same `$TUNNEL_CODEX_STATE` → same thread,
across tmux panes, process kills, reboots, and hosts.

⚠ **Orphan hazard (live today):** `close` does not delete the thread server-side, it
*orphans* it. Without recording the threadId first, recovery means hunting
`~/.codex/sessions/YYYY/MM/DD/` by date. Nothing in the shim warns about this.

## 4. The token-readout trap

The shim's `[usage: {...}]` tail prints both `last` and `total`. They mean different
things, and reading the wrong one is expensive. Measured on thread `01a0ac77…`:

| figure | value | of 258,400 window |
|---|---|---|
| `last.input_tokens` — **actual context occupancy** | 51,002 | **~20 %** |
| `total_token_usage.total` — cumulative, NOT occupancy | 177,544 | *reads as 69 %* |

Acting on `total` rotates the thread roughly **3× too early**, discarding the accumulated
memory that is the entire point of a stored thread. Occupancy is
`last.input_tokens / modelContextWindow`.

Growth slope matters more than level: `22,397 → 51,002` across 5 requests (~+7K/request).

**Beyond tokens:** the dominant degradation vector in a long thread is not context
pressure but **stale decisions** — the thread faithfully recalls instructions since
reversed, and cites them with confidence. Rotation on *project pivot* protects more than
rotation on token count.

## 5. Session control exists in the protocol, absent from the shim

| capability | protocol | shim |
|---|---|---|
| enumerate threads | `thread/list` (+ `archived` filter, `cwd` filter, pagination) | ❌ |
| name / rename a thread | `thread/setName`, `Thread.name` | ❌ |
| archive / delete | `thread/archive`, `thread/delete` | ❌ |
| resume a *chosen* thread | `thread/resume` | ⚠ only the id already in state |
| transcript location | `Thread.path` | ❌ — derivable by hand: `~/.codex/sessions/YYYY/MM/DD/rollout-<ISO>-<threadId>.jsonl` |

Shim verbs are `open · send · steer · ask · read · resume · close · status`. Switching
threads today means swapping state files or hand-editing `threadId`.

Tunnel threads share `~/.codex/sessions/` with interactive Codex, so `codex resume` can
open a tunnel thread for hand inspection. ⚠ Do so only when the tunnel is idle — two
clients on one thread risks the writer-lock race (@Cartan verdict 2026-09-03).

## 6. Design note — bundler, not compiler

If a house preset surface is built, it should store **vendor key spelling verbatim**
(`sandbox_mode`, `model_reasoning_effort`, `writable_roots`, `network_access`) and invent
only the *bundle name*. A translation layer from house names → vendor names is exactly the
surface that rots on each codex-cli upgrade, and it forces the operator to learn a private
dialect that matches nothing in the Codex UI or docs. Bundle, do not translate.

## Cross-references

- Mechanism (Landlock/seccomp): `observation.sandbox-enforcement-mechanism.2026-09-17.md`
- Knob semantics + the three routes: `res/settings.md`
- Corrections owed to canon, not yet applied: `res/user-run.md` multi-repo claim
  (`writable_roots` disproves "would force danger-full-access"); `res/settings.md`
  Route-B "global" caveat (§2 above retires it); thread-birth-only sandbox doctrine
  (0.154.0 exposes per-turn `sandboxPolicy`).
