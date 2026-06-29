# Propagation Pass — the standard re-projection prompt (CONFORMED to LOCKED 0008)

`status: CONFORMED to LOCKED 0008 (2026-06-30). Was DRAFT/candidate-(b); the piql run HAPPENED and 0008 ENCODES it —`
`this prompt no longer hypothesizes an auto/flag split, it IMPLEMENTS locked doctrine (L1–L10). O3 RESOLVED by 0008.`
`owner: temple architect (Houston) · reconciled: 2026-06-30 · originally drafted: 2026-06-25 · host: office`
`grounds-on: LOCKED temple/decisions/0008-propagation-transport.md (L1–L10) · extends 0004 · 0006 · 0007`
`principle: re-projection, not broadcast — agents-as-data (§2), materializer/verify (§3b), one-direction (Force 4)`
`⚠ OPEN — narrowed, not closed (queued for @Janus as OQ3 in twin-propagation.read-side-step.pass.draft.md):`
`   whether this prompt stays a standalone generic pass OR is SUPERSEDED by the (b) draft's "What a dispatched`
`   agent does" steps / the eventual materialize --verify. This edit RESOLVES OQ3(a) — the polarity now conforms`
`   to flag-by-default — and narrows OQ3 to that pure lifecycle/dedup question. Honest framing: this does the`
`   KEEP-branch's work because the correctness fix was asked for now; only the file's ultimate FATE is deferred,`
`   not its polarity. Do not read this conforming edit as a vote for "keep" — that call is @Janus's at OQ3.`

> **What this is.** The standard prompt for bringing one project's agent surfaces in line with temple canon
> after a temple-level change (model/effort matrix, new seats, spawn hierarchy, tool-emission duty). It is
> **re-projection with drift-detection**, NOT "tell the project leader to go adjust." Run it per project, in
> that project's folder, by @Atlas or @Epoch (or the project's own Houston). Human-in-the-loop and
> **report-only at Stage 0** (0008 L1); it **collapses into `materialize --verify`** (§3b) the day a real
> materializer exists (0008 Stage 2).

---

## The prompt (fill `<PROJECT>` and dispatch)

You are running a **propagation pass** on project `<PROJECT>`. Bring its agent surfaces in line with temple
canon **without overwriting authorized local divergences and without touching trust.** You re-project; you
do not improvise. **Default is FLAG, not apply** (0008 L2) — you surface differences for the architect; you
auto-apply only the narrow, fully-gated exception below.

**Read — temple canon (the source):**
- `temple/decisions/index.md` — the locks affecting agents (esp. **0006** model×effort matrix + new seats;
  **0007** tool-emission duty; **0008** propagation/transport doctrine — the rules this pass obeys).
- `temple/doctrine.md` §1b (sovereignty tiers), §2 (agents-as-data, roster), §3b (contract / verify / F1–F4),
  §4 (over-process failure mode), §7 (trust does not port).
- `temple/roster.md` + `temple/system-map.md` — current cast + spawn topology.

**Read — local project (the consumer surface):**
- `<PROJECT>/PROJECT.yaml` — `agents:`, `tools:`, **and `protected:`** (the declared protected-set, L9).
- `<PROJECT>/.claude/agents/*` (and any other vendor surface present).
- `<PROJECT>/flag.md` (or its decisions ledger) — **authorized local divergences** (e.g. piql D29: an
  `agents:` field reconciled with majkee's explicit authorization — NOT a fork).

**Classify every difference — FLAG by default (0008 L2):**

1. **DEFAULT — JUDGMENT-RESIDUE → flag, do NOT apply.** Every difference is flagged to the **project
   architect** carrying `{canon-says, local-says, recorded-rationale}` *unless* it qualifies for the narrow
   MECHANICAL exception below. The architect reconciles — you never overwrite an authorized divergence.
   *(Why flag is the default: asymmetric risk, not any project's count. Mistaking judgment for lag and
   auto-applying corrupts canon **upward** through a project surface — F4, the silent and expensive error;
   mistaking lag for judgment and flagging it costs only a human glance. The expensive error is silent, the
   cheap error visible — so the polarity rests on flag.)*

2. **NARROW EXCEPTION — MECHANICAL → auto-apply, only when ALL of these hold:**
   - **(precondition — verify before build, Force 7) the canon source value is itself SETTLED** — not a
     broken-session artifact, not an open normalization item, not a value with no recorded rationale.
     **Never project from an unsettled source.** This is the actual guard; strip it and there is no auto
     class. *(It is the guard that correctly held the Vara-effort case back during the piql run — its canon
     target was a ctrl+z'd-session artifact, not provisional-ness.)*
   - pure frontmatter / format normalization, **OR** an exact model/effort lag carrying canon rationale and
     **no** recorded local reason; **AND**
   - the change touches **neither** a provisional seat's **governance axis** (L3), the **lint boundary** (L4),
     nor the project's **declared protected-set** (L9).
   - **Anything failing any clause falls back to FLAG.** Auto-apply is the exception that must earn its seat,
     not the first bucket.

3. **TRUST / PERMISSIONS → exclude entirely (L5, §7).** Never propagate trust or permission config (`tools:`
   grants, hooks, `maxTurns`, permission mode); each project regenerates its own — trust is a materialize
   target, generated per vendor, never assumed to travel. If a canon change *implies* a permission change,
   emit `trust-regen-needed-locally` — **flag it, never write it.**

**Provisional seats — governance axis only (0008 L3/L8).** A seat recorded as provisional (carrying an
explicit promotion threshold, L8) is protected from auto-apply **on its governance axis** — its *existence,
spawn topology, routing position, promotion status*. Its **behavioral axis (effort, model tier) is ORDINARY
lag** under L2 (including the canon-integrity precondition) — do **not** withhold an effort/model lag merely
because the seat is a pilot. (The piql run recorded it in plain text: *"effort is a behavioral axis, not a
governance axis."*)

**Scope fence — propagation vs local-lint (0008 L4).** Propagation's scope is **seats, model, effort, spawn
topology** — the surface canon actually governs. **Naming coherence is NOT in scope** (stale
`coder-junior→delta` references, project-prefix consistency on agent `name:` fields). Those are a
`materialize --verify` lockfile **lint** — local hygiene for the local gate. Do not let the pass swell into a
general linter (§4 over-process).

**Declared protected-set (0008 L9).** Read `<PROJECT>/PROJECT.yaml protected: [{field, reason: D-<proj>-NN}]`.
Each entry **MUST cite a local decision** — an uncited protection is not honored; a protection citing an
unsettled / un-rationaled value is **not real protection** (canon-integrity symmetry — the list must not
launder unsettled local values). The protected-set is hard against **silent** overwrite — a mandatory-class
change (L10) still passes through notify-then-apply, but never silent auto-apply.

**Precedence — an exception marker, not a column (0008 L10).** Default is **project-wins**. Temple-wins only
for a rare **mandatory class** (security / vendor-deprecation / a correctness fix), and even then via
**notify-then-apply with an objection window — never silent.** Do **not** tag ordinary canon locks with a
precedence field; that is the over-process tax (§4).

**Stamp a projection-version (0008 L6).** Record on the local surface the temple-canon version/date it was
projected from (e.g. `projected-from: decisions@<canon-date>`). This makes staleness **pull-detectable** — a
project whose stamp lags current canon flags *itself* stale on its next read; no broadcast bookkeeping. The
stamp is the only state the transport must persist.

**One-direction guard (Force 4).** You write only into `<PROJECT>`; you **never** edit temple canon. If you
find a local improvement worth upstreaming, **flag it for the architect** to carry via the beacon (point,
never copy — 0004 L2) — do not push it back yourself.

**Emit a report** (the deliverable — nothing locks without architect sign-off; report-only at Stage 0):
```
project: <PROJECT>
projected-from:        decisions@<canon-date>
flagged-for-architect: [ { canon-says, local-says, recorded-rationale }, ... ]   # the DEFAULT bucket (L2)
auto-applied:          [ <surface>: <field> <old> → <new>  (canon settled ✓), ... ]   # narrow class only
protected-respected:   [ <field> (reason: D-<proj>-NN), ... ]   # L9 — declared, left untouched
trust-regen-needed:    [ ... ]   # L5 — flagged only, never written
mandatory-notify:      [ ... ]   # L10 — only if a mandatory-class change applies; notify-then-apply, never silent
```

---

## Operating notes (post-0008)

- **Two thin transports, one address book (L7) — keep them decoupled.** This pass is dispatched *into* a
  project folder; it does **not** require the mail transport at all. Mail delivers a message and knows nothing
  of canon diffing; the propagation pass re-projects canon and knows nothing of mail. Do not fuse them into
  one god-script — the logic is a **neutral script** (0003 precedent), triggered by cron / manual /
  hook-doorbell; the hook only *rings*, the script holds the transport, the architect holds the judgment.
  Hook ≠ brain. *(Host asymmetry: on a given host the transport may live with whatever agent/host is resident
  there; a host without it simply does not run it.)*
- **Stage 0 (now): report-only, human-in-the-loop.** Bring the report back; the architect applies after
  sign-off; @majkee gavels. **Executor-topology (pull-by-resident vs temple-dispatch) is PARKED to Stage 1**
  (0008 L1) — at report-only it does not bind, so do not resolve it here.
- **Stage 1 (script exists):** the neutral script runs the two transports; stamps populate; the trigger menu
  turns on; still report-then-apply, never silent. The **L10 silence-default** (does a lapsed objection window
  apply opt-out or hold opt-in?) is settled here — it does not exist until the script does.
- **Stage 2 (materializer exists):** this pass **collapses into `materialize --verify`**; flag-by-default
  becomes the gate's diff classifier; L4's lint runs as the lockfile's consistency check.
- **First-runner evidence is in canon, not ahead of it.** The richest first test (piql.dev — D29 authorized
  divergence) already ran; 0008 *encodes* what it taught. Do not re-frame this pass as a hypothesis awaiting a
  first run — that run is history.

---

*Lifecycle: this prompt is the Stage-0 hand-run gate for 0008 L1. Its FATE — kept as a standalone generic
pass vs superseded by the (b) draft's "What a dispatched agent does" steps / the materializer — is OQ3,
queued for @Janus in `temple/tools/twin-propagation.read-side-step.pass.draft.md`. This conforming edit closes
OQ3(a) (polarity) and leaves OQ3(b) (the file's fate) to that pass. Gavel by @majkee.*
