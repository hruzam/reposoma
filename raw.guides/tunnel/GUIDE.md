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

→ chapter `user-run` — bring-up on a new host, session reset, multi-vault patterns,
  TUNNEL_CODEX_STATE wiring (`/guide tunnel user-run`)

## Manifest

| file | class | title |
|---|---|---|
| `res/user-run.md` | chapter | user-run — bring-up, session reset, multi-vault patterns |
| `dev-journal.tunnel.md` | journal (dev-layer, uncanonical) | field-usage lessons ladder — append-only, not `/guide`-served |

## Lineage — point, never copy

Born as termbrana's law-2.4 write capability (session 03-tunnel; the FAIL is part of the
proof — zero-turn `thread/start` leaves no rollout, thread birth belongs to first send).
Exchange semantics: HANDSHAKE §TABLE (Cartan co-signed). Mechanics spec: Cartan's
tunnel verdict (meeting-room, 2026-09-02, in git history). Version facts here are dated
observations, not pins — on any codex-cli upgrade, re-run the shim selftest and one live
round-trip before trusting (L8).
