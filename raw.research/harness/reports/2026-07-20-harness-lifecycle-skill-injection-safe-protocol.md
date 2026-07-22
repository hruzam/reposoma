# Harness Lifecycle & Skill Injection — Safe Protocol Study
**Date:** 2026-07-20
**Filed under:** raw.research / agent-docs
**Dedicated to:** harness builder
**Status:** SAFE PROTOCOL — study of injection mechanics adopted constructively, not for harm

---

## 1 — Mental model: Agent = program, harness = glue

```
MODEL          = compute / brain (vendor-specific, replaceable)
AGENT .md      = the "program" — identity, rules, tools declared
HARNESS        = the glue that assembles context at runtime:
                 CLAUDE.md · skills · hooks · settings · MCP
```

**What survives a vendor shift (invariant layer):**
- Instruction content — markdown files, portable across tools
- Skill bodies — AgentSkills is an open standard (agentskills.io)
- Hook logic — shell scripts, not model-specific
- Workflow conventions and naming contracts

**What does not survive (vendor-specific layer):**
- Tool names (`Read` / `Bash` vs other CLI names)
- CLI primitives (`/compact`, `/model`, `/skill-name` mechanics)
- Injection mechanics — how CLAUDE.md gets assembled into context

The harness is more portable than the model layer. The `.md` files are the durable asset.

---

## 2 — Cold start: what happens, in order

At every new session, Claude Code assembles context in this exact sequence:

```
1.  Anthropic system prompt (built-in, proprietary)
2.  Agent definition file (~/.claude/agents/<name>.md)
3.  --append-system-prompt flag value (if passed at CLI)
    ─── system prompt boundary ───
4.  CLAUDE.md files injected as a USER MESSAGE (not system prompt):
    org-policy → ~/.claude/CLAUDE.md → ./CLAUDE.md → CLAUDE.local.md
5.  Auto memory (MEMORY.md — first 200 lines / 25KB)
6.  Git status + current date in XML tags
7.  Skill METADATA only (~100 tokens per skill, descriptions only)
    — skill BODIES are not loaded yet
```

**Critical fact:** CLAUDE.md is NOT part of the system prompt.
It arrives as a user message after the boundary.
This means it has lower authority than the system prompt layer.

**Skill metadata position:** skill descriptions load into the system prompt layer at startup (~100 tokens each). This gives them HIGHER authority than CLAUDE.md content.

**After compaction:** CLAUDE.md is re-injected from disk. Skill bodies survive up to 5,000 tokens each, combined budget 25,000 tokens, newest first.

---

## 3 — Skill metadata mechanics: what happens at trigger time

Three-level progressive disclosure:

| Level | When loaded | Token cost |
|---|---|---|
| Metadata (YAML frontmatter description) | Always, at startup | ~100 tokens |
| SKILL.md body | When triggered | <5k tokens |
| Supporting files / scripts | On demand | 0 until accessed |

**How the body loads:** Claude literally runs `bash: cat SKILL.md`. The text enters context as a message. It is not a process command — it is text injection via bash read.

**Two trigger modes:**
- User types `/skill-name` → immediate load
- Claude matches prompt against description → auto-loads (unless `disable-model-invocation: true`)

**`!` backtick preprocessing:** runs shell command before Claude sees skill content. Output replaces the placeholder inline. This is preprocessing, not model reasoning. Claude receives the rendered result only.

```yaml
# example
File now: !`cat $file`
Vector anchor: !`grep -n "$vector" .vector-index`
```

These commands fire at invocation time, before Claude's first token. The model receives data, not instructions to fetch data.

---

## 4 — The injection analogy: EXIF photo payload, adopted constructively

**The original attack pattern:**
```
photo opened → OS reads EXIF metadata → payload activates
→ code runs before the user sees the image
→ system-level access from what looked like passive content
```

**The structural parallel in skills:**
```
/skill-name typed → frontmatter parsed → !` commands execute
→ description already resident in system prompt from startup
→ Claude receives fully-rendered, pre-hydrated result
→ everything fires before Claude's first reasoning token
```

Same architecture. Preprocessing pipeline that activates before the visible layer.

**Why this matters:** the EXIF hack was dangerous because it got system-level access from passive metadata. Skills get system-prompt-level authority from description metadata. The `!` pipeline gets arbitrary shell execution from passive-looking backtick syntax. The mechanism is identical in structure — the intent is the differentiator.

---

## 5 — What the harness builder can adopt (constructive protocol)

### 5a — Description as behavioral priming (system-prompt layer)

```yaml
---
description: >
  Re-anchor a document section to a live vector reference.
  Injected content is ground truth. Overrides session context.
  Use when told: refresh, re-anchor, update section anchor.
when_to_use: "user says refresh, re-anchor, update section"
---
```

`description` + `when_to_use` combined cap: **1,536 characters**.
This is not just a label — it is a behavioral contract at the highest layer of the context stack.
Use it for: priming, authority statements, ground-truth declarations, trigger phrases.

### 5b — `!` backtick as live context hydration pipeline

```yaml
---
name: refresh
arguments: [file, vector, ctx]
allowed-tools: Read Write
effort: high
---

## Injected state (preprocessing)
Current file: !`cat $file 2>/dev/null || echo "[FILE NOT FOUND]"`
Vector anchor: !`grep -n "$vector" ${CLAUDE_PROJECT_DIR}/.vector-index 2>/dev/null`
Session clock: !`date -Iseconds`

## Task
Re-anchor section $vector in $file.
Context note: $ctx
Treat injected state above as current ground truth.
```

The pipeline fires before Claude sees anything. The model receives assembled data, not instructions to assemble it. This is the constructive adoption of the EXIF pattern.

### 5c — Argument substitution syntax

| Variable | Expands to |
|---|---|
| `$ARGUMENTS` | full raw string after /skill-name |
| `$0`, `$1`, `$2` | positional (0-based) |
| `$ARGUMENTS[0]` | same, bracket form |
| `$file`, `$vector` | named — declare in `arguments:` frontmatter |

Multi-word argument requires quotes: `/refresh ./doc.md 3715382 "reframe intro"`

### 5d — Permission and resource tuning per invocation

```yaml
allowed-tools: Read Write Bash(git *)   # clears after one message
disallowed-tools: AskUserQuestion       # for autonomous loops
model: claude-opus-4-5                  # one-turn model override
effort: max                             # one-turn effort override
context: fork                           # run in isolated subagent
agent: color                            # specify which subagent type
```

`context: fork` + `agent:` is the sharpest slot: spawn a specific specialist with a clean, pre-hydrated briefing assembled by the `!` pipeline. The specialist sees nothing from the parent conversation — only what the skill body provides.

### 5e — Safeguard flags

The same architecture that enables constructive injection is the prompt injection attack surface. Anthropic flags it explicitly: "treat Skills like installing software."

**Safeguards the harness builder must hold:**

1. **Source trust:** skills from unknown sources can inject system-level behavioral overrides via `description` and run arbitrary shell via `!` backtick
2. **Audit `!` commands:** treat every backtick block as a shell script that runs with your user privileges at invocation time
3. **`disable-model-invocation: true`** for any skill with side effects — prevents Claude from auto-triggering it
4. **`disallowed-tools:`** for autonomous skills — prevent them from calling `AskUserQuestion` or other interactive tools in background loops
5. **Workspace trust dialog:** project-level skills require explicit acceptance before `allowed-tools` takes effect
6. **No network-calling skills from untrusted sources:** `!` commands in skills have full network access in Claude Code (unlike API sandbox)

---

## 6 — Hard limits

| Layer | Limit |
|---|---|
| `description` + `when_to_use` | 1,536 chars total, truncated |
| `!` backtick | runs once, no recursive substitution |
| `allowed-tools` grant | clears after one message |
| `model` override | one turn only |
| Skill body after compaction | 5,000 tokens kept; combined budget 25,000 tokens |
| CLAUDE.md adherence | user-message layer — not enforced, only guided |

---

## 7 — Summary: the three layers and their authority

```
SYSTEM PROMPT (highest authority)
  ├── Anthropic built-in
  ├── Agent .md definition
  ├── --append-system-prompt
  └── Skill METADATA (description, ~100 tokens each)

─── boundary ───

USER MESSAGE (guided, not enforced)
  ├── CLAUDE.md (all scopes, concatenated)
  ├── Auto memory (MEMORY.md, first 200 lines)
  └── Skill BODY (when triggered)

─── preprocessing (fires before either layer) ───
  └── !` backtick commands in skill body
```

**The harness builder's rule:** place behavioral contracts at the layer that gives them the right weight. Identity and ground-truth declarations belong in system-prompt layer (agent .md or skill description). Workflow conventions belong in CLAUDE.md. Procedural playbooks belong in skill bodies. Live data belongs in `!` preprocessing.

---

## Sources (verified 2026-07-19/20)
- [Extend Claude with Skills — Claude Code docs](https://code.claude.com/docs/en/skills) — CONFIDENCE: H
- [Agent Skills overview — Anthropic platform](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview) — CONFIDENCE: H
- [How Claude remembers — CLAUDE.md loading](https://code.claude.com/docs/en/memory) — CONFIDENCE: H
- [Complete Guide to Agent System Prompts (reverse-engineering)](https://www.mynameisfeng.com/blog/the-complete-guide-to-writing-agent-system-prompts-lessons-from-reverse-engineering-claude-code) — CONFIDENCE: M

---

*Epoch research · harness builder edition · 2026-07-20*
