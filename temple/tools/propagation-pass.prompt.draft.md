# Propagation Pass — the candidate-(b) prompt (DRAFT)

`status: DRAFT — pending one manual run (first-runner) + lock as candidate 0008 (with @Janus pass)`
`owner: temple architect (Houston) · resolves: decisions/index.md "Still open" O3, candidate (b)`
`date: 2026-06-25 · host: office`
`principle: re-projection, not broadcast — agents-as-data (§2), materializer/verify (§3b), one-direction (Force 4)`

> **What this is.** The standard prompt for bringing one project's agent surfaces in line with temple canon
> after a temple-level change (model/effort matrix, new seats, spawn hierarchy, tool-emission duty). It is
> **re-projection with drift-detection**, NOT "tell the project leader to go adjust." Run it per project, in
> that project's folder, by @Atlas or @Epoch (or the project's own Houston). Human-in-the-loop until a real
> materializer exists (then this collapses into `materialize --verify`).

---

## The prompt (fill `<PROJECT>` and dispatch)

You are running a **propagation pass** on project `<PROJECT>`. Bring its agent surfaces in line with temple
canon **without overwriting authorized local divergences and without touching trust.** You re-project; you
do not improvise.

**Read — temple canon (the source):**
- `temple/decisions/index.md` — the locks affecting agents (esp. **0006** model×effort matrix + new seats;
  **0007** tool-emission duty).
- `temple/doctrine.md` §1b (sovereignty tiers), §2 (agents-as-data, roster), §3b (contract / verify / F1–F4).
- `temple/roster.md` + `temple/system-map.md` — current cast + spawn topology.

**Read — local project (the consumer surface):**
- `<PROJECT>/PROJECT.yaml` — `agents:`, `tools:`.
- `<PROJECT>/.claude/agents/*` (and any other vendor surface present).
- `<PROJECT>/flag.md` (or its decisions ledger) — **authorized local divergences** (e.g. piql D29: an
  `agents:` field reconciled with majkee's explicit authorization — NOT a fork).

**Diff into exactly three buckets:**

1. **MECHANICAL → auto-apply.** Model/effort assignments, new global seats to add, frontmatter, spawn
   hierarchy — anything where local simply *lags* canon with no recorded reason. Re-emit the local surface to
   match canon. These need no human decision.
2. **JUDGMENT-RESIDUE → flag, do NOT apply.** Where local diverges from canon **and** the divergence is
   recorded as authorized in `flag.md` (or is plainly deliberate). Emit a flag to the **project architect**
   carrying `{canon-says, local-says, recorded-rationale}`. The architect reconciles — you never overwrite an
   authorized divergence.
3. **TRUST / PERMISSIONS → exclude entirely.** Never propagate trust or permission config; each project
   regenerates its own (§7 — trust is a materialize target, not portable canon). If a canon change *implies*
   a permission change, emit `trust-regen-needed-locally` — **flag it, never write it.**

**Stamp a projection-version.** Record on the local surface the temple-canon version/date it was projected
from (e.g. `projected-from: decisions@2026-06-25`). This makes staleness **pull-detectable** — a project
whose stamp lags current canon flags *itself* stale; no broadcast bookkeeping.

**One-direction guard (Force 4).** You write only into `<PROJECT>`; you **never** edit temple canon. If you
find a local improvement worth upstreaming, **flag it for the architect** to carry via the beacon (point,
never copy) — do not push it back yourself.

**Emit a report** (the deliverable — nothing locks without architect sign-off):
```
project: <PROJECT>
projected-from: decisions@<date>
auto-changed:        [ <surface>: <field> <old> → <new>, ... ]
flagged-for-architect: [ { canon-says, local-says, recorded-rationale }, ... ]
trust-regen-needed:  [ ... ]   # flagged only, never applied
```

---

## Notes for the first run (what we are trying to learn)

- **Where does the auto/flag line actually fall?** The mechanical/residue split is a hypothesis until one
  real project exercises it. Capture every case that was ambiguous — that ambiguity is the evidence that
  shapes candidate 0008.
- **Is the address/transport even needed for this?** This pass is dispatched *into* a project folder; it does
  not require the mail-transport mechanism. Keep the two decoupled (one address book, two transports).
- **First-runner candidate:** a project with a known authorized divergence (piql — D29 `agents:`) is the
  richest test, because it forces the residue bucket to do real work.

*Next: run once → fold the learnings → lock as candidate 0008 (propagation + mail-extension mechanism),
challenge-before-lock via @Janus, gavel by @majkee.*
