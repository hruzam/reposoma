# Project intake — piql.dev (per-project copy)

`tier: raw.guides/intake · founding record · READ-ONLY — do not maintain here`
`canonical card: reposoma/raw.settings/raw.card.piql.dev.md (create via /project-regular-self-report piql.dev)`
`this file is the A–G source for Phase 2 (new card) — once the card exists this file becomes historical`
`project: piql.dev · path (office box): /home/hruzam/www/piql/piql.dev`
`one head: @Houston (piql.dev claude basement) · temple architect: @majkee / reposoma basement`
`filled by: @Epoch (piql researcher) · 2026-06-18`
`rule: answer short. a blank means "not promised yet", not a bug. field work refines it.`

> piql predates the PROJECT.yaml convention — onboarding here is *adoption*, not a fork-create.
> The de-facto contract today is `CLAUDE.md` + `flag.md` (as the registry beacon records).
> A–G below maps piql's existing, documented reality so the temple can write the canonical contract.

---

## A · Identity
- name + one-line purpose: **piql.dev — privacy-first orchestration bus: gate → scrub → Ollama inference → answer, on CPU-only office hardware (i5-12400, no GPU, Manjaro).**
- which is this — "real reposoma", or a new one: **a new one — the original temple/template origin. Predates the PROJECT.yaml convention; being formally adopted now.**

---

## B · Nature of the work — this draws the domain seats (I grant none you don't earn)
- what dominates: **building/coding (bus bricks) + operating a live system (Ollama, Tailscale mesh, always-on office box). Mix, build-first.**
- a narrow correctness/performance-critical heart? → deep core specialist: **yes — the privacy gate. Fail-closed discipline is non-negotiable: any error must block, never leak. Deterministic matchers own the send/block decision; model is additive-only.**
- a body of method/math the team must get right? → domain researcher: **no (no numerics/spectral). Researcher role = live-verified model/version freshness: Ollama releases, model candidates for the hardware, API shape changes.**
- deterministic tools, agentive tools, or both? → the builder split: **deterministic-dominant today (bus bricks: zsh + curl + jq, strict-schema contracts, test-driven). Agentive (.piql/ primitive tree) is north-star only — not built.**
- a human-facing surface where the system explains itself? → surface seat: **yes — the `piql` command + `piql-doctor` health check; the operator guides. Terminal-only; no browser surface.**

### Seat candidates → `agents:` (present, don't lock — architect decides)

| seat | status | evidence |
|---|---|---|
| architect | **firm** | houston runs this; phase sequencing, canon, bus design |
| challenger | **base seat — ABSENT from active roster** | ⚠ piql has no challenger agent (CLAUDE.md: houston/vara/trajectory/epoch). Flag: does the temple @Janus pass cover the challenger function for ongoing sessions, or does piql need a standing challenger? |
| researcher | **firm** | epoch runs this; live model/version freshness checks |
| implementer | **firm** | trajectory runs this; builds deterministic bricks (the implementer's dominant mode here is deterministic-tool-builder — worth naming, but trajectory is the one dev; architect decides if it splits out) |
| orchestrator | **candidate — do NOT assert earned** | vara is listed but piql is human-gated (Gate A/B/C); current "orchestration" = brick pipeline + human gates. Subai precedent: defer until human routing is a measured bottleneck. Present as candidate; let architect gavel. |

---

## C · The contract — becomes PROJECT.yaml (capability terms, not stack terms)
- stack (lang/framework — informational): **zsh + curl + jq (bus layer); Ollama REST API (JSON/HTTP, 127.0.0.1:11434); gemma3:4b (gate model, Ollama-managed)**
- commands:
  - test:  `bus/prefilter/tests/run-tests.zsh && bus/pip/tests/run-tests.zsh`
  - lint:  *(not defined)*
  - build: *(not defined — file-driven bricks, no build step)*
  - run:   `piql "…"` *(after sourcing `piql.env.zsh`; see `guides/piql.md`)*
  - health: `bus/piql-doctor.zsh` *(or `piql-doctor` after sourcing — 9 checks)*
- docs entry points *(all resolve to real files in piql.dev repo)*:
  - architecture: `flag.md` *(hardware/security/phase decisions; no standalone ARCHITECTURE.md)*
  - decisions:    `flag.md` *(tracked; per-machine plan at `session/plan/session.plan.md`)*
  - conventions:  `guides/piql.md` *(operator guide — entry to `guides/` dir)*
- hard constraints *(→ flag.md + per-vendor trust layer, NOT PROJECT.yaml — schema v1 has no constraints field)*:
  - Ollama bind `127.0.0.1:11434` only — no LAN until Gate C (SETTLED: flag.md)
  - GGUF format only — no pickle (SETTLED: flag.md)
  - Gate must fail-closed — any error → block, never leak (bus contract; BRICK_01)
  - No `0.0.0.0` bind (SETTLED: flag.md)
  - Comment language: *(not stated anywhere in piql anchors — leave blank)*
  - Forbidden tools: *(not formally stated)*

---

## D · Teams & the one head — the allocation
- vendor-teams on this project: **Claude Code (always — lead: architecture, canon, bus design, agent layer, phase sequencing) · Cursor/Codex (secondary — deterministic brick implementation: zsh/curl/jq bricks, implementation-only lane)**
- the one head (allocates work, holds canon authority): **@Houston (piql.dev claude basement). Operator = human gate.**
- the split — what each team OWNS ("mine / yours"). Canon stays at the basement gate: **Claude owns architecture + bus design + canon authorship + phase sequencing. Cursor owns deterministic brick implementation (code-only; no architectural calls). Canon stays at the Claude gate; Cursor reads contract, integrates. (Force 4, one-direction.)**

*Note: Gemini/Antigravity mentioned in `registry/projects/piql.dev.md` as part of multi-vendor aspirational shape — not actively allocated on piql today. Leave seat open; don't pre-assign.*

---

## E · Volume & cadence — this sets the thresholds I name out loud
- how much work, how fast (rough): **low-to-moderate; single operator; hardware-gated (local model scan tier blocked until office box proven + Gate B/C passed). Cloud models carry all dev-time work.**
- "every few steps" feedback = how many steps / how often: **at every phase gate (A / B / C); operator is the human gate. Between gates: at each brick completion (brick = PASS/FAIL + written result card).**
- the threshold that would earn a msg-bus / orchestrator / sub-team (or leave to me): **orchestrator deferred — not earned. Revisit when: (a) multiple bricks in parallel require agent-dispatch coordination the human can't route, OR (b) local scan tier is live post-Gate C and generating volume. Until then: human-as-orchestrator.**

---

## F · Live state — Model-C sizing (the one untuned string)
- does the work need runtime truth (schema · last error · logs)? how fat: **runtime truth IS files — `session/mesh-state.md` (lighthouse), `flag.md` (decisions), bus task cards (`session/bus/tasks/`), `~/.config/piql/registry.toml` (machine-local footprint map). No constantly-running DB. mcp_profile = minimal / placeholder (O1 deferred, per onboarding-kit R6).**

---

## G · Out of scope — what this project does NOT promise:
- **NOT GPU or dedicated VRAM** (CPU-only, settled hardware decision — do not re-litigate)
- **NOT LAN Ollama exposure** before Gate C (loopback-only until operator passes the gate)
- **NOT `.piql/` primitive tree / vendor-neutral CLI** (north star, not built — keep path open, don't build)
- **NOT headless agent orchestration** (no autonomous dispatch; always human-gated phases)
- **NOT a cloud-model replacement** (piql gates cloud; it does not replace it)
- **NOT a web/browser interface** (terminal-only today)
- **NOT multi-machine model hosting** (one Ollama host, office box; home = thin client by physics)

---

## ✱ Beacon conformance note — for the temple architect

Current beacon: `reposoma/registry/piql.md`

**Checked against convention (registry README + onboarding-kit + task):**

| check | status | detail |
|---|---|---|
| filename `piql.dev.md` | ⚠ **MISMATCH** | file is `piql.md`; convention (subai.devenv.md, reposoma.devenv.md) uses full project-id. Should be `registry/piql.dev.md`. Index row would need updating. |
| pointers only | ✓ | beacon holds paths, not content; no docs pasted in |
| path style | ✓ (de facto) | uses `/home/hruzam/...` absolute paths — same style as `subai.devenv.md` (the cleared beacon ground truth); `~/` tilde form not used |
| `host:` present | ✓ | `host: office` |
| `updated:` present | ✓ | `updated: 2026-06-18` |

**Recommended action (temple architect):** rename `piql.md` → `piql.dev.md` + update the `registry/index.md` row reference. Mechanical change; content is conformant.
