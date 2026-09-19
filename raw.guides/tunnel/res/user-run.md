---
chapter-of: tunnel
title: user-run — bring-up, session reset, multi-vault patterns
audience: operator
verified: 2026-09-04
---

# user-run — bring-up, session reset, multi-vault patterns

Operational patterns for running the tunnel day-to-day: getting it live on a new host,
clearing a bloated session, running independent Codex threads per project, surviving long
turns, and checking the sandbox before handing a seat write-side work.

---

## Bring-up on a new host (or after any version change)

L8 applies on any codex-cli upgrade **or downgrade** — selftest + one live turn, in order:

```zsh
# 1. Fixture proof — no quota; proves shim wiring, not the real protocol
zsh ~/.config/zsh/ai/tunnel-codex.selftest.zsh
# expect: 64/64 ... passed

# 2. Live probe — if an existing thread state file is present
export TUNNEL_CODEX_STATE=<your vault path>
tun resume
# exit 0 + status line  → thread reachable on this host; proceed to step 3
# exit 30 (no rollout)  → thread was born on another host's ~/.codex; close + new thread

# 3. Verified live turn (the actual L8 proof)
tun ask "ping"
# exit 0 + reply        → protocol compatible on this version; tunnel is live
# exit 40 (turn-error)  → turn status field shape changed; inspect and report
```

**Observed delta on codex-cli 0.149.0 vs 0.152.1 (home, 2026-09-04):**
thread-level `status` arrives as an object `{type: 'idle'}` instead of the string
`"idle"` — display-only, emitted by `resume`'s banner. Turn-level `status` (the gate
inside `drive_turn` and `reconcile`) is still the string `"completed"`. No code change
required. The round-trip is the proof; the version pin is the weather.

**Cross-host threads:** Codex stored threads are reachable by threadId from any host
that has the same API credentials — `tun resume` + `tun ask "ping"` confirms this.
Local `~/.codex/thread-writer-locks/<threadId>.lock` is machine-local metadata, not a
cross-host barrier.

---

## Clearing a session (token bloat)

No in-thread context trim exists in the shim. Reset means a new thread:

```zsh
tun status               # record the threadId if you want to archive it
tun close                # removes local state; re-arms Law 2.4
codex delete <threadId>  # optional: retire server-side; omit to leave it archived
tun open --enable        # fresh preflight (no thread yet)
tun send "brief: ..."    # thread born here; hand-write Cartan a compact context summary
```

**Brief discipline:** 3–5 sentences on the first `send` cost far less than a week of
accumulated turns. Name the project, the current task, and any standing decisions
Cartan needs to honor. Do not narrate the old thread — summarize the live state.

**Reset triggers:** context window approaching (~80 %+), project pivot, or deliberately
starting a clean experimental branch without contaminating the main thread.

---

## Multiple vaults — per-project sessions

One state file = one thread = one Cartan with that project's memory.
Any number of independent vaults can coexist on the same machine:

```zsh
# Project A
export TUNNEL_CODEX_STATE=~/projects/projectA/tunnel.state.json
tun open --enable
tun ask "you are Cartan on projectA — <brief>"

# Project B — re-export in same shell, or use a separate terminal
export TUNNEL_CODEX_STATE=~/projects/projectB/tunnel.state.json
tun open --enable
tun ask "you are Cartan on projectB — <brief>"
```

Each thread remembers only its own project context. Switching is a single re-export.
`tun status` always shows which vault the current shell is pointing at.

**Project-switcher integration** — so the vault follows the project switch automatically,
add one export per project block in `ia-sync/zsh/project-switcher.zsh`:

```zsh
# inside the fo / im / lrv / … switch block:
export TUNNEL_CODEX_STATE=~/path/to/project/tunnel.state.json
```

Deploy via `ia-sync` after editing. After this, `fo` (or whichever switcher) sets both
the project environment and the Codex vault in one move.

---

## Long turns — never kill the driver

A turn is NOT a fire-and-forget submission. Killing the local driver process mid-turn
**interrupts** the server turn (`status: "interrupted"`, `completedAt: null`, no
`final_answer`) — it does not survive to complete on its own. The stored-thread memory
protects CONTEXT across turns, not an in-flight turn whose driver died.

- Any turn expected to run long (multi-repo audit, script generation, deep reasoning) →
  **run it detached / in the background**, or raise the client timeout well past the
  model's thinking budget. A foreground call with a short timeout is the classic trap.
- If a driver died AFTER the turn actually completed, recover the result with `tun read`
  (re-fetch, no turn spent). `read` also returns an interrupted turn's partial
  `commentary` items — free forensics on what the seat had started.
- To continue after an interrupt, a one-line nudge is enough — the thread still holds the
  original brief plus any partial findings; do not re-paste the whole task.

*(field origin: `dev-journal.tunnel.md`, 2026-09-04)*

## Sandbox check before write-side dispatch

`tun status` reports `sandbox: {type, networkAccess}`. **Read it before handing the thread
write-side work.** A `readOnly` sandbox means the Codex seat can inspect the repo but cannot
delete / edit / commit / push.

Two responses to a readOnly seat + a write task:
1. Reopen the table with a writable sandbox (operator config).
2. **Preferred:** use the readOnly seat as verifier + plan-author — it emits an exact,
   paste-ready script — and hand execution to a write-capable seat. This keeps execution
   gated AND buys a decorrelated cross-vendor verification of the plan for free.

*(field origin: `dev-journal.tunnel.md`, 2026-09-04)*

## Sandbox escalation — when to widen, and why `/tmp` is not a door

The three values on `tun open --sandbox …`: `read-only` (default, Law 2.4),
`workspace-write` (writes within the thread's workspace root + tmp; other repos blocked),
`danger-full-access` (no sandbox — full filesystem + network).

**`/tmp` is not an escape.** The sandbox policy governs the codex process AND every child it
spawns; a script inherits the policy regardless of where it lives. Under `read-only` the
process cannot even write the script; under `workspace-write` a script writing to a repo
outside the workspace root is still blocked. There is no side-door — widening the sandbox is
the only supported path.

**Two mechanics before you widen:**
- **Sandbox is fixed at thread birth *by house rule*, not by the protocol.** The shim sends
  it only at `thread/start`, so in practice you change it with `tun close` (re-arms the
  gate) → `tun open --enable --sandbox workspace-write` → a NEW thread, prior memory gone.
  0.154.0 *does* expose a per-turn `sandboxPolicy` override, but only a client can send it
  (never the model), and wiring it to `send` would hand leash-loosening to any Bash-capable
  seat. We decline it deliberately. Knob detail: `/guide tunnel settings`.
- **`approvalPolicy: "never"` is baked into v0.** A writable sandbox therefore executes
  autonomously with no approval prompt — the only gate is your initial `open`.

**When escalation is clean:** routine multi-edit work inside ONE repo → open `workspace-write`
launched at that repo's root. **When it is not:** anything where the surgical-table gate
(author-on-table / operator-or-executor-deploys) should hold. For those, keep the tunnel
`read-only` and use the seat as verifier + plan-author, handing the emitted script to a
write-capable seat (see previous section) — gated execution plus free cross-vendor
verification, a feature not a limitation.

**Multi-repo work — a house choice, not a mechanical limit.** Earlier text here claimed work
spanning several repos "would force `danger-full-access`". That is false:
`sandbox_workspace_write.writable_roots` makes several named repos writable while everything
else stays EROFS (verified 2026-09-18, 0.154.0). The restriction stands as policy — keep
multi-repo fan-out behind verify→execute — but say it as a choice, because the mechanism
does not force it.

`danger-full-access` is a deliberate, rare choice — with `approvalPolicy: "never"` it is a
large trust surface. Never a habit.

*(field origin: `dev-journal.tunnel.md`, 2026-09-04 · re-verify the enum on any codex-cli upgrade, L8)*

## TUNNEL_CODEX_STATE — wiring options

| Option | When to use |
|---|---|
| Per-session `export TUNNEL_CODEX_STATE=<path>` | Deliberate, explicit — the design intent; always correct |
| Project-switcher block export (above) | One vault per project; switch carries it automatically |
| `config.home.zsh` / `config.office.zsh` export | Only if one persistent vault spans all work on that machine |

No global default is baked into the shim by design — a stray invocation must never
silently resurrect an old thread. State selection is always an explicit operator or
project-switch decision (exit 13 if neither `--state` nor the env var is present).
