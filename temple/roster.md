---
expiration: weather (updating often according dev needs)
updated: 2026-06-15
CLI: Claude Code, Gemini (agy), Cursor, ChatGPT/Codex, piql
Chat-bots: GEM (gemini.google.com), claude.ai
IDE: Cursor
locals: gemma3:4b (Ollama, gate-only)
---

# TEAM ROSTER

---

## CLI runtimes & surfaces

| Handle | Invocation | Backend | Notes |
|--------|-----------|---------|-------|
| Claude Code | `claude` | Claude (Anthropic) | Primary CLI, this session |
| Antigravity | `agy` | Gemini (API) | Research; personal login sunset 2026-06-18, survives on API key |
| Cursor | `cursor` / `agent` | Cursor (Anthropic/OpenAI mix) | Coder + co-architect, reads `.claude/` harness |
| ChatGPT / Codex | `chatgpt` | OpenAI | Third research voice (R3) |
| piql | `piql` | Claude via privacy gate | Privacy-gated assistant; scrubs PII/secrets locally before cloud; exit 0 answered · 2 blocked · 1 tool broke |
| piql-doctor | `piql-doctor` | local | 9-check health tool for piql bus |
| GEM | gemini.google.com | Gemini | Chat-bot |
| claude.ai | claude.ai | Claude | Chat-bot |

**Office box:** i5-12400 · Manjaro · no GPU · reachable via Tailscale (`ssh office` → `100.126.182.111`)

---

## Global agents — `~/.claude/agents/`

These load in every Claude Code session regardless of project.

| @ name | File | Model | Role |
|--------|------|-------|------|
| @Atlas | `atlas-ui` | Sonnet | Interactive primitive creator — interactive sessions, buffers before writing |
| @AtlasAuto | `atlas-auto` | Sonnet | Automated primitive creator — spawnable by orchestrators, writes to staging |
| @Zenith | `zenith` (`claude.creator.sniffer`) | Haiku | Targeted reader for heavy `raw.settings` reference files |
| @Agol | `agol` | Fable | Continuous-reasoning advisor — cross-phase synthesis, non-adversarial, no verdict forced |
| @Houston | `houston` | Opus · effort:high | Architect / orchestrator — phase planner, owns `session/plan/session.plan.md`, spawns @AtlasAuto + @Janus, gated by @CapCom. Project-agnostic global form (freya/piql variants are project-scoped) |
| @Janus | `janus` | Opus · effort:high | Challenger — second voice before a decision locks: one position, one primary risk, one alternative. Read-only. Project-agnostic global form (freya `janus-devstudio-counsel` is project-scoped) |
| @CapCom | `capcom` | Sonnet | Mission controller — human gate before Houston gets full autonomy |
| @Hypatia | `hypatia` | Opus | Strategic cross-project consultant (Larva / Chytros / Stridularium) — Astrolabe method, one ranked verdict |
| @Recorder | `recorder` | Haiku | Session memory librarian — merges dumps/artifacts into `session-draft-memory.md` |
| @Senior | `trajectory` | Sonnet | Senior implementation lead — flags better approaches, spawns @Delta |
| @Delta | `delta` | Haiku | δ(x) executor — surgical tasks, zero judgment, integrates to one |
| @Symmetry | `symmetry` | — | AI-human cohabitation project persona (conceptual layer, not a CLI agent) |

**Agol vs Janus:** Agol = continuous synthesis, no verdict forced. Janus = adversarial challenger, one verdict. Pick by purpose. Agol → Janus fallback if Fable ceiling hit.

---

## Project-scoped agents
> Project-scoped agents, stack facts, and research phases live in each project's own roster (e.g. freya.devstudio — in that repo). Kept out of the agnostic substrate.

---

## Local models

| Model | Runtime | Port | Role |
|-------|---------|------|------|
| gemma3:4b | Ollama | 127.0.0.1:11434 | piql gate — advisory PII/secret detection layer (can add redactions, cannot block) |

---

## Knowledge layers

| Layer | Path | Use |
|-------|------|-----|
| raw.settings | `/home/hruzam/reposoma/raw.settings/` | Native primitive cards, harness docs — Atlas/AtlasAuto source of truth |
| reposoma RAG | `/home/hruzam/reposoma/` | Global config, raw cards, temple |
| piql registry | `~/.config/piql/registry.toml` | Paths, services, ports for office box |
| recorder index | `~/.claude/recorder.index.json` | All known session roots (cross-project scan) |
| houston goal | `~/.claude/houston.goal` | CapCom reads this before spawning Houston |

---

## Name origins

One line per name. Full vignettes live in each agent's body.

| Name | Origin | Why this role |
|------|--------|---------------|
| **Houston** | *"Houston, we have a problem"* — Apollo 13. First AI collaborator (~2 years). | The voice you call when things go wrong in space. Field project architect. |
| **Agol** | Henrietta Swan Leavitt (1908): *"no sharp dividing line can be drawn between true Algol stars and those whose variations are continuous."* | Advisor that holds reasoning across phase boundaries without forcing a verdict shape. |
| **CapCom** | NASA Capsule Communicator — the only voice at Mission Control authorized to speak directly to astronauts in flight. | One human gate between the crew and the full ground apparatus. *"Houston, we have a problem"* was said here first. |
| **Hypatia** | Hypatia of Alexandria — mathematician, astronomer, philosopher. Her instrument: the astrolabe. | Takes chaotic inputs, runs the calculation, returns a precise bearing. No hedge soup. |
| **Recorder** | Dr. David Warren — inventor of the flight data recorder and cockpit voice recorder. | Keeps the record clean whether anyone is listening or not. |
| **Trajectory / Senior** | Katherine Johnson — NASA mathematician. John Glenn refused to fly until she personally verified the IBM's numbers. | Gives the vessel its flight path. Not just execution — trajectory. |
| **Epoch** | An epoch is a fixed reference point from which time is measured. The name says it. | Researcher; every claim dated, every source cited, recalibrates from cutoff before every run. |
| **Janus** | Roman god of transitions and doorways — two faces, past and future. | Challenger; sees what the plan cannot see from inside itself. |
| **Atlas** | Holds the celestial sphere in myth. Also: the book that maps the whole world's shape. | Every agent profile, every skill card is a page. Holds the structure so others can navigate. |
| **Vara** | Dorothy Vaughan — *"Human Computer"* who mastered the IBM 7090 and carried her whole team with her. Etymology: Vaughan (lineage) + Variable (adaptability) + Latin *vara* (support that holds the structure) + Sanskrit *vara* (blessing, choice). | Orchestrator; stability through evolution, no one left behind when the paradigm shifts. |
| **Orby** | Sir William Herschel — saw binary stars dancing and theorized fuzzy nebulae were distant island universes. He was right. | Deep researcher; methodical observation, patience as telescope, delivers coordinates not conclusions. |
| **Delta** | Paul Dirac's δ(x) — zero everywhere except the exact point of action, where it fires completely and integrates to precisely one. | Surgical executor; smallest change, exact scope, nothing left over. |
| **Symmetry** | Emmy Noether — mathematician. Einstein: *"the most significant creative mathematical genius thus far produced."* Her theorem: every symmetry of a system corresponds to a conserved quantity. | What is invariant in human↔AI cohabitation when frames shift? That is the question this project lives in. |
| **Zenith** | Arab astronomers of the Islamic Golden Age. Coordinate: *samt ar-raʾs* (سمت الرأس) — "the road directly above one's head." A 14th-century scribal error turned *samt* into *zenit* → *zenith*. The word misfired; the concept landed exactly overhead. | A tribute to a civilization that held the sky open and the mind free. Navigates directly to the relevant point, no spread. |
