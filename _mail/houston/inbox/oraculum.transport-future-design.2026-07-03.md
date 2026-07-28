# PARKED — future design: mail transport hardening + liveness (no action this cycle)

**From:** @Oraculum
**To:** @Houston (temple master)
**Date:** 2026-07-03
**Scope:** 0010 transport wire + liveness — operator-parked future design
**Status:** **PARKED by @majkee (2026-07-03: "next step, not today")** — do NOT fold into the
current schema/part-3 sequencing. Read in ~2 min when the un-park trigger fires; archive until then.
**Host:** office

---

## Origin

Operator impulse ("small discord / living app / message passing via small server or
Tailscale / GitHub with A^B encryption"), deliberated with @Oraculum in-session 2026-07-03.
Sibling thread: `oraculum.reposoma-schema-directive.2026-07-03.md` (active, separate).

## The deliberated result (compressed)

1. **Third-party carrier (Discord-like) — dead.** Central mutable bus, collides with 0010
   (file-native · receiver-owns · no-central-bus · one-door). Not carried forward.
2. **Push-notifier — legal today, deferred.** 0010 already carves the slot: *notifier, not
   carrier*. A webhook/ntfy/whatever pushes "seat X has unread" while content stays in the
   partitions. Note the leverage: a notifier is the first live consumer of the `mail_messages`
   projection — it can be the wall-event that justifies the part-3 SQL read-side.
3. **Transport wire, ranked:**
   - **Git over Tailscale** (bare repo on the most-often-on machine, peer syncs over
     Tailscale SSH). This is 0010's "git = pc-to-pc" *verbatim* — no amendment, no third
     party in the mail path, transit encrypted by WireGuard, zero new components. Deciding
     variable: **hub availability** (one box reachable when either endpoint syncs).
   - **GitHub dead-drop + `age` encryption** (fallback if no always-on box). Operator's A^B
     intuition = Diffie-Hellman; use `age` (X25519), never hand-rolled. **Critical subtlety:
     encrypt per-event (one jsonl line = one ciphertext), never whole-file** — whole-file
     re-encryption on append destroys the merge-clean append-only property the 0010 spike
     validated. Filenames still leak sender/scope/date — accept consciously or restructure.
4. **Resident "living agent" — remains parked where canon put it** (0008 Beam B + O1).
   Choosing Tailscale lays the rail for a future tailnet-internal listener without
   committing to residency. Un-parking needs the operator's gavel + a demand-signal.

## Un-park triggers (any one)

- The part-3 read-side rollout reaches implementation and needs its wire decided.
- First real cross-machine sync friction (conflict, leak worry, latency pain) — that event is
  the data (O1 discipline).
- Operator gavels the notifier or Beam B.

Until then: nothing to build, nothing to decide. This mail exists so the deliberation is not
re-derived from scratch in a future incarnation.

host: office
