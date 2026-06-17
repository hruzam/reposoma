# Project intake — reposoma.devenv (per-project copy)

`tier: raw.guides/intake · the architect's own copy (never the shared template)`
`project: reposoma.devenv · path (office box): /home/hruzam/www/ovum/reposoma.devenv`
`one head: @Houston (reposoma basement) · temple architect: @Houston (reposoma basement) — same seat (reposoma IS the temple's home)`
`rule: answer short. a blank means "not promised yet", not a bug. field work refines it.`

> Flushed from the shared template `raw.guides/project-intake.md` 2026-06-17. A–G is the
> contract; the research queue below is NOT the contract. **Charter §6 forks ?Q-1..8 are now
> GAVELLED — see the ⚖ GAVELS section, which supersedes any inline "?Q gavel pending" markers.**
> §D GROUNDED by RR-01 + Janus-passed + LOCKED (2026-06-17).

## A · Identity
- name + one-line purpose: **reposoma — a standalone, portable, file-based knowledge metabolism (capture → register → synthesize → spectral-analyze → derived views). Repository × ribosome: a translating machine, not an application.**
- which is this — "real reposoma", or a new one: **the real reposoma (restart). ?Q-1 LOCKED (D1): v-next = green-field `~/www/ovum/reposoma.v2/`; `/home/hruzam/reposoma/` = data substrate; `pulse.md` = invariant. This devenv = current working area until reposoma.v2 is born at P0.**

## B · Nature of the work — this draws the domain seats (I grant none you don't earn)
- what dominates: **a mix — authoring/synthesis (RAG, canon, guides) + building/coding (engines, validators, tools) + a method-math heart (spectral). Build toward a beating loop FIRST (LAW-1). X→Z research cadence.**
- a narrow correctness/performance-critical heart? → deep core specialist: **yes — the spectral engine numerics (B → L_sym → eigsh → KMeans; centrality + Fiedler diagnostics). EARNED at P2, not pre-granted (LAW-1).**
- a body of method/math the team must get right? → domain researcher: **yes — spectral graph theory + the vector-language algebra (6 axes / 13 moves). Signal/spectral researcher seat pending load (P2+).**
- deterministic tools, agentive tools, or both? → the builder split: **both. Deterministic (registry, tree-converter, validators, `_grid::` flatteners, retriever, dashboard) → Claude lead / Cursor support. Agentive (the Synthesizer/recorder — librarian-strict, ?Q-7) → Claude design + flash-tier runtime.**
- a human-facing surface where the system explains itself? → surface seat: **yes — terminal retriever (fzf/jq) + dashboard (cat pulse + git log + links) + the adopted graph organ (?Q-8). Sublime is the current capture/projection organ (!D-A2), not a commitment. Earned, not pre-granted.**

## C · The contract — becomes PROJECT.yaml (capability terms, not stack terms)
- stack (lang/framework — informational): **file-native — markdown (content) · JSONL (database + vector trace) · JSON (registry/tree) · CSV (`_grid::` projections = spectral B-matrices) · Python (spectral engine: numpy/scipy/eigsh, ISOLATED to that brick) · sh (tree-converter, compressor, hooks). No DB server (LAW-4). On-disk naming = ?Q-4 LOCKED (D4): factory-standard technical names; biology only in project names.**
- commands: test · lint · build · run: **TBD at P0. build=none (file-driven organs); run=the manual loop (capture → register → synthesize → retrieve via fzf). Pinned when the P0 skeleton lands and the loop beats once.**
- docs entry points: architecture · decisions · conventions: **architecture=the charter (canonical `reposoma.v1/DASHBOARD/synth.restart.reposoma.md`, moves to reposoma.v2 at P0; = plan file, !D-A3); decisions=charter §6 gavels + §8 ADDENDUM (flag seed); conventions=`CLAUDE.md` (lighthouse) + the 5 laws.**
- hard constraints: comment language · forbidden tools · security rails: **comment lang=English; forbidden=DB server, cloud-required state, heavy/pretty viewers (Obsidian/Superset — !D-A1), electron-class weight, absolute hardcoded paths (portability); rails=the 5 laws — esp. LAW-1 (#loop-before-organs) + LAW-5 (sovereignty: vendor primitives are thin re-pointable sockets).**

## D · Teams & the one head — the allocation  **[GROUNDED by RR-01, 2026-06-17 — see report]**
- vendor-teams on this project: **Claude basement (always — lead/OWNER) · Cursor (Composer-preferred OWNER for surface + scaffolding — Codex-as-primary is the expensive seat, RR-01 §4b) · Gemini (CONSULTANT ORACLE, NOT an owner — solo/personal delivery surface sunsets 2026-06-18, no confirmed consumer-API CLI path; query for math/large-context grounding via whatever auth survives) · piql local Qwen + Qwen CLI (flash/mouth tier, reserved — !D-A4).**
- the one head (allocates work, holds canon authority): **@Houston (reposoma basement). Operator (@majkee) = the human gate + math/physics/PHP advisor + fetch-subagent (eyes/hands where the team has no reach).**
- the split — what each team OWNS ("mine / yours"). Canon stays at the basement gate:
  **GROUNDED by RR-01 (reposoma-specific) · @Janus-passed · LOCKED 2026-06-17 — two STANDING owners + two ON-DEMAND.** *(Reconciled: deterministic-tools ownership moves Claude→Composer on the cost-gradient — reposoma RR-01, not the shared subai map; Composer builds cheap-exact, Claude audits.)*
  - **Claude (STANDING · lead)** — the thinking-scalpel + agentic-test-loop bricks: the spectral-numerics *test-loop* · MCP fingers + hooks (the agentive seam) · the agentive Synthesizer/recorder design; PLUS architecture · canon authorship · cross-team **audits + tests** · bash · the plan. [RR-01: Claude LEAD on numerics test-loop, MCP+hooks, audits — hardest-confirmed cell]
  - **Composer (STANDING · owner)** — **deterministic tools** (registry · tree-converter · validators · `_grid::` flatteners · retriever · dashboard) AND surface/render bricks (the "skin" analogue) as LEAD; cheap-exact (~1/10 cost), Claude audits exactness. Prefer Composer over Codex on cost. [RR-01: Composer LEAD on deterministic + surface; cost-gradient]
  - **Codex (ON-DEMAND specialist)** — hard-math consult on the spectral algebra (RR-01 refined X *up* — strongest hard-math of the four) + the C++/native brick when summoned. **Not a standing owner.**
  - **Gemini (ON-DEMAND · consult-only)** — queried oracle for method-math cross-check · large-context synthesis · blind scope re-synthesis, via whatever auth survives 06-18 (personal login dies; `agy` free ~20 req/day). Non-load-bearing by **capability first, sunset second**; owns no brick. [RR-01 BROKE X's "fine bash, good C++" — weakest of the four on both]
  - Each owner builds + self-tests; canon stays at the Claude gate, one-direction (Force 4). **Socket↔seat map + MCP yes/no = ?Q-5 (D5: investigate piql — see GAVELS).**
  - **Two flagged Z's — NOT built (LAW-1, earned, never on the spine):** **(1) `spectral-oracle`** (numerics-correctness) — a no-LLM golden-fixture harness proving the spectral engine right regardless of which brand wrote it; breaks the single-auditor circularity (Claude authors AND audits numerics). **Promote FIRST at P2.** **(2) OpenCode-shaped model-neutral CLI** (sovereignty, LAW-5) — the agent-invocation socket; owner-relationship lives in the neutral CLI, routes Gemini/whoever as an oracle through one config, defeats the sunset. Real-and-adopted for the neutral-CLI core; speculative for local-model ownership on 16GB/no-GPU. A late branch. Flip-conditions in RR-01 §7. **→ now enriched with concrete tooling in the Z-catalog (Orby), below.**
  - **C++ = a flagged Z-branch sandbox** (LAW-1 / X→Z), OFF the file-native spine — the lone compile step, isolated like numpy/scipy. **Promotion gate:** a *named* brick the `sh`/Python spine provably cannot meet, surfacing AFTER the loop beats (P2+). Until named, C++ is a learning sandbox in a side branch, **not a §D seat** (@Janus: don't harden a wish-to-learn into canon).

## E · Volume & cadence — this sets the thresholds I name out loud
- how much work, how fast (rough): **early / pre-P0. The loop has not beaten yet (LAW-1 — that IS the work). Single operator present as the gate. Low volume.**
- "every few steps" feedback = how many steps / how often: **at every phase gate + before every lock (X) → operator sees it; one decision = one durable record (charter §8 / flag). Feedback discipline is a temple lean — see the cooperation convention below.**
- the threshold that would earn a msg-bus / orchestrator / sub-team (or leave to me): **DEFER all. Cross-seat message exchange follows the temple architect's lean (see below), human pulls the trigger. No `_bus/` organ in reposoma.devenv until the loop beats (LAW-1). Orchestrator = show until human routing is a *measured* bottleneck (doctrine §3). Executor abort convention = ?Q-6 (D6: research commissioned, RR-04).**

## F · Live state — Model-C sizing (the one untuned string)
- does the work need runtime truth (schema · last error · logs)? how fat: **yes, but THIN. Runtime truth IS the files — `registry.jsonl` (status), the vector-move JSONL trace, the spectral `analysis_report.md`. No constantly-running DB (LAW-4). The spectral engine reads compiled B-matrices (csv/jsonl), not a live server.**

## G · Out of scope — what this project does NOT promise:
- **NOT larva, NOT a larva dev tool — a sibling toolbox sharing technology + thinking.**
- **NOT an agent framework · NOT a transport protocol · NOT a vector DB · NOT a memory product.**
- **NOT a 1:1 home↔office agent mirror (explicit buffer non-goal).**
- **NOT a UI project until v2/v3 (Sublime + terminal suffice; every view is a swappable organ).**
- **NOT a pretty-viewer project — Obsidian, Superset, heavy-look tooling OUT entirely (!D-A1).**
- **NO heavy DB · no cloud-required state · no wrapper-on-wrapper REST loops.**
- **NOT a second parallel canon — sovereignty + portability (LAW-5).**

---

## ⚖ GAVELS — charter §6 LOCKED 2026-06-17 (canonical: `reposoma.v1/DASHBOARD/synth.restart.reposoma.md §6`)
Reconstructed after the power outage — the gavels were never lost; they live in the canonical charter
§6 (the `_mail/` copy is the frozen 2026-06-11 snapshot, which predates them). These supersede inline
"?Q gavel pending" markers above.

- **!D1 (?Q-1 ship-burning) — LOCKED.** v-next = **green-field `~/www/ovum/reposoma.v2/`**, from scratch. `/home/hruzam/reposoma/` = the **data substrate** (stays; copy in as training data later, once parts are built). `pulse.md` = the fresh **invariant** load/flush file. → unblocks the charter move + P0.
- **!D2 (?Q-2 vector profile) — LOCKED.** Reduced 5-move profile (claim/decision/defer/gap/hook) for v0; **preserve the full 13-move shape in project files** as a future/pickable style.
- **!D3 (?Q-3 first mRNA) — LOCKED.** First raw input = the **charter's own source buffer** (cleanest self-test).
- **!D4 (?Q-4 naming) — LOCKED.** Factory-standard technical names on disk; **biology only in project names**.
- **!D5 (?Q-5 sockets) — PARTIAL / delegated.** piql is partly-built → **investigate `/home/hruzam/www/piql/piql.dev/guides`** (read, or spawn its own architect / an Epoch mapper). Socket↔seat map + MCP depend on piql's seat. @majkee may run it himself if data is thin.
- **!D6 (?Q-6 abort convention) — research commissioned.** @majkee's research lab (Epoch) grounds best-practices vs live internet; Houston supplies the X → drafted as **RR-04** (`research/inputs/abort-convention.brief.md`).
- **!D7 (?Q-7 synthesizer temperament) — LOCKED.** Librarian-strict, no-invention, in P0–P1.
- **!D8 (?Q-8 graph organ) — free hand** to Houston + research centre. Proceed via Orby's Z1 candidates → ground + counterweight + @Janus at P2.

## ✱ Cooperation convention — temple architect's lean (ADOPTED 2026-06-17)
Bound here so the fresh temple generates *comparable* feedback across both devlines. Reposoma
adopts the same lean the temple architect gave the sibling (its RR-02 ruling) — the **shape**,
not necessarily the folder name:
- **Exchange shape:** `<to>/<from>.<topic>.<utc-ts>.md` — sovereign markdown, vendor-neutral, durable + reversible.
- **Human pulls the trigger:** a worker "runs" only when @majkee hands the mail/brief to the chosen CLI **interactively**. **No headless `-p` worker dispatch.** (The staged research briefs already honor this.)
- **Research seam already conforms:** handoffs ride `research/inputs/ → research/outputs/` (durable, human-gated). General (non-research) cross-seat mail rides a **collision-free live mailbox** — reposoma.devenv `_mail/` is the FROZEN boot snapshot, so the live mailbox is a distinct path (proposal `_post/`), **instantiated on first real message**, path flagged to the operator then. No empty infra now (LAW-1, anti-show).
- **Defer the headless worker bus** until ALL THREE hold: (a) human routing is a *measured* bottleneck at real volume, (b) a verified need no interactive path meets, (c) the dispatch surface is stable + post-sunset-verified.
- **Feedback discipline:** every phase gate + every lock surfaces to the operator; one decision = one durable record; the operator collects feedback at the seams.

## ✱✱ Open research requests — queued for the temple architect (= this seat)
- filed by @Houston (reposoma basement) · 2026-06-17 · note: a queue UNDER the card, not a schema change.

**Standing method for ALL reposoma research (operator law, 2026-06-17): X→Z.**
- **X** = a hypothesis, *grounded against live data at a date* (cite source + date + confidence). The verifiable part → flagged [LEAN] + confidence, locks to the flag/§8.
- **Z** = the vector the grounded data *points toward but which does not exist yet* — the thing to **develop**. Be creative; build it ONLY as an optional brick behind a flag/branch, **never on the proven spine until it earns promotion.**
- **Operator boundary:** Z is deep-knowledge work — the team's, not the operator's. @majkee advises on **math / physics / PHP** and acts as **fetch-subagent** (go somewhere, read/photograph what the team can't reach). Do not route a Z domain-verdict to him.

**RR-01 · brand-competence map — GROUNDED ✓ (2026-06-17).** Report:
`~/reposoma/research/harness/reports/RR-01-brand-competence-grounded.2026-06-17.md`. Headline:
**two owners (Claude + Composer), Gemini consultant-not-owner**; prefer Composer over Codex (cost). Folded into §D (LOCKED).

**RR-02 · graph organ (?Q-8 / D8 free hand) — SINGLE-VOICE ANSWER from Orby (see Z-catalog · Z1).** Brief at
`research/inputs/graph-organ.brief.md`, seeded with Orby's candidates (Cosmograph / Sigma.js + Graphology / Vizdom).
Owes counterweight + grounding + @Janus before the P2 ?Q-8 lock.

**RR-03 · charter re-synthesis — STAGED (recommended in the remaining Gemini window).** Convergence/divergence
on ?Q-1..8 at `research/inputs/charter-resynthesis.brief.md`. Now lower-stakes (gavels found), but still a good
second-brand sanity pass on the locked gavels. Runner = Gemini.

**RR-04 · abort convention (?Q-6 / D6) — STAGED for @majkee's research lab.** The X first-kick at
`research/inputs/abort-convention.brief.md` → grounded best-practices (exit codes, step/time caps, write-fencing).
Runner = Epoch / research lab; output → `~/reposoma/research/harness/reports/`. Houston runs @Janus on the result before the ?Q-6 lock.

## ✱✱✱ Z-catalog — Orby's parting gift (Gemini consultant, 2026-06-17)
Source: `reposoma.devenv/_mail/houston/orby.the-z-vector-parting-gift.2026-06-17.md`. **Status discipline:**
ONE consultant voice — flagged X→Z research, NOT grounded/triangulated/challenged. All parked behind LAW-1.

- **Z1 · Graph organ → ?Q-8 / RR-02.** **Cosmograph (cosmos.gl)** GPU/WebGL serverless CSV/JSON ~1M nodes ·
  **Sigma.js v3 + Graphology** mature WebGL MIT render-only on static Pages · **Vizdom (Rust/WASM)** declarative/DAG.
  Orby's verdict: Composer wraps Cosmograph (H-temporal) + Sigma.js (H-spatial), served by `python -m http.server`.
- **Z2 · Sovereignty CLI → §D Z(2), LAW-5.** **Goose (Block, Rust)** model-neutral MCP agent ("Ribosome shell") ·
  **mcpc (Apify)** wraps MCP tools as bash commands · **llama-swap** hot-swap proxy for the flash/mouth tier.
- **Z3 · Spectral telemetry → NEW, intersects ?Q-6.** (a) spectral drift/OOD → `exit 75` Harbour-Log · (b) Fiedler
  value = fragmentation proof · (c) Rayleigh-energy guardrail = abort the pulse on hallucination-likely queries.
  **Most seductive Z** — PARKED post-P3, telemetry-justified only; **MUST NOT shape the ?Q-6 gavel without a @Janus pass.**

---

## ✱✱✱✱ Still needed from / open to the operator (@majkee)
- **P0 is unblocked (D1).** Shall I draft the P0 plan? — create green-field `~/www/ovum/reposoma.v2/`, relocate the charter there as the plan file, promote the §6 gavels + §8 ADDENDUM into a real `flag.md`, then run the loop once (capture → register → synthesize → retrieve). LAW-1: that's the gate.
- **?Q-5 / piql (D5):** your call — I read `/home/hruzam/www/piql/piql.dev/guides` myself, or you spawn piql's own architect / an Epoch mapper. The socket↔seat map waits on it.
- **?Q-6 / abort (D6):** route **RR-04** (`research/inputs/abort-convention.brief.md`) to your research lab when ready.
- **Gemini window (~3–4h):** optionally dispatch **RR-03** (second-brand sanity on the locked gavels) before it closes.
- **Cooperation convention** — your nod, or correct the lean (esp. the live-mailbox `_post/` proposal).
- **PROJECT.yaml** — handled by the other temple architect you're waking; §C + locked §D + the GAVELS are ready to draw from.
