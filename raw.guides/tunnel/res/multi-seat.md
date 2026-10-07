---
chapter-of: tunnel
title: multi-seat — one Codex head, one vault, one carrier, several Claude seats
verified: 2026-10-07 · proven in nablarva-X0-restarted (Houston forge, GO+KEEP): 1 Codex head · 1 carrier (oraculum) + a second Claude seat (atlas-ui) on one vault · 9 carrier turns + 2 yielded-slot turns · 0 collisions · 1 reset at 81 % · codex-cli 0.160.0
half_life_days: 30
recheck: on any codex-cli / claude-code upgrade (turn-lock + spawn facts are weather, L8); when a third vendor joins
---

# multi-seat — running a tunnel with more than two hands on it

`what: the regime for a session where ONE Codex head (behind the tunnel) is worked by a Claude CARRIER and, sometimes, a second Claude builder — on ONE vault, through the bus, with the operator holding the gavel. The base mechanics (verbs, exit codes, vault, lock) are the GUIDE and user-run; this chapter is the multi-party discipline laid over them.`
`born: the KEEP'd per-bed protocol tunnel-using-protocole.md (nablarva-X0-restarted, closed GO+KEEP 2026-10-07). That file is the worked instance with this bed's fixed values; this chapter is the vendor-agnostic shape. Point at the bed file for a live example until it is pruned; point here for the law.`

## The seats

| call sign | runtime | holds |
|---|---|---|
| **head** | Codex, behind the tunnel | the work; one stored thread = one memory; reached only through the vault |
| **carrier** | Claude (the cSharp / status_owner) | mints bus numbers · runs the tunnel verbs · carries files unchanged · never summarises · never advances STATUS |
| **builder(s)** | Claude (living session or spawn) | author their own files; may `ask` the head on the SAME vault when the operator yields the slot |
| **witness** | a seat that authored none of it | fresh-eyes proof; spawned by the carrier or woken by the operator |
| **operator** | human | opens the table (law 2.4) · gavels · yields the carrier slot · runs interactive sessions the tunnel cannot |

One Codex head, **one vault file, one carrier** who owns the verbs. A second Claude seat is a guest on the carrier's vault, not a second carrier.

## The five rules (generalised from the KEEP)

1. **The address is per shell.** `TUNNEL_CODEX_STATE` lives in one shell; every agent Bash call is a fresh shell; so every tunnel command carries the export in the same call (`export TUNNEL_CODEX_STATE=<vault>; <verb>`). Operator terminal sets it once with `tn-use <bed>`.
2. **Who may run what.** `ask`/`send`/`steer` (spend quota) → the carrier, or a builder in a slot the carrier yielded. `resume`/`open`/`close` (contend for the thread, no quota) → the carrier only, between settled turns; `open --enable` is the operator's hand. `read`/`jq`/lock-check (free) → anyone, any time. No seat enables itself.
3. **One turn at a time; TUI or tunnel, never both.** The per-vault lock covers `ask`/`send`/`steer` through THIS vault only — not `close`/`resume`, not the Codex TUI, not a second vault. Before every turn: `ls "$TUNNEL_CODEX_STATE.lock"` → present = wait (exit 61 is not a retry signal). If the operator has the TUI open on the thread, no verb but `read`; returning to the tunnel: TUI `/exit` → carrier `tun resume` (a one-time writer-lock NOTE is normal residue).
4. **A turn.** Write the bus file FIRST; the tunnel message points at it and is **one line + a path, never a body** (every relayed word lands in the head's context — this is the single biggest token lever; a head filled to 81 % in 16 cycles on bodies, held near 56 % afterward on one-liners). Open every message with call sign + cycle. Long turn → background it; **never kill the driver** (that interrupts the server turn). Preserve the reply as a file before claiming the handoff. The last stdout line is `[usage: ctx=…/… (NN%) …]`; above ~80 % → tell the operator (reset is theirs).
5. **When it fails — `read` first, always.** Promote `read` from fallback to the first move after any timeout: `tun read | jq '.thread.turns[-1] | {status, completedAt}'` (free). completed → take it, never re-send · interrupted → one-line nudge, same cycle · unknown → hold. Exit 50 = reconcile mismatch (record both texts, read-back is truth) · 61 = wait · 13 = no vault in this shell · 30/40 = read then decide. **Unknown completion is not a retry signal.**

## Several seats, one head — the sharing rules

- **Share the vault file, never fork it.** Two Claude seats consult one head only by pointing `TUNNEL_CODEX_STATE` at the *same* vault — the turn lock then serialises them (second caller waits, exit 61). **Never two vaults on one threadId** (no shared lock; cross-host is this case by construction — forbidden).
- **The carrier owns numbering.** A guest builder does not mint bus numbers; it writes its RETURN at the reply path the POINT named and asks the carrier to carry it. A per-seat RETURN that needs its own slot gets a carrier-minted cycle, not a filename suffix *(open defect: the slice/suffix rule for per-seat RETURNs under one cycle — bus GUIDE, U13)*.
- **Design traffic by file; the wire is a consultation line, not a mailbox.** Claude↔Claude coordination goes through `_bus/` and mail-by-path, never through the head (every relay is a model turn in the head's context). The tunnel reaches Codex; it is not an outbound door to other Claude seats.
- **Every message names its sender and cycle.** The head sees one conversation; the files say who wrote what, the wire does not.

## The approval blind spot (state it, do not trip it)

A head running `approvalPolicy: on-request` behind the tunnel has nobody to answer an escalation, so the shim declines it and the command **fails silently**. Until closed:
- Writes stay inside the head's workspace root; a POINT's `permitted_writes` is a cooperative fence, not an enforced one (adding `writable_roots` only *adds* — it cannot narrow an existing repo root).
- **Every POINT asks "name any refused command"; every RETURN answers** (`none` is an answer). That line is discipline covering a hole, not the hole closed.
- Approval policy is a **binding decision per head** (write it in the agent's binding — `/guide germline-forge`), not a transport default: a head expected to write autonomously is bound `workspace-write` + `approval never` rooted at its bed; otherwise keep `on-request` and keep the refused-command line mandatory.

## Re-entry — the cold-start regime

A multi-seat tunnel session re-enters through cold-start cards, one per living seat, committed in the session that writes them (an uncommitted card gets swept — observed): **head card · carrier card · builder card**, plus one regime line naming who carries · who mints · who witnesses · who is spawn vs living. Each card: `resume:` (how the seat is woken/spawned), what is DONE (don't redo), what the seat may be asked (its rows), and `pointers:` into the live RUNBOOK/STATUS. Law: `/guide cold-start-card`. A reset (head over ~80 %) re-briefs the fresh head from its card + the last few bus files — not from the dead thread.

## Two builder-seat kinds — declare at bed open

- **spawn** (default) — a bounded builder spawned by the carrier: no watchers, no tunnel, one assigned slice, hand back. Cheapest; cannot witness its own work; cannot watch a design across cycles.
- **living** — a session the operator wakes: carries watchers, may hold a yielded tunnel slot, challenges a design across rounds. Use only when a RUNBOOK says a round needs independent watching. Declaring the kind at bed open turns "spawn or living?" from a judgement under load into a line in a file.

## Lineage — point, never copy

Worked instance (fixed values, this bed): `nablarva/.dev/session/nablarva-X1-architecture/tunnel-using-protocole.md` (KEEP'd; born in X0, closed GO+KEEP 2026-10-07). Exchange semantics: HANDSHAKE §TABLE. Build discipline for the bindings the approval section names: `/guide germline-forge`. Bus shape: `/guide bus`. On any codex-cli upgrade the turn-lock and spawn facts are weather (L8) — re-verify with one live round-trip.
