# Decision Record — Sovereign Agent Build: what locks

`status: LOCKED 2026-06-17 (gaveled by majkee)`
`date: 2026-06-17 · thread: agentive-collaboration / sovereignty`
`shape: ADR — context · decision · consequences · what-an-agent-does-differently`

> Synthesis of the sovereignty report (external triangulation) measured against the
> temple doctrine + activation study (existing canon). The report re-derived the
> doctrine; this record locks the convergence and flags the genuine forks.

---

## Context

A solo operator across several CLIs (Claude Code, Antigravity, Cursor, Codex, piql),
keeping know-how as sovereign markdown + git. Three models under test: **A** sovereign
markdown, **B** native primitives, **C** MCP-served. The report leans A-as-canon; the
doctrine already says the same (Force 3). The work of this thread was to measure one
against the other and find where the existing build exceeds the report, where the report
exceeds it, and what the convergence licenses us to lock.

---

## Locked

**L1 — The architecture.** Model **A is canon**; **B is a thin enforcement layer**
(hooks, model routing) adopted surgically; **C is a thin live slice** (schema, last error,
logs, post-cutoff docs), *sized by the operator, not by the report's default*. The fork
is static-vs-live, not markdown-vs-MCP.

**L2 — `agentctl` is the gate, not Ruler.** It is a *superset* of the report's recommended
compile-down (adds parameterized templates + contract + lockfile drift-verify, which Ruler
lacks). Keep building it; do not swap. Resist frameworkitis (< 300 lines). Fold in the four
report→agentctl deltas: AGENTS.md as a first-class materialize target · governance-as-code ·
deferred-loading on the live MCP · OpenCode held as runtime hedge.

**L3 — Sovereignty is three tiers, not two.** `[S]` sovereign-authored · `[GC]`
generated-but-committed · `[GW]` generated-&-gitignored. `"nothing to migrate"` is true
**only for [S]**. `.claude/settings.json` is `[GC]` and **per-vendor** — the trust layer
must live in git for provenance even though no human types it. **Trust is a materialize
target; it never ports.**

**L4 — The graduation rule.** A vendor-owned format graduates to canon-safe **when a
neutral body takes stewardship**. AGENTS.md graduated (AAIF, Dec 2025) → reclassify it
out of vendor-weather toward `[S]`-grade. MCP and SKILL.md are mid-graduation by the same
test. The file plane gains a *law for movement between columns* instead of a manual re-sort.

**L5 — Force 3 gets its boundary.** "Nothing to migrate" is scoped to the **knowledge
layer**. The **integration layer** — `agentctl`, registry, MCP profiles, trust config —
carries real migration cost. State the boundary; budget for it; stop over-claiming it away.

**L6 — Two supply chains, split by ownership.** Framework primitives (Laravel style) flow
via **Boost / composer**. Cross-project sovereign primitives (temple, agents, conventions)
flow via **agentctl** from the meta-repo. They must **never both own one file.**

---

## The challenger's one risk (adversarial pass before lock)

**Two generators, one file.** In a Laravel project, `boost:install` regenerates `AGENTS.md`
*and* `agentctl materialize` wants to write the operator's conventions into it. Two writers,
one surface → silent clobber (the *greenfield-on-brownfield* failure mode, doctrine §4). This
is the single most likely thing to bite, and L6 only names the principle — the **operational
seam** (which section, what order, who runs last) is unresolved and lives on the practical
(Freya) side. Until that seam is fixed, treat any project running both Boost and agentctl as
**drift-prone** and gate `AGENTS.md` with `agentctl verify` in CI.

---

## Open — flagged, not locked

**O1 — Model-C live-slice sizing.** The report defaults thin; the operator's workload
(operating live systems > writing about them) may want it fat. Operator-only sizing; no
external evidence resolves it.

**O2 — Spectral-engine driving challenge/process maps.** Parked in
`multi-agent-composition-and-swarms.seed` — that study's exact lens. Cohabitation is
out-of-box (engine as local MCP, Claude reads results), never in-process. Brief on request;
must not eat this frame.

**O3 — The cleaned system map.** Add `Atlas → Zenith`; keep `@Trajectory` self-clone and
`@Houston → @Delta` (trivial reads); drop only the word "swarm" from the feedback edge.

---

## What an agent must do differently (the compile-down lifts this)

- Author canon in **Tier 1 only**. Never hand-edit a Tier 3 file — it is regenerated.
- Treat `AGENTS.md` as **canon-grade but still a generated output**; never let two
  generators write it.
- In Laravel projects, **Boost owns framework guidelines; agentctl merges sovereign
  conventions after** — and `agentctl verify` guards the seam in CI.
- Governance (`deny`-first + `PreToolUse` backstop) is **materialized per vendor**, not
  assumed portable.
