# Twin read-side binding spec (T1) — part-3 boot-step adoption, interface-bound (DRAFT)

`status: DRAFT — Houston DRAFTS → @Janus challenged 2026-07-09 (REVISE, folded) → @Delta verified the contract 2026-07-09 → @majkee gavels → dispatch. Locks nothing; writes no twin surface.`
`owner: temple architect (Houston) · date: 2026-07-09 · host: office`
`scope: T1 of the oraculum-mail task line (sequence LOCKED 07-09; T2 gaveled = wait-for-the-wall). The read-side BINDING CONTRACT only (Action A). NOT the Action-B canon-alignment pass.`
`grounds-on: LOCKED 0010 (esp. R-b, R-a, L7) · 0008 L1/L2/L7 · AGENTS.md "Sit in saddle" step 5 · _mail/README.md (presence-only, ask-first).`
`supersedes: Action A of twin-propagation.read-side-step.pass.draft.md (2026-06-29, PRE-0010) — that draft stays on disk as history; its OQ5 is now RESOLVED by 0010; Action B (canon alignment) is out of T1 scope.`
`resolves: 0010 residual item 2 (twin read-side rollout, R-b-bound).`
`depends-on: temple-mail-inbox.contract.draft.md (deliverable-0, §0) — the citable, @Delta-verified interface contract this whole spec binds to.`

> **What this is.** The interface contract each twin's boot/saddle doctrine adopts so it reads its OWN
> inbox on boot — via the tool interface, never the storage layout. When a twin adopts, it consumes its
> doorbell ring; the re-ring stops accumulating. This closes the one-directional temple→twin mail/ring
> transport into a round trip. It is a doctrine-adoption spec (Action A), not the canon-alignment pass.

---

## 0. Deliverable-0 — the citable interface contract (added post-@Janus, 2026-07-09)

@Janus's REVISE verdict found the load-bearing hole: the spec told twins to "bind to the
`temple-mail-inbox` interface," but **that interface had no citable contract** — its spec home
(`tools.md:16` → `transport-and-doorbell.run2-and-circuit.md`) is a dangling pointer (file cut, gone). An
interface you cannot cite is one each twin's architect reconstructs from the example string → divergent
adoptions → the "second parallel system" R-b exists to prevent, arriving via under-specification instead of
a layout glob.

**Fix (T1's FIRST deliverable):** `temple-mail-inbox.contract.draft.md` — the restored, focused spec home:
call · returns · semantics · address-derivation · **empty/error exit behavior**. **@Delta verified it
against the on-disk script 2026-07-09** (signature `<origin>:<seat>`; `INBOX … — N unread` filename-only
listing; empty→silent/exit0; errors exit 1 & 2; read-only; layout encapsulated → R-b holds by
construction). Owed: **@majkee gavels + re-points `tools.md:16` to it.** **Everything below cites that
contract by path; it does not restate it.**

## 1. The binding rule (R-b, made enforceable)

- A twin's boot doctrine binds to the **contract** `temple-mail-inbox.contract.draft.md` (once gaveled), via
  the call `temple-mail-inbox <this-origin>:<this-seat>`.
- **FORBIDDEN:** any `glob _mail/<agent>/inbox/*.md`, any path/format knowledge, any presence-by-file-listing.
  That is the *layout*; R-b bans it. Binding to the contract makes the `.md`→jsonl storage swap (0010) a
  **single-tool internal change** — one edit, zero per-twin re-rollout.

## 2. The invariant to land in each twin (tight invariant, loose craft)

- **INVARIANT (fixed, temple-owned):** on boot/saddle, the seat runs `temple-mail-inbox
  <this-origin>:<this-seat>` (+ `toAll`) **per the cited contract** — presence-only, ask-first; empty →
  silent, carry on. If items are present, surface *"I see inbox/toAll items — read them now, or is this a
  quick run?"* and **ask before reading**.
- **CRAFT (loose, twin-local, SOVEREIGN):** the exact wording, and *where* in its own boot sequence the step
  sits. Never temple-written (0008 L2 flag-by-default + Force 4 — the boot file is the twin's sovereign
  surface). The twin's own architect adopts and words it locally.

## 3. The stamp / gate (how re-rings stop — the T1 gate made verifiable)

- **Adoption stamp:** on adopting, the twin records a stamp in its OWN boot doctrine, e.g.
  `mail-readside: adopted @ decisions@<snapshot>` (local wording is craft; the *presence* of a stamp is the
  invariant).
- **Gate (revised post-@Janus — verifies CONTRACT-ADOPTION, not just string-presence):**
  1. the twin's boot/saddle file **invokes `temple-mail-inbox <origin>:<seat>` AND cites the contract doc**
     (path reference) — so a divergent re-implementation of the contract fails the gate, not just a missing
     call; NOT a layout glob; and
  2. the twin no longer accumulates unread doorbell re-rings — because its boot now drains its inbox
     (0010 L7: boot-time query against the synced log; a drained seat reads as `stamp≠<none>`).
- **Today's stale set (context):** 5 real doorbell rings sit unread in the twins' `_mail/houston/inbox/`
  (`stamp=<none>`, maximally stale). A twin consumes its ring only once its boot reads its inbox. Adoption
  is what stops the accumulation.

## 4. Dispatch shape (post-gavel — NOT executed in this spec)

The **write into a twin's sovereign boot file is not a temple write** (Force 4). So dispatch splits
(@Janus confirmed this split is sound; "@Trajectory/@Delta implement" = build the temple-side kit, not
write the twin's file — no Force-4 breach):

- **(a) Temple-side, @Trajectory/@Delta implement — the reusable ADOPTION KIT:** the canonical boot-step
  snippet (interface call **citing the contract** + ask-first surface + stamp line) as a paste-in block,
  plus a one-line per-twin adoption instruction, plus a verify (the two §3 gate conditions). Temple owns the
  *kit*, not the per-twin edit.
- **(b) First adoption per twin = bootstrap, out-of-band (0010/Stage-0):** @majkee carries the step by hand
  once per twin — a twin needs the step to read the mail that would carry the step (chicken-and-egg). After
  the first adoption, the twin's boot is self-sustaining and future doctrine rides the mail transport.
- **(c) Subsequent per-twin landing:** each twin's **resident architect** (or a dispatched agent given the
  twin folder) pastes the kit into its own boot file and words the craft locally. Temple/@Delta do **not**
  reach cross-repo into a twin's sovereign surface.

## 5. What is IN vs OUT of T1

- **IN:** deliverable-0 the citable contract (§0) · the binding rule (§1) · the boot-step invariant (§2) ·
  the stamp/gate (§3) · the adoption-kit + bootstrap dispatch shape (§4).
- **OUT (separate threads, do not blur — the @Janus conflation guard from 0008):**
  - **Action B — canon-alignment propagation pass** (diff twin agent surfaces vs 0006/0007, flag-by-default).
    That is the broader propagation thread, gated on reconciling the stale pre-0008 generic prompt
    (`propagation-pass.prompt.draft.md`). NOT T1.
  - **Address-book beacon** (0010 L8, addresses-only) — 0010 residual item 3, "when part 3 lands."

## 6. @Janus challenge (2026-07-09) — verdict + fold

- **Verdict: REVISE** (spine sound; one structural fix).
- **Weakest assumption (folded, §0):** the interface had no citable contract → R-b was a slogan, not
  enforceable; the old gate verified string-presence, not contract-adoption. → deliverable-0 + gate rewrite +
  @Delta disk-verification.
- **Q1 placement → A1 CONFIRMED:** boot step rides the mail transport as a doctrine-adoption flag, outside
  propagation (keeps 0008 L4's fence tight). Do NOT extend L4 for a one-time adoption.
- **Q2 bootstrap → CONFIRMED:** majkee-by-hand first adoption is the honest Stage-0 seed.
- **Q3 Force-4 seam → NON-ISSUE:** the §4 (a)/(c) split is correct; "implement" = build the kit.
- **Q4 R-b sufficiency → DISSOLVED:** the contract exists (§0), @Delta confirmed the layout is encapsulated,
  and the §3.1 gate now catches worded-craft divergence by requiring a contract citation.

---

*Next: @majkee gavels the bundle — (1) contract doc, (2) re-point tools.md:16, (3) this spec — THEN
dispatch the adoption kit + bootstrap (piql first — lightest, already reconciled; then the 4 first-pass
twins). Mind the re-ring warning (0010): until a twin adopts + stamps, any commit touching
`temple/decisions/` re-rings it.*
