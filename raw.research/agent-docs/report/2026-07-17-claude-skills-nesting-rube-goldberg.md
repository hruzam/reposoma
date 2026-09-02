---
what: research report — Claude Code skills/subagent nesting assessment
date: 2026-07-16
author: epoch
triggered-by: "/cmd-zen SEARCH nesting claude skills (losing context early?) OR second beats first?"
sister-of: raw.research/agent-docs/ (agent primitives context)
gavel: G-03
sources-verified: 2026-07-16
---

# Claude Code Skills/Subagent Nesting — Rube Goldberg Assessment

## Core findings

### 1. Skills do not nest — they stack into the same context

Skills (SKILL.md files) inject content into the current conversation and stay there.
Stacking multiple skills in one message (v2.1.199+) loads all into the same shared window.
No isolation. No skill-calls-skill mechanism. Dynamic injection (`!cmd`) runs once, not re-scanned.

### 2. `context: fork` is the isolation mechanism — and it deliberately loses history

A skill with `context: fork` spawns a subagent with the SKILL.md body as its task.
The forked skill does NOT see conversation history.
It DOES get: CLAUDE.md, git status, its own agent system prompt.
Official warning: "only makes sense for skills with explicit instructions — reference content
without a task returns without meaningful output."

### 3. Subagent nesting: 5 levels deep (v2.1.172, June 2026)

Parent reads only the leaf summary. Everything in between costs tokens and disappears.
~30–60% overhead per nesting level. Wide trees multiply ~7×.
SDK programmatic subagents still cannot nest.
`Agent(type)` allowlists in subagent definitions are ignored — only honored on main thread.

### 4. "Second beats first" — precedence is INVERTED between skills and subagents

| Primitive  | Collision winner                                      |
|------------|-------------------------------------------------------|
| Skills     | Enterprise > Personal (~/.claude/) > Project (.claude/) |
| Subagents  | Managed > CLI > Project (.claude/) > User (~/.claude/) > Plugin |

Skills: higher scope wins (personal beats project).
Subagents: project beats user (more local wins).
These are opposite. Silent wrong-definition risk when names collide across levels.

### 5. Skills preloaded into subagents — the clean bridge

```yaml
skills:
  - api-conventions
  - error-handling-patterns
```
Full skill content injected at subagent startup. No runtime discovery cost.
Skills with `disable-model-invocation: true` cannot be preloaded.

---

## Rube Goldberg verdict table

| Pattern | Verdict |
|---------|---------|
| Skill with reference content (no `context: fork`) | ✅ Valuable — loads on demand, stays in window |
| Skill with `context: fork` + explicit task instructions | ✅ Valuable — clean isolation for self-contained ops |
| Skill with `context: fork` + only reference/convention content | ⚠️ Rube Goldberg — subagent gets rules but no task |
| Subagent with `skills:` preload | ✅ Valuable — clean bridge, domain knowledge without discovery cost |
| Nested subagents (depth ≤3) with model tiering | ✅ Valuable — context pressure offload, parallel subtasks |
| Nested subagents, unrestricted `Agent` tool + Opus everywhere | ❌ Rube Goldberg — unbounded token burn |
| Assuming skill-to-skill context flows | ❌ Rube Goldberg — all flatten into same window |
| Mixing skill/subagent names expecting same precedence | ❌ Rube Goldberg — precedence is inverted |

## The "losing context early" question — verdict

Not a bug. It is the `context: fork` contract.
Does this skill need conversation history? Yes → don't fork. No → fork is right.
The Rube Goldberg risk: chaining forked skills expecting context to accumulate. It won't.

## Sources verified 2026-07-16

- https://code.claude.com/docs/en/sub-agents
- https://code.claude.com/docs/en/skills
- https://ofox.ai/blog/claude-code-nested-subagents-2026/
- https://readysolutions.ai/blog/2026-06-11-claude-code-custom-subagents-vs-skills/
