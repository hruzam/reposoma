# Temple audit loop — the standing card (DRAFT — gavel-pending)

`tier: raw.guides · status: DRAFT (Oraculum, 2026-07-03) — @majkee gavels before this becomes practice`
`produces: one mail report to the architect seat + a gavel list. The audit itself NEVER edits canon.`
`first run: 2026-07-03 (Oraculum) — report: _mail/houston/inbox/oraculum.temple-audit.2026-07-03.md`

## Invariants (the leash)

- **Auditor ≠ receiver**, by incarnation minimum. Context isolation is real; the shared MEMORY.md node
  per project-dir is not — the mail report is the only clean transfer artifact.
- **The audit writes nothing into canon.** It files mail + drafts. Fixes happen post-gavel in
  **separated, reversible commits — one concern per commit** (rollback isolation; Janus 2026-07-03).
- **Challenge before report:** @Janus attacks the hypothesis set (with disk access) before it reaches
  the receiver. Hypotheses, not conclusions.
- **Blind before grounded (Force 5):** sweep agents get scope, never the auditor's leanings; any
  second-brand voice (Gemini via operator buffer) gets the *cold* brief, never the findings. Reconcile
  convergence/divergence after.

## The three axes

- **VERTICAL** — one project through all layers: contract → beacon → index row → intake → its decisions.
  Drift shows as *disagreement between copies* (e.g. a status stated 3× that reads 3 ways).
- **HORIZONTAL** — one invariant across the whole circle: pick a lock (point-never-copy · §4.7 ·
  tense rule · append-only) and check every project against it.
- **STRESS** — deliberate-red (0009 L5 spirit): plant one dead pointer / one fake in-place ADR edit in a
  sandbox; the loop (or the gate) must catch it. **An audit that cannot fail is show.**

## Standard loop shape (as run 2026-07-03)

1. Auditor canon read — saddle order first, then what the saddle *skips*.
2. Two blind parallel sweeps: **chain-integrity** (every pointer resolves? orphans? host-leaks?) ·
   **duplication/context** (copies · archive candidates · re-entry line counts vs target).
3. Auditor folds into a hypothesis set, three bins: *lapsus* (meaning conflicts) · *chain* (untrackable
   without external help) · *compression* (context economy).
4. **@Janus challenge:** per-hypothesis verdict + the single weakest assumption + the alternative.
5. Optional second brand: operator carries the cold brief to Gemini; fold as ground *after* findings freeze.
6. File the report → architect inbox (mail convention) + gavel list for the operator.
7. Post-gavel: separated commits. Distribution is **observed** on the real doorbell (a `decisions/` commit
   rings it naturally) and **verified** separately on disposables — the doorbell-smoke probe + one throwaway
   probe mail per circle inbox through the `temple-mail-inbox` interface (0010 R-b). Never test-fire on
   production canon.

## Cadence + reminder

- **Full loop:** semi-annual or annual — operator's call. The reminder should **ride `temple-recalibration`
  (tools.md #7)** as an audit half-life entry dropping into `_mail/toAll/inbox/` (the 0003-pattern native
  script — NOT a vendor hook). #7's timer is still pending: if a cron gets built, it should *be* that
  trigger — one timer, two duties. No second automation layer.
- **Chain-integrity alone is mechanizable:** a deterministic script (same family as the proposed
  `adr-guard` gate) costs zero agent tokens once written — can run monthly or per-commit.
- **Enforcement beats cadence:** the `adr-guard` commit gate (Janus alternative, 2026-07-03) catches the
  worst class (in-place ADR edits · inbox-path citations) at write time. The periodic loop then hunts what
  a gate can't: meaning conflicts and context bloat.

## Open (not yet gaveled)

- `adr-guard` gate build — the enforcement arm this card assumes (gavel G3 in the 07-03 report).
- Second-brand pass: default-on vs on-request.
- Cadence pick + whether the reminder rides #7 (recommended) or a standalone cron.
