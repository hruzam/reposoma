# Decision Record — Cross-machine mail transport: completing `_mail` direct-inform (part 4)

`status: GAVELED-BY-OPERATOR 2026-07-02 (@majkee). Two @Janus passes folded (pass-1 → append-only inbox; pass-2 → distributor=notifier-not-carrier). Post-review amendments R-a/R-b/R-c gaveled 2026-07-02 (advisor-high whole-scope review + disposable spike; L1–L10 unchanged). Append-only once committed (doctrine §1b). COMMIT GATE = conscious acceptance of the twin re-ring ONLY — 0009 L5 real-fire is PAID (probe re-verified green + deliberate-red 2026-07-02). index.md row 0010 written to working tree; commit follows on the re-ring go.`
`date: 2026-07-02 · host: office · extends 0008 (transport doctrine). Guards checked clean: 0008 (no-central-bus / F3) · 0007 L3 (discovery-only, no callable column) · registry Force-4 (no write into another project's canon).`
`shape: light ADR — context · locked shape (L1–L10) · post-review amendments · consequences · residual`

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

## Post-review amendments (gaveled 2026-07-02 — @majkee)

*Source: an `advisor-high` (Fable) whole-scope review + a disposable end-to-end spike (@Trajectory), both
2026-07-02. Neither changes L1–L10; these are residual/sequencing refinements that protect the North Star
("do not build a second parallel system per project").*

**R-a — the supersession is double, and named.** When the 0010 transport is built it supersedes BOTH
(i) the per-message `.md` inbox store (current `temple-mail`) AND (ii) the doorbell's *pushed-ring* delivery
(`temple-doorbell.zsh` writing via `temple-mail`), which L7 replaces with a boot-time query. Until the
transport lands, the live file-based tools are **explicit stepping-stones** — safe in the interim precisely
because reposoma `_mail` is gitignored, so the file model's move/delete drain semantics only break
*cross-machine*, which is exactly 0010's scope.

**R-b — part-3 binds to the tool interface, never the storage layout.** The twin read-side rollout (part 3)
MUST adopt the interface `temple-mail-inbox <origin>:<seat>` with zero path/format knowledge — never the
layout (`glob _mail/<agent>/inbox/*.md`, presence = unread). This makes the eventual `.md`→jsonl swap a
**single-tool internal change** (one edit, no per-twin re-rollout) and is the structural reason the interim
format cannot ossify into a per-project second parallel system.

**R-c — append-only does double duty (spike-confirmed).** Disposable spike, 2026-07-02: per-writer
partitions make concurrent state-transitions structurally non-overlapping (Scenario B — two hosts archiving
the same message, each to its own partition → **clean merge**, fold = archived). In-place mutation of a
shared record **conflicts** (Scenario C — literal git conflict markers) = the empirical justification for
L3. Even same-partition appends from two hosts merge cleanly because append-only content is purely additive
(line-diff, no edits to existing lines). Fold-as-view (L5) and doorbell-as-query (L7) both validated, no DB.

---

## Consequences

- **Closes task-1 part 4** (the delicate one). Part 1 (mail) is LIVE. Part 2 (doorbell) is built + hook
  installed + **verified firing** (see below). Part 3 (twin read-side rollout) remains residual — now
  constrained by R-b.
- **COMMIT GATE (reduced to one call).** Committing under `temple/decisions/` re-rings every stale twin —
  which is the doorbell's *intended* job. The doorbell real-fire is now **VERIFIED**:
  `~/.config/zsh/ai/doorbell-smoke.zsh` re-ran **green + deliberate-red on 2026-07-02** (@Delta, exit 0,
  zero residue; dry-fire confirmed it would ring the 5 stale twins with `canon=decisions@2026-07-02`). So
  **0009 L5's owed real-fire is PAID.** The only remaining gate is **@majkee's conscious acceptance of the
  twin re-ring** (low-stakes: the twins already hold unread rings and cannot consume them until part-3
  read-side adoption). Houston has no Bash → the commit is handed to @Delta on the go.
- **@majkee's MariaDB mail-MCP stays valid** — with L6 applied (distributor demoted to notifier).
- Extends 0008; guards 0007 L3 + registry Force-4 checked clean (an inbox is a receive-buffer, not canon;
  the message is inert until the receiver drains it).

---

## Residual / next

1. **Doorbell real-fire (0009 L5) — PAID.** The probe `ai/doorbell-smoke.zsh` was already BUILT 2026-06-27
   and re-verified green + deliberate-red 2026-07-02 (@Delta). No build owed. *(Correction: earlier memos
   wrongly carried this as "build the probe / unbuilt" — the source file on disk was the truth. Trust disk
   over carried-forward text on tool state.)*
2. **Twin read-side rollout (part 3)** — per **R-b: bind to the `temple-mail-inbox` interface, never the
   layout.** The twin-pass draft's Action A (@majkee-by-hand first adoption); @Janus's 5 OQs on that draft
   still owed before dispatch. Sequencing note (R-a): interim file-format coexists safely until the
   transport is built; do not let part-3 bake the layout in.
3. **Address-book beacon** — draft the addresses-only discovery surface (L8) when part 3 lands.

*Next: @Delta commits 0010 + index row 0010 (and the now-unblocked 0009 row) once @majkee gives the
twin-re-ring go. @Janus FINAL-confirm on 0009 optional (its L5 is now satisfied).*
