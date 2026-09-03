---
title: TUNNEL — the live Claude↔Codex table (TABLE shape, HANDSHAKE r3)
scope: cross-vendor instrument — machine layer; born in termbrana 03-tunnel, independent since
audience: operator + any Bash-capable seat
state: LIVE — v0 proven 2026-09-03 (FAIL→fix→PASS receipts); v1 candidates parked
verified: 2026-09-03 · behavior facts observed on codex-cli 0.152.1 — WEATHER per Sella L8, verify on upgrade
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
export TUNNEL_CODEX_STATE=~/my-work/tunnel.state.json

tun open --enable          # OPERATOR opens the table (law 2.4); preflight only, no thread yet
tun send "task text"       # thread born on FIRST send; result on stdout
tun ask "task text"        # send + reconcile + verified result, one command; exit 50 on mismatch
tun read                   # reconcile / re-fetch last result (streamed == read-back)
tun send "follow-up"       # same thread — it remembers
tun close                  # re-arms the enable gate (local state removed)
```

`tun` = palette alias → `zsh ~/.config/zsh/ai/tunnel-codex.zsh`.

**Exit codes (man-page contract):** 0 ok · 10 not-enabled · 11 usage · 12 no-thread-yet
(send first) · 13 state-not-specified · 20 spawn-fail · 30 protocol error · 40 turn
error · 50 reconcile mismatch (streamed ≠ read-back — record, never silently retry).

**Stdout contract:** open/close/status/resume → stdout EMPTY (banners on stderr) · send/ask/steer → result text + final [usage: {...}] line · read → raw thread JSON.

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
  enables itself.

## Bring-up on a new host (or after a version change)

L8 applies on any codex-cli upgrade **or downgrade** — selftest + one live turn, in order:

```zsh
# 1. Fixture proof — no quota, proves shim wiring only
zsh ~/.config/zsh/ai/tunnel-codex.selftest.zsh
# expect: 64/64 ... passed

# 2. Live probe — if a thread already exists
export TUNNEL_CODEX_STATE=<your vault path>
tun resume
# exit 0 + status line  → thread reachable on this host; proceed to step 3
# exit 30 (no rollout)  → thread lives on another host's ~/.codex; close + new thread

# 3. Verified live turn
tun ask "ping"
# exit 0 + reply        → protocol compatible; tunnel is live
# exit 40 (turn-error)  → status field shape changed between versions; report upstream
```

**Known 0.149.0 vs 0.152.1 delta (observed 2026-09-04):** thread-level `status` arrives
as an object `{type: 'idle'}` rather than the string `"idle"` — display-only, printed
by `resume`. Turn-level `status` (the gate inside `drive_turn`) is still the string
`"completed"`. No code change required; the round-trip is the proof, not the version pin.

## Clearing a session (token bloat)

No in-thread trim exists. Reset = close + new thread:

```zsh
tun status               # note the threadId if you want to archive it first
tun close                # removes local state; re-arms Law 2.4
codex delete <threadId>  # optional: retire the thread server-side
tun open --enable        # fresh preflight
tun send "brief: ..."    # thread born here; give Cartan a compact context summary
```

Hand-write the context brief on the first `send` — 3-5 sentences cost far less than a
week of accumulated turns. Reset when: context window approaching, project pivot, or a
clean experimental branch is wanted.

## Multiple vaults — per-project sessions

One state file = one thread = one Cartan with that project's memory. Any number of
independent vaults can coexist:

```zsh
# Project A
export TUNNEL_CODEX_STATE=~/projects/projectA/tunnel.state.json
tun open --enable && tun ask "you are on projectA — <brief>"

# Project B — re-export in same shell or use a separate terminal
export TUNNEL_CODEX_STATE=~/projects/projectB/tunnel.state.json
tun open --enable && tun ask "you are on projectB — <brief>"
```

Each thread remembers only its own project; switching is a single re-export.
`tun status` always shows which vault the current shell is pointing at.

**Project-switcher integration** — add one line per switch block in
`project-switcher.zsh` so the vault follows the project automatically:

```zsh
# inside the fo / im / lrv switch block:
export TUNNEL_CODEX_STATE=~/path/to/project/tunnel.state.json
```

## TUNNEL_CODEX_STATE — wiring options

| Option | When |
|---|---|
| Per-session `export TUNNEL_CODEX_STATE=<path>` | Deliberate, explicit — the design intent |
| Project-switcher integration (above) | One vault per project; switch carries it |
| `config.home.zsh` / `config.office.zsh` export | Only if one persistent vault spans all work |

No global default is baked in by design — a stray invocation must never silently
resurrect an old thread. State selection is always an explicit operator or switch decision.

## Lineage — point, never copy

Born as termbrana's law-2.4 write capability (session 03-tunnel; the FAIL is part of the
proof — zero-turn `thread/start` leaves no rollout, thread birth belongs to first send).
Exchange semantics: HANDSHAKE §TABLE (Cartan co-signed). Mechanics spec: Cartan's
tunnel verdict (meeting-room, 2026-09-02, in git history). Version facts here are dated
observations, not pins — on any codex-cli upgrade, re-run the shim selftest and one live
round-trip before trusting (L8).
