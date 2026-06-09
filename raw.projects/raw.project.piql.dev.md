---
card: raw.project.piql.dev
type: project-pointer
created: 2026-06-08
path: /home/hruzam/www/piql/piql.dev/
repo: git@github.com:hruzam/piql.dev.git  (branch: core)
status: active — orchestration bus live (BRICK 01 gate + BRICK 02 pip link GREEN)
role: TEMPLE / TEMPLATE ORIGIN — the most refined team setup; private/client projects derive from this
---

# piql.dev

The template/temple origin. A private, CPU-only local-model + multi-brand orchestration bus on an
office i5-12400 (Manjaro, no GPU), reachable from home over Tailscale. The pattern freya.devstudio
(and future private/client projects) derive from. Working style: fast, no overengineering,
briefing-over-building, human-gated phases.

## What the project/agent builder should know
- This is the TEMPLATE ORIGIN — to scaffold a new private/client project, start from this pattern.
- Refined shape: gated phase model; divergent-local `pulse.md` + `session/plan/` (git-excluded,
  per-machine) vs TRACKED `session/mesh-state.md` (the cross-machine "lighthouse"); orchestration
  bus as composable bricks under `bus/`; multi-machine via `$MACHINE_NAME` + Tailscale mesh;
  multi-vendor strength-combining (Claude / Cursor / Gemini-Antigravity / local).
- North star: a vendor-neutral `.piql/` primitive tree, peer to Claude Code.

## Read first
- `CLAUDE.md` — entry, settled hardware, army, north star
- `flag.md` — original handoff + settled hardware/security decisions
- `session/mesh-state.md` — TRACKED lighthouse: what's on which machine + live decisions
- `session/plan/session.plan.md` + `pulse.md` — full plan + phase table (local, per-machine)
- `bus/` — orchestration bus bricks (prefilter gate, pip cloud link)
- `guides/piql-bus-usage.md` — how to use the bus

## Active agents
houston-piql-architect · vara-piql-orchestrator · trajectory-piql-senior-dev · epoch-piql-researcher
Global reuse: trajectory-senior-dev · coder-junior · recorder · claude.creator.{auto,ui,sniffer}

## Hardware (settled)
Office i5-12400 · 16 GB · Intel UHD 730 (CPU-only) · Manjaro · always-on (sleep masked).
Home laptop = thin client (Ryzen 5 3500U). Reach: Tailscale mesh (office 100.126.182.111).

## Bus state (2026-06-08)
- BRICK 01 — privacy gate (`bus/prefilter/`), gemma3:4b, GREEN. Hybrid: deterministic matchers + model semantics.
- BRICK 02 — `pip` cloud link (`bus/pip/`), GREEN, privacy proven end-to-end. Expose as command `piql` (not bare `pip`).
- Local models: gemma3:4b (gate), qwen3:1.7b (future router). Ollama 0.24.0, 127.0.0.1 only.

## Temple reference
This IS the temple. freya.devstudio derived from it and refined further (canon/, Janus, CapCom).
When designing a new project team, read this + freya.devstudio.
