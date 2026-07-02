# Decision Record — Cross-machine mail transport: completing `_mail` direct-inform (part 4)

`status: GAVELED-BY-OPERATOR 2026-07-02 (@majkee). Two @Janus passes folded (pass-1 → append-only inbox; pass-2 → distributor=notifier-not-carrier + 0007/registry-F4 cleared). Append-only once committed (doctrine §1b). COMMIT GATED — see Consequences (0009 L5 doorbell real-fire + re-ring warning). index.md row 0010 written to working tree; commit follows at the gate.`
`date: 2026-07-02 · host: office · extends 0008 (transport doctrine). Guards checked clean: 0008 (no-central-bus / F3) · 0007 L3 (discovery-only, no callable column) · registry Force-4 (no write into another project's canon).`
`shape: light ADR — context · locked shape (L1–L10) · consequences · residual`

---

## Context

The four-part "direct-inform" mechanism over `_mail` (piql.dev:houston brief, 2026-06-29) was complete
in doctrine for parts 1–3 but **part 4 — cross-machine carry — was the delicate unresolved one.** reposoma
gitignores `_mail`, so temple mail does not travel office↔home; the obvious fix ("flip reposoma/_mail to
tracked") was pre-flagged by @Janus as **B-flavored coupling** — it reintroduces the central-bus hazard
0008 locked against and piql STOPPED at F3 (over-fitting ia-sync's *append-only* clean-merge onto a
*stateful mailbox* with delete/move semantics). @majkee proposed a central mail DB + sync script; two
@Janus passes converged it to the shape below. This record locks part 4.

---

## Locked (the shape)

**L1 — Invariant (from 0008, closed here for cross-machine): file-native · receiver-owns · no-central-bus.**
The cross-machine question is answered without a shared mutable store.

**L2 — Per-writer append-only partitions.** Each writer appends to a jsonl partition it single-owns
(`inbox/<recipient>/<writer>.jsonl`); the recipient's mailbox is a **read-time union** of partitions.
There is no shared write surface on any host or across hosts. This is the repo's pulse-bus pattern
("owned files → collision-free", gaveled 2026-06-19) applied to mail.

**L3 — State transitions are appended events, never in-place mutation.** "archived" (and any status) is a
**new appended event**, never an in-place edit or `git rm` of the record. Current state = fold the log
(any `archived` event wins). Resolves to **receiver-owns-the-drain, every-writer-owns-its-write** — the
property that makes concurrent cross-machine drain merge cleanly.

**L4 — pc-to-pc transport = git.** Append-only + per-writer partitioning ⇒ trivial merges; no new
transport primitive is invented. (rsync/syncthing of append-only files would also work; git is already
present.)

**L5 — MariaDB = project-local materialized VIEW only.** Rebuilt by replaying the synced log; **never
synced, never a source of truth.** This resolves "DB or jsonl?" as *layered* (log = wire/truth, DB = local
read-model). The DB is the queryable projection — what a DB is good at — not the transport unit.

**L6 — Failover distributor = NOTIFIER, not carrier (the pass-2 revision — the one back door closed).**
The MCP's failover "agent distributor" may only **read** the view to decide "seat X has unread mail and is
booting on host Y → ring the doorbell there." It **MUST NEVER originate, hold, or forward message
content.** Content enters the system through exactly one door: a writer's own partition-log append,
git-transported. If failover must "deliver" while git is degraded, it does so by writing a normal
sender-side partition append and letting git reconcile later — the DB never holds the authoritative
envelope. Failover is a **redundant doorbell, not a backup bus.** This keeps "DB = pure read-projection" a
structural fact, not a promise about the distributor's behaviour.

**L7 — Doorbell = boot-time query against the git-synced log, not a pushed signal.** Every host's boot
sequence: replay synced log → materialize view → query "unread for me?". The notifier *reads* the log; it
does not *carry* the wake (a pushed signal can land on the wrong host and be missed).

**L8 — Address book = discovery-only, addresses-only.** who↔whom addressing may live in the registry
(0008's "one address book"). It **MUST stay addresses-only.** If it grows into routing/capability that a
sender *acts on* without local verify, that is callable-column creep = a **0007 L3 breach** (cross-project
copy is discovery-only by construction; no callable column syncs). Hold the line.

**L9 — GC/compaction = single-actor per-partition pass.** Never a side effect of "mark read": a
prune folded into a receiver's drain gets resurrected by git from the other machine's copy. Compaction is
a separate, coordinated, single-owner pass per partition.

**L10 — sender/receiver = per-project (receiver-owns); NOT a registry-wired callable transport.** Building
a project-local sender/receiver is fine (mailing-not-canonical, last-tier). Wiring a callable
sender/receiver *through* the registry is the central bus reborn (0007 L3) — forbidden.

---

## Consequences

- **Closes task-1 part 4** (the delicate one). Part 1 (mail) is LIVE. Parts 2 (doorbell real-fire) and 3
  (twin read-side rollout) remain **residual implementation**, tracked separately — this record locks the
  *doctrine*, not those builds.
- **COMMIT GATED.** Committing under `temple/decisions/` re-rings every stale twin, and the relocated
  doorbell's real-fire is still OWED (0009 L5 smoke-probe unbuilt). This record + the index row are written
  to the working tree now; the **commit waits on the 0009 L5 gate** (or a conscious acceptance of the
  re-ring). Houston has no Bash → the gated commit is handed to @Delta.
- **@majkee's MariaDB mail-MCP stays valid** — with L6 applied (distributor demoted to notifier).
- Extends 0008; guards 0007 L3 + registry Force-4 checked clean (an inbox is a receive-buffer, not canon;
  the message is inert until the receiver drains it).

---

## Residual / next

1. **Doorbell real-fire (0009 L5 smoke-probe)** — build + dry-fire + deliberate-red before the doorbell is
   trusted; also gates this commit.
2. **Twin read-side rollout (part 3)** — the twin-pass draft's Action A (@majkee-by-hand first adoption).
3. **Address-book beacon** — draft the addresses-only discovery surface (L8) when part 3 lands.

*Next: @Delta commits 0010 + index row 0010 once the 0009 L5 doorbell real-fire clears (or the re-ring is
consciously accepted). @Janus FINAL-confirm optional (both passes already folded).*
