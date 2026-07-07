# Decision Record — Tool-Lifecycle / Publishing Doctrine: tools as the third registry consumer

`status: DRAFT — shape pending @majkee gavel (revised post-@Janus; +L7 emission discipline); cross-project seal pending two named conditions (L6)`
`date: 2026-06-25 · thread: tool-lifecycle / publishing home (subai → temple)`
`shape: ADR — context · structural finding · locked · challenger's catch · consequences · what-an-agent-does-differently`
`extends: 0004 (cross-project registry) · instantiates: doctrine §1b Tier-G-committed + §3b verify-gate · guards: F4`
`source: _mail/houston/inbox/subai.houston.tool-lifecycle-doctrine.2026-06-25.md (post-@Janus, subai-side)`

---

## Context

Guides have a publishing home (`raw.guides/`). Beacons have one (`registry/`, 0004). **Tools — scripts,
bricks, MCP servers, finished app-blocks — have none.** Scattered across development folders they get
forgotten. The trigger was concrete: wiring `subai-spectral` as the fourth callable MCP tool in
subai.devenv, the point at which holding the whole tool surface in one head stopped scaling.

**The operator's motivation (majkee, 2026-06-25).** Two needs, one mechanism: (1) *capture* — build
project documentation in parallel with the work so nothing is lost; (2) *usability* — give the operator
and his agent-partners a way to find and call the tools a project has produced. The reference shape is a
**Laravel-Boost-equivalent**: a structured, trustworthy inventory an agent can act on. Most projects have
no Boost. The spectral-RAG is the eventual engine but is early-stage — so the team needs a **file-native
bridge that works with or without the RAG today**, which the RAG later inherits rather than replaces.

Plane 3 (binding/activation), doctrine §3b. This record **extends 0004**; it mints no new flag/pulse-spine
citizen.

---

## Structural finding

**Tools are not a new doctrine — they are the missing third consumer of an existing one.** Guides, tools,
and beacons all flow one direction: *project artifact → reposoma `raw.*` substrate → cross-project index.*
Tools differ from guides/beacons in exactly one respect: **they carry executable facts that drift, while
prose does not.** That single difference is already covered by standing doctrine:

- The "split-tier" map is **§1b's sovereignty gradient applied to executable facts** — not an invention.
  Hand-authored intent = **Tier-S**; gate-verified facts = **Tier-G-committed** ("an output, yet committed —
  for *provenance on anything trust-bearing* — verified by the drift gate, never hand-edited").
- "Trust binds only to gated columns" = §1b's *provenance-on-trust-bearing* + §3b's **verify step**, both
  built to defeat **F4** ("silent divergence between what the registry says and what a repo runs").
- The graduation ladder = §1b's **graduation rule** ("encode the rule, not the snapshot").
- "Map as a light registry" = **extend 0004** + the **Force-3** test 0004 already passes (a pointer index
  over the one source is integration, not a second knowledge system).

The lesson this record preserves (why it is its own ADR, not a 0004 amendment): **an executable-state map
is not a decision ledger.** `flag.md` records *decisions* — unverifiable, so correctly hand-authored. A
tool-map records *executable facts* — verifiable, therefore drift-prone, therefore it must be gated. The
subai-side @Janus pass killed the "*like flag.md*" analogy on exactly this point; the proof was twenty
minutes old in that session — a hand-stamped `CLOSED` in subai's `flag.md` was false because the
`privacy_gate` finger had silently dropped two flags. Canonizing "trust without re-verify" would mint that
failure as cross-project doctrine.

---

## Locked (the shape)

**L1 — Two tiers, two homes, sorted by sovereignty (§1b).**
- **Tier-S intent** (`name · job · graduation-state`) — hand-authored, the source of truth. Rides the
  **existing project contract** (`PROJECT.yaml` `tools:` block), beside `agents:`. No new spine file.
  *Escape valve (graduation rule on the home itself):* a dedicated Tier-S `tools.md`, pointed to by the
  contract, only once the block outgrows the contract.
- **Tier-G-committed facts** (`path-exists · interface-responds · deps-resolve · working-state`) — a
  **generated, git-committed lockfile**, emitted and re-verified by the verify-gate, **never hand-edited.**
  This is doctrine Tier-G-committed verbatim (§1b) and the §3b lockfile pattern applied to tools.

**L2 — Trust binds only to gate-verified columns (F4 guard).** A hand-typed status never bears trust. An
agent reincarnated into a project folder reads the map to orient — but *acts on* the Tier-G columns only.

**L3 — The cross-project copy is discovery-only BY CONSTRUCTION, not by promise (structure, not promise —
0004 L4).** The gate runs only where the tools physically live, so the **project-side lockfile is the sole
trust/call surface.** The cross-project surface is forbidden any *actable* column by construction:
- the **beacon row stays a pure pointer** (addresses only — exactly the live `registry/<project>.md`, which
  carries no executable state field; discovery holds because the surface contains nothing to call against);
- an optional **derived intent-snapshot** may live in the substrate (the `registry/projects/` + `raw.guides/`
  class) carrying **Tier-S intent only — `name · job · graduation-state`, dated, `source-of-truth:` pointer,
  source files win** — the coarse, non-executable lifecycle class of the beacon's own `status:` label;
- **the Tier-G executable columns (`path-exists · interface-responds · deps-resolve · working-state`) never
  sync.** They are the columns an agent *calls a tool against*; replicated cross-project and dated, they are
  precisely the `flag.md CLOSED`-that-read-true-and-was-false failure re-minted at the tier this record
  exists to protect.

Discovery-only thus holds **by absence of any callable column**, not by a request to "notice the date."
point-never-copy (0004 L2) is preserved — the beacon points; any snapshot is derived, re-published, never
hand-edited downstream.

**L4 — No gate yet ⇒ Tier-S-only, bears no trust.** Until a real verify-gate exists, the map is the
contract `tools:` block alone; the **Tier-G columns stay empty** — never hand-stamped to look verified.
(This is the explicit guard against re-minting the `privacy_gate CLOSED`-that-was-false failure on day one.)

**L5 — Graduation ladder + packaging-shift (encode the rule, §1b).**
`spike → project-brick → shared-tool (rule-of-two) → package`.
Packaging-shift (`.devenv → .v<N>`): freeze the interface → extract to its own repo → leave a consuming
stub in the origin → flip `graduation-state: packaged`. (The reposoma.v2 precedent.)

**L6 — Seal-gate: two distinct conditions, both required (Force 6 + Force 7).** The *shape* locks now; the
doctrine **seals cross-project only when BOTH clear:**
- *(a) verify-the-mechanism (Force 7):* subai runs the split-tier map through one real packaging-shift —
  proves the mechanism survives contact. **subai is the first runner** (sibling of 0002's detection-rate
  conditional).
- *(b) generalize-the-pattern (rule-of-two):* a second project independently needs the doctrine — proves it
  is not one project's local shape.

One runner clears (a); it does **not** clear (b). Do not read a single packaging-shift as license to lock
cross-project.

**L7 — Emission discipline: capture is fluent because it is TRIGGERED, not swept (Force 2).** A home with no
duty to move into it just gives the forgetting a tidier address. So the obligation is codified, not assumed:
- **The row is part of definition-of-done.** A tool does not count as graduated until its contract `tools:`
  row reflects the new state — writing it down *is* finishing it (Force 2: "write everything down,
  immediately"). Documentation is built in parallel with the work because it is *part of* the work, not a
  later pass.
- **The graduation ladder (L5) is the emission trigger.** The row updates *at* each transition, by the agent
  making it, so capture rides the work instead of trailing it. *Gate the big, flow the small* (§4.5): the
  duty binds at the rungs where tools actually get forgotten — `project-brick`, `shared-tool`, `packaged` —
  a throwaway `spike` need not be registered until it earns the `brick` rung.
- **The architect seat owns the discipline** (it owns the contract, plane 2). Written as a **seat-obligation,
  not a person's habit**, so it survives reincarnation and seat-replacement: a successor in the chair reads
  L7 and knows the emission duty came *with the chair* — this is the explicit answer to "will the next
  architect know they must emit."
- **Backstop (Stage 1, structural — structure, not promise).** Once the verify-gate exists, it flags any
  tool present on disk (`path-exists`) with **no contract row** — converting the emission duty from
  *discipline* into *detection*, the same move L3/L4 make for trust. Until the gate exists, L7 is held by the
  seat; after it, the gate catches what the seat misses.

**Staged rollout (consequence of L4 + L6):**
- *Stage 0 — now:* contract `tools:` block only (Tier-S intent), emitted per L7. No fact tier, no trust.
  Discovery = beacon.
- *Stage 1 — gate exists:* verify-gate emits the lockfile; Tier-G columns populate; trust attaches
  project-side; the L7 backstop (un-emitted tool detection) turns on.
- *Seal:* after both L6 conditions clear, re-evaluate for cross-project lock.

---

## Architect's divergence from subai's literal proposal (flagged, not silent)

subai proposed **one mixed file** with two column-classes. I split it: **intent in the contract, facts in
a generated lockfile.** Rationale, drawn from the doctrine subai itself cited — the **verify-gate must own
its output exclusively** (§3b lockfile), and hand-authored + generated content in one file invites the
exact accidental hand-edit the split exists to prevent. The split also **mints no new spine file** (honors
the operator's "don't grow the line"): intent rides the existing contract, and the lockfile materializes
only when the gate does. subai's single-file map stays the recorded **alternative** for a project that
prefers one lookup home — to be settled by the first runner if the lockfile separation proves heavy.

---

## The challenger's catch (Janus, before lock)

**Verdict: REVISE — the bones hold; one beam (L3) was wrong.** The split-tier finding, the
"executable-state map ≠ decision ledger" lesson, L4's empty-until-gated guard, and the seal-gate are sound.

**The catch:** as first drafted, L3 made "discovery-only" a *promise* where 0004 made it a *structure*. The
live beacon (`registry/subai.devenv.md`) is discovery-only not because a sentence asks agents to treat it
so, but because it **physically contains no actable fact** — only addresses; "source-wins" is trivially
true when the copy holds no callable column to lose. The first L3 left it *unspecified* whether the synced
copy could carry the Tier-G executable columns — and that silence is where F4 creeps back: an agent
cold-reading a synced `working-state: ok` will call on it, ignoring the date exactly as the subai `flag.md
CLOSED` stamp was ignored. The `status: cleared` field the beacon already syncs is *not* a counter-example —
it is a coarse, non-executable lifecycle label nothing is ever called against; the forbidden move is syncing
the *callable* tier.

**Resolution (folded into L3 above):** the cross-project surface is forbidden any actable column **by
construction** — beacon stays a pure pointer; an optional derived snapshot carries Tier-S intent only (the
non-executable `status:`-class); the Tier-G executable columns never sync. Discovery-only now holds by
*absence*, matching 0004 L4's "structure, not promise."

**Secondary watch (folded into L6):** the original seal-gate fused two distinct conditions under
"rule-of-two" — *verify-the-mechanism* (subai's one packaging-shift, Force 7) and *generalize-the-pattern*
(a second project needing it). Named as two separate seal conditions so one packaging-shift is not misread
as license to lock cross-project.

**Operator's catch — post-Janus, folded into L7:** the draft codified the *shelf* (homes, tiers, trust) but
not the *obligation to shelve* — no trigger tying a tool's existence to an emitted row, so "fluent capture"
was a hope, not a rule, and a successor architect had no written duty. Closed by **L7** (emission discipline:
definition-of-done + graduation trigger + seat-obligation + Stage-1 detection backstop).

---

## Consequences

- Tools get a publishing home **without a new flag/pulse-spine citizen**: intent in the contract (plane 2),
  facts in a generated lockfile (Tier-G-committed), discovery via the beacon (0004, plane 3).
- **Capture is fluent, not retroactive (L7):** documentation is emitted at each graduation transition as part
  of done — the original "tools scatter and get forgotten" gap is closed by a trigger, not a periodic sweep.
- **Not a second knowledge system (Force 3):** like 0004, a pointer/inventory over the one source — true
  *only as long as* the discovery copy stays derived, holds no callable column, and the source wins.
- **Boost-equivalent, available now:** a cold-started agent reads the contract `tools:` block to find what
  exists; once the gate runs, it trusts the gated columns enough to call. The spectral-RAG inherits this
  surface later instead of replacing it.
- **Append-only teaching preserved:** the "executable-state map ≠ decision ledger" lesson, the
  structure-not-promise correction, and the seal-gate pattern get a record they can be cited *from*.

---

## What an agent does differently

- **To publish a tool:** add it to the project contract `tools:` (Tier-S intent) with a `graduation-state`.
  **Never** hand-stamp a fact column.
- **To keep capture fluent (L7):** emit/refresh the contract row *at* each graduation transition — the row
  is part of done. The duty came with the architect seat; do not defer it to a later documentation pass.
- **To trust a tool's state:** read the gate-verified lockfile (Tier-G-committed), **project-side only**.
  No lockfile ⇒ state is *unknown* — discover, do not trust.
- **To find a sibling's tools:** read the beacon / intent-snapshot (discovery) → jump to the project → call
  there. The cross-project copy carries no callable column; never treat it as live state.
- **At a packaging-shift:** follow L5 — freeze, extract, stub, flip `graduation-state`.

---

*Source mail: `_mail/houston/inbox/subai.houston.tool-lifecycle-doctrine.2026-06-25.md`.*
*Lineage: doctrine §1b (sovereignty gradient), §2 + §4.5 (seat-obligation, gate-big-flow-small), §3b
(contract / verify-gate / F4), decision 0004 (registry).*
*Next: @majkee gavel → on lock, add index.md row + flag, then subai runs Stage 0 as first runner.*

---

*Evidence redirect (wave 2 audit — 2026-07-07): source mail drained verbatim to `temple/evidence/0007/`
(never edited; home is outside `temple/decisions/` by design — adr-guard domain stays crisp):*
- `temple/evidence/0007/subai.houston.tool-lifecycle-doctrine.2026-06-25.md` — original subai → temple
  dispatch (tool-lifecycle proposal, post-@Janus, reconstructed verbatim from transcript; operator-approved)
