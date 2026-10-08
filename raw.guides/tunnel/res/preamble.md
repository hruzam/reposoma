---
chapter-of: tunnel
title: preamble — a standing turn rule the shim prepends to every send/ask/steer
audience: operator + carrier seats
verified: 2026-10-08 · shim ia-sync@17a00fe, selftest 113/113 (17 preamble cases); field origin nablarva-X1 T13/T14 (rollout measurement, codex-cli 0.160.1) · first live turn with a preamble not yet observed
half_life_days: 30
recheck: on any codex-cli upgrade (re-injected developer blocks are weather, L8); after the first live preamble turn (record its ctx delta here)
---

# preamble — a standing turn rule, set once at open

## Why it exists

A tunnel message is short, but the turn it starts can be long. nablarva-X1 (2026-10-08)
measured the bound head's rollout: tunnel prompts were **420–840 B**, yet on many turns the
head re-read its whole read order (AGENTS.md, flag, pulse, PROJECT.yaml, RUNBOOK, STATUS,
`git status`/`diff`), at **30–42 kB per batch**. One turn produced 335 kB of tool output.
`resume` itself adds no fixed cost per turn. Occupancy follows what the turn *reads*. A hand
relay felt cheaper because the payload was pasted and the receiver did not re-orient.

Asking "you are oriented" in every message works until somebody forgets it. A preamble makes
the rule part of every turn: the shim adds it, so nobody has to remember it.

## Notation

```zsh
tun open --enable --preamble <file>   # new vault: store the path (law 2.4 — set at open, never per send)
tun open --preamble <file>            # existing vault: set or replace (local; no --enable needed)
tun open --preamble none              # existing vault: clear
jq .preamble "$TUNNEL_CODEX_STATE"    # which file this vault prepends
```

- **What reaches the head:** `<file text, trimmed>` + `\n\n---\n\n` + `<your message>`. stdout
  is unchanged (the reply only). stderr says `preamble <path> (<n> chars) prepended` on every
  turn, so a carrier's `.err` trace shows it.
- **The file is read at turn time, not copied into the vault.** Edit the file and the next turn
  carries the new text. Every turn pays its size in context, so keep it short (target ≤ 600
  chars).
- **Missing or unreadable file → exit 11 before lock and spawn.** No turn is sent and no lock
  is left behind. Fix the file or `--preamble none`. The shim never silently sends a turn
  without its rule.
- `--preamble` is valid only on `open` (exit 11 elsewhere). Empty file = no-op.
- `open` on an existing vault whose thread is already born also runs the liveness probe
  (`thread/resume`). On codex-cli 0.160.x, wait until the TUI's writer-lock is gone first
  (`/guide tunnel user-run` §Switching).

## Wiring — where the file lives

The rule has two layers. Each sits with its owner, never inside a bed that dies with its gate:

| layer | home | owner |
|---|---|---|
| vendor-neutral default (below) | this chapter — copy it | guide writer |
| project wording | the project's tunnel policy home (next to its `tunnel-using-protocole.md` or design wrapper) | the project head; canon by the project's gavel |
| bed instance (hotfix) | `<bed>/tunnel.preamble.md` | the carrier; dies with the bed — promote the wording first |

First instance (hotfix, bed-scoped):
`~/unikuklatrix/nablarva/.dev/session/nablarva-X1-architecture/tunnel.preamble.md`.

## Default template (vendor-neutral — copy, then name the project)

```text
[tunnel turn rule — <project/bed> · prepended by the shim to every turn]
[set by <seat>(<role>) for <operator> · <YYYY-MM-DD> · why: <one clause + pointer to the finding>]
You are already oriented in this thread. Do NOT re-read the read order or run git status/diff
unless this message asks for it or names a changed file. Read only the files and lines named
below. No web research unless named. If you believe canon changed, say so in one line and ask;
do not reload it. Name any refused command in your reply.
```

**The provenance line is required: who, when, why.** The head sees this text on every turn
with no other context. Without a source it is an anonymous command, and a careful head may
reasonably doubt it or ask about it each time. One line is enough:
- **who:** the seat that wrote the rule and the operator it acts for. The head can then weigh
  it against the project's authority chain. A preamble is a carrier instruction, not canon.
- **when:** the date, so a stale rule is visible as stale.
- **why:** one clause plus a pointer to the finding, so the head can tell what the rule
  protects and when an exception is reasonable.

Change the line whenever the rule text changes. Keep it on one line; it costs context on
every turn.

Each clause answers an observed cost or blind spot:
- re-orientation → "already oriented"
- git sweeps and web research → "unless named"
- silent approval declines → "name any refused command" (`/guide tunnel settings`; field
  feedback F2)

## What a preamble does not fix

- **Re-injected developer blocks.** After a TUI settings change or certain resumes, Codex
  re-sends `<skills_instructions>`/`<permissions instructions>` (6.5–22.6 kB observed). Budget
  for them.
- **Heavy work stays heavy.** A design turn that must read is still a design turn. The preamble
  removes only the reading nobody asked for.
- **It is instruction, not enforcement.** A head can still ignore it. Check the first turns'
  `ctx` deltas: a short turn should cost a few kB, not tens of kB.
