---
card: eagle
kind: agent-profile · RELATIVE (refreshable via /project-regular-self-report pattern or manual pass)
host: office
status: active
verified: 2026-07-15
half_life_days: 30
agent: ~/.claude/agents/eagle.md
model: sonnet
effort: low
tools: Read, Grep, Glob, Bash, Write
---

# eagle — agent profile card

Agent: `@Eagle`
Role: Project orientation and structure explorer. Spawnable by any orchestrator (Houston,
Flight, Vara, Atlas) or invoked directly. Returns a compact orientation report without
consuming the spawner's context window. Can run tree-snapshot (Bash) and write output
reports when explicitly asked. Never touches harness or canon files.

Companion skill: `/project-read` — inline, same procedure, zero spawn overhead, no Bash.
Use Eagle when isolation matters or tree-snapshot depth is needed; use /project-read inline.

Skill: resynthesize this card when cascade logic changes, new projects enter the map,
beacon field names drift, or tool list changes.


## Cascade — how Eagle resolves a project root

Four steps, cheapest first. Stops at first hit.

Step 1: temple-project-map.zsh (fastest — one file read, one grep)
  File: ~/.config/zsh/ai/temple-project-map.zsh
  Pattern: grep [<project-name>] -> extract path from ="<path>" on same line
  Coverage: all projects currently in the map (see coverage section below)

Step 2: registry/index.md (logical map — catches projects not yet in the machine map)
  File: reposoma/registry/index.md
  Pattern: grep project name -> find table row -> extract beacon link

Step 3: beacon file (physical path in frontmatter)
  File: reposoma/registry/<project>.md
  Field: path: /home/hruzam/www/...

Step 4: ask once. No response -> stop, report "root unresolvable".

Special case — nabla-lab: omitted from the machine map by design (subdirectory of
reposoma). Resolution: map[reposoma] + /nabla-lab.

Explicit path argument (/home/... or ~/...): skip the cascade entirely.


## Projects in temple-project-map.zsh as of 2026-07-15

Mapped (9 entries):
  reposoma          -> /home/hruzam/reposoma
  subai.devenv      -> /home/hruzam/www/ovum/subai.devenv
  reposoma.devenv   -> /home/hruzam/www/ovum/reposoma.devenv
  freya.devstudio   -> /home/hruzam/www/imago_cz/freya.devstudio
  piql.dev          -> /home/hruzam/www/piql/piql.dev
  vacuole           -> /home/hruzam/vacuole
  fantasyobchod     -> /home/hruzam/www/imago_cz/fantasyobchod
  psdvsSys          -> /home/hruzam/www/psdvs/psdvsSys
  applications-in-common -> /home/hruzam/www/elements-factory/applications-in-common

Omitted by design:
  nabla-lab         -> subdir of reposoma; resolves via special case above

Not in the map (registry only, need Step 2+):
  vacuole.md, piql.dev, subai.devenv -- verify these resolve via step 2 if map misses them


## Beacon field names in use (as of 2026-07-15)

Standard frontmatter fields Eagle reads or references:
  beacon:       project slug
  path:         absolute disk path (the authoritative field Eagle extracts)
  repo:         github URL(s)
  host:         office | home | both
  status:       bootstrap | active | building | maintenance | cleared
  contract:     path to PROJECT.yaml
  lighthouse:   path to the main "read first" file
  sibling-of:   list of sibling project slugs
  shares:       named shared topics
  deposited-by: who created the beacon
  updated:      date last updated

Shared anchors section (## Shared anchors in beacon body): names the exact entry
points inside each sibling. Eagle reads this before navigating cross-project to avoid
a full sibling harness traversal.


## Harness read order (load-bearing)

1. AGENTS.md (or CLAUDE.md -> @AGENTS.md) -- loop, rules, delegation
2. .dev/flag.md                            -- locked decisions, invariants
3. .dev/pulse.md (top section only)        -- current state, newest first
4. .dev/PROJECT.yaml                       -- stack, MCP, devenv transport

Fallback: if .dev/ absent, try root-level flag.md and pulse.md.
Reposoma: read pulse.claude.md + pulse.atlas.md instead of .dev/pulse.md.


## Optional quick-reference layer (section 1.5)

If raw.settings/raw.card.<slug>.md exists and is within half_life_days:
Eagle may read it first for fast orientation before the full harness.
Card is NOT authoritative -- harness wins on any disagreement.
Stale card (verified + half_life_days expired): flag to orchestrator, proceed to harness.


## Known staleness triggers

This card should be refreshed when any of the following change:
- A new project is added to temple-project-map.zsh (coverage section above goes stale)
- Beacon frontmatter field names change (new fields adopted, old ones retired)
- The cascade step order changes (e.g. a step is added or removed)
- Eagle's model or tool list changes
- A new special-case resolution is added (like the nabla-lab rule)


## Run log

## 2026-07-16

Eagle upgraded — 3 extractions from factory diff:
- Cascade: Step 3.5 added (glob sweep before asking — AGENTS.md / PROJECT.yaml fallback)
- Read order: pulse.*.md variant fallback added (covers non-standard pulse layouts)
- Output block: Drift + Absent files rows added to orientation report template
- Memory: `memory: user` added to frontmatter — user preferences only (report format,
  detail level). Project state memory lives in raw.settings cards (section 1.5).
  Per-project Eagle-private memory rejected — redundant with existing sources.
- Source: factory diff against `/home/hruzam/.claude/agents/project-explorer.md`
  (factory-generated, now redundant — recommend deletion)

## 2026-07-15

Card created. First synthesis from eagle.md (last updated 2026-07-15).
9 projects in the machine map. Cascade: 4 steps. Special case: nabla-lab.
Beacon fields: 9 standard frontmatter fields + Shared anchors body section.
Companion skill /project-read confirmed distinct (inline vs spawned isolation).
