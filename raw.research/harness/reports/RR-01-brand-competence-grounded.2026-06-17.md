---
study: RR-01 — brand-competence map (the §D ownership split, earned not guessed)
runner: temple architect's research service → @Epoch-class blind researcher
date: 2026-06-17
grounding: LIVE internet as of 2026-06-17 (training-data facts re-verified)
blindness: ran clean — did NOT read the architect's preferred §D split (subai.devenv.intake.md) or any prior brand verdict
method: reposoma research-pattern.md (blind-before-grounded · 5–10 sources/lens · counterweight MUST dissent)
target: decision
---

# RR-01 — Who OWNS which subai.devenv brick (Claude · Gemini · Cursor-Codex+Composer)

Ownership question only. Headless dispatch / the bus is deferred (RR-02). "Lead" = the brand that should
*own and produce* the brick; "support" = the second pair of hands / review / fallback; "avoid" = do not seat here.

Scope reminder: solo operator, three-team build, office box i5-12400 / 16GB / **no-GPU**; vendor-neutral where
feasible (PORTABILITY LAW); >3 concurrent agents is painful on the weak box.

---

## 1. Executive answer  **[LEAN — confidence: medium-high]**

**Seat Claude as basement/lead on the two correctness-and-glue bricks (numerics engine, MCP fingers + hooks),
Cursor on the surface/skin brick, and split the remaining two — and treat Gemini as a *grounding consultant, not
an owner*, because its delivery surface is being yanked out from under solo/personal users on 2026-06-18.**

The sharpest grounded surprise vs. naive priors: **Gemini's raw reasoning is genuinely competitive (it leads several
expert-reasoning benchmarks over Opus), but its OWNERSHIP value collapses on the delivery/portability axis the day
after this report.** A brand you can't reliably invoke tomorrow cannot *own* a brick. Capability ≠ ownership.

---

## 2. The decision table — brick-class × brand × fit

| Brick class | Claude (basement/lead) | Gemini (second seat) | Cursor-Codex+Composer | Row confidence |
|---|---|---|---|---|
| **Numerics / spectral engine** (numpy/scipy, correctness-critical) | **LEAD** — strongest agentic test-run + multi-file refactor loop; explores multiple numerical methods rather than blind `scipy.integrate`; SWE-bench-Verified ~72.5% (Mar 2026) | **SUPPORT (consultant)** — Gemini 3.1 Pro tops expert-reasoning (94.3% vs Opus 4.6 91.3%); use to *cross-check the math*, not to own the code (delivery risk) | **AVOID** — fast inline editor, weak fit for correctness-critical autonomous test loops | **medium** |
| **Deterministic hardcoded tools** (no-LLM-at-runtime, must be exact) | **LEAD** — best at autonomous "write → run tests → fix until green"; the loop that makes determinism *provable* | **AVOID** — login sunset = unreliable owner for the most boring/load-bearing layer | **SUPPORT** — Composer is fast and cheap for scaffolding glue/CLI; Claude reviews for exactness | **high** |
| **MCP fingers + hooks** (the wiring) | **LEAD** — treats MCP as foundational; native hooks (PreToolUse/PostToolUse/Stop/SubagentStop/SessionStart), subagents, per-subagent MCP config — deepest of the three | **AVOID (as owner)** — MCP is now table-stakes everywhere, so portability is fine, but `agy` hooks/skills are "not 1:1 yet" + sunset churn | **SUPPORT** — Cursor speaks the same MCP; server packages are interchangeable, so it can consume what Claude builds | **high** |
| **Skin / surface renderers** (terminal → browser) | **SUPPORT** — strong on backend/terminal surface; weaker on the tight visual browser loop | **AVOID** — no durable delivery surface for a solo dev here | **LEAD** — Composer 2.5 (~4× faster, frontier-level) owns the React/Tailwind change-class-check-browser loop; this is its home turf | **medium-high** |
| **Research / method-math grounding** | **SUPPORT** — excellent reasoning + citation discipline; strong default | **LEAD (as consultant only)** — huge free large-context window for doc/corpus synthesis + tops expert-reasoning benches; **but see DISSENT** — this "lead" lives ONLY as a queried oracle, not a seated owner, post-sunset | **AVOID** — not a research/grounding tool | **low-medium** |

Legend: **LEAD** owns/produces · **SUPPORT** reviews/second-pair-of-hands/fallback · **AVOID** don't seat here.

---

## 3. Per-row "why" (one line each, grounded)

- **Numerics → Claude lead, Gemini consult:** correctness wants an *agentic test loop* (write→run→fix), which is Claude's wheelhouse; Gemini's edge is *judgment about the math*, so query it, don't let it own the file. [morphllm; sciencedirect S2095034925000157; llm-stats 2026]
- **Deterministic tools → Claude lead, Cursor support:** the most boring layer must be *provably* exact → Claude's autonomous test-runs; Cursor cheaply scaffolds, Claude verifies. [ofox.ai; cosmicjs; nxcode]
- **MCP + hooks → Claude lead, Cursor support:** Claude Code's hooks + subagents + MCP-as-foundation are the deepest primitive set; because MCP is vendor-neutral, Cursor consumes the same servers (portability law satisfied). [sitepoint MCP guide; claudefa.st cursor-mcp; deployhq]
- **Skin/surface → Cursor lead:** the tight Tailwind/JSX visual loop is exactly where Cursor's inline speed (~4×) beats a CLI; Claude backs it up for the terminal-side surface. [builder.io; prismic; beyondtmrw Composer 2.5]
- **Research/grounding → Gemini consult-lead, Claude support:** Gemini's free large-context + benchmark-topping reasoning make it the best *oracle to ask*; Claude is the dependable owner-of-record. [ivern.ai; lxt benchmarks; tygartmedia]

---

## 4. Cross-cuts

### 4a. The 2026-06-18 Gemini personal-login sunset  **(load-bearing — verified today)**
- **What dies (TOMORROW):** On 2026-06-18, the old **Gemini CLI + Gemini Code Assist IDE extensions stop serving
  requests for free Code-Assist-for-individuals, AI Pro, and AI Ultra.** Free + consumer-paid personal logins lose
  access entirely. [developers.googleblog.com transition post, ann. 2026-05-19]
- **What survives, NOT at 1:1 parity:**
  1. **Antigravity CLI `agy`** (Go, closed-source) — browser **OAuth** flow, OS-keyring tokens; Google states explicitly
     "**there won't be 1:1 feature parity right out of the gate**" but `agy` *does* retain **Agent Skills, Hooks,
     Subagents, Extensions** (Google mirrored Claude Code's primitive model). Quota model shifts **daily → weekly
     compute cap**; community reports the free weekly cap is *tight* (~"two thousand lines of generated code" before
     exhaustion — **user reports, not official quota docs**, treat as low-confidence). [developers.googleblog; theregister 2026-05-20; digitalapplied]
  2. **Paid Gemini API key** path — explicitly preserved, but the official wording frames it around
     **organizational / Enterprise Agent Platform** keys; whether a *consumer* paid API key cleanly drives a CLI after
     the cutoff is **not confirmed by Google's own post** (gap — flag for the basement to test, do not assume). [developers.googleblog; digitalapplied]
- **Ownership implication:** a brand you may not be able to reliably invoke tomorrow **cannot be a brick OWNER for a
  solo operator.** Gemini stays as a *consultant oracle* (query for math/large-context grounding via whatever auth
  survives), not a seated owner. Confidence on the *date and the consumer-CLI death*: **high**. Confidence on *exact
  agy free limits*: **low**.

### 4b. Cost / economics
- Single $20/mo Pro tier covers a solo dev on any one tool. **Claude Code + Cursor both have $20/mo Pro tiers — running
  both costs the same as picking one of many single tools** ($40/mo total). Codex "Pro" usefulness starts at $200/mo and
  averages $100–200/dev/mo of real token spend → **Codex-as-primary is the expensive seat**; prefer Composer for the
  hard-coder role. Gemini's value was *free large context* — that's the thing the sunset most threatens. [morphllm; nocode.mba; beyondtmrw]

### 4c. Portability / lock-in (the PORTABILITY LAW)
- **MCP is now universal** (Claude, Cursor, Gemini all read MCP servers natively; packages interchangeable) → the
  **fingers** brick is portable *regardless of owner*. The lock-in risk is **not the protocol, it's the per-tool config
  fragmentation** (`CLAUDE.md` vs `.cursorrules` vs `agy` skills) and the muscle-memory/migration tax. Keep brick
  *interfaces* MCP-native so the *owner* can be swapped. [sitepoint MCP; getmaxim; developersdigest]

---

## 5. **FLAGGED DISSENT — counterweight lens (MUST dissent)**

> **Running three brands as three owners is a tax the solo operator is underpricing — and the cleanest move is to
> drop Gemini from ownership entirely and seriously question whether you need *three*.**
>
> 1. **Three brands = three config substrates, three muscle memories, three permission models, three update churns.**
>    The research consistently prices a **context-switching + config-fragmentation tax**: budget *1–2 weeks of reduced
>    productivity per tool migration*, and the cognitive overhead of flow-state interruption can go *net-negative* even
>    when a tool is individually good. Consolidation to fewer tools is repeatedly the *financially* recommended move for
>    solo devs, "even when individual pricing seems comparable." [developersdigest switching-cost; sitepoint ROI]
> 2. **Gemini is the weakest *ownership* seat by construction** — its delivery surface for solo/personal users is being
>    deprecated *the day after this report* with no 1:1 replacement and an unconfirmed consumer-API path. Seating it as a
>    brick OWNER imports churn risk into the basement for a capability (reasoning/large-context) you can get *as a
>    consultant* without owning anything.
> 3. **The 16GB / no-GPU box punishes concurrency** (>3 agents painful). Three live owners invites exactly the parallel
>    fan-out the hardware can't sustain. Fewer owners ⇒ fewer concurrent heavyweight sessions.
>
> **The dissent's own blind spot:** consolidating to one brand *re-introduces vendor lock-in* — the very thing the
> PORTABILITY LAW exists to prevent. So the honest synthesis is **not "one brand"** but **"two owners (Claude + Cursor),
> Gemini as consultant, and an MCP-native escape hatch"** (see pattern-scout). The counterweight complicates the
> three-owner default *exactly as the pattern intends* — and that's what keeps this verdict honest.

---

## 6. **Pattern-scout — the 4th path / materially different split**

**OpenCode (or an OpenCode-shaped model-neutral CLI) as the portability escape hatch — and the option that one brand
drops out of ownership.**

- **What it is:** an open-source, **model-neutral** coding agent (~160k★, 75+ providers via models.dev) that drives
  Claude, Gemini, GPT, *and local models via Ollama* **in one session, one config**, fully offline-capable. There are
  documented ports of "Claude-Code-style Agent Teams" onto it. [opencode.ai; redhat 2026-04; dev.to Agent Teams port]
- **Why it matters here:**
  - It **directly defeats the Gemini-sunset risk**: route Gemini *through* a neutral CLI on whatever API survives, so
    the *owner relationship* lives in OpenCode, not in a vendor tool that can deprecate your login.
  - It is the **portability-law-pure** answer: brick owners become *model choices behind one neutral interface* rather
    than three separate vendor tools — the config-fragmentation tax in §5.1 largely evaporates.
  - **No-GPU caveat (verify before betting):** the "local Ollama" leg is attractive for sovereignty but a **16GB /
    no-GPU box realistically runs only small quantized models** (a Qwen-class local would be a *fallback/cheap-tools*
    seat, not a numerics owner). Treat local-model ownership as **speculative** until benchmarked on the actual box.
- **The materially different split it enables:** **two owners, not three** — Claude owns {numerics, deterministic,
  MCP+hooks}, Cursor owns {skin}, research/grounding is a *queried oracle* (Gemini or whoever's strongest that week,
  reached through the neutral CLI). Gemini **drops out of ownership** but stays available as a consultant. Status:
  **real-and-adopted** for the neutral-CLI core; **emerging/speculative** for local-model ownership on this hardware.

---

## 7. What would change the answer (the facts whose change flips it)

1. **If Google confirms a clean consumer paid-API-key path that drives a stable CLI post-06-18** → Gemini becomes a
   viable *owner* of research/grounding (promote its row from consultant to lead). *(Currently unconfirmed — the single
   biggest open fact.)*
2. **If `agy`'s free weekly cap is generous** (the ~2000-line community figure is wrong/pessimistic) → Gemini-via-agy
   regains ownership candidacy for grounding. *(Low-confidence input today.)*
3. **If the office box gains a GPU** → local-model ownership (pattern-scout's Ollama leg) becomes real, and the
   "drop a brand, go neutral-CLI + local fallback" path gets materially stronger.

---

## 8. Sources (with dates + confidence)

| # | Source | Used for | Date | Confidence |
|---|---|---|---|---|
| 1 | developers.googleblog.com — "Transitioning Gemini CLI to Antigravity CLI" | sunset facts, no-1:1-parity, agy retains Skills/Hooks/Subagents | ann. 2026-05-19 | **high** (primary) |
| 2 | theregister.com — "Bye-bye Gemini CLI; Google nudges devs to Antigravity" | corroborates sunset + agy positioning | 2026-05-20 | med-high |
| 3 | digitalapplied.com — Gemini CLI dies June 18 migration guide | daily→weekly cap, ~2000-line community report, consumer-API ambiguity | 2026-06 | medium (secondary; some figures user-reported) |
| 4 | tygartmedia.com / finout.io / devtk.ai | current Claude lineup + pricing (Opus 4.8 $5/$25, Sonnet 4.6 $3/$15) | 2026-06 | med-high |
| 5 | llm-stats.com / lxt.ai / sciencedirect S2095034925000157 | Gemini 3.1 Pro 94.3% vs Opus 4.6 91.3% reasoning; scientific-computing behavior | 2026-02→06 | medium |
| 6 | nxcode.io / deployhq / ofox.ai / cosmicjs | Claude=backend/test-loop lead, Cursor=frontend/inline, hooks+subagents | 2026 | med-high |
| 7 | beyondtmrw.org / builder.io / prismic.io | Cursor Composer 2.5 (~4×, frontier-level), React/Tailwind loop | 2026-05 | med-high |
| 8 | sitepoint MCP guide / getmaxim / claudefa.st cursor-mcp | MCP universal + interchangeable across all three (portability) | 2026 | high |
| 9 | morphllm.com / nocode.mba / spectrumailab | cost: $20 tiers, Codex $100–200/mo real spend | 2026 | med-high |
| 10 | developersdigest switching-cost / sitepoint ROI | counterweight: context-switch + config-fragmentation tax, consolidation | 2026 | medium |
| 11 | opencode.ai / redhat 2026-04 / dev.to Agent-Teams-port | pattern-scout: model-neutral CLI, 75+ providers, Ollama-local | 2026 | med-high |

**Stale-prior corrections logged:** (a) Antigravity `agy` is NOT a feature-stripped replacement — it deliberately keeps
Claude-Code-style Skills/Hooks/Subagents/Extensions; (b) Gemini is NOT capability-weak — it *leads* several reasoning
benchmarks; its weakness is *delivery/ownership reliability*, which is the axis this study cares about.

— end RR-01, dated 2026-06-17 —
