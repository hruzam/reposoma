# Decision Record — Propagation & Transport: re-projecting temple canon onto project surfaces

`status: LOCKED 2026-06-25 (gaveled by @majkee). Two @Janus passes folded — Beam A → L9/L10; Beam B (pull-by-resident executor) parked as an open Stage-1 decision. index.md row 0008 + flag ledger updated on lock. Append-only henceforth (doctrine §1b): superseded, never edited.`
`date: 2026-06-25 · thread: O3 candidate-(b) — propagation pass → transport mechanism`
`shape: ADR — context · structural finding · locked · challenger's catch (×2) · consequences · what-an-agent-does-differently`
`extends: 0004 (cross-project registry) · 0006 (model×effort matrix, new seats) · 0007 (tool-emission duty) · builds-on: _mail addressing convention (gaveled 2026-06-25)`
`instantiates: doctrine §2 (agents-as-data) · §3b (materializer / verify / F1–F4) · §7 (trust does not port)`
`evidence: first propagation run on piql.dev (report: _mail/houston/inbox/atlas.piql-propagation-report.2026-06-25.md) · reconciliation: _mail/piql/inbox/houston.propagation-reconciliation.2026-06-25.md`

---

## Context

Temple-level topology changes — the **0006** model×effort matrix, the new seats (@Vara, @Vector), the
spawn hierarchy, the **0007** tool-emission duty — do not reach a project's agent surfaces by themselves.
Each project carries its own `.claude/agents/*` projections and its own authorized local divergences. When
canon moves, those surfaces drift silently (F1) until someone re-aligns them. The naive fix — "tell each
project's architect to go adjust" — is a broadcast that invites copy-drift and backward leaks (F4).

O3 named the pattern and split it: candidate-(a) was the *trigger* question; candidate-(b) was the
*re-projection mechanism*. The propagation-pass prompt (`temple/tools/propagation-pass.prompt.draft.md`)
was written as candidate-(b)'s hypothesis, then **run once, read-only, against piql.dev** — the richest
test because piql carries a recorded authorized divergence (D29's reduced six-archetype list). This record
encodes what that run taught. It is the transport half of the same body whose addressing half — the logical
`<origin>:<agent>` mail convention, *derived not stored* — was **already gaveled 2026-06-25**. This record
does not redefine that address book; it builds the transports that ride it.

Plane 3 (binding/activation). Extends 0004; mints no new flag/pulse-spine citizen.

---

## Structural finding

**Propagation is not broadcast — it is the materializer's verify-step applied to the agent layer before the
materializer exists.** Agents-as-data (§2) already makes a project's agent surfaces *projections* of
sovereign Tier-S definitions. So bringing a project in line with moved canon is not "editing the project" —
it is **re-projection under one-direction (F4)**: read canon, diff the local projection, re-emit the lagging
parts, never write upward. Human-in-the-loop today; it **collapses into `materialize --verify`** (§3b) the
day a real materializer exists. The pass is the gate, hand-run.

**The empirical finding (the polarity flip).** The candidate-(b) prompt *hypothesized* auto-apply as a
co-equal first bucket — "MECHANICAL → auto-apply" sat at the top of the three-bucket diff. The piql run
**falsified the auto-first hypothesis.** Measured against a real divergent project, the clean auto bucket
held nearly nothing: of the surface differences found, one was an authorized divergence (D29), one was a
seat-design judgment (Vara's promotion topology), one a topology contradiction in stale prose
(Houston→Trajectory), one a tier-commit open question (F4 gitignore), one a value projected from a
*contaminated* canon source (Vara's effort target — itself an unsettled broken-session artifact), and the
remaining "mechanical" residue was a stale naming reference that **isn't propagation's job at all** (see L4).
The auto bucket on the one real test was thin — but note *why* each item left it, because the reasons are
distinct and the draft must not blur them (the first @Janus pass below caught exactly this blur).

**The robust ground for flag-by-default is asymmetric risk, not the count.** Whether divergences happen to
be "mostly judgment" on any given project is fragile evidence — a different project could flip the tally.
The durable argument is the **asymmetry of the two misclassifications**: mistaking *judgment for lag* and
auto-applying it **corrupts canon upward through a project surface (F4)** — the precise failure the whole
one-direction discipline exists to prevent; mistaking *lag for judgment* and flagging it costs only a human
glance. The expensive error is silent; the cheap error is visible. That asymmetry holds **even if the count
flips**, so the polarity rests on it, not on "most divergence is judgment." Auto-apply is therefore the
exception that must earn a narrow, well-bounded seat — but it *does* earn one: strip the canon-contamination
from the Vara-effort case (assume the target were settled intent) and it is a clean model/effort lag that
*should* auto-apply. The mechanical class is real; it was merely empty-by-accident on a project carrying a
corrupt source value (L2 canon-integrity precondition).

---

## Locked (the shape)

**L1 — Re-projection, not broadcast (the spine).** A propagation pass runs *into* one project's folder,
reads temple canon as the source, diffs the local agent surface against it, and re-emits only the lagging
parts. It **never edits temple canon** (F4 one-direction); a local improvement worth keeping is *flagged
for the architect to carry via the beacon* (point-never-copy, 0004 L2), never pushed upward by the pass.
Until a real materializer exists, the pass is human-in-the-loop and report-only by default; it **collapses
into `materialize --verify`** when the gate is built. **Who *executes* the pass — a temple-dispatched agent
vs the project's own resident maintainer — is deliberately left OPEN to a Stage-1 decision** (see rollout +
the parked Beam B note): at Stage 0 it is hand-run by @Atlas/@Epoch or the project's own Houston,
report-only, and the choice does not affect correctness because the executor only diffs-and-flags while the
architect adjudicates at reconciliation.

**L2 — Flag-by-default polarity, gated by a canon-integrity precondition (the empirical lock).** The default
is **flag** (justified by the asymmetric-risk argument above, not by any project's count). Auto-apply is
reserved for a **narrow mechanical class, defined so it is not a null category** — a difference qualifies
for auto **only when all hold**:
- *(precondition — verify before build, F7)* **the canon source value is itself settled** — not a
  broken-session artifact, not an open normalization item, not a value with no recorded rationale. **Never
  project from an unsettled source.** This is the actual guard that correctly held the Vara-effort case back
  (its canon target was a ctrl+z'd-session artifact), and it applies to *every* auto-apply, not just seats;
- pure frontmatter / format normalization, **or** an exact model/effort lag carrying canon rationale and
  *no* recorded local reason; AND
- the change touches neither a provisional seat's **governance axis** (L3), the lint boundary (L4), nor the
  project's declared **protected-set** (L9).

Anything failing any clause is **judgment-residue → flag, do not apply**. The flag to the project architect
carries `{canon-says, local-says, recorded-rationale}`. The architect reconciles; the pass never overwrites
an authorized divergence (piql D29 is the worked example: a *global* new seat does not auto-propagate into a project with an authorized reduced scope).

**L3 — Provisional-seat zone covers the GOVERNANCE axis, not the behavioral one.** A seat recorded as
pilot/provisional (D30's @Vara) is protected from auto-apply **on its governance axis** — its *existence,
spawn topology, routing position, and promotion status*. Those are design under evaluation, and a pass must
not silently change whether a provisional seat exists or where it sits in the dispatch graph. **Its
behavioral axis — effort, model tier — is NOT judgment-by-construction:** the piql run itself recorded that
*"effort is a behavioral axis, not a governance axis,"* so a provisional seat's effort lag follows the
ordinary L2 path (including the canon-integrity precondition) like any other seat's. The earlier conflation
— treating Vara's effort as judgment *because she is a pilot* — over-fit a single contaminated datapoint:
Vara's effort was correctly withheld by L2's canon-integrity precondition (corrupt source), **not** by
provisional-ness. Keep the two reasons separate so neither carries the other's weight. **L3 is the
temple-side backstop that complements L9:** a project declares its *own* divergences via the protected-set
(L9, citing local decisions), but a provisional seat's protection is keyed off the *temple* promotion
threshold (D30/L8) and holds even for a just-minted seat the project has not yet declared — a project cannot
self-declare a temple seat's provisional status, so L3 supplies the default protection regardless.

**L4 — Propagation-vs-local-lint boundary (scope fence).** Propagation's scope is **seats, model, effort,
and spawn topology** — the surface canon actually governs. **Naming coherence is NOT in scope** (stale
`coder-junior→delta` references, project-prefix consistency on agent `name:` fields). Those are a
**`materialize --verify` lockfile lint** — a local consistency check, not a re-projection of canon. Drawing
this fence keeps the pass from swelling into a general linter (the over-process failure mode, §4): it
projects what canon moved, and leaves local hygiene to the local gate.

**L5 — Trust excluded entirely (§7).** Trust and permission config (`tools:` grants, hooks, `maxTurns`,
permission mode) is **never propagated** — it is a materialize target, generated per vendor, kept Tier-G for provenance, and never assumed to travel. If a canon change *implies* a permission change, the pass emits `trust-regen-needed-locally` as a **flag only** — never writes it. (piql's three trust flags — Vector's grants if added, Houston's hook fields, Trajectory's Bash grant — were correctly excluded from the run.)

**L6 — Projection-version stamp (pull-detectable staleness).** Each propagation stamps the local surface
with the canon version it was projected from (`projected-from: decisions@<date>`). A project whose stamp
lags current canon **flags itself stale on its next read** — staleness is *pull-detectable*, with no central broadcast bookkeeping. The stamp is the only state the transport must persist.

**L7 — One address book, two thin transports (NOT one god-script).** The logical address book —
`<origin>:<agent>`, derived not stored (gaveled 2026-06-25, honoring 0004 L4's no-`~/`-in-beacons) — is
**shared**; over it ride **two decoupled, thin transports**:
- **mail physical-staging** — cross-repo delivery of a message to a receiver's inbox (the piece the
  addressing-convention gavel explicitly *deferred* to this candidate). Receiver owns the message; no
  sent-copy; replies return to your inbox.
- **propagation re-projection** — the pass of L1, dispatched *into* a project folder.

These do not fuse. Propagation dispatches into a folder and **does not require the mail transport** at all;
mail delivers a message and knows nothing of canon diffing. The mechanism is a **neutral script** (0003
precedent — logic lives in a script, not a framework, not a model), triggered by **cron / manual /
hook-doorbell**. The hook only *rings the doorbell*; the script holds the transport; the architect (or a
dispatched @Atlas/@Epoch) holds the judgment. Hook ≠ brain. *(Host asymmetry, operator O3: on a given host
the transport may live with whatever agent/host is resident there — e.g. piql on `office`; a host without it simply does not run that transport — consistent with the neutral-script-per-machine precedent.)*

**L8 — Provisional-seat governance: the named-promotion-threshold (D30 template).** A seat admitted as
provisional **records an explicit promotion threshold** at admission — D30's formulation is the template:
*"promote only when @majkee can no longer route + review dispatch volume by hand"* (a concrete, observable
condition, not "when it feels ready"). This canonizes how provisional seats are recorded team-wide and is
the governance hook L3 keys off: the pass reads the threshold to know a seat is still provisional (so its
*governance axis* stays protected), and the architect reads it to know when the seat graduates and that
protection lifts.

**L9 — Declared protected-set (project-side sovereignty, made declarative) [folded from operator O1].** A
project MAY declare in its contract (`PROJECT.yaml`) a `protected: [{field, reason: D-<proj>-NN}]` list —
fields the pass must not auto-overwrite. This converts L2's *infer-from-recorded-rationale* into
*read-a-declared-list*: cheaper to evaluate, robust, and the literal mechanism for "don't overwrite what's
locked." Rules:
- **Each entry MUST cite a local decision** (`reason: D-<proj>-NN`) — same discipline as recorded-rationale, now structured. An uncited protection is not honored.
- **Hard against *silent* overwrite, not against all overwrite.** A mandatory-class change (L10) still passes through notify-then-apply; the protected-set blocks the *silent auto-apply*, not the explicit escalated one.
- **The canon-integrity precondition applies symmetrically.** A protected entry citing an unsettled /
  broken-session / un-rationaled value is **not real protection** — the declared list must not become a
  laundering channel for unsettled local values (the mirror of L2's precondition on the canon side).

**L10 — Precedence is an exception marker, not a per-change field [folded from operator O1].** The default
is **project-wins** (the L2/L9 polarity). Precedence is invoked *only* for a rare **mandatory class** —
security, vendor-deprecation, a correctness fix — where temple must win over local; and even then it is
**notify-then-apply with an objection window, never silent** (silent temple-wins is the same F4 corruption
pointed the other way — temple clobbering a legitimate local safety call). Everything else is
flag→architect-reconciles. **Do not tag ordinary canon locks with a precedence field** — that is the
over-process tax (§4). The mandatory marker is the exception that must be justified, not a default column.

**Staged rollout (consequence of L1 + L7):**
- *Stage 0 — now:* the pass is the hand-run prompt; report-only; architect applies after sign-off. Transport
  = manual dispatch. Mail physical-staging unbuilt (cross-repo still by @majkee's hand). Protected-set (L9)
  declarable now (it is just a contract block the pass reads).
- *Stage 1 — script exists:* the neutral script runs the two transports; projection-version stamps populate;
  trigger menu (cron/manual/hook) turns on; still report-then-apply, never silent. **Executor-topology
  decided here** (pull-by-resident vs temple-dispatch): this is when tokens become measurable *and* the one
  real pro-resident argument goes live — at Stage 1+ the pass *writes*, so a temple-dispatched agent would
  need a cross-project write-grant into a foreign folder while a resident already holds it. Decide then, on
  evidence; do not pre-lock now. **L10 silence-default to settle here too** (advisor-flagged): when a
  mandatory-class change's objection window lapses with no project reply, does it **apply (opt-out) or hold
  (opt-in)?** It can override an explicitly-protected, decision-cited field, so it must be settled — but the
  window does not exist until the script does, so it is correctly out of scope to build at Stage 0.
- *Stage 2 — materializer exists:* the pass collapses into `materialize --verify`; flag-by-default becomes
  the gate's diff classifier; L4's lint runs as the lockfile's consistency check.

---

## Architect's note — what this record does NOT decide (flagged, not silent)

This record locks the *propagation/transport shape* and its resolution rules (L9/L10). It does **not**:
- settle the live O4 normalization items — Vara's effort target, erasing unnecessary project agents — which
  are **deliberate-loop work, not propagation** (Vara's effort is *behavioral lag awaiting a settled canon
  value*, not provisional-seat judgment; L2's canon-integrity precondition is why the pass leaves it alone,
  and the O4 loop is where the canon value gets settled);
- **decide the executor topology** (pull-by-resident vs temple-dispatch) — explicitly parked to Stage 1 per
  the second @Janus pass (see below);
- build the cross-repo mail staging (L7's deferred piece is *scoped* here, not *implemented*);
- touch piql's F4 gitignore tiering question — that is piql's own 0007-adjacent call.

*Post-lock note (2026-06-25, append-only): O4 gaveled Vara's effort = `high` (settled intent; xhigh→high on
Sonnet 4.6). The "unsettled-source" Vara-effort example in the structural finding / L2 / L3 is therefore
**historical, true as-of the piql run** — not edited (append-only §1b). Live consequence: with canon now
settled, the next piql propagation finds Vara `medium` (no local reason) → canon `high` (settled) → **the
L2 canon-integrity precondition now passes**, making this the first live instance of the auto-apply class
0008 predicted would qualify once the source settled. Settlement confirms 0008; it does not contradict it.*

---

## The challenger's catch (Janus)

### First pass — verdict REVISE (on the original L1–L8)

**Bones held (L1, L5, L6, L7, L8 sound; flag-by-default survives any count); one load-bearing beam was
wrong, and not the one the architect flagged.** The draft's own worry was L2 ("is the mechanical class
theater, since the auto bucket went to zero?"). Janus showed the bucket emptied because **L3 ate the one
candidate that would have survived** — Vara's effort lag — on an invalid justification: the piql report
states the *opposite* of L3's premise in plain text (*"effort is a behavioral axis, not a governance
axis"*), and the reconciliation withheld Vara for a **canon-integrity** failure (*"the canon-high target is
itself an unsettled broken-session artifact"*), not provisional-ness. L3 had over-fit one contaminated
datapoint into a standing law. **Folded:** (1) the real reason became a canon-integrity precondition on ALL
auto-apply (L2); (2) L3 narrowed to the governance axis; (3) the polarity re-grounded on asymmetric risk,
not the count. Re-running the bucket test, a settled-canon effort lag qualifies for auto, so the mechanical
class is real and non-null.

### Second pass — verdict REVISE (on the operator-input beams) — folded

Operator @majkee added precedence/protected-set (Beam A) and pull-by-resident (Beam B). Janus ruled:
- **Beam A → fold (done: L9/L10).** Nit folded: protected-set is hard against *silent* overwrite, not all
  overwrite; canon-integrity symmetry kept so the list cannot launder unsettled local values.
- **Beam B → do NOT lock (done: parked to Stage 1).** Its "correctness not cost" justification rested on two
  legs and both collapse: *information-locality* is destroyed by Beam A itself (once the protected-set is
  *declared* in the contract, any dispatched agent reads it — the resident has no special knowledge, and
  under flag-by-default the executor only diffs-and-flags while the architect adjudicates); *trust-locality
  §7* is redundant (§7 is config-generation, not who-runs-the-pass, and L5 already walls trust out of
  propagation). Only the architect's own unmeasured token estimate remained — too weak to lock a default
  topology. **The one real pro-resident argument (write-grant into a foreign folder) is not live until the
  pass writes, i.e. Stage 1** — so the decision is parked there, on evidence.
- **Architect's three self-flagged uncertainties, ruled:** (1) L3-vs-L9 redundancy — **DENY, keep both**
  (L3 temple-side/promotion-keyed backstop; L9 project-declared/local-decision-cited). (2) Split into 0009 —
  **DENY**, no coherent separate record; protected-set is L2 made declarative, precedence is a near-nothing
  exception marker. (3) Push→pull premature — **CONFIRM, and worse: self-undercutting** (the Beam-A↔Beam-B
  collapse). This was the architect's real cognitive miss this loop — folding two beams that contradict each
  other — caught by the pass and corrected.

---

## Consequences

- Temple topology changes reach project surfaces **without a broadcast and without a fork**: re-projection
  under one-direction (F4), human-in-the-loop, collapsing into the materializer's verify-step later.
- **The polarity is defended by asymmetry, not census (L2):** flag-by-default because the silent error
  (judgment auto-applied as lag) corrupts canon upward, while the visible error (lag flagged) costs a glance.
- **Auto-apply earns a real, narrow seat (L2):** gated by a canon-integrity precondition plus the
  format/exact-lag clauses — non-null, since a settled-canon effort lag qualifies.
- **"Don't overwrite what's locked" is now declarative (L9):** a project states its sovereign fields in the
  contract, each citing a local decision; the pass reads a list instead of inferring — hard against *silent*
  overwrite, with the canon-integrity symmetry preventing laundering of unsettled values.
- **Precedence stays small (L10):** project-wins by default; temple-wins only for a justified mandatory
  class, and even then notify-then-apply, never silent — no per-change precedence tax (§4).
- **Two reasons stay unconflated (L3):** governance axis protected (temple-side backstop), behavioral axis
  lags like any seat's; complements the project-declared protected-set.
- **The pass cannot swell into a general linter (L4):** local hygiene stays with the local gate.
- **Trust never travels (L5, §7);** staleness is pull-detectable (L6); two thin transports over one address
  book (L7); provisional seats get a governance grammar (L8).
- **Executor topology is decided on evidence, not pre-locked:** parked to Stage 1, when tokens are
  measurable and the write-grant concern is live.

---

## What an agent does differently

- **To propagate canon into a project:** run the L1 pass *into* the project folder — read canon, diff the
  local surface, **flag by default** (L2). Auto-apply only the narrow mechanical class, and **only when the
  canon source value is itself settled**; never overwrite an authorized divergence, a declared protected-set
  entry (L9), a provisional seat's governance axis (L3), or cross the lint boundary (L4).
- **To protect a local choice from the pass:** declare it in the contract `protected:` list with a citing
  reason (L9). An uncited or unsettled-valued protection is not honored.
- **To override local from temple:** only for a mandatory class (security/deprecation/correctness), via
  notify-then-apply with an objection window — never silent, and never as a routine precedence tag (L10).
- **To handle a provisional seat:** protect its existence/topology/routing/promotion from auto-apply; treat
  its effort/model as ordinary lag under L2 (L3, L8).
- **To handle trust:** exclude it entirely; emit `trust-regen-needed-locally` as a flag, never a write (L5).
- **To make staleness visible:** stamp `projected-from: decisions@<date>` on the local surface (L6).
- **To choose a transport:** mail to deliver a message; the propagation pass to re-project canon — two thin
  transports over one logical address book, never one script (L7).
- **To run the pass before the script exists:** dispatch the prompt at `temple/tools/propagation-pass.prompt.draft.md`,
  report-only, bring the report to the architect — apply nothing without sign-off.

---

*Evidence: `_mail/houston/inbox/atlas.piql-propagation-report.2026-06-25.md` (the run) ·
`_mail/piql/inbox/houston.propagation-reconciliation.2026-06-25.md` (the reconciliation, @majkee-gaveled).*
*Lineage: doctrine §2 (agents-as-data, projections), §3b (materializer / verify / F1–F4), §4 (over-process
failure mode), §7 (trust does not port) · decisions 0004 (registry), 0006 (matrix/seats), 0007 (emission).*
*Next: LOCKED 2026-06-25 — index.md row 0008 added + flag ledger updated (propagation-O3 resolved). Stage 1
follows: build the neutral transport script · decide executor topology (pull-by-resident vs dispatch) ·
settle the L10 silence-default (opt-in vs opt-out).*
