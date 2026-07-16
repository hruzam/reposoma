# Project intake — reposoma.devenv (per-project copy)

`tier: raw.guides/intake · founding record · READ-ONLY — do not maintain here`
`canonical card: reposoma/raw.settings/raw.card.reposoma.devenv.md (create via /project-regular-self-report reposoma.devenv)`
`this file is the A–G source for Phase 2 (new card) — once the card exists this file becomes historical`
`project: reposoma.devenv · path (office box): /home/hruzam/www/ovum/reposoma.devenv`
`one head: @Houston (reposoma basement) · temple architect: @Houston (reposoma basement) — same seat (reposoma IS the temple's home)`
`rule: answer short. a blank means "not promised yet", not a bug. field work refines it.`

> Refreshed 2026-06-18 for the PROJECT.yaml author. Charter §6 forks ?Q-1..8 GAVELLED — see ⚖ GAVELS
> (supersedes inline "?Q gavel pending" markers). **D1 AMENDED 2026-06-18: build in `reposoma.devenv`;
> `reposoma.v2` reserved for the finished product; `PROJECT.yaml` lives HERE.** §D = GROUNDED (RR-01) + Janus-passed + LOCKED.

## A · Identity
- name + one-line purpose: **reposoma — a standalone, portable, file-based knowledge metabolism (capture → register → synthesize → spectral-analyze → derived views). Repository × ribosome: a translating machine, not an application.**
- which is this — "real reposoma", or a new one: **the real reposoma (restart). ?Q-1 LOCKED (D1) + AMENDED (2026-06-18): the workshop = THIS `reposoma.devenv` (P0 + dev happens here); `reposoma.v2` is reserved for the FINISHED PRODUCT app (promotion target, later); `/home/hruzam/reposoma/` = data substrate; `pulse.md` = invariant.**

## B · Nature of the work — this draws the domain seats (I grant none you don't earn)
- what dominates: **a mix — authoring/synthesis (RAG, canon, guides) + building/coding (engines, validators, tools) + a method-math heart (spectral). Build toward a beating loop FIRST (LAW-1). X→Z research cadence.**
- a narrow correctness/performance-critical heart? → deep core specialist: **yes — the spectral engine numerics (B → L_sym → eigsh → KMeans; centrality + Fiedler diagnostics). EARNED at P2, not pre-granted (LAW-1).**
- a body of method/math the team must get right? → domain researcher: **yes — spectral graph theory + the vector-language algebra (6 axes / 13 moves). Signal/spectral researcher seat pending load (P2+).**
- deterministic tools, agentive tools, or both? → the builder split: **both. Deterministic (register, retrieve, check, validators, `_grid::` flatteners, dashboard) → Composer / Claude-audit. Agentive (the Synthesizer/recorder — librarian-strict, ?Q-7) → Claude design + flash-tier runtime.**
- a human-facing surface where the system explains itself? → surface seat: **yes — terminal retriever (fzf/jq) + dashboard (cat pulse + git log + links) + the adopted graph organ (?Q-8). Vision drawing: `reposoma.devenv/architecture.vision.md`. Earned, not pre-granted.**

## C · The contract — becomes PROJECT.yaml (capability terms, not stack terms)
- stack (lang/framework — informational): **file-native — markdown (content) · JSONL (database + vector trace) · JSON (registry/tree) · CSV (`_grid::` projections = spectral B-matrices) · Python (spectral engine: numpy/scipy/eigsh, ISOLATED to that brick) · sh/py (register, retrieve, check, hooks). No DB server (LAW-4). NOT a vector DB (§7) — association = the spectral embedding (eigenvectors), computed from the file-graph, not stored. On-disk naming = ?Q-4 LOCKED (D4): factory-standard technical names; biology only in project names.**
- commands: test · lint · build · run: **P0: `bin/register <file|stdin>` · `bin/synthesize <id>` · `bin/check <id>` · `bin/retrieve [query]`. build=none (file-driven organs). test=`check` (the 3-assertion audit). Pinned as the P0 skeleton lands (`session/plan/session.plan.md`).**
- docs entry points: architecture · decisions · conventions: **architecture=the charter (canonical `reposoma.v1/DASHBOARD/synth.restart.reposoma.md`) + the vision drawing (`architecture.vision.md`) + the active plan (`session/plan/session.plan.md`); decisions=charter §6 gavels + §8 ADDENDUM (→ `flag.md` at P0.5); conventions=`CLAUDE.md` + the 5 laws.**
- hard constraints: comment language · forbidden tools · security rails: **comment lang=English; forbidden=DB server, vector DB, cloud-required state, heavy/pretty viewers (Obsidian/Superset — !D-A1), electron-class weight, absolute hardcoded paths; rails=the 5 laws — esp. LAW-1 (#loop-before-organs) + LAW-4 (truth-in-files) + LAW-5 (sovereignty).**
- **PROJECT.yaml lives in `reposoma.devenv/` (D1-amended), authored by the other temple architect (operator-authorized 2026-06-18).**

## D · Teams & the one head — the allocation  **[GROUNDED by RR-01, 2026-06-17 — see report]**
- vendor-teams on this project: **Claude basement (always — lead/OWNER) · Cursor (Composer-preferred OWNER for surface + scaffolding — Codex-as-primary is the expensive seat, RR-01 §4b) · Gemini (CONSULTANT ORACLE, NOT an owner — solo/personal delivery surface sunsets 2026-06-18, no confirmed consumer-API CLI path; query for math/large-context grounding via whatever auth survives) · piql local Qwen + Qwen CLI (flash/mouth tier, reserved — !D-A4).**
- the one head (allocates work, holds canon authority): **@Houston (reposoma basement). Operator (@majkee) = the human gate + math/physics/PHP advisor + fetch-subagent (eyes/hands where the team has no reach).**
- the split — what each team OWNS ("mine / yours"). Canon stays at the basement gate:
  **GROUNDED by RR-01 (reposoma-specific) · @Janus-passed · LOCKED 2026-06-17 — two STANDING owners + two ON-DEMAND.** *(Reconciled: deterministic-tools ownership moves Claude→Composer on the cost-gradient — reposoma RR-01, not the shared subai map; Composer builds cheap-exact, Claude audits.)*
  - **Claude (STANDING · lead)** — the thinking-scalpel + agentic-test-loop bricks: the spectral-numerics *test-loop* · MCP fingers + hooks (the agentive seam) · the agentive Synthesizer/recorder design; PLUS architecture · canon authorship · cross-team **audits + tests** · bash · the plan. [RR-01: Claude LEAD on numerics test-loop, MCP+hooks, audits — hardest-confirmed cell]
  - **Composer (STANDING · owner)** — **deterministic tools** (register · retrieve · synthesize-glue · validators · `_grid::` flatteners · dashboard) AND surface/render bricks (the "skin" analogue) as LEAD; cheap-exact (~1/10 cost), Claude audits exactness. Prefer Composer over Codex on cost. [RR-01: Composer LEAD on deterministic + surface; cost-gradient]
  - **Codex (ON-DEMAND specialist)** — hard-math consult on the spectral algebra (RR-01 refined X *up* — strongest hard-math of the four) + the C++/native brick when summoned. **Not a standing owner.**
  - **Gemini (ON-DEMAND · consult-only)** — queried oracle for method-math cross-check · large-context synthesis · blind scope re-synthesis, via whatever auth survives 06-18. Non-load-bearing by **capability first, sunset second**; owns no brick. [RR-01 BROKE X's "fine bash, good C++"]
  - Each owner builds + self-tests; canon stays at the Claude gate, one-direction (Force 4). **Socket↔seat map + MCP yes/no = ?Q-5 (piql portion RESOLVED — see GAVELS D5).**
  - **Two flagged Z's — NOT built (LAW-1, earned, never on the spine):** **(1) `spectral-oracle`** (numerics-correctness golden-fixture harness; promote FIRST at P2). **(2) OpenCode-shaped model-neutral CLI** (sovereignty, LAW-5; Orby Z2: Goose/mcpc/llama-swap). Flip-conditions in RR-01 §7.
  - **C++ = a flagged Z-branch sandbox** (LAW-1 / X→Z), OFF the file-native spine; promotion-gated on a *named* brick the `sh`/Python spine provably cannot meet, AFTER the loop beats. Not a §D seat (@Janus: don't harden a wish-to-learn into canon).

## E · Volume & cadence — this sets the thresholds I name out loud
- how much work, how fast (rough): **P0 ACTIVE — the loop has not beaten yet (LAW-1 — that IS the work). Single operator present as the gate. Low volume.**
- "every few steps" feedback = how many steps / how often: **at every phase gate + before every lock (X) → operator sees it; one decision = one durable record. Feedback discipline = temple lean (cooperation convention below).**
- the threshold that would earn a msg-bus / orchestrator / sub-team (or leave to me): **DEFER all. Cross-seat exchange follows the temple lean (human pulls the trigger). No `_bus/` until the loop beats (LAW-1). Orchestrator = show until human routing is a *measured* bottleneck. Executor abort convention = ?Q-6 (D6: research commissioned, RR-04).**

## F · Live state — Model-C sizing (the one untuned string)
- does the work need runtime truth (schema · last error · logs)? how fat: **yes, but THIN. Runtime truth IS the files — `registry.jsonl` (status), the vector-move JSONL trace, the spectral `analysis_report.md`. No constantly-running DB (LAW-4). The spectral engine reads compiled B-matrices (csv/jsonl), not a live server.**

## G · Out of scope — what this project does NOT promise:
- **NOT larva / a larva dev tool · NOT an agent framework · NOT a transport protocol · NOT a vector DB · NOT a memory product.**
- **NOT a 1:1 home↔office agent mirror · NOT a UI project until v2/v3 (Sublime + terminal suffice).**
- **NOT a pretty-viewer project — Obsidian/Superset/heavy-look OUT (!D-A1). NO heavy DB · no cloud-required state · no wrapper-on-wrapper REST.**
- **NOT a second parallel canon — sovereignty + portability (LAW-5).**

---

## ⚖ GAVELS — charter §6 LOCKED (canonical: `reposoma.v1/DASHBOARD/synth.restart.reposoma.md §6`)
Supersede inline "?Q gavel pending" markers above.

- **!D1 (?Q-1) — LOCKED + AMENDED 2026-06-18.** Workshop = **`reposoma.devenv`** (P0 + dev here). **`reposoma.v2` reserved for the finished product app** (promotion target, later). `PROJECT.yaml` + `flag.md` live HERE. `/home/hruzam/reposoma/` = data substrate; `pulse.md` = invariant.
- **!D2 (?Q-2) — LOCKED.** Reduced 5-move profile for v0; preserve the full 13-move shape in project files as a future/pickable style.
- **!D3 (?Q-3) — LOCKED.** First mRNA = the charter's own source buffer (`_mail/raw.toSynth.project.md`).
- **!D4 (?Q-4) — LOCKED.** Factory-standard technical names on disk; biology only in project names.
- **!D5 (?Q-5) — piql portion RESOLVED 2026-06-17** (`research/outputs/piql.decision.2026-06-17.md`): piql = **optional privacy-gate brick** (adopt subai's floor; spine never depends on it), **NOT the flash/mouth socket** — that charter assumption was corrected. Flash/mouth = a separate seat (candidate: local Qwen via `llama-swap`, Orby Z2), earned post-loop. **Full socket↔seat map + MCP yes/no still open.**
- **!D6 (?Q-6) — research commissioned.** RR-04 abort-convention brief (`research/inputs/abort-convention.brief.md`) → @majkee's research lab.
- **!D7 (?Q-7) — LOCKED.** Librarian-strict synthesizer in P0–P1.
- **!D8 (?Q-8) — free hand** to Houston + research centre. Orby Z1 candidates (Cosmograph / Sigma.js / Vizdom) → ground + counterweight + @Janus at P2.

## ✱ P0 status (active)
Plan: `reposoma.devenv/session/plan/session.plan.md` — DRAFTED, @Janus-passed (the `check`-brick hole closed), D1-amendment + Orby's reviewed skeleton drafts folded. **Awaiting @majkee's go + builder pick.** Vision drawing: `architecture.vision.md`.

## ✱ Cooperation convention — temple architect's lean (ADOPTED 2026-06-17)
- **Exchange shape:** `<to>/<from>.<topic>.<utc-ts>.md` — sovereign md, vendor-neutral. Live mailbox = `_post/` (frozen `_mail/` = boot snapshot). First message landed: `_post/subai-epoch/houston.read-surface.2026-06-17.md`.
- **Human pulls the trigger** — no headless `-p` dispatch; staged briefs wait for the operator.
- **Research seam** rides `research/inputs/ → research/outputs/`. **Defer the headless worker bus** until measured volume + verified need + stable surface.
- **Feedback discipline:** every gate + lock surfaces to the operator; one decision = one durable record.

## ✱✱ Open research requests (X→Z law: X grounded @date · Z = the develop-it vector, flagged, behind a branch)
- **RR-01 · brand-competence — GROUNDED ✓** (`~/reposoma/research/harness/reports/RR-01-...md`). Folded into §D (LOCKED).
- **RR-02 · graph organ (?Q-8/D8)** — single-voice answer from Orby (Z-catalog Z1); owes counterweight + grounding + @Janus before P2 lock.
- **RR-03 · charter re-synthesis** — STAGED (now a second-brand sanity pass on the locked gavels).
- **RR-04 · abort convention (?Q-6/D6)** — X first-kick STAGED for the research lab (`research/inputs/abort-convention.brief.md`).

## ✱✱✱ Z-catalog — Orby's parting gift (Gemini, 2026-06-17 · `_mail/houston/orby.the-z-vector-parting-gift...md`)
ONE consultant voice — flagged, NOT grounded/triangulated/challenged; all parked behind LAW-1.
- **Z1 graph organ → ?Q-8:** Cosmograph (cosmos.gl) · Sigma.js v3 + Graphology · Vizdom (Rust/WASM).
- **Z2 sovereignty CLI → §D Z(2):** Goose (Block) · mcpc (Apify) · llama-swap.
- **Z3 spectral telemetry → NEW, intersects ?Q-6:** drift/OOD → exit 75 · Fiedler = fragmentation proof · Rayleigh guardrail = abort-the-pulse. PARKED post-P3; MUST NOT shape ?Q-6 without a @Janus pass.
- **P0 skeleton sketch (Orby, `_mail/houston/orby.p0-skeleton-sketch...md`)** — reviewed: `register.py`+`retrieve.sh` are DRAFTS for Composer to harden (Gemini lands no brick); fold into S2.

---

## ✱✱✱✱ Still needed from / open to the operator (@majkee)
- **P0 go + builder** — greenlight the plan; pick Composer (harden Orby's drafts) or the Claude-implementer fallback to beat the loop now. Claude takes `check` + the Synthesizer.
- **PROJECT.yaml** — operator-authorized; the other temple architect authors it **here in `reposoma.devenv/`** from this refreshed §C + locked §D.
- **?Q-6 / RR-04** — route to the research lab when ready.
- **Gemini window** — optional RR-03 (sanity pass on the gavels).
