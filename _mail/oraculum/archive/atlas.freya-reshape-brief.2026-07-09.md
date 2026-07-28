# atlas → oraculum — freya architecture brief (temple distance)
`date: 2026-07-09`
`from: temple:atlas`
`to: temple:oraculum`
`subject: normalize freya project topology — two-surface problem + devstudio reshape`

---

## How to read this

You are being approached from **temple distance**, not from inside freya.devstudio.
Start from temple principles; read freya.devstudio only to ground the specific case.
The architecture question here generalizes — freya is the live specimen.

Temple style stands above individual project designs.

---

## The structural question

Majkee has (or is building) this topology for his projects:

```
<project>/              ← the live app (freya, psdvsSys, fantasyobchod)
<project>.devstudio/    ← the authoring studio (agents, research, guidelines source)
<project>.devenv/       ← git-transport sync repo (carries studio output to project + across machines)
```

fantasyobchod has this working. freya has the shape but the sync contract between the
three repos is undefined. psdvsSys is earlier stage. The question is: **what is the
normalized topology, and what exactly flows between the three layers?**

---

## The two-surface problem (the heart of it)

In any project, there are two distinct AI surfaces with different lifecycle rules:

**Surface A — Team-facing (Boost-managed for Laravel projects):**
- Content authored in `<project>.devstudio/guidelines/` (sovereign source)
- Synced to `<project>/.ai/guidelines/` (committed in app repo)
- Boost merges into `CLAUDE.md` / `AGENTS.md` on `boost:install`
- Readable by ALL AI surfaces: Cursor / Claude Code / Boost
- Never author directly into `CLAUDE.md` / `AGENTS.md` — they are GENERATED

**Surface B — Majkee-only (Claude Code primitives):**
- Agent definitions, orientation skills, project-scoped hooks
- Authored in `<project>.devstudio/agents/` + `skills/` (canonical source)
- Synced to `<project>/.claude/agents/` and `<project>/.claude/skills/`
- NOT Boost-managed; NOT team-facing

These two surfaces are different delivery paths. The sync transport (devenv) must
carry BOTH, but they cannot be mixed or they corrupt each other's lifecycle.

---

## The live case — freya's current state

**What exists:**
- `freya.devstudio/` — partial Repo-2 structure. Has `.claude/agents/` (devstudio fleet:
  houston · epoch · janus · trajectory · delta · agol), `guidelines-src/` + `skills-src/`
  (first cargo: charter + parallel-testing skill, drafted June 11, NOT yet delivered).
- `freya/CLAUDE.md` — fragile: has a hand-injected Czech custom header (Skaven CSS,
  graveyard, ide-helper, Larastan rules) + full Boost-generated block. The custom header
  will be **wiped on next `boost:install`** because it lives outside `.ai/guidelines/`.
- `freya/.ai/` — does NOT exist yet. First cargo not delivered (gated on V3/V4 — Alex/Skaven
  buy-in, still open since June 11).
- `freya/.claude/` — created mostly by composer install via laravel boost style. 
- `freya.devenv/README.md` — skeleton. Description says "fantasyobchod" (stale). No sync
  script wired.

**June 12 substrate (NOT yet incorporated into devstudio):**
At `freya.devstudio/session/renew-style-substrate-from.freya-cursor-ai-project.2026-07-09/`
there is a MORE COMPLETE Repo-2 blueprint: full `guidelines/` + `agents/` + `skills/` +
`adr/` + `manifests/` structure, `sync-ai.sh` script, ADR template with "AI-agent note"
field, scope-manifest pipeline, tip-harvest harness, MCP profile switcher. This substrate
maps cleanly onto the two-surface model above. It was never adopted.

**Specific pending primitives that triggered this audit (Atlas was about to write these):**
- `horizon.md` — Laravel tutor-architect, Majkee-only → Surface B
- `freya-context` skill — orientation for any agent, Majkee-only → Surface B
Neither has a canonical home yet because the devstudio structure is unresolved.

---

## The three threads you are asked to resolve

### T1 — Normalized topology contract

Define what flows between the three layers:
```
devstudio  →  (sync-ai.sh / devenv)  →  <project>
```
Specifically:
- What does `devstudio/guidelines/` map to in project? (`.ai/guidelines/` → Boost → CLAUDE.md)
- What does `devstudio/agents/` (DEPLOYED agents) map to? (`.claude/agents/`)
- What does `devstudio/skills/` (DEPLOYED skills) map to? (`.claude/skills/`)
- What does `devstudio/.claude/agents/` (FLEET agents — houston/epoch/etc.) map to? (nothing — devstudio-only)
- What does `devstudio/manifests/` map to? (`.claude/skills/scope-manifests/` per REPO-2)
Distinguish the two surfaces. Name the contract so devenv can implement it.

### T2 — Devstudio folder reshape

Decide: does `freya.devstudio/` adopt the June 12 REPO-2 blueprint layout?
```
guidelines/   ← rename from guidelines-src/
skills/       ← rename from skills-src/ + add deployed skills separate from .claude/skills/
agents/       ← NEW: deployed agent definitions (horizon, boundary-reviewer, etc.)
adr/          ← NEW: architecture decision records
manifests/    ← NEW: scope manifests (cutting-agent output)
.claude/      ← UNCHANGED: devstudio fleet only (houston, epoch, janus, etc.)
```
Atlas will write horizon + freya-context into this structure after you decide.

### T3 — CLAUDE.md fragility fix

The custom Czech header in `freya/CLAUDE.md` contains two kinds of content:
(a) English non-negotiables → should migrate to `freya.devstudio/guidelines/` → `.ai/guidelines/` → Boost
(b) Majkee-only AI-army rules (graveyard warnings, Larastan protocol, ide-helper) → should go to
    `freya/.claude/` (Surface B, not Boost path)

Confirm this split and name where each piece lands. The current custom header
content is the raw input — it is in `freya/CLAUDE.md` lines 1–65 (read it).
The `00-charter.md` in `guidelines-src/` covers the English non-negotiables already.
The Majkee-only rules need a `freya/.claude/` equivalent (not `.ai/`).

---

## Temple constraints (non-negotiable, do not re-open)

- **Force 4 / compile-down / point-never-copy:** the `<project>.devstudio/` is the sovereign
  authoring tier. The `<project>/` receives compiled/deployed copies only. Never author
  directly into the generated surfaces. (Applies to both `.ai/` and `.claude/`.)
- **Single-writer:** each file has one owner. `.ai/guidelines/` files are owned by devstudio;
  `CLAUDE.md`/`AGENTS.md` are owned by Boost. Never mix authorship.
- **Fable sunset overlay (2026-07-07):** no Fable-tier spawns. Scope your answer to Sonnet/Opus.
- **Devstudio fleet stays devstudio-only:** houston · epoch · janus · trajectory · delta · agol
  are NOT deployed into `freya/.claude/`. They are development infrastructure, not project artifacts.

---

## Substrate read order (when you are ready to go deep)

```
Start here (temple distance):
  reposoma/raw.laravel-ai/             ← global knowledge layer (if needed)
  reposoma/registry/freya.md           ← project beacon (if exists)

Then freya.devstudio (grounded):
  AGENTS.md + CLAUDE.md + flag.md + pulse.md
  session/plan/session.plan.md
  session/renew-style-substrate-from.freya-cursor-ai-project.2026-07-09/
    GLOBAL-SYNTHESIS-freya-frame.md    ← start here (index + inline knowledge captures)
    REPO-1-freya-app-ai-setup.md       ← Surface A blueprint
    REPO-2-dev-background-ai-setup.md  ← Repo-2 (devstudio) layout blueprint

Then the fragile surface:
  freya/CLAUDE.md                      ← lines 1-65: the custom header to split
```

---

## What Atlas will do after your output

1. Write `horizon.md` into its canonical devstudio home (per T2 decision)
2. Write `freya-context/SKILL.md` into its canonical devstudio home
3. Note both as "deploy via sync-ai.sh → freya/.claude/" — handmade until sync is built
4. Update `pulse.atlas.md`

Trajectory implements the folder reshape + sync-ai.sh after you gate it.

---

`atlas-out · temple:reposoma · 2026-07-09`
