# Onboarding kit — from a filled intake to a project's first bones

`tier: raw.guides · the deliverable bundle the architect emits per project`
`audience: Houston (or an architect agent) onboarding a project from raw.guides/project-intake.md`
`date: 2026-06-17 · companion to: bootstrap-new-project.md (the procedure) · DRY by reference`

> The intake (`raw.guides/project-intake.md`) is the INPUT. This file is the OUTPUT contract —
> what *"PROJECT.yaml and not only that, per temple dogma"* means concretely. One bundle per
> project. Smallest-first. Procedure lives in `bootstrap-new-project.md`; this adds the routing,
> the bundle definition, the light-gate for Gemini/Cursor, and the red-flags checklist.

## Scope fence (read first)
The project architect comes here to stand up the **agent-build part only**: the team skeleton, the
contract, the durable-file stubs, the gate, the thresholds. The application architecture, the domain
code, and the roadmap are **his business** — I take *capability terms* from his contract and never
do the stack work. (doctrine §0, §4: don't greenfield-on-brownfield; merge into his house.)

## Intake → where each answer lands (the routing — not everything is the contract)
| Intake | Lands in |
|---|---|
| A · name + purpose | `PROJECT.yaml: name` |
| C · stack / commands / docs | `PROJECT.yaml: stack · commands.* · docs.*` |
| C · hard constraints (comment-lang, forbidden tools, security rails) | **flag.md invariants + per-vendor trust layer** — *not* `PROJECT.yaml` (schema v1 has no `constraints` field; trust never ports, §7) |
| B · nature of work | the **seat list** (4 base seats always; domain seats *earned*, §5) → feeds `agents:[…]` |
| D · teams + one head + mine/yours split | vendor-team allocation + registry record + `mcp_profile`; ownership → flag/plan |
| E · volume & cadence | the **named deferral thresholds** (orchestrator / sub-team) → flag/plan |
| F · live state | `mcp_profile` + Model-C sizing — **deferred (O1)**; keep `.mcp.json` a placeholder |
| G · out of scope | flag/plan |

## The bundle (one per project — "PROJECT.yaml and not only this")
1. **`PROJECT.yaml`** `[S]` — contract v1 (schema in `tools/agentctl.spec.md`). The one file an agent may assume.
2. **`session/{plan,flag,pulse}.md`** `[S]` — durable files, seeded (plan=doing · flag=locked · pulse=volatile).
3. **`docs/ARCHITECTURE.md`** pointer + **`docs/decisions/`** `[S]` (ADR dir, append-only) — the entry points the contract names.
4. **registry record** — reposoma plane-3 binding (which agents / profile / path). By hand until/unless agentctl exists.
5. **the gate** — for Gemini/Cursor, by-hand light surfaces (below); robust `agentctl materialize` **deferred**.
6. **named deferral thresholds** — written out loud in flag/pulse (when a domain seat / orchestrator / sub-team is earned).
7. **the trust/constraints layer** — intake-C constraints → flag.md + per-vendor settings (deny-first + PreToolUse). Per vendor; never assumed portable (§7).
8. **registry beacon** — deposit `registry/<project>.md` (a thin pointer to the project's lighthouse) + a row in `registry/index.md`, so siblings find you. Point, never copy (see `registry/README.md`).

Start every project with the **four seats** (doctrine §6): architect + challenger + researcher + implementer. No domain seat pre-granted.

## The light gate — Gemini (`agy`) + Cursor: do NOT build a lot
Per operator (2026-06-17): these two need no robust system. The cards converge on *one source, three consumers*:
- Author **one `AGENTS.md`** at repo root `[GC]` — the graduated, canon-grade cross-tool surface every runtime reads.
- **Gemini CLI:** set `contextFileName: AGENTS.md` in `.gemini/settings.json` (so `GEMINI.md` → `AGENTS.md`). Skills via the shared SKILL.md corpus (same open standard, reused — never duplicated). MCP minimal/placeholder.
  - ⚠ **Auth path:** personal-login Gemini CLI **sunsets 2026-06-18**; target the surviving **API-key / Antigravity (`agy`)** surface (`~/.gemini/antigravity-cli/`), *not* the dying personal login. (`agy` is not 1:1 parity — re-verify.)
- **Cursor CLI/IDE:** reads `AGENTS.md` (fallback contract) + `.cursor/rules/*.mdc` (scope by globs, the native leash) and loads the shared `~/.claude/{skills,agents}` corpus directly. MCP at `.cursor/mcp.json` (minimal/placeholder).
- **No `agentctl`, no lockfile, no materialize pipeline** for these two. The robust gate earns its seat only at Claude-harness scale / ≥2 actively-materialized projects (agentctl spec, activation entry B). Defer it; name the threshold; don't pre-build show.

## Freshness gate (operator rule: a raw.settings primitive is trustworthy only if `verified` ≤ 72h)
Fresh today (2026-06-17) = `verified` ≥ 2026-06-14. Status of the cards this onboarding leans on:
- `raw.card.gemini-cli.md` — `verified: 2026-06-02` → **STALE (15d)**. The load-bearing volatile fact is the **2026-06-18 sunset / auth path** — verify *that* before onboarding a Gemini surface.
- `raw.card.cursor-ide.md` — `verified: 2026-06-02` → **STALE (15d)**. Surface conventions are stable; recheck the MCP path only.
- `raw.card.agents.addendum.md` — `verified: 2026-06-11` → **STALE (6d)**. Recheck MCP config paths before baking them into a surface.
- **Pragmatic call:** the surface *conventions* (AGENTS.md, `.cursor/rules`, `GEMINI.md→AGENTS.md`, shared skills) are stable enough to use now; only the Gemini auth/`agy` fact is urgent. A full re-derivation is not needed — a targeted researcher recheck of the volatile bits (card `recheck:` URLs) suffices.

## Red flags to clear with each architect
- **R1 · template collision** — two projects, one intake file. Each fills its **own copy** → `raw.guides/intake/<project>.intake.md` (or hands prose). Keep the template blank.
- **R2 · constraints outside the contract** — `PROJECT.yaml` v1 has no `constraints` field. Capture comment-language / forbidden-tools / security-rails in flag.md + the per-vendor trust layer, or they are silently "not promised."
- **R3 · no agentctl yet** — Gemini/Cursor surfaces are hand-authored; drift-prone until a `verify` step exists. Gate any generated surface manually. (Robust agentctl deferred per the light gate above.)
- **R4 · two-generators-one-file** (0001 challenger risk) — a framework generator (e.g. Laravel Boost) + a sovereign writer on the same `AGENTS.md` → silent clobber. Ask in intake; if both, framework owns its guidelines, conventions merge *after*, verify guards the seam.
- **R5 · one-direction / one-head** (Force 4) — each project architect is *that* project's one head; reposoma basement holds cross-project canon. Confirm the mine/yours split so a consumer edit never becomes canon by accident.
- **R6 · Model-C untuned** (O1, field-work gavel 2026-06-17) — live-slice sizing deferred; `.mcp.json` stays a placeholder. Do not design it.

## Order of operations (per project)
1. Architect fills their intake copy → hands it to me.
2. I draft the bundle (1–7) smallest-first, light gate for Gemini/Cursor.
3. **@Janus challenge** on the contract before lock (Force 6).
4. Operator gavels → lock to flag/decisions.
5. Author the light surfaces by hand (verify the auth/freshness flags first).

> The smallest team that ships one correct thing beats the complete team that ships an org chart.
