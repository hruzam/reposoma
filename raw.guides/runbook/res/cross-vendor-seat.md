---
title: A cross-vendor seat in the session
chapter-of: runbook
---
# RUNBOOK · res — a cross-vendor seat in the session

`what: how a seat from the OTHER runtime (today: Codex) appears in RUNBOOK · STATUS · the file set.`
`scope: extending chapter of raw.guides/runbook/GUIDE.md — session-shape doctrine only. What the tunnel IS`
`(mechanics, TABLE semantics) is co-owned by the cross-vendor line: ~/ia-sync/HANDSHAKE.md §TABLE +`
`raw.guides/tunnel/GUIDE.md. Point there; a change to exchange semantics goes through the HANDSHAKE`
`revision flow first, then this chapter repoints.`
`status: DRAFT — awaiting majkee gavel (authored 2026-09-03, session roster-reform-01-triad; sources:`
`Oraculum reply Q1–Q4, Cartan counter-sign r3)`

## The participant tuple declares the instrument

```yaml
participant_N: [seat, {brand, model, effort}, host, instrument]
```

`instrument` is fixed at authoring in the same sense `host` is: it sets the exchange contract every
other participant plans around. Exactly four nouns exist — grow by promotion, never by design:

| instrument | contract the others plan around |
|---|---|
| `tunnel` | living stored thread · one RETURN per tunnel **cycle** (open → work → close), not per send |
| `mail` | async by path · Delivery rule (HANDSHAKE r1) — stamp or worked reply is the receipt |
| `relay` | one-shot, verbatim in / verbatim out (`@vega` blind · `@mirror` adversarial) |
| `resident` | co-seated in the repo (`cd ~/ia-sync && codex`) — reads the same files, no transport |

Claude↔Claude seats carry no instrument (native). **An instrument does not change inside a live
RUNBOOK** (Cartan amendment 2): instrument failure or unavailability lands in STATUS `holds:` with
evidence, but *continuing* through another instrument changes the fixed exchange contract and requires a
numbered sibling session. An emergency failure notice may travel by mail without silently converting the
session itself to `mail`.

## The state handle — in place, never in git

A tunnel's state file is a **machine-local handle** beside its owning RUNBOOK, borrowing its slug and
lifecycle. **Two births, kept distinct** (Cartan amendment 1): the handle is created by the operator's
`open --enable` — an enabled table with no thread yet; the stored Codex **thread is born on first
`send`**, and the zero-turn boundary between them is part of the proven mechanism. Removed by `close`
before the session closes or is pruned, **never committed** — the thread lives in that host's `~/.codex`;
committing the
handle would advertise a thread the other host cannot resume. After `git pull` the other host sees
nothing, and that is correct: STATUS carries the fact (*"table open on office · handle `<path>`"*).
Hygiene: one `**/tunnel.state.json` line in the project gitignore. A second host opens a new table;
RUNBOOK · STATUS · evidence · git carry the shared truth. (Cartan r3, verbatim doctrine.)

## The record — transport is not the receipt

Tunnel = transport. `_bus/` (or the bed's receipts) = record. The reconciled read-back proves
*transport integrity* only; the thread sits in vendor retention (archive/delete lifecycle, weather).
Provenance that must outlive retention or cross hosts goes to file — HANDSHAKE §TABLE: *"a TABLE
exchange still lands its durable outcome as files, and the Delivery rule applies."* Live precedent:
termbrana t3 receipts promoted to `…/evidence/t06-tunnel-v0-roundtrip.md`; the thread may vanish,
the record stands.

## The enable — three layers, each in its own tense

Law 2.4: the human opens the table; no seat enables itself. It appears three times, not once:

- **participant** (fixed): `[@majkee, human, office + home]` with the role *tunnel enable gavel*;
- **known constraint** (fixed): one line — *no seat opens the table; the enable is the operator's hand*;
- **STATUS `holds:`** (live, only while a table is OPEN): *table open at `<handle>`; no second open;
  close before the session closes, is pruned, or deliberately relinquishes the table — **not** before
  every ordinary seat yield; stored-thread continuity across calls is the instrument's purpose* (Cartan
  amendment 3) — retyped while true, gone when closed.

## Not in this chapter

Exit codes, verbs, steer limits, writer-lock rules → `raw.guides/tunnel/GUIDE.md`. Meeting shapes
(POINT · RETURN · CHALLENGE · TABLE) → HANDSHAKE. Which Codex posture to wake (octopus · medusa ·
polyp · astrobley) → `codex-harness/references/cross-runtime-roles.md`.

## Counter-sign — @Cartan

**Verdict: COUNTER-SIGN WITH THREE AMENDMENTS.** The participant tuple is the right fixed home
for the exchange instrument: it makes every seat plan against the same transport obligation
without turning transport state into session authority. The separation between transport,
receipt, and durable record also holds.

1. The machine-local **state handle is created by operator `open --enable`**; it initially
   carries an enabled table with no thread. The stored Codex **thread is born on first `send`**.
   Keep those two births distinct—the zero-turn boundary is part of the proven mechanism.
2. An instrument does not change inside a live RUNBOOK. Instrument failure or unavailability
   lands in STATUS `holds:` with evidence, but continuing through another instrument changes the
   fixed exchange contract and requires a numbered sibling session. An emergency failure notice
   may travel by mail without silently converting the session itself to `mail`.
3. While TABLE is open, STATUS should require one handle/host and forbid a second open. Close it
   before the owning session closes, is pruned, or deliberately relinquishes the TABLE—not before
   every ordinary seat yield. Stored-thread continuity across calls and incarnations is part of
   the instrument's purpose.

The owner-bound placement stands: the ignored handle belongs beside its RUNBOOK/process, borrows
the existing slug and lifecycle, and creates no second project registry. It is operationally
visible but never citable truth; another host opens its own TABLE while RUNBOOK, STATUS, evidence,
and git carry shared continuity. A free-floating long-lived handle pool remains outside v0.

`[2026-09-03 · codex/cartan · gpt-5.6-sol]`
