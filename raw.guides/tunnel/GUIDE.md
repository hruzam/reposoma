---
title: TUNNEL — the live Claude↔Codex table (TABLE shape, HANDSHAKE r3)
scope: cross-vendor instrument — machine layer; born in termbrana 03-tunnel, independent since
audience: operator + any Bash-capable seat
state: LIVE — v0 proven 2026-09-03 (FAIL→fix→PASS receipts); v1 candidates parked
verified: 2026-10-03 · usage + exit contract on codex-cli 0.159.3 (BRICK-01 deployed office, selftest 89/89); live-turn behaviour facts still date from 0.152.1/0.154.0 — WEATHER per Sella L8, verify on upgrade
authority: "~/ia-sync/HANDSHAKE.md §TABLE governs the exchange semantics; this guide is usage only. Shim source: ia-sync/zsh/ai/tunnel-codex.{zsh,py} (compose-first; live copy ~/.config/zsh/ai/). Evidence: nablarva toolbox/termbrana/research/evidence/t06-tunnel-v0-roundtrip.md"
---

# TUNNEL — usage

A live synchronous channel to a **stored Codex thread**: it remembers across calls and
days, results are streamed AND reconciled (`thread/read`), and the whole thing is
operator-gated (termbrana law 2.4 — the human opens the table).

## When to reach for which instrument

| Need | Instrument |
|---|---|
| Codex does real work, multi-turn, continuity | **tunnel** (this guide) |
| One-shot blind second opinion | `@vega` relay |
| One-shot adversarial audit of a position | `@mirror` relay |
| Codex co-architecture, full repo context | Cartan resident (`cd ~/ia-sync && codex`) |
| Claude session ↔ Claude session | native SendMessage |
| Anything async | mail by path (HANDSHAKE) |

## Usage

State path is ALWAYS explicit — `--state <path>` or `TUNNEL_CODEX_STATE` env; neither
present = clean fail (exit 13), nothing created. One state file = one thread = one
conversation-with-memory; put it where the work lives.

```zsh
export TUNNEL_CODEX_STATE=~/my-work/tunnel.state.json   # inside ia-sync: tunnel*.state.json is gitignored

tun open --enable [--cwd ~/repo]   # OPERATOR opens the table (law 2.4); preflight only, no thread yet
tun send "task text"               # thread born on FIRST send (at --cwd if given); result on stdout
tun ask "task text"                # send + reconcile + verified result; exit 50 on mismatch
tun read                           # re-fetch the thread (free, no turn) — also the recovery primitive
tun send "follow-up"               # same thread — it remembers
tun close                          # prints the threadId + re-bind command, THEN removes local state

# BRICK-01 (2026-10-03) — reach a thread you did NOT birth (an interactive cSharp head):
tun open --enable --thread <threadId> [--cwd ~/repo]   # BIND: local declaration only, no server resume
tun resume                         # liveness probe — AFTER the interactive client released it;
                                   # stamps the server's REAL sandbox/effort/cwd/instruction files into state
tun status                         # now shows state.runtime (truth as of last contact), not only intent
```

`tun` = palette alias → `zsh ~/.config/zsh/ai/tunnel-codex.zsh`. Operator recipe for a bound
head, step by step with what you should see: `/guide tunnel user-run` §"Binding to a head".

**Vault manager (`tn-*`, session scope, 2026-10-04)** — the "which vault is this shell on"
device; the shim above stays the only thing that talks to Codex:

```zsh
tn-ls                                   # every vault under $RB_ROOT; * = this shell's current
tn-use <bed> [name]                     # export TUNNEL_CODEX_STATE for <bed>/tunnel[.<name>].state.json
tn-on  <bed> [name] -- --thread <id> --cwd ~/ia-sync    # use + open --enable (values set HERE, Law 2.4)
tn-st  [bed] [name]                     # intent layer vs runtime layer, readable
tn-off [bed] [name]                     # close (prints threadId + re-bind line first)
```

One vault = one thread. A bed may hold several (`tunnel.head.state.json`, `tunnel.impl.state.json`
…); a shell points at one at a time; two vaults must never share a threadId.

**Exit codes (man-page contract):** 0 ok · 10 not-enabled · 11 usage · 12 no-thread-yet
(send first) · 13 state-not-specified · 20 spawn-fail · 30 protocol error · 40 turn
error · 50 reconcile mismatch (streamed ≠ read-back — record, never silently retry) ·
61 turn-in-flight (BRICK-01: another send/ask/steer on this vault is still running — wait, or
`tun read`; never a second turn on one head).

**Stdout contract:** open/close/status/resume → stdout EMPTY (banners on stderr) · send/ask/steer → result text + one final usage line · read → raw thread JSON.
The usage line is `[usage: ctx=<last.input>/<window> (<pct>%) out=<n>]` by default (BRICK-01b) —
occupancy, the only number a seat should act on. `TUNNEL_CODEX_USAGE=full` restores the raw
`[usage: {...}]` JSON; `off` drops the line (a consumer that wants only the text:
`tun ask "…" | sed '$d'` also works on any shape).

## Limits + lifecycle (v0, honest)

- **`steer` is resumed-steer only** — no mid-stream steering across processes (no-daemon
  design). v1 resident-process candidate.
- **Never touch `~/.codex/thread-writer-locks/`** — Codex-owned state; unlink can race
  another client (@Cartan verdict 2026-09-03). To retire a stored thread deliberately:
  supported `codex archive` / `codex delete` — an explicit operator lifecycle action,
  never hidden cleanup.
- Quota: each `send` spends real ChatGPT-account turns. The enable gate exists so this
  is always a chosen cost.
- Any Bash-capable seat may drive verbs AFTER the operator's `open --enable`; no seat
  enables itself. **The gate is a presence check, not an authorisation check** — the shim
  cannot tell a seat from the operator; a seat that must never enable is held by its
  instruction contract, not by the shim.
- **One turn in flight per vault** (BRICK-01): `send/ask/steer` hold `<state>.lock`; a second
  caller through the same state path gets exit 61. Protection is per *handle*, not per
  thread — a second vault, an interactive TUI, or any other client on the same thread is
  outside it. Cross-client order is operator discipline: the interactive client releases
  before a tunnel turn. The Codex writer-lock is only *read* for a stderr note, never gated on.
- **Several seats, one head — share the vault file.** Two Claude sessions may consult the same
  thread if they `tn-use` the *same* vault: the turn lock is per vault, so the second caller
  waits (exit 61) instead of racing. Never two vaults on one threadId (no shared lock — the one
  accidental two-writer shape; cross-host is this case by construction). Every message names
  its sender and cycle — the head sees one conversation. One `_bus/` sequence per thread; the
  coordinator mints the numbers. And the tunnel is a **consultation line, not a mailbox**:
  Claude↔Claude traffic goes by files (`_bus/`, mail by path); every relayed word is a model
  turn and lands in the head's context.
- **Bind ≠ birth.** A bound thread keeps the sandbox, model and cwd it already has;
  `--sandbox`/`--model` on a bind are intent only. Trust `state.runtime.*` (after `resume`),
  never `state.sandbox`, for a head you did not birth.

→ chapter `user-run` — bring-up on a new host, session reset, multi-vault patterns,
  TUNNEL_CODEX_STATE wiring (`/guide tunnel user-run`)
→ chapter `settings` — the knob card: what each sandbox mode actually permits, the fine
  knobs (`writable_roots`, `/tmp`, network), model/effort/identity params, and which of
  the three routes can reach each one today (`/guide tunnel settings`)

## Manifest

| file | class | title |
|---|---|---|
| `res/user-run.md` | chapter | user-run — bring-up, session reset, multi-vault patterns |
| `res/settings.md` | chapter | settings — the knob card (what you can set, what it means, how to send it) |
| `res/multi-seat.md` | chapter | multi-seat — one Codex head, one vault, one carrier, several Claude seats (proven: Houston forge, GO+KEEP) |
| `dev-journal.tunnel.md` | journal (dev-layer, uncanonical) | field-usage lessons ladder — append-only, not `/guide`-served |
| `src/` | dev-layer (uncanonical, sella-src pattern) | driving observations + evidence — reached by explicit path only |

## Lineage — point, never copy

Born as termbrana's law-2.4 write capability (session 03-tunnel; the FAIL is part of the
proof — zero-turn `thread/start` leaves no rollout, thread birth belongs to first send).
Exchange semantics: HANDSHAKE §TABLE (Cartan co-signed). Mechanics spec: Cartan's
tunnel verdict (meeting-room, 2026-09-02, in git history). Version facts here are dated
observations, not pins — on any codex-cli upgrade, re-run the shim selftest and one live
round-trip before trusting (L8).
