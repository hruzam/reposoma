# Goal-completion report — 0008 Stage-1 transport + circuit characterization

`status: SUBSTANTIVELY DONE — one gavel-gated step remains to close task-1's round-trip (consolidation by Houston.temple, 2026-06-25) · host: office · goal: ~/.claude/houston.goal (authorized @majkee, human gate cleared)`
`role note: this is a CONSOLIDATION, not a re-verification. Houston holds no Bash and re-ran nothing — each PASS below is attributed to the implementer run that produced it. The one fact Houston verified directly is file-presence of the installed hook (Read of .git/hooks/post-commit) and the absence of any saddle-boot inbox-read step (Grep).`
`sources folded: transport-and-doorbell.build-report.md (Run 1) · transport-and-doorbell.run2-and-circuit.md (Run 2) · circuit-characterization.2026-06-25.md (Vara probes) · tools.md (Tier-S registry)`

> The autonomous goal named two real Stage-1 tasks (read-side wiring · recalibration notifier) and asked
> the bounded build→test→fix→report circuit to measure loops-to-converge per difficulty tier. Both
> *mechanisms* shipped and verified; the circuit was measured per tier and a failure-branch probe found a
> real escalation-rule bug. **Task 1's defining behavior — "the boot READS its inbox, completing the
> round-trip" — needs one saddle-doctrine step that is canon, so it is drafted here for @majkee's gavel,
> not self-applied.** This report answers the goal's REPORT section in one place.

---

## Completion ledger (honest headline)

| goal task | mechanism | activation / wiring | status |
|---|---|---|---|
| **1 — read-side wiring** | `temple-mail-inbox` built + verified (Run 2) | **saddle-boot must CALL it, ask-first — drafted below, pending gavel** | **round-trip closes on gavel** |
| **2 — recalibration notifier** | `temple-recalibration` built + verified (Run 2) | recalibration schedule (operator, non-sudo) — pending | mechanism done; activation pending |
| circuit characterization | — | — | done (measured per tier; failure branch probed) |

Two activation switches sit in parallel: the **doorbell hook = thrown** (verified live), the **recalibration
schedule = pending operator**. Task 1's wiring is a third, and it is *doctrine* (Houston's lane), not an
operator switch — hence drafted, not punted.

---

## What was built · where it lives

All artifacts live in the **0003 machine layer** (`~/.config/zsh/`) — **NOT canon**, no `~/` paths bound into
any repo or beacon (§4.7 · 0004 L4). The only place physical paths live is P0.

| piece | logical tool | file (machine layer) | run | state |
|---|---|---|---|---|
| P0 project map | `temple-project-map` | `temple-project-map.zsh` | 1 | live |
| A mail primitive | `temple-mail` | `temple-mail.zsh` | 1 | live |
| B canon-doorbell | `temple-doorbell` | `temple-doorbell.zsh` (+ hook template) | 1 | **live — hook installed (verified, see below)** |
| **read-side (goal task 1)** | `temple-mail-inbox` | `temple-mail-inbox.zsh` | 2 | tool live — **boot-call drafted, pending gavel** |
| **recalibration (goal task 2)** | `temple-recalibration` | `temple-recalibration.zsh` | 2 | built — **schedule pending** (operator, non-sudo) |
| selftest harness | `temple-transport-selftest` | (proto-gate, #8 in tools.md) | circuit | live |

All registered in machine-layer `~/.config/zsh/AGENTS.md`. Tier-S registry: `temple/tools/tools.md` (DRAFT,
pending @majkee gavel — Force 4).

**Goal task 1 — read-side wiring (STANDARD).** `temple-mail-inbox <origin>:<agent>` resolves via P0, lists
UNREAD inbox items (presence = unread) + `toAll/` broadcasts, filenames only, **ask-first** — never
auto-reads. The tool is built and verified. **What remains to *complete the round-trip*: the saddle-boot
doctrine must actually invoke it** — see the drafted step below. (A silent shell auto-run is explicitly the
wrong shape: it would violate `_mail/README.md`'s ask-first token-economy rule. The right shape is a doctrine
step, surfaced to whoever boots the seat.)

**Goal task 2 — recalibration notifier (TRIVIAL).** `temple-recalibration` scans `raw.settings/raw.card.*.md`
for `verified:` + `half_life_days:`; when `(today − verified) ≥ half_life_days`, drops a dated
`recalibration-<date>.md` into `_mail/toAll/inbox/`. Built on **P0** + the doorbell skeleton — one author, one
notifier family (§4.4 coherence). Supersedes the 2026-06-19 Vega assignment by @majkee's go.

---

## DRAFT — saddle-boot read-side step (Force 4: Houston drafts, @majkee gavels; NOT self-applied to canon)

`AGENTS.md`'s "Sit in saddle" sequence currently reads `decisions/index.md → registry/index.md → the monkey
memo → temple/README.md` — there is **no inbox-presence step** (confirmed by Grep: `temple-mail-inbox` appears
only in tool reports + `_mail/README.md`, never in boot doctrine). Proposed addition to the saddle sequence —
a 5th step, honoring `_mail/README.md`'s ask-first rule:

> **5. Check your inbox (presence-only, ask-first).** Run `temple-mail-inbox <this-origin>:<your-seat>`. It
> lists UNREAD inbox items + `toAll/` broadcasts by filename only — it never reads them. If items are present,
> surface *"I see inbox/toAll items — read them now, or is this a quick run?"* and **ask before reading**
> (token economy, `_mail/README.md`). Empty → silent, carry on.

This completes task 1's round-trip at the level Houston operates: the mechanism (Run 2) + the doctrine that
invokes it. **On gavel, task 1 is fully done.** Until gavel, the tool is live but unwired at boot.

---

## Verify-it-fires results (attributed to the run that produced each)

| check | result | source run |
|---|---|---|
| A — message → `piql.dev:houston` lands at correct inbox path/filename, no sent-copy | PASS | Run 1 (@Trajectory) |
| B — stale (piql stamped current, vacuole no-stamp) → vacuole rung once, piql + reposoma NOT rung; residue cleaned | PASS | Run 1 (@Trajectory) |
| read-side — reposoma 2+1, piql 2+1, vacuole 0+1, unknown→err; ask-first held | PASS | Run 2 (@Trajectory) |
| recalibration — synthetic stale card detected + listed; clean state writes no file | PASS | Run 2 (@Trajectory) |
| selftest harness — 5/5 green, zero-residue by construction (sandboxed map) | PASS | circuit (H1, @Trajectory) |
| **doorbell hook installed + carries real guard logic** | **PRESENT — verified directly** | Houston Read of `.git/hooks/post-commit` |

**Hook status — settled (was a cross-source conflict).** tools.md reported the post-commit hook live;
Run-1/Run-2 reports and the prior rolling memo were written *before* the install and still say "pending."
Houston Read `~/reposoma/.git/hooks/post-commit` directly: the hook **is present**, guards on
`git diff-tree … | grep '^temple/decisions/'`, and invokes `temple-doorbell-run` in background (hook ≠ brain,
0008 L7). **The doorbell is live**; the three stale sources are superseded by this report. This matters
because the goal names a silently-dead script as THE failure mode for this class — so the live/pending line
was the one claim worth settling from primary evidence, not a contradicted secondary source.

---

## Iterations-to-converge per task (the circuit-capability data)

| task | tier | fix-loop cap | **iterations** | margin | outcome | source |
|---|---|---|---|---|---|---|
| read-side | standard | 4 | **3** | 1 | converged, PASS | Run 2 |
| recalibration | trivial | 2 | **2** | 0 | converged at cap, PASS | Run 2 |
| H1 — selftest harness | hard | 6 | **2** | 4 | converged, PASS | circuit (@Trajectory) |
| H2 — paradox probe (rung 1) | trivial-cap 2 | 2 | **1** | — | clean fast-stop, no false-pass | circuit (@Delta) |
| H2 — paradox probe (rung 2) | trivial-cap 2 | 2 | **1** | — | concurred (escalation should not have fired — see below) | circuit (@Vector) |

**Reading:** SUCCESS path validated across three tiers (trivial/standard/hard all converged inside cap).
STOP+report validated (H2 rung 1: @Delta fast-recognized impossibility, no false-pass — best-case failure
handling).

---

## Anything flagged or stopped

- **No sudo halts. No install halts.** Both go-live switches are non-sudo (hook install — done; recalibration
  schedule — pending operator). Nothing required a third-party install.
- **The real find — escalation-rule bug (surfaced by @Vara's own self-critique).** The circuit rule said
  "on cap-hit, escalate one rung" but was silent on *fast-recognition of impossibility*. @Vara escalated
  reflexively (Delta→Vector) when the correct terminal was **stop at Delta**, and reported its own error
  rather than hiding it (honesty-over-show). Rung-2 independence was therefore un-measurable (the escalation
  carried Delta's diagnosis → @Vector's concurrence is a rubber-stamp, not independent recognition).
- **Calibration items (recorded in `circuit-characterization.md` as next-run recommendations — NOT yet folded
  into live rules; folding is a gavel/operator action, surfaced here, not applied):**
  1. *Sharpen the escalation trigger:* "Escalate one rung ONLY on cap-hit-without-pass. Fast-recognition of
     impossibility (or a correct stop+report before the cap) is a TERMINAL stop — do not escalate."
  2. *Failure-branch probes carry NO prior diagnosis* — hand the next rung only the spec, to preserve the
     independence the probe measures.
  3. *Trivial cap = 2 ran with zero margin* (the 2nd iteration was a zsh `local-in-for` quirk, not logic) —
     consider trivial→3 for quirk-prone build tasks, or classify quirk-prone tasks as standard.
  4. *Verify-gap on H1:* harness was green-on-correct + nonzero-on-incidental-red, but no *deliberate* red was
     driven through each discriminator. One deliberate-red pass would fully close the verify gap.

---

## Net

The goal is **substantively done**: both named Stage-1 *mechanisms* shipped and verified, loops-to-converge
measured per tier, the failure branch probed (and it paid off — it found the under-specified escalation logic,
which is exactly what a failure-branch probe is for). @Vara coordinated the production topology
(Houston→Vara→implementers) and self-corrected transparently — a successful pilot exercise (D30).

**The one thing between here and "fully done":** task 1's round-trip closes when @majkee gavels the saddle-boot
read-side step drafted above. It is doctrine (canon), so Houston drafts and does not self-apply.

**Still open after this goal (parked by design / pending operator — not blockers):**
- @majkee gavel: the saddle-boot read-side step (closes task 1) · `tools.md` (Tier-S registry) · whether the
  four calibration items become live circuit rules / edit `~/.claude/houston.goal`.
- Operator (non-sudo): schedule recalibration (`systemctl --user` timer or crontab).
- 0008 Stage-1 decisions, when they come due: executor-topology (pull-by-resident vs dispatch) · L10
  silence-default (opt-in vs opt-out). Parked until the pass writes / tokens are measurable.
- O4 cleanup loop (erase unnecessary project agents · broader normalization — deliberate, not blind propagation).

*Draft for @majkee — Force 4. Houston consolidated and drafted; the operator gavels what becomes durable canon/rule.*
