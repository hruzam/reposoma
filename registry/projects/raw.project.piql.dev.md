---
card: raw.project.piql.dev
type: project-pointer
created: 2026-06-08
updated: 2026-06-24
path: /home/hruzam/www/piql/piql.dev/
repo: git@github.com:hruzam/piql.dev.git  (branch: core)
status: active — bus LIVE/GREEN; PROJECT.yaml CANONICAL (D29, 2026-06-23); temple-alignment pass closed; only Gate E/F (SSH) + named follow-ups open
role: TEMPLE / TEMPLATE ORIGIN — the most refined team setup; private/client projects derive from this
---

# piql.dev

The template/temple origin. A private, CPU-only local-model + multi-brand orchestration bus on an
office i5-12400 (Manjaro, no GPU), reachable from home over Tailscale. The pattern freya.devstudio
(and future private/client projects) derive from. Working style: fast, no overengineering,
briefing-over-building, human-gated phases.

## What the project/agent builder should know
- This is the TEMPLATE ORIGIN — to scaffold a new private/client project, start from this pattern.
- **PROJECT.yaml is now canonical** (resolved 2026-06-23, D29): temple-authored (@majkee) from the
  intake, **adopted by piql — not forked** (D14 anti-fork discipline). The old "don't create
  PROJECT.yaml locally" guidance is superseded.
- Refined shape: gated phase model; divergent-local `pulse.md` + `session/plan/` (git-excluded,
  per-machine) vs TRACKED `session/mesh-state.md` (the cross-machine "lighthouse"); orchestration
  bus as composable bricks under `bus/`; multi-machine via `$MACHINE_NAME` + Tailscale mesh;
  multi-vendor strength-combining (Claude / Cursor / Gemini-Antigravity / local).
- North star: a vendor-neutral `.piql/` primitive tree, peer to Claude Code — axis-locked as a
  one-direction **output surface**, NOT a second sovereign knowledge source (D31).

## Read first (POINTERS — never copies; each source owns its own detail)
- `CLAUDE.md` — entry, settled hardware, active agents, north star
- `flag.md` — phase state + DECISIONS LOG (D26–D31 canonical here) + alignment notes
- `PROJECT.yaml` — canonical contract (temple-authored, piql-adopted; resolved 2026-06-23)
- `session/mesh-state.md` — TRACKED lighthouse: live per-machine state (what's on which box)
- `session/handoff.2026-06-24.md` — latest travel handoff (office→home switch + cross-project synthesis)
- `session/plan/session.plan.md` + `pulse.md` — full plan + phase table (local, per-machine)
- `bus/` — orchestration bus bricks (prefilter gate, pip cloud link)
- `guides/` — `piql.md` · `piql-bus-usage.md` · `ssh-self-service.md` · `phase08-gates-BC-manual.md`

## Active agents
Core project (`.claude/agents/`): **houston** (architect) · **vara** (orchestrator — PILOT/provisional, D30) ·
**trajectory** (senior dev) · **epoch** (researcher).
PROJECT.yaml archetypes (reconciled 2026-06-23, D29): `architect, researcher, implementer, orchestrator, creator, executor`.
Vendored global creators (`.claude/agents/`, since 2026-06-24): `atlas-auto`, `atlas-ui`, `delta`.
Challenger function = global **@Janus** (no project-materialized seat).

## Hardware (settled)
Office i5-12400 · 16 GB · Intel UHD 730 (CPU-only) · Manjaro · NVMe 512 GB · always-on (sleep masked).
Home laptop = thin client (Ryzen 5 3500U). Reach: Tailscale mesh (office 100.126.182.111).

## Bus state
Bus is **LIVE/GREEN** (confirmed 2026-06-24). Brick detail below carries its as-of date — see
`session/mesh-state.md` for live machine state.
- BRICK 01 — privacy gate (`bus/prefilter/`), GREEN. **Gate v2 (2026-06-09) deterministic-first:**
  regex+denylist OWNS send/block; model additive-only, non-blocking. 17/17. Default model gemma3:4b.
- BRICK 02 — `pip` cloud link (`bus/pip/`), GREEN; privacy proven end-to-end. Exposed as command
  `piql` (not bare `pip`). Usage: `guides/piql-bus-usage.md`.
- Tooling: `piql` command wired · `piql-doctor` health check (9/9).
- Local runtime *(as-of mesh-state 2026-06-08)*: Ollama **0.24.0**, bound `127.0.0.1` only — Phase 8
  binding security gate PASSED 2026-06-08 (loopback-only verified). Models on box: gemma3:4b (gate),
  qwen3:1.7b, qwen3:4b, qwen2.5:3b. (0.30.5 upgrade evaluated → NOT needed; `think:false` works on 0.24.0.)
- LAN scan host (the heavier local-model tier): architecturally slotted but **not built** —
  hardware-blocked/deferred. Gated runbook + model candidates in `flag.md`.

## Decisions (one-line index — `flag.md` owns the full log)
- **D26** advisor = Opus · **D27** drop `-p` headless → MCP seam · **D28** guide-publishing is
  one-direction (project `guides/` → reposoma `raw.guides/`) · **D29** PROJECT.yaml canonical (resolved
  2026-06-23) · **D30** vara = pilot orchestrator (seat not yet earned) · **D31** `.piql/` axis-lock
  (one-direction output surface).

## Open / next
- **Gate E + F** (SSH hardening) — co-located runbook ready (`session/ssh-setup/HANDOFF_GATE_EF.md`).
- Named follow-ups (`flag.md`): `docs/decisions/` ADR migration (+ bring D1–D25, flip `docs.decisions`
  pointer) · `.claude/agents/*` tier reconcile (D31 caution) · temple draft reconciliation (drift-note).

## Temple reference
This IS the temple. freya.devstudio derived from it and refined further (canon/, Janus, CapCom).
When designing a new project team, read this + freya.devstudio.
