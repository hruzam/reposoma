# pulse.atlas — Atlas status log (Atlas writes · Houston + all reads)

Newest on top. Single-writer: Atlas owns this file.
Read alongside `pulse.claude.md` to see what the Claude crew has done.
Atlas reads `pulse.claude.md` before starting — sees what Houston has tabled or done.

Canon: `raw.canon/canon.mail-protocol.md` (single-writer-per-file · ask-first · everyone reads all).

---

## [2026-07-03]

### Gemini rebuild — plan + execution briefs COMPLETE

Plan: `~/.claude/plans/we-are-in-plan-smooth-sprout.md`

4 executor brief files written to `_mail/toAll/inbox/`:
- `task.gemini-rebuild.phase0-research.md` — Epoch (RE/SEARCH, 7 questions, gates all)
- `task.gemini-rebuild.phase1-infra.md` — Trajectory Track A (processor + keyboard + kill + base.zsh + README + guides + AGENTS.md)
- `task.gemini-rebuild.phase1-scripts.md` — Gemini team / second Claude session Track B (4 per-agent scripts)
- `task.gemini-rebuild.phase2-finalize.md` — Trajectory (gemini-cross-check + epoch.md + 2 cards + stress test + ia-sync sync)

Exploration findings captured in plan: current gemini-agents.zsh has 7 partitions + all models; ia-sync is explicit/manual (sync.sh, already stale); single hard-coded path breaks after rebuild (gemini-cross-check.md line 33); model matrix in raw.card.gemini-models.md recommends 2.5 line for CLI; no stability matrix exists yet.

**Needs commit:** pulse.atlas.md + 4 new brief files (Trajectory or user).

---

### Stale settings cards — RESOLVED (Epoch actualized, not marked)

Houston tabled to Atlas: `card.claude-ai`, `card.claude-code`, `card.cursor-ide`, `card.gemini-gems` — all 4 past half-life.
User confirms Epoch actualized all 4. Inbox mail already archived. Closed here. Houston's pulse.claude.md entry stands as historical record.
Companion flag (`card.cursor-ide` + `card.gemini-cli` via session-hygiene card) — subsumed by same Epoch pass.

---

## [2026-07-02]

### T5 DONE — nabla-lab report read + gemini-rebuild mail lean (2026-07-03)

- Read `nabla-lab/session/report.final.oraculum.2026-07-02.md` §6 + `leg-gemini-direct.2026-07-02.md`
- Key finding: Gemini P1 research leg produced no cards — bluebottle persona lock + 503s on direct CLI attempts (separate from the script). `-p` flag confirmed real by Oraculum's direct bash.
- Lean written to `_mail/atlas/inbox/majkee.gemini-rebuilding-cleanup.2026-07-03.md` under `# ATLAS PREINCARNATION LEAN`
- Covers: confirmed facts, one clarification request ("massive"?), structural leans (`.sh` over `.zsh`, `--raw` load-bearing, RE/SEARCH gates BUILD), dependency flags (gemini-cross-check + epoch.md)

---

### T4 DONE — gemini-cross-check + BlueBottle + Delta soft-enforcement (2026-07-02)

Mail: `_mail/atlas/inbox/epoch.gemini-synth-delta-build.2026-07-02.md`

**Task 1 — Delta soft-enforcement (no new primitive):**
- `~/.claude/agents/epoch.md` — `## Subagent` updated: delta spawn now includes turn-budget
  injection rule ("Complete in ≤3 turns: read → edit → report") + gemini-cross-check routing rule.
  Option A (project-scoped delta) rejected — would leash ALL delta spawns in reposoma, not just Epoch's.
  `maxTurns` cannot be injected at Agent tool call time (not a supported parameter).

**Task 2 — gemini-cross-check + BlueBottle:**
- `reposoma/.claude/agents/gemini-cross-check.md` — NEW Haiku plumbing agent (maxTurns:4,
  Bash+Write+Read). Writes blob to tmp → calls `zsh ~/.config/zsh/ai/bluebottle.zsh "$TMPFILE"` →
  returns synthesis or graceful-fail signal. Never blocks Epoch.
- `~/.gemini/agents/bluebottle.md` — NEW Gemini Flash synthesis seat (no tools, strict schema:
  3 agreements · 2 additions/corrections · 1 overstated). Persona: Turing mercury delay-line memories.
- `~/.config/zsh/ai/bluebottle.zsh` — NEW standalone driver. Two-path:
  1. REST API primary: `GOOGLE_API_KEY` (preferred, matches CLI key priority) → curl →
     `generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent` →
     jq extract → clean output. Fix: `printf '%s'` not `echo` for jq pipe (trailing newline broke parse).
  2. CLI fallback: `gemini "@bluebottle $BLOB"` with `grep -v` noise filter for startup warnings.
- `~/.config/zsh/ai/gemini-agents.zsh` — `bluebottle()` function added as PARTITION 5;
  agy→PARTITION 6, help→PARTITION 7; help table updated.
- `~/.config/zsh/ai/gemini-base.zsh` — `g-bluebottle` / `gemini-bluebottle` aliases added.
- `~/.config/zsh/ai/base.zsh` — "Defines:" comment updated to include bluebottle.

**Confirmed working:** REST API path fires (GOOGLE_API_KEY set), schema respected, zero CLI noise.
BlueBottle correctly flags non-research input. Graceful-fail guard in place.

**Parked:** headless auth / `--agent` flag investigation — moot, REST API is the right rail.

---

### T3 DONE — Oraculum seated, Hypatia retired (2026-07-02)

- `~/.claude/agents/oraculum.md` — new agent (Fable · effort:high · Read/Grep/Glob/Write/Agent)
  - Scientist-tier, user-invoked alternative to Houston. Same canon reading list.
  - Phases: Substrate → Architecture → Directive. Buffering (Nabla-derived). Honesty baked in.
  - Therapy protocol (Symmetry-derived). Neural/coding depth close to Color.
- `~/.claude/agents/hypatia.md` — tombstone (retired, points to oraculum)
- `~/.claude/skills/agol-brief/SKILL.md` — new skill (repurposed from hypatia-brief)
- `~/.claude/skills/hypatia-brief/SKILL.md` — tombstone (retired, points to agol-brief)
- `temple/roster.md` — Hypatia → Oraculum (table row + name-origin entry)
- `temple/system-map.md` — HYP node → ORA; dispatch hierarchy updated; v5 changelog added
- `raw.canon/canon.cost-gradient.md` — tier table updated
- `temple/decisions/0006-model-effort-assignment.md` — matrix row updated
- `~/.claude/agents/houston.md` — @Hypatia refs removed; @Oraculum noted as user-invoked alt
- `~/.claude/agents/flight.md` — @Hypatia → @Oraculum in "do not spawn" list
- `~/.claude/agents/agol.md` — stale "running on Opus" note cleared; Fable confirmed

**Positioning note:** Oraculum is a philosophical gradient above Houston (user choice of seat,
not a dispatch node Houston calls). `hypatia-brief` repurposed to `agol-brief` for Agol
synthesis handoffs. Therapy file `raw.therapy/hypatia-core/` kept as historical archive.

---

### Done
- **T2 DONE — nabla-lab AGENTS.md: standing disciplines section** (2026-07-02)
  - Added `## Standing disciplines` (two bullets) after Conventions, before Read order.
  - Token economy / ask-first → pointer to `raw.canon/canon.mail-protocol.md`. Context discipline → read thin, list inbox filenames first. Canon gavel not duplicated (already in Conventions).

- **T1 DONE — nabla-lab canon injection audit** (2026-07-02)
  - Audit scope: does a bones project (PROJECT.yaml + AGENTS.md + CLAUDE.md + session/pulse.md) produce correct canon injection for global agents? Includes temple disciplines — doctrine, forces, **token economy** — not just project orientation.
  - Findings:
    - `CLAUDE.md` (`@AGENTS.md`) present and live → project orientation injection works ✓
    - `session/pulse.md` + `PROJECT.yaml` present, correct shape ✓
    - `.claude/` does not exist → no project-scoped agent surface → **0008 propagation pass not applicable** (empty diff)
    - `CLAUDE.md` is gitignored → fresh clone breaks injection (latent risk, single-host lab for now)
  - **Two-layer verdict:**
    - *Project orientation:* sufficient. Global agents spawned in nabla-lab receive the lighthouse (what the project is, shaping team, gates, read order).
    - *Temple canon:* **insufficient.** Doctrine, nine forces, token economy (`raw.canon/canon.mail-protocol.md`), decision records (0001–0008) are NOT in the injection path. Reposoma is a separate repo, not mounted. Global agents carry only their compiled-in discipline slice — if temple moved since the definition was last written, the agent in a nabla-lab session won't know.
  - **nabla-lab gap (project-level):** AGENTS.md (the lighthouse) does not mention token economy / ask-first / don't-blow-context discipline. Agents operating there have no project-level signal for these behaviors — they rely entirely on their own definition. If a new global agent or a claude.ai persona (Nabla, Symmetry) operates in this project, it is flying blind on temple disciplines.
  - **Open question for Houston:** is the doctrine gap a structural issue for ALL bones projects, or only for projects whose AGENTS.md doesn't explicitly reference temple disciplines? Should `bootstrap-new-project.md` include a token-economy / key-discipline callout in the bones template?

- `raw.settings/README.md` — new: folder entry point, card frontmatter template, freshness rule
- `raw.card.claude-code.md` — MCP scope table (4 scopes, merge-not-override) + context-loading-by-scope (3 scenarios, CWD invariant, synthesizing-agent note)
- `bootstrap-new-project.md` — CLAUDE.md budget rule (120 cap, cumulative framing, open research flag) + session-handoff pattern note
- `~/.claude/CLAUDE.md` — Delta-for-git rule; combined line-count >120 notify rule (33 lines, outside repo)
- `commit ee95593` — 3 tracked files, 87 insertions
- `pulse.atlas.md` — this file (bones, wired to bus)
- `atlas-ui.md` — Step 0 added (read-state-first, pulse wiring)
- `~/.claude/skills/session-resume/SKILL.md` — new global skill (CWD-derived slug, ask-first, journal-free)

### Open / tabled
- CLAUDE.md line cap: RESOLVED — official = per-file 200-line soft cap; MEMORY.md is separate hard limit (200 lines/25KB). Bootstrap + card updated. Temple's 120-combined rule stands as conservative judgment.
- `@Agol` Fable candidate — DONE: `model: fable` written to `~/.claude/agents/agol.md` (outside repo, active next session)
- `advisor-high` model:fable — confirmed live ✓ no action needed
- **[TABLED → Houston]** nabla-lab doctrine gap: AGENTS.md missing token economy / temple disciplines callout. Broader question: should `bootstrap-new-project.md` bones template include a standing discipline section (or pointer to `raw.canon/`) so every project lighthouse covers this by default? Atlas flags; Houston gates.
