# The Bonding Layer: Scripts, Hooks & Skills in CLI Agent Systems

**Author:** @Houston (claude.ai) — research artifact  
**Date:** 2026-08-05  
**Scope:** Claude Code CLI skill system, community patterns, architectural vectors  
**Status:** research snapshot — not a design document  
**For:** @majkee / LARVA v3 architectural consideration

---

## 1. The Official Three-Layer Stack (As Of August 2026)

The Claude Code skill system has **no single "bonded script" concept** with its own name. What exists is a composable surface built from three officially supported mechanisms that sit at different points on the trust spectrum.

### 1.1. Hooks (Zero Trust, Mechanical, Global)

Hooks are lifecycle event handlers that run deterministic scripts when specific events occur. They fire at 25+ lifecycle points. The key ones:

- `SessionStart` — fires on every new or resumed session
- `UserPromptSubmit` — fires before Claude sees the prompt
- `PreToolUse` — the primary security checkpoint, fires before any tool executes
- `PostToolBatch` — fires after tool execution
- `Stop` / `SubagentStop` — fires when agent completes
- `PreCompact` — fires before context compaction

Hook configuration lives in `.claude/settings.json` (project scope) or `~/.claude/settings.json` (user scope). Hooks talk back via exit codes (coarse: 0=allow, 2=block) and JSON on stdout (fine: inject context, rewrite arguments, make decisions).

Four handler types exist: `command` (shell script), `http` (web endpoint), `mcp_tool` (MCP server call), and `prompt` (inject text). Hooks can run async with `async: true`.

**Trust model:** Zero trust. Hooks execute regardless of what the model thinks. They cannot hallucinate. They are the system-level enforcement layer.

### 1.2. Skills (Model-Invoked, Trust-Based, On-Demand)

A skill is a directory containing a SKILL.md file with YAML frontmatter and markdown instructions. Skills follow the open Agent Skills standard (cross-runtime: Claude Code, Codex, and converging).

Discovery: at session start, Claude loads only each skill's `name` and `description` from frontmatter (~100 tokens per skill). Activation: when a prompt matches, Claude loads the full SKILL.md body (typically <5K tokens). Execution: Claude follows the instructions and calls supporting files only as needed (progressive disclosure).

Skills live at three scopes:
- `~/.claude/skills/<name>/` — personal (user-level)
- `.claude/skills/<name>/` — project (committed to git, shared with team)
- Enterprise / Plugin — distributed via marketplace or `/plugin install`

**Trust model:** Full trust in model judgment. The model decides when to activate, what to read, which scripts to call. The human authored the instructions; the model interprets them.

### 1.3. The Bonding Mechanisms (The Middle Layer)

Between hooks and skills, three mechanisms create the "bonded script" surface:

#### 1.3.1. `!command` Shell Injection (Deterministic, Pre-Model)

The `!` backtick syntax in SKILL.md body runs shell commands **before** the skill content reaches the model. The command output replaces the placeholder inline — Claude sees only the result, never the command.

```markdown
---
name: pr-summary
description: Summarise changes in a pull request
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

## Pull request context

- PR diff: !`gh pr diff`
- PR comments: !`gh pr view --comments`
- Changed files: !`gh pr diff --name-only`

## Your task

Summarise this pull request...
```

**Trust model:** Deterministic. The script runs unconditionally when the skill activates. The model has no say in whether it runs — only in what it does with the output. This is the closest thing to a "bonded script" in the traditional sense.

**Key constraint:** `allow_shell_injection` must be enabled. Security warning applies — this allows arbitrary shell execution scoped to the skill.

#### 1.3.2. `allowed-tools` + Bundled `scripts/` Folder (Model-Invoked, Declared Scope)

A skill can bundle shell scripts, Python helpers, reference docs, and templates alongside SKILL.md:

```
my-skill/
├── SKILL.md
├── references/
│   └── REFERENCE.md
├── scripts/
│   └── process.py
├── templates/
│   └── template.md
└── examples/
    └── sample.md
```

The `allowed-tools` frontmatter field grants permission for listed tools **only during the turn that invokes the skill**. It does not permanently grant access.

```yaml
allowed-tools: Bash(git *), Bash(npm run *), Read, Write
```

**Trust model:** Model-invoked but scoped. The agent decides whether to call the scripts, but it can only use the tools declared in `allowed-tools`. The permission expires when the skill's turn ends.

#### 1.3.3. Skill-Scoped Hooks (Zero Trust, Skill-Bounded)

Hooks can be declared inside a SKILL.md frontmatter block. They fire only during that skill's lifetime and are cleaned up when the skill finishes.

```yaml
---
name: secure-operations
description: Perform operations with security checks
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/security-check.sh"
---
```

For subagents, `Stop` hooks are automatically converted to `SubagentStop`. Frontmatter hooks in a project subagent run only after the workspace trust dialog is accepted.

**Trust model:** Zero trust but bounded. The hook is mechanical (deterministic), but it only exists while the skill is active. This is the tightest bonding between a script and a skill — mechanical enforcement scoped to a specific workflow.

---

## 2. The Full Spectrum (Official + Community)

| # | Layer | Official? | Trust Model | Trigger | Lifetime |
|---|-------|-----------|-------------|---------|----------|
| 1 | Global hooks (settings.json) | Yes | Zero trust, mechanical | Lifecycle event | Always on |
| 2 | Skill-scoped hooks (frontmatter `hooks:`) | Yes | Zero trust, skill-bounded | Lifecycle event during skill | Skill turn only |
| 3 | `!command` shell injection | Yes | Deterministic, pre-model | Skill activation | Before model sees content |
| 4 | `scripts/` + `allowed-tools` | Yes | Model-invoked, declared scope | Model decision during skill | Skill turn only |
| 5 | Pure skill (markdown only) | Yes | Full trust, model judgment | Prompt matching | On-demand |
| 6 | `learnings.md` + Stop hook | Community | Feedback loop | Session end | Persists across sessions |
| 7 | Vector-based skill discovery | Community | Semantic hook + model judgment | File read event | Per-read |
| 8 | `defer` for human-in-the-loop | Official (SDK) | Pause/resume | PreToolUse match | Survives pause |
| 9 | `/output-style` as regime swap | Official | Persona injection | User invocation | Session-wide |
| 10 | `/compact focus` as selective memory | Official | Directed compaction | User invocation | Until next compact |
| 11 | Self-improving CLAUDE.md | Community | Agent self-edit | Session end | Persists in repo |

---

## 3. Community Patterns (The Open Windows)

### 3.1. Self-Improving Skills via `learnings.md` + Stop Hook

**The pattern:** A `learnings.md` file sits alongside SKILL.md. It gets read at the top of every run. A Stop hook triggers a reflection skill that analyzes the session, extracts corrections, and appends structured entries to `learnings.md`.

**How it works:**
1. Skill reads `learnings.md` before starting work
2. Agent works normally, user corrects mistakes
3. Stop hook fires at session end
4. Reflection script/skill analyzes the session transcript
5. New learnings are appended with confidence levels
6. Next session starts with accumulated knowledge

**Community implementations:**
- `haddock-development/claude-reflect-system` — full reflect system with confidence levels
- `gyc567/open-reflect` — dual-platform (Claude Code + OpenCode), evolutionary knowledge tracking
- MindStudio's learnings loop pattern — manual + automated variants

**Key insight:** This is not a hook. Not a skill. It's a **feedback loop glued between them**. The Stop hook is mechanical (fires unconditionally at session end). The reflection is model-invoked (the agent decides what to extract). The `learnings.md` is a persistent store that survives across sessions. The composition creates something none of the three layers can do alone.

**Weekly consolidation pattern:** When `learnings.md` exceeds ~100 entries, a consolidation skill merges duplicates, removes outdated entries, synthesizes principles, and flags items for human review. This prevents unbounded growth and promotes pattern emergence.

### 3.2. Semantic Skill Discovery via Vector Hooks

**The pattern:** Documentation is stored in a vector database (ChromaDB). When Claude reads a file, a PostToolUse hook extracts content, queries the vector store for semantically similar skills, and surfaces suggestions. Claude decides whether to load them.

**How it works:**
1. Hook fires on `Read` tool use
2. Hook extracts first ~500 chars of the read file
3. Python script queries ChromaDB for semantic matches
4. Matches above threshold (>25% for file reads, >30% for prompts) are surfaced as suggestions
5. Claude decides whether to load the full skill

**Key insight:** This replaces flat description-matching with semantic search. "User login flows" matches "OAuth authentication patterns" even though the words differ. The hook is mechanical (fires on every Read), but the activation decision is model-judged. This is the most experimental pattern — fragile, dependency-heavy (ChromaDB, embeddings), but architecturally interesting.

### 3.3. `defer` Hook for Human-in-the-Loop Pause

**The pattern:** A PreToolUse hook detects a sensitive tool call and returns `{ permissionDecision: "defer" }` instead of "allow". Claude exits. The human reviews the deferred action, and the session resumes with `claude -p --resume <session-id>`.

**How it works:**
1. PreToolUse hook matches a dangerous pattern (e.g., `rm -rf`, production DB write)
2. Hook returns `{ permissionDecision: "defer" }` via JSON stdout
3. Claude Code pauses — entire context window, tool history, and plan survive
4. Human reviews the deferred `deferred_tool_use` payload
5. Human resumes with approval: `claude -p --resume <session-id>`
6. Hook now returns `"allow"` with `updatedInput` containing the approved payload
7. Execution continues from exactly where it paused

**Key insight:** This turns a bonded script from "run and forget" into "run, pause, wait for human, resume." The context survives the wait. This is the most production-ready community pattern for high-stakes automated workflows.

### 3.4. `/output-style` as Persona/Regime Injection

**The pattern:** `/output-style` swaps the system prompt Claude Code uses, changing personality, verbosity, and output format. Community trick: combine output-style with a skill so the same skill behaves differently depending on which persona is loaded.

**Relevance to LARVA:** This is a soft equivalent of the `rn` regime system. The difference: `/output-style` is a Claude Code built-in that modifies the system prompt at runtime. LARVA regimes modify behavior via skill files loaded into context. The output-style approach is lighter (no token cost for the regime file) but less controllable (no structured parameters, no force-persist/kill semantics).

### 3.5. Self-Improving CLAUDE.md (The "Correct Once, Never Again" Pattern)

**The pattern:** A structured CLAUDE.md with designated sections the agent is allowed to append to. Combined with a Stop hook that triggers a reflection pass, or a manual prompt at session end.

**Sections structure:**
- Static rules (human-authored, agent-read-only)
- Learnings (agent-appendable, human-reviewable)
- Corrections (agent-appendable, with timestamps)
- Consolidated principles (agent-synthesized from learnings)

**Key insight:** The community treats CLAUDE.md as a living document, not static config. Every correction becomes a permanent learning. The risk is unbounded growth — hence the weekly consolidation pattern.

### 3.6. Plugin System as Skill Distribution

As of April 2026, the plugin system bundles skills, hooks, agents, MCP servers, and LSP servers into installable packages. The plugin marketplace (`/plugin marketplace add owner/repo`) and `npx skills add <name>` handle distribution.

**Security warning:** Snyk's ToxicSkills research found prompt injection in 36% of skills tested and 1,467 malicious payloads across the ecosystem. Always review SKILL.md and bundled scripts before installing. Treat skills like any third-party code.

---

## 4. The 15 Frontmatter Fields (Complete Reference)

Every SKILL.md can declare these YAML frontmatter fields:

| Field | Purpose | Default |
|-------|---------|---------|
| `name` | Display label (plugin skills: sets command name) | Directory name |
| `description` | Trigger text — Claude reads this every turn to decide activation | (none) |
| `disable-model-invocation` | Hide from Claude's auto-matching; user-only via `/name` | false |
| `user-invocable` | Whether user can invoke with `/name` | true |
| `argument-hint` | Placeholder text shown in `/name` autocomplete | (none) |
| `allowed-tools` | Tools pre-approved during this skill's turn | (none) |
| `model` | Override model for this skill (e.g., `opus`, `sonnet`) | Session default |
| `effort` | Reasoning effort (`high`, `medium`, `low`) | Session default |
| `context` | `fork` runs skill in isolated subagent context | Main context |
| `agent` | Subagent type when `context: fork` | `general-purpose` |
| `hooks` | Skill-scoped lifecycle hooks (PreToolUse, Stop, etc.) | (none) |
| `paths` | File path patterns that trigger this skill | (none) |
| `shell` | Shell for `!command` blocks (`powershell` on Windows) | System default |
| `$ARGUMENTS` | Dynamic parameter substitution in skill body | Auto-appended if absent |
| `$0`, `$1`... | Indexed argument access | (none) |

---

## 5. @Houston's Architectural Vectors (Unseen Patterns)

These are patterns I see in the available surface that the community hasn't widely adopted or combined yet. They are not validated — they are vectors for experimentation. Karpathy floor applies: don't build on speculation.

### 5.1. Vector: Skill-Scoped Hooks as a Regime Enforcement Layer

**What exists:** Skill-scoped hooks fire only during a skill's lifetime. The community uses them almost exclusively for security validation (block dangerous commands).

**What's not being done:** Using skill-scoped hooks to enforce *behavioral* constraints, not just security constraints. A `PreToolUse` hook on `Write` that checks whether the output matches a style guide. A `PostToolBatch` hook that runs a linter after every edit. A `Stop` hook that validates the skill's output against a checklist before allowing completion.

**LARVA implication:** This is the mechanical equivalent of `rnf` (force-persist regime). A regime backed by a skill-scoped hook cannot be ignored by the model — it's enforced at the system level. The regime file tells the model *how* to behave; the hook ensures it *did* behave. Trust + verify in one package.

**Why it's not happening:** Community is security-focused. Behavioral validation requires domain-specific scripts that are harder to generalize than "block `rm -rf`".

### 5.2. Vector: `!command` Injection as Wake Contract

**What exists:** `!command` injects dynamic context (git status, PR diff, branch name) before the model sees the skill content.

**What's not being done:** Using `!command` to inject the agent's *identity and boundary context* — the wake contract. Instead of embedding "who am I / where is my harness / where do I read / where do I write / what is my boundary" in static markdown, resolve it dynamically:

```markdown
---
name: larva-agent
description: LARVA v3 agent skill
---

## Wake Contract

- **Who am I:** !`cat ~/.claude/identity.json | jq -r .name`
- **Harness:** !`echo $CLAUDE_HARNESS`
- **Read from:** !`cat ~/.claude/identity.json | jq -r .read_path`
- **Write to:** !`cat ~/.claude/identity.json | jq -r .write_path`
- **Boundary:** !`cat ~/.claude/identity.json | jq -r .boundary`
- **Current project:** !`basename $(pwd)`
- **Git state:** !`git branch --show-current && git status --short`
```

**Why this matters:** The wake contract becomes environment-aware. The same SKILL.md works on both machines, on any project, for any agent — the identity resolves at runtime from a single source of truth (`identity.json`). No more per-machine copies of agent configs.

### 5.3. Vector: Learnings Loop + Skill-Scoped Hook = Self-Correcting Skill

**What exists separately:**
- `learnings.md` pattern (community) — accumulates knowledge across sessions
- Skill-scoped Stop hook (official) — fires when this specific skill completes

**What's not being combined:** A skill that carries its own `learnings.md` AND a scoped Stop hook that triggers reflection — creating a self-correcting skill that improves without any global infrastructure.

```
my-skill/
├── SKILL.md          # Instructions + Stop hook in frontmatter
├── learnings.md      # Accumulated corrections (read at activation)
├── scripts/
│   └── reflect.sh    # Extracts corrections from transcript
└── references/
    └── REFERENCE.md
```

Frontmatter:
```yaml
---
name: my-skill
description: ...
hooks:
  Stop:
    - matcher: ""
      hooks:
        - type: command
          command: "./scripts/reflect.sh"
---

## Learnings from prior runs
!`cat learnings.md 2>/dev/null || echo "No prior learnings."`

## Instructions
...
```

**Key insight:** The reflection is scoped to this skill only. It doesn't pollute a global CLAUDE.md. Each skill evolves independently. The skill carries its own memory.

### 5.4. Vector: `context: fork` + Skill-Scoped Hook as Agent Sandbox

**What exists:** `context: fork` runs a skill in an isolated subagent context. Skill-scoped hooks fire within that context.

**What's not being done:** Using fork + hooks to create a fully sandboxed agent personality — an agent-within-an-agent that has its own behavioral constraints, its own tool permissions, and its own lifecycle hooks, all declared in a single SKILL.md.

**LARVA implication:** This is a portable agent definition file. @Eagle, @Laika, @Vega — each could be defined as a SKILL.md with `context: fork`, `allowed-tools`, skill-scoped hooks, and bundled scripts. The agent's entire operational surface fits in one directory. Deploy it anywhere that reads SKILL.md.

**Why it's not happening:** `context: fork` was introduced as a Skills 2.0 feature (May 2026). The community hasn't yet combined it with skill-scoped hooks and learnings loops into a full agent definition.

### 5.5. Vector: The Missing Lifecycle Event — "SkillActivated"

**What doesn't exist:** There is no hook that fires specifically when a skill is activated by the model. `UserPromptExpansion` fires when a user types `/skillname`, but model-invoked activation has no corresponding event.

**What this would enable:** A hook that fires when Claude decides to load a skill could:
- Log which skills are actually being used (metrics)
- Inject additional context based on which skill was chosen
- Chain skills (skill A's activation triggers skill B's loading)
- Validate that the model's skill selection was correct before loading the full body

**LARVA implication:** This is the missing piece for `rn` regime composition. If you could hook skill activation, you could enforce "when skill X activates, also load regime Y" — mechanically, not via model judgment.

### 5.6. Vector: Bidirectional `learnings.md` — Forge-to-Product Bridge

**What exists:** `learnings.md` accumulates corrections within one skill in one location.

**What's not being done:** A learnings file that propagates from forge (development environment) to deployed product (team environment) — matching the forge/product distinction that's already load-bearing in freya-devenv.

Pattern: forge-side `learnings.md` accumulates corrections during development. A deploy script (`bin/deploy-to-freya.sh` equivalent) filters learnings by confidence level and promotes high-confidence entries to the product-side skill's `learnings.md`. Low-confidence entries stay in forge for further validation.

**Why this matters:** The team benefits from validated corrections without being exposed to experimental ones. The deploy bridge already exists as a concept in LARVA — extending it to skill learnings is a natural fit.

### 5.7. Vector: Hook-Gated Regime Transitions

**What exists:** LARVA regimes (`rn crtv`, `rn hnst`, `rn krpth`) are loaded via skill files and toggled by @majkee's explicit commands.

**What's not being done:** Using hooks to enforce regime transitions mechanically. A `UserPromptSubmit` hook that detects regime commands (`rn hnst`, `pkl hnst`) and injects/removes the corresponding skill content — making regime toggling a system-level operation, not a model-interpreted instruction.

```json
{
  "hooks": {
    "UserPromptSubmit": [{
      "matcher": "",
      "hooks": [{
        "type": "command",
        "command": "./scripts/regime-router.sh"
      }]
    }]
  }
}
```

The `regime-router.sh` script parses the prompt for `rn`/`rnf`/`pkl` commands, modifies a state file, and injects the appropriate regime content as `additionalContext`. The model doesn't need to interpret the command — the hook does it mechanically.

**LARVA implication:** This collapses the gap between "regime as a skill" (trust-based) and "regime as a hook" (mechanical). The transition is mechanical; the behavior change is trust-based. This matches the LARVA principle: "hooks are mechanical, skills are on-demand, never conflate them" — but adds a clean bridge between them.

---

## 6. Ecosystem Health & Warnings

### 6.1. Security Surface

Snyk's ToxicSkills research (early 2026) found:
- Prompt injection in 36% of skills tested
- 1,467 malicious payloads across the ecosystem
- Supply chain risks in community skill repositories

**Standing rule:** Review every SKILL.md and bundled script before installing. Treat skills like any third-party code. Skills from established registries with community review carry lower risk than random forks.

### 6.2. Cross-Runtime Portability

Skills follow the open Agent Skills standard. Claude Code, Codex, and others are converging but portability is not seamless yet. Claude Code adds proprietary features on top: `allowed-tools`, `context: fork`, skill-scoped hooks, `!command` injection. These don't work in other runtimes.

**Standing rule:** Keep the core procedure understandable without relying entirely on Claude Code-specific fields. Add platform-specific behavior only where it provides clear value.

### 6.3. Context Budget

Every feature consumes context. Skills load ~100 tokens per installed skill (description scanning) plus full body on activation. Too many skills = noise that makes Claude less effective, plus skills may not trigger correctly.

Community consensus: 8-12 well-chosen skills cover most of a senior developer's day. More than that and you're burning context for diminishing returns.

---

## 7. Mapping to LARVA v3 Vocabulary

| LARVA Concept | CLI Equivalent | Notes |
|---|---|---|
| Regime (`rn`) | `/output-style` + skill file | Output-style is lighter but less controllable |
| Force-persist (`rnf`) | Skill-scoped hook (enforces behavior mechanically) | Not used this way yet (Vector 5.1) |
| Kill regime (`pkl`) | No direct equivalent | Would need hook-gated regime router (Vector 5.7) |
| Wake contract | `!command` injection (Vector 5.2) | Dynamic, environment-aware |
| Hook (LARVA sense) | Hook (Claude Code sense) | 1:1 mapping, same concept |
| Skill (LARVA sense) | Skill (Claude Code sense) | 1:1 mapping, same concept |
| Forge vs. product | Personal vs. project skill scope | Similar but not identical |
| T3 journal | `learnings.md` pattern | Community equivalent, less structured |
| Agent persona card | SKILL.md + `context: fork` (Vector 5.4) | Portable agent definition |
| `cmd` vocabulary | `/slash-commands` | Different syntax, same purpose |
| Measurement run | Reflection + Stop hook | Community pattern, not formal |

---

## 8. Decision Gate

The research surface is mapped. Before producing any artifact that depends on these patterns, three questions need answers:

1. **Build or wait?** Several vectors (5.1, 5.3, 5.7) are architecturally sound but untested. Karpathy floor says: don't build on speculation. Run one trial per vector before committing.

2. **Which runtime?** The bonding mechanisms are Claude Code-specific. If LARVA v3 agents span Claude Code + Gemini CLI + Cursor, the portable subset is: SKILL.md body + `scripts/` folder. Everything else (frontmatter hooks, `!command`, `allowed-tools`) is Claude Code-only.

3. **Forge-first or product-first?** The learnings loop and hook-gated regimes are development workflow features. Should they live in forge (Majkee's toolbox) or be promotable to the product (team-facing)?

---

*End of research artifact. @Houston, 2026-08-05.*
