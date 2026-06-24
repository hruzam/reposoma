---
study: RR-01 — brand-competence map, REPOSOMA projection (the §D mine/yours split)
runner: temple architect's research service (@Epoch-class voice)
date: 2026-06-17
grounding: LIVE internet as of 2026-06-17 (training-data model names / benchmarks / prices re-verified)
method: reposoma research-pattern.md (X→Z law · blind-before-grounded · counterweight MUST dissent · cost-gradient)
builds-on: research/harness/reports/RR-01-brand-competence-grounded.2026-06-17.md (the SHARED subai-side brand map — brand-level facts reused, NOT re-derived)
target: decision (feeds reposoma charter §D)
hypothesis: X = the operator's read (below); each cell CONFIRMS / BREAKS / REFINES it
---

# RR-01 (reposoma) — brick-class × brand fit, grounded against X

> **What this is.** The shared map answered "who owns which *subai* brick". This document re-projects that
> grounding onto **reposoma's** brick classes and **keeps Codex and Composer as distinct columns** (the hypothesis
> distinguishes them; the shared map collapsed them into "Cursor-Codex+Composer"). Brand-level capability facts are
> reused from the shared map and cross-referenced; the reposoma-specific cells are newly grounded today.

## Hypothesis X (the operator's read — under test)
- **Codex** = fine coder, **not** a thinking-scalpel.
- **Composer** = fine coder, **not** a thinking-scalpel.
- **Gemini** = great **buffer/synthesizer**, fine **bash**, good **C++**.
- **Claude** = most capable for **architecture + code revisions/audits + test design** (the thinking-scalpel), also a strong coder.

## The grounded brand facts that move the cells (verified 2026-06-17)
- **Claude Opus 4.8** (rel. 2026-05-28): SWE-Bench Verified **88.6%**, SWE-Bench Pro **69.2%**, Terminal-Bench 2.1 **74.6%** — *leads every coding benchmark in the current table*; USAMO 96.7%. [vellum; morphllm; buildfastwithai — 2026-06] **(this REVISES the shared map's older ~72.5% Claude figure sharply upward — stale-prior corrected).**
- **Codex / GPT-5.5** (base "Spud", rel. 2026-04-23): Terminal-Bench 2.0 **82.7% (SOTA on bash/terminal)**, SWE-Bench Pro 58.6%, FrontierMath Tier 4 **35.4%** (Pro 39.6% — *best of the four on hard math*). OpenAI explicitly markets multi-file refactors + **test generation** + structured migrations as its home turf. [openai introducing-gpt-5-5; mindstudio; wikipedia GPT-5.5 — 2026]
- **Composer 2.5** (Cursor, on Kimi K2.5 base): SWE-Bench Multilingual **79.8%** (~tied Opus), CursorBench 63.2%, but Terminal-Bench 2.0 only **69.3%** (13 pts behind Codex on bash). **~1/10 the per-token cost** of Opus/GPT-5.5. [datacamp composer-2-5; thenewstack; beyondtmrw — 2026-05]
- **Gemini 3.1 Pro**: SWE-Bench Verified ~74–76%, **Terminal-Bench ~54.2%** (behind Opus's 63.1% — *weakest of the four on terminal/bash*), FrontierMath Tier 4 **16.7%** (*weakest of the four on hard math*). Strong large-context synthesis + competitive general reasoning. [nxcode gemini-3-1; gitautoreview; clickrank — 2026]
- **Gemini sunset (TOMORROW, 2026-06-18 23:59 PT):** Gemini CLI stops serving Pro/Ultra/free Code-Assist users. Antigravity CLI (`agy`, Go, closed-source) goes free-GA — but the **free tier is capped at ~20 requests/day (a ~98% cut)**; paid Gemini / Enterprise Agent-Platform **API keys retain uninterrupted CLI access**. [digitalapplied; theregister 2026-05-20; chatforest — 2026] **(this is HARSHER than the shared map's ~2000-line community figure — the official-adjacent number is now 20 req/day free.)**

---

## 1. The decision table — brick-class × brand × fit (LEAD / SUPPORT / AVOID)

Legend: **LEAD** = owns & produces the brick · **SUPPORT** = second pair of hands / review / fallback · **AVOID** = do not seat here.
Codex and Composer kept distinct per X.

| Reposoma brick class | Claude | Gemini | Cursor-Codex | Cursor-Composer | Verdict on X | Row conf. |
|---|---|---|---|---|---|---|
| **Spectral numerics** (numpy/scipy/eigsh, correctness-critical) | **LEAD** — agentic write→run-pytest→fix loop is what makes numerics *provably* right; SWE-Verified 88.6% | **AVOID (as owner)** — weakest hard-math of the four (FM-T4 16.7%) + delivery dies 06-18 | **SUPPORT** — strongest *hard-math* model (FM-T4 35.4%/Pro 39.6%); cross-check the algebra, let Claude own the file+tests | **SUPPORT** — cheap to scaffold the brick skeleton; Claude verifies | **REFINES X** (Codex is *more* than "fine coder" on math; still not the test-loop owner) | med-high |
| **Deterministic hardcoded tools** (registry, tree-converter, validators, `_grid::` flatteners, retriever, dashboard) | **SUPPORT/AUDIT** — writes the spec, cross-audits for exactness; can lead if Cursor is busy | **AVOID** — login sunset = wrong brand for the boring load-bearing layer | **SUPPORT** — strong agentic implementer per spec | **LEAD** — ~1/10 cost, near-frontier multilingual coding; the cheap-exact-scaffold seat reposoma wants | **CONFIRMS X** (both Cursor brands = fine coders, Claude = the audit gate) | high |
| **Agentive synthesizer/recorder** (librarian-strict, ?Q-7) | **LEAD** — Claude designs the temperament + owns the prompt/canon contract; native subagents/hooks deepest | **SUPPORT (consult)** — large-context synthesis is its one real edge, but only as a queried oracle post-sunset | **AVOID** — not a librarian-temperament tool | **AVOID** — not a librarian-temperament tool | **REFINES X** (Gemini's "synthesizer" strength is real but *non-owning* — consult, not seat) | med |
| **Bash / native bricks (incl. C++)** (tree-converter, compressor, hooks; any C++ organ) | **LEAD (bash)** — Terminal-Bench 2.1 74.6%, best agentic-terminal of the four | **AVOID** — Terminal-Bench ~54.2% = *weakest* of the four; the bash claim does not survive grounding | **LEAD (C++/native)** — GPT-5.5 SOTA terminal 82.7% + multilingual/systems strength | **SUPPORT** — multilingual-capable but 13pts behind Codex on terminal | **BREAKS X** (Gemini "fine bash / good C++" is the weakest seat here; Codex owns bash/native) | high |
| **Research / method-math grounding** (spectral graph theory, the 6-axis/13-move algebra) | **SUPPORT** — excellent citation discipline + reasoning; the dependable owner-of-record | **LEAD-as-CONSULT only** — free large-context corpus synthesis is genuinely useful, **but see DISSENT** — lives ONLY as a queried oracle, never a seated owner after 06-18 | **SUPPORT** — best hard-math sanity-check (FrontierMath); query for the math, don't seat | **AVOID** — not a research tool | **CONFIRMS-WITH-CAVEAT X** (Gemini = great synthesizer ✓, but ownership ✗ by delivery) | med |
| **Audits + tests** (the thinking-scalpel work — cross-team review, test design) | **LEAD** — the single clearest cell; Opus 4.8 leads SWE-Verified/Pro/Terminal-Bench *simultaneously*; architecture+revision+test-design is exactly the scalpel | **AVOID** — neither capability-leading here nor deliverable tomorrow | **SUPPORT** — strong test *generation*, but generates-the-tests ≠ owns-the-audit-gate | **AVOID** — fast coder, not an audit voice | **CONFIRMS X (hard)** (Claude = the thinking-scalpel; this is the cell X gets most right) | high |

---

## 2. Per-row "why" (one line each, grounded) + bearing on X

- **Spectral numerics → Claude LEAD, Codex SUPPORT (math sanity), Composer SUPPORT (scaffold):** correctness is won by the *agentic test loop* (write→`pytest`→fix-until-green), Claude's wheelhouse; **but** Codex is the strongest *hard-math* reasoner of the four (FrontierMath T4 35.4%/Pro 39.6%), so it earns a real consult seat on the eigsh/L_sym algebra — **X under-rates Codex's math → REFINES.** [openai gpt-5-5; vellum opus-4-8; clickrank]
- **Deterministic tools → Composer LEAD, Codex SUPPORT, Claude AUDIT:** the most boring layer must be *exact and cheap*; Composer 2.5 at ~1/10 cost with near-frontier multilingual scores is the right hands, Claude is the exactness gate — **CONFIRMS X.** [datacamp composer-2-5; thenewstack]
- **Agentive synthesizer/recorder → Claude LEAD (design), Gemini consult:** the librarian temperament + canon contract is a *design* problem (Claude's), Gemini's large-context helps only as a queried oracle — **REFINES X** (its synthesizer strength is non-owning). [shared-map §3,§5; nxcode]
- **Bash / native (incl. C++) → Claude LEAD bash, Codex LEAD C++/native, Gemini AVOID:** the hypothesis seats Gemini here, but Gemini is the *weakest* terminal model of the four (~54.2% vs Opus 74.6%, Codex 82.7%) — **the cell BREAKS X.** Bash goes to Claude/Codex; C++/native to Codex. [gitautoreview gemini; openai gpt-5-5; vellum]
- **Research / method-math grounding → Gemini consult-LEAD, Claude SUPPORT, Codex math-check:** Gemini's free large-context synthesis is its one durable edge — **as an oracle, not an owner** (delivery dies tomorrow) — **CONFIRMS-WITH-CAVEAT.** [shared-map §3; digitalapplied]
- **Audits + tests → Claude LEAD:** Opus 4.8 leads SWE-Verified 88.6% / SWE-Pro 69.2% / Terminal-Bench 74.6% at once — architecture + revisions/audits + test-design is precisely the scalpel — **CONFIRMS X (hardest-confirmed cell).** [vellum; morphllm; buildfastwithai]

---

## 3. Cross-cuts

### 3a. Cost / economics
- One $20/mo Pro tier covers a solo dev per tool. **Claude Pro + Cursor Pro = ~$40/mo total** and buys Claude (audit/numerics/bash) + both Cursor seats (Composer cheap-exact, Codex hard-coder/C++). **Codex-as-primary is the expensive seat** (real spend $100–200/dev/mo); seat it *narrowly* for C++/native + hard-math consult, not as the default coder. Composer's ~1/10 token cost is the reposoma-fit reason it LEADs deterministic tools. [shared-map §4b; datacamp composer-2-5; morphllm]
- **Reposoma-specific economics:** the spectral engine is ISOLATED to one brick (charter §C) and the loop is low-volume/pre-P0 (§E). So the expensive seats (Codex/Opus) are touched *rarely and surgically* — which makes a 3-brand bill tolerable **only if** ownership is narrow. A 4th always-on brand is not justified by reposoma's volume.

### 3b. Portability / lock-in (LAW-5: sovereign re-pointable sockets)
- MCP is universal across all four → the **deterministic-tools + retriever** bricks stay portable regardless of owner; the lock-in risk is **per-tool config fragmentation** (`CLAUDE.md` vs `.cursorrules` vs `agy` skills vs `GEMINI.md`), not the protocol. Keep brick *interfaces* MCP-native / file-native so the *owner* is swappable — this IS LAW-5 at the brand layer. [shared-map §4c; source-catalog: cursor-rules, antigravity-gcli-migration]

### 3c. The 2026-06-18 Gemini personal-login sunset (load-bearing — verified today)
- **What dies tomorrow (23:59 PT, 06-18):** Gemini CLI stops serving Pro/Ultra/free Code-Assist-for-individuals. Free + consumer-paid *personal* logins lose CLI access. [digitalapplied; theregister 2026-05-20] **conf: high.**
- **What survives, NOT at parity:** (a) **`agy` (Antigravity CLI)** free-GA but **~20 requests/day free cap (~98% cut)** — community/migration-guide figure, treat as **med** confidence, harsher than the shared map's ~2000-line number; `agy` does retain Skills/Hooks/Subagents (Google mirrored Claude Code's primitives). (b) **paid Gemini / Enterprise Agent-Platform API key** retains uninterrupted CLI access — the durable path, but it is **paid + org-framed**. [digitalapplied; chatforest; shared-map §4a]
- **Reposoma ruling (the architect's standing call):** Gemini is **non-load-bearing here by design** (charter §D, !D-A4). RR-01 grounds *why that call is correct*: even ignoring the sunset, Gemini is the **weakest of the four on both bash and hard-math** — the two reposoma seats X tried to give it. The sunset is the *second* reason, not the first. Gemini stays a **queried consultant for large-context grounding** (RR-02/RR-03 already ride it *blind, human-dispatched, durable-markdown* per the cooperation convention — that is a single-shot oracle use, exactly the surviving capability), never a brick owner.

---

## 4. FLAGGED DISSENT — the counterweight (MUST dissent)

> **Running 3–4 brands on a pre-P0, single-operator, loop-hasn't-beaten-yet project is a cognitive-tax and
> lock-in counterweight the §D split is underpricing — and the honest reposoma move is TWO owners, not four.**
>
> 1. **Config-substrate tax.** Four brands = four rule-file dialects (`CLAUDE.md` / `.cursorrules` / `GEMINI.md` / `agy` skills), four permission models, four update churns. Research consistently prices ~1–2 weeks reduced productivity per tool migration and net-negative flow-state cost even for individually-good tools. For a project whose LAW-1 is "the loop must beat FIRST," four owners is anti-LAW-1 show. [shared-map §5; source-catalog: developersdigest]
> 2. **Gemini is the weakest *ownership* seat by construction AND by capability.** Its delivery surface for personal users dies tomorrow with a 98%-cut free fallback, AND it is last-of-four on the exact two axes (bash, hard-math) X seated it on. Seating it as any owner imports churn for a capability (large-context synthesis) obtainable as a one-shot consult.
> 3. **Codex is the expensive seat** ($100–200/dev/mo real spend). Giving it a *standing* C++/native lane on a project with maybe one or two C++/native bricks (charter §C lists `sh` tree-converter/compressor — bash, not C++) risks paying frontier prices for a lane reposoma may barely use. **Question whether reposoma needs Codex as an owner at all vs. an on-demand C++ specialist summoned per-brick.**
>
> **The dissent's own blind spot:** collapsing to one brand re-introduces vendor lock-in — the exact thing LAW-5 forbids. So the honest synthesis is **not "one brand"** but **"Claude as basement/lead+audit, Composer as the cheap-exact deterministic hands, Codex summoned narrowly for C++/native + hard-math sanity, Gemini as a sunset-aware consult oracle"** — which is *fewer standing owners than X implies* while preserving an MCP/file-native escape hatch. That keeps the verdict honest: X's four-column frame is right to *map*, wrong to read as four standing *owners*.

---

## 5. The Z — the capability/brick reposoma needs that NO brand owns cleanly

**Z = a vendor-neutral "numerics-correctness oracle" brick — a file-native golden-test + spectral-invariant harness that
PROVES the spectral engine right independent of which brand wrote it.**

The argument from the grounded data:
- Every brand is now a *strong coder* (88.6% / 82.7% / 79.8% / ~75% SWE-class). The grounding shows the brands have **converged on coding** and **diverged on**: hard-math reasoning (Codex leads, Gemini trails), agentic test-loops (Claude leads), bash/terminal (Codex/Claude lead, Gemini trails). **No single brand owns "provably-correct numerics" cleanly** — Claude owns the *test loop*, Codex owns the *math judgment*, and they are different brands. The correctness of reposoma's load-bearing heart (B → L_sym → eigsh → KMeans; Fiedler/centrality diagnostics) therefore sits in the *seam between two brands*, owned by neither.
- The competence map points at a brick that closes that seam: a **deterministic, no-LLM-at-runtime correctness harness** that encodes the spectral invariants reposoma can check *without trusting any brand's word* — e.g. golden eigenvalue/eigenvector fixtures on known graphs, Fiedler-sign/connectivity assertions, KMeans-stability seeds, symmetry/Hermitian checks on L_sym, regression-pinned `analysis_report.md` diffs. It is **agent-authored once (Claude designs, Codex math-checks, Composer scaffolds) then runs forever as a plain `pytest`/`sh` organ** — file-native, portable, brand-agnostic (LAW-4/LAW-5 clean).
- **Why no brand owns it:** brands sell *coding* and *reasoning*; none ships *your domain's correctness contract*. The contract is reposoma-specific spectral-graph algebra — it is exactly the kind of method-math Z the operator-law reserves for the *team*, built **only as an optional brick behind a flag**, earning its place on the spine after P2 (LAW-1), never before.

> **Name it:** `spectral-oracle` (working name) — the numerics-correctness contract brick. It is the natural home of the
> cross-brand seam the competence map exposes, and the first concrete Z this study points at.

---

## 6. Top recommendation (the [LEAN] for §D) — conf: med-high

**Seat the reposoma §D split as: Claude = basement/lead (architecture · canon · synthesizer DESIGN · audits+tests · bash ·
numerics test-loop) · Composer = cheap-exact deterministic-tools owner · Codex = narrow on-demand specialist (C++/native +
hard-math sanity on the spectral algebra), NOT a standing owner · Gemini = sunset-aware large-context CONSULT oracle, never
a brick owner.** Build the `spectral-oracle` correctness brick (the Z) as an optional flagged organ, earned at P2.

This **confirms** X's Claude verdict (hardest-confirmed), **confirms** X's "Cursor = fine coders" verdict, **refines** X by
promoting Codex above "just a fine coder" on hard-math, and **breaks** X's "Gemini = fine bash / good C++" — those are
Gemini's two *weakest* axes, so the bash/native seats move to Claude (bash) and Codex (C++/native).

---

## 7. What would change the answer
1. **A clean consumer paid-API-key path that stably drives a CLI post-06-18** → Gemini could regain a *consult-owner* seat for research-grounding (still not bash/numerics, where it's capability-weak). *Currently org-framed / unconfirmed — biggest open fact.*
2. **A real C++/native brick load materializing** (charter §C currently lists `sh`, not C++) → Codex's narrow specialist lane becomes a standing owner; until then it stays on-demand.
3. **The office box gains a GPU** → a local Qwen/Ollama seat (charter's reserved flash tier) becomes a real cheap-tools owner, further shrinking the case for a 4th cloud brand.

---

## 8. Sources (dates + confidence)

| # | Source | Used for | Date | Conf. |
|---|---|---|---|---|
| 1 | vellum.ai / morphllm.com / buildfastwithai.com — Opus 4.8 benchmarks | Opus 4.8 SWE-Verified 88.6% / SWE-Pro 69.2% / Terminal-Bench 74.6% / USAMO 96.7% (Claude lead) | 2026-06 | high |
| 2 | openai.com introducing-gpt-5-5 / mindstudio.ai / en.wikipedia GPT-5.5 | Codex/GPT-5.5: Terminal-Bench 82.7% SOTA, SWE-Pro 58.6%, FrontierMath T4 35.4%, refactor+test-gen home turf | 2026-04→06 | high |
| 3 | datacamp.com composer-2-5 / thenewstack.io / beyondtmrw.org | Composer 2.5: SWE-Multilingual 79.8%, Terminal-Bench 69.3% (−13 vs Codex), ~1/10 cost | 2026-05 | med-high |
| 4 | nxcode.io gemini-3-1 / gitautoreview.com / clickrank.ai | Gemini 3.1 Pro: SWE-Verified ~75%, Terminal-Bench ~54.2% (weakest), FrontierMath T4 16.7% (weakest) | 2026 | med-high |
| 5 | digitalapplied.com / theregister.com / chatforest.com — Gemini sunset | 06-18 23:59 PT CLI death; `agy` free ~20 req/day (~98% cut); paid/Enterprise API keys survive | 2026-05→06 | high (date) / med (20-req figure) |
| 6 | epoch.ai FrontierMath-T4 / datacamp opus-4-8-vs-gpt-5-5 | hard-math ranking Codex > Opus(USAMO) > Gemini | 2026 | med |
| 7 | **shared map** RR-01-brand-competence-grounded.2026-06-17.md | brand-level grounding reused: MCP universality, consult-not-owner Gemini, $20-tier economics, OpenCode escape hatch | 2026-06-17 | (internal authority) |

**Stale-prior corrections logged:** (a) Claude's coding number is now **88.6% SWE-Verified (Opus 4.8)**, not the shared map's older ~72.5% — the Claude-lead cells are *stronger* than the shared map stated. (b) Gemini's "fine bash / good C++" prior is **broken** — it is the weakest of the four on terminal AND hard-math; capability, not just delivery, disqualifies it from those reposoma seats. (c) The `agy` free cap is now reported as **~20 req/day**, harsher than the prior ~2000-line figure.

— end RR-01 (reposoma projection), dated 2026-06-17 —
