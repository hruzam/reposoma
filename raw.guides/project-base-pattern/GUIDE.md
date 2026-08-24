# Project base pattern — flag · pulse · PROJECT.yaml (quick matrix)

`tier: raw.guides · operator FYI quick-reference (NOT canon — derived snapshot, sources win)`
`audience: @majkee (operator) · a one-glance reminder, not a spec`
`date: 2026-06-30 · host: office`
`derived-from (authoritative — read these if the snapshot and they disagree):`
`  · bootstrap-new-project.md §5 ("plan / flag / pulse" per project)`
`  · temple/decisions/index.md (the temple-exception note: no per-substrate pulse)`
`  · decision 0007 (PROJECT.yaml tools:) · 0008 L9 (PROJECT.yaml protected:)`

> FYI card. The three files every project carries answer three *different questions*. Lose the
> distinction and you get drift (no pulse), re-litigation (no flag), or ungoverned agents (no contract).

## The essence (one breath each)
- **flag.md = memory** — *what's been decided and locked.* Settled, past-tense.
- **pulse.md = heartbeat** — *where we are right now.* Live, present-tense.
- **PROJECT.yaml = constitution** — *what the project IS.* The machine-readable binding contract.

**The one insight:** flag and pulse are the *same kind* of thing (human narrative docs) split by
**tense/volatility**; PROJECT.yaml is a *different kind* entirely — not narrative, but the **Tier-S
contract the tooling reads** (agentctl / the materializer).

## Matrix

| axis | **flag.md** | **pulse.md** | **PROJECT.yaml** |
|---|---|---|---|
| **answers** | what's decided (locks) | where we are (phase/status) | what the project is (contract) |
| **tense** | past — settled | present — live | standing — declarative config |
| **volatility** | durable; append-only (supersede, never edit) | volatile; rewritten each phase | stable; changes only deliberately |
| **format / consumer** | human MD — read before planning | human MD — status glance | machine YAML (Tier-S) — agentctl / materializer gated |
| **authority to change** | gaveled (operator locks it) | planner/coordinator updates freely | contract change — schema-validated, gated |
| **failure if missing** | re-litigating settled decisions | losing the thread / drift | no binding spec — agents/tools/trust ungoverned |

## The temple caveat (the part that catches people)
**reposoma is the exception by nature** — it's the meta-repo, *not* a project, so it deliberately has
**no pulse**. `temple/decisions/index.md` says it outright: *"the substrate has no volatile
session/pulse — that is per-project. Locks live here."* So in this repo the roles map differently:

| role | a normal project | reposoma (the temple) |
|---|---|---|
| **flag** (locks) | `flag.md` / decisions ledger | `temple/decisions/index.md` (0001…) |
| **pulse** (live status) | `pulse.md` | — *none* (per-project only) |
| **contract** (the spec) | `PROJECT.yaml` | — no single one; `registry/` (cross-project map) + each project's own `PROJECT.yaml` |

Projects (piql, vacuole, freya…) each carry their own three; the temple holds locks + the registry instead.

## Comment / confidence note
- High confidence on **flag/pulse** — they appear in both the seat-config *and* the canon, with matching
  wording in `bootstrap-new-project.md §5`.
- **PROJECT.yaml-as-Tier-S-contract** is grounded on 0007 (`tools:`) + 0008 L9 (`protected:`) — solid for
  the *role*; the *full field schema* lives in `tools/agentctl.spec.md` per project (read that, not this,
  for exact fields).
- This card is a **convenience snapshot, not a source of truth.** If it ever disagrees with the files in
  `derived-from`, the files win.
