# Repo 2 — Development Background (meta repo): Agents, Workflow, Research

Scope: the *authoring* side. This repo is the single source of truth for
guidelines, agent definitions, skills, ADRs and research tooling. Nothing here
is loaded into coding sessions directly — it is synced into project repos
(Freya and future ones) in compiled/trimmed form.

---

## 1. Directory layout

```
dev-background/
├── guidelines/                      # CANONICAL guideline sources
│   ├── shared/
│   │   ├── php-laravel.md
│   │   └── filament.md
│   └── freya/
│       ├── 00-architecture.md
│       └── 30-freya-domain.md
├── skills/                          # canonical on-demand knowledge
│   ├── opencart-migration/SKILL.md
│   └── scope-manifest-howto/SKILL.md
├── agents/                          # Claude Code subagent definitions
│   ├── boundary-reviewer.md         # validates changes against layer ownership
│   ├── manifest-writer.md           # semantic half of the cutting agent
│   └── researcher.md                # web/Playwright research agent
├── adr/
│   ├── 0001-modular-monolith.md
│   ├── 0002-filament-strangler-fig.md
│   └── template.md
├── manifests/                       # cutting-agent OUTPUT (committed!)
│   └── freya/
│       ├── _index.md                # scope list + terminology definitions
│       ├── orders.scope.md
│       └── catalog.scope.md
├── scripts/
│   ├── sync-ai.sh                   # push compiled guidelines into project repos
│   └── audit-guidelines.sh          # line-count + staleness report
└── CLAUDE.md                        # rules for agents working IN this repo
```

---

## 2. sync-ai.sh (Povilas pattern, extended)

```bash
#!/bin/bash
# Usage: ./scripts/sync-ai.sh ../freya
set -e
TARGET="$1"

mkdir -p "$TARGET/.ai/guidelines" "$TARGET/.claude/skills"

# guidelines: shared + project-specific, compiled flat
cp guidelines/shared/*.md      "$TARGET/.ai/guidelines/"
cp guidelines/freya/*.md       "$TARGET/.ai/guidelines/"

# skills + current manifests (on-demand, cheap until activated)
rsync -a --delete skills/                "$TARGET/.claude/skills/"
rsync -a --delete manifests/freya/       "$TARGET/.claude/skills/scope-manifests/"

# agents
mkdir -p "$TARGET/.claude/agents"
cp agents/boundary-reviewer.md "$TARGET/.claude/agents/"

# recompile CLAUDE.md in the target project
( cd "$TARGET" && php artisan boost:install )
```

Run after any guideline/manifest change. CI option: a job in this repo that
opens a PR against Freya with the synced files, so guideline changes get
reviewed like code.

---

## 3. Agent definitions (subagents)

Keep them single-purpose; each gets its own clean context window, which is
itself a token-economy tool — heavy exploration happens in the subagent and
only the conclusion returns to the main session.

`agents/boundary-reviewer.md` (sketch):

```markdown
---
name: boundary-reviewer
description: Validates a diff against Freya layer ownership and Deptrac rules.
tools: Read, Grep, Bash(vendor/bin/deptrac *)
---
You review changes for architectural violations only — not style.
1. Read manifests/_index.md for scope and layer definitions.
2. For each changed file, determine its layer and scope.
3. Run Deptrac. Report violations with file:line and the rule broken.
4. Output: PASS/FAIL + table of violations. No fixes unless asked.
```

`agents/researcher.md` (sketch):

```markdown
---
name: researcher
description: Web research with Playwright for JS-rendered pages (YouTube posts,
changelogs, docs). Produces a sourced digest, never raw dumps.
tools: WebSearch, WebFetch, mcp__playwright__*
---
Output contract: max 1 page, every claim with a URL, separate "facts" from
"opinions", note publication dates. Save digests to research/ with date prefix.
```

MCP policy for THIS repo's `.claude/settings.json`: Playwright **on**,
laravel-boost **off** (no Laravel app here — nothing for it to introspect).

---

## 4. Cutting agent → manifests pipeline

Division of labor (your established principle, made explicit):

1. **Deterministic pass** (Deptrac + scripts): file→layer mapping, dependency
   graph, route inventory. Output: machine-readable JSON per scope.
2. **Semantic pass** (LLM — Gemini CLI today, or the manifest-writer subagent):
   intent, invariants, prose summary per scope. Input: the JSON from pass 1 +
   the four pressure-test artifacts (tree, routes, composer.json, one feature
   end-to-end).
3. **Compile** both into `manifests/<scope>.scope.md` with a fixed header:

```markdown
# Scope: orders
> Terminology: "feature scope" = vertical slice; "abstraction level" =
> horizontal layer. (Defined here to prevent agent misinterpretation.)
Layer ownership: ...
Public surface (other scopes may use): ...
Invariants: ...
Files: (generated — do not hand-edit)
```

Manifests are committed and synced as skills → future agents read one small
file instead of rescanning the codebase. Regenerate per scope only when its
files change (hash the file list from pass 1 to detect staleness).

---

## 5. ADR template (adr/template.md)

```markdown
# ADR-NNNN: <title>
Date: YYYY-MM-DD · Status: proposed | accepted | superseded by ADR-XXXX
## Context
## Decision
## Consequences
## AI-agent note
One paragraph: what an agent must do differently because of this decision.
(This paragraph is what gets extracted into guidelines.)
```

The "AI-agent note" is the bridge: ADRs stay full-length here; only the note
lines get compiled into the ~300-line guideline budget of Repo 1.

---

## Sources / further reading

- Claude Code subagents & settings: https://code.claude.com/docs
- Boost skills concept (on-demand vs upfront):
  https://laravel.com/docs/13.x/ai
- Povilas's sync-script workflow:
  https://aicodingdaily.substack.com/p/my-ai-guidelines-for-laravelphp-and
