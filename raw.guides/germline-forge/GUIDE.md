---
title: germline-forge — build one identity, two bindings, two renders; fold it to project or global; prove it; promote it
scope: germline-forge
audience: builder (atlas-ui / atlas-auto / Codex harness builders) + operator + any seat asked to witness or promote a forged agent
machine: both
verified: 2026-10-07
verified-note: distilled from the Houston forge (nablarva-X0-restarted, closed GO + KEEP; package frozen three times; witnessed by assay on claude 2.1.292; Codex routes per codex-cli 0.160.0)
half_life_days: 30
recheck: on any claude-code or codex-cli upgrade (entry mechanisms and spawn behaviour are weather — Sella L8); on the next forge (Codex side proof, Atlas re-forge)
status: DRAFT — first distillation; majkee reviews; becomes canon by his word, not by age
authority: nablarva flag L16 @ 32b645f (one identity · three cards · L16.14 pens) · germline README (source → stamped one-way render) · majkee gavels 2026-10-07 (binding homes · 7 files · B4) · Sella §5.4 (promotion = reviewed merge)
---

# germline-forge — how an agent is forged, folded, proven and promoted

`what: the build protocol for a germline agent — vendor-blind identity + project addendum + one binding per vendor → one fully derived render per vendor; where each layer lives for a GLOBAL seat vs a PROJECT seat; which checks make the derivation honest; how a witness proves behaviour; what promotion is and is not.`
`not: a new Sella law. Sella says WHY (agents = programs; the compiler is stochastic; promotion is a reviewed merge). This guide says HOW, dated. Where they disagree, Sella wins and this guide is stale.`
`born: the Houston forge, 2026-10-05→07 — package raw/houston/ (7 files), three freezes, one witness in three rounds, one real audit. Raw material: raw/observations.atlas-ui.2026-10-07.md (31 dated lessons).`

## 0 · The shape in one picture

```text
identity.md ──────────────┐      vendor-blind, project-blind · the cards · evidence discipline
project/<project>.md ─────┤      roles → real paths · landing · keeper state · project method
binding.<vendor>.md ──────┤      entry · permissions · delegation authority · return destination
                          ▼
render/<vendor>/<slug>.md       = identity ⊕ addendum ⊕ binding, byte-copied into three marker
                                  pairs, first body line = the stamp (three canonical paths @ blobs)
                                  — fully derived; never edited; recomposed from sources
                          ▼
runtime artifact                  what a runtime actually loads: Claude → a copy at
                                  .claude/agents/<slug>.md; Codex → a custom-agent TOML (child) or a
                                  profile (main session) carrying the composed body
```

Precedence is fixed: a later layer **specialises** an earlier one — adds paths, procedures,
mechanics — and never overrides the identity, a project lock, or the runtime's own instruction
hierarchy. A disagreement between layers is a finding, never last-file-wins.

## 1 · Seven files, and why seven (majkee 2026-10-07: "full invariance; reduce if orphans")

| file | writer | role |
|---|---|---|
| `germline/agents/<slug>/identity.md` | one | the program: who, what it never owns, its cards, evidence rules, capability + authority limits, saddle. **No vendor fact, no project path.** |
| `project/<project>.md` | one (project facts reviewed by the project's design seat) | the addendum: the identity's roles mapped to real homes; where each card's output lands; keeper state and migration; project procedures; first-audit seed |
| `binding.claude.md` · `binding.codex.md` | one each | mechanics only: frontmatter the render carries · card selection · **entry declaration** (child vs main-session, four fields) · placement · proof list · `verified:` |
| `render/claude/<slug>.md` · `render/codex/<slug>.md` | the binding's writer, by pipeline | derived, stamped, marker-wrapped; the only thing a witness sees loaded |
| `README.md` | the package writer | manifest (full blobs) · workbench↔canonical map · the three checks · who-runs-when · loading per vendor · witness brief · provenance |

Reduce to five (binding as a marked section inside the render) only if the binding sources prove
to be **orphans** — edited only in lockstep with their render, or never. In the Houston forge both
bindings were edited independently twice (home line; entry declaration) → not orphans.

## 2 · The fold — where each layer lives (chapter `fold-scheme`)

| layer | GLOBAL seat | PROJECT seat | reaches live by |
|---|---|---|---|
| identity | `~/reposoma/.germline/agents/<slug>/identity.md` | the global one (projects do not fork identities) | commit reposoma · `~/.germline` symlink · **no deploy leg** |
| addendum + bindings | — | `<project>/.germline/agents/<slug>/{<project>.md, binding.<vendor>.md}` (gaveled 2026-10-07) | committed **with the project**; manual |
| Claude render | `~/ia-sync/claude/agents/<slug>.md` | `<project>/.claude/agents/<slug>.md` — **wins over the same-name global** (B4, observed 2026-10-07) | global: `bash ~/ia-sync/deploy.sh` → both machines · project: commit with project, **no deploy.sh** |
| Codex render (child) | `~/ia-sync/codex/agents/<slug>.toml` | `<project>/.codex/agents/<slug>.toml` — selected via `spawn_agent` | global: deploy.sh leg exists · project: commit with project |
| Codex render (main session) | a named **profile** in `~/.codex/config.toml` (`codex --profile <slug>`) — local by design | same | **manual, per machine** |
| workbench | `<bed>/raw/<slug>/` — the seven files, deploy-inert, read by nobody at runtime | same | never; promotion = reviewed merge (Sella §5.4) |

Every source carries `home:` (workbench path now · canonical path after promotion). A render whose
stamp carries a workbench path or an `UNASSIGNED-…` element is reviewable, **not promotable**.

## 3 · The three checks (chapter `checks`) — three questions, none substitutes for another

1. **`verify_cmd` — unchanged bytes?** `git hash-object` of the six source/render files against the
   README manifest (README excluded from its own hash). Runs in zsh as written.
2. **Body equality — equal bodies?** Six `diff` lines (three per render): the render's marker section
   vs the source body (bytes after the second `---`); plus exactly one opening/closing marker per
   section. Catches a stale binding hiding behind matching hashes — it did, on day one.
3. **Stamp currency — current stamps?** Each stamp element (identity · addendum · binding) pins the
   current source blob. Catches a frontmatter-only source edit (bytes changed, bodies did not).

Who runs them, when: each writer before returning · the carrier before any POINT touching the
package · the gate reviewer first, **then a composition read** (hashes prove bytes, not meaning).

## 4 · Entry declaration — one identity, two bindings per vendor

| | child binding (returns bounded work) | main-session binding (leads a bounded invocation) |
|---|---|---|
| Claude | `Agent` spawn from `<project>/.claude/agents/<slug>.md` | `claude --agent <slug>` in the project root |
| Codex | custom-agent TOML via `spawn_agent` | `codex --profile <slug> -C <root>` (0.160.0: `--profile`, no `--agent`) |
| declare | **entry · permissions · delegation authority · return destination** — the same four fields on both vendors | |

Facts that bind the declaration (dated): on claude 2.1.292 **a child can spawn and inherits the
parent's effective permissions** — the runtime does not fence a child; **the card must** ("no card
spawns an executor" lives in the identity; the forbidden spawn set lives in the binding). Every
capability claim in a binding carries the client version it was observed on; the witness re-dates
or falsifies it.

## 5 · Proof and witness (chapter `witness`)

Composition checks prove bytes. **Behaviour is proven only by a fresh session, witnessed by a seat
that authored none of it** (L16.8): the author cannot witness, a subagent the author spawns is a
pre-check, not a witness. The brief is a table — exact prompt (absolute paths) · "PASS looks like" ·
"FAIL looks like" · observed · verdict — one prompt per row, a mid-turn nudge is a new row, first
~5 lines pasted verbatim or the row is `secondhand`. The witness places and removes the test copy.
`verified:` in the binding then states **exactly** what the witness allows and what stays unproven.
Witnessing ≠ promotion.

## 6 · Promotion — a reviewed merge, never auto-deploy (Sella §5.4)

The operator names destinations (gaveled homes, §2) · copies source and render · commits · the
render's `revision:` is stamped from the committed identity · the global render reaches both machines
through `deploy.sh`; project files travel with the project; the Codex profile is set by hand on each
machine. A promotion copy is verified at the destination with the same three checks (`cmp` / blobs);
runtime availability needs a fresh-session proof *at the destination* — a matching hash proves only
composition. The keeper migration (if the agent inherits a maintainer role) follows promotion, because
it must point at a card that exists.

## 7 · Lessons that cost something (full list: `raw/observations.atlas-ui.2026-10-07.md`)

- Files carry the work; the wire carries one line + a path (a head filled to 81 % on RETURN bodies).
- Batch metadata edits with body edits and say "final" — a partner recomposes once.
- Compose renders by pipeline; write sources by hand.
- A POINT written over a moving disk is stale in minutes — the README manifest wins.
- Declarations get witnessed as hard as behaviour; the only FAIL in three rounds was the author's
  runtime claim.
- A cold-start card is committed in the session that writes it; a keeper is named in the
  promotion manifest or it dies with the bed (this file's own raw material did, once).

## Sella anchor (proposed; Sella untouched until majkee says)

Under Sella §5 "A conforming application", item 4 (promotion protocol), one line:
`→ build/fold/prove/promote procedure, dated: raw.guides/germline-forge/GUIDE.md (DRAFT 2026-10-07).`

## Manifest

| file | class | title |
|---|---|---|
| `res/fold-scheme.md` | chapter | fold-scheme — global vs project seats, deploy legs vs manual, canonical homes, the workbench |
| `res/checks.md` | chapter | checks — the three commands as run, who/when, the failure each one catches |
| `res/witness.md` | chapter | witness — brief shape, rows that worked, rules that keep a row honest, what `verified:` may say |
| `raw/observations.atlas-ui.2026-10-07.md` | raw (uncanonical) | 31 dated lessons from the Houston forge — the source of §7 |
| `raw/note.atlas-ui-to-carrier.2026-10-07.md` | raw (uncanonical) | one carriage note (POINT vs disk) kept as evidence for the "manifest wins" rule |

## Lineage — point, never copy

Houston forge: nablarva `d1c4b1e` (bed preserved whole) · `fe32a29` (stub) · package now at
`nablarva/.dev/session/nablarva-X1-architecture/raw/houston/` until promotion · witness
`raw/witness.claude.2026-10-07.md` · audit `raw/houston-audit.2026-10-07.{md,diff}` · locks flag L16 ·
record `nablarva@2ae8636:.dev/architect-now-uncanonical/`. Precedent for the package shape: Shuttle
(`~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/atlas-ui/`, 3 files). Codex invariance
note: `~/reposoma/.majkee/journal/2026-10-07.md` §1.1.
