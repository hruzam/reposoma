# Claude Code — Agent Harness: Complete YAML Frontmatter Reference
_As of 2026-06-05 (Claude Code CLI + Agent SDK)_

---

## File Structure

Agent files are Markdown with YAML frontmatter, stored in:

| Location | Scope | Priority |
|----------|-------|----------|
| Managed settings (admin-deployed) | Organization-wide | 1 (highest) |
| `--agents` CLI flag (JSON) | Current session only (ephemeral) | 2 |
| `.claude/agents/` | Current project | 3 |
| `~/.claude/agents/` | All your projects | 4 |
| Plugin `agents/` directory | Where plugin is enabled | 5 (lowest) |

Files are scanned recursively — subfolders are allowed. Subfolder paths do **not** affect agent identity (only `name` does). For plugins, subdirectories become part of the scoped identifier (`plugin-name:agent-name`).

```markdown
---
name: agent-identifier
description: When to use this agent
# ... additional fields
---

System prompt content goes here in Markdown.
Can span multiple lines.
```

**Restart session** to pick up file changes made on disk. Agents created via `/agents` UI take effect immediately.

---

## All YAML Frontmatter Fields

### Required

```yaml
name: string
```
- Unique identifier (lowercase letters and hyphens only, e.g. `code-reviewer`)
- Must be unique within its scope
- Passed to hooks as `agent_type`
- Filename does not need to match

```yaml
description: string
```
- Natural language description: when Claude should delegate to this agent
- Controls automatic delegation
- Write clearly and specifically; "use proactively" encourages delegation

---

### Model & Computation

```yaml
model: sonnet | opus | haiku | inherit | <full-model-id>
```
- `inherit` = use same model as parent (default if omitted)
- Full IDs: `claude-opus-4-8`, `claude-sonnet-4-6`, `claude-haiku-4-5-20251001`
- Resolution order: `CLAUDE_CODE_SUBAGENT_MODEL` env var → per-invocation param → this field → parent model

```yaml
effort: low | medium | high | xhigh | max
```
- Reasoning effort level (available levels depend on model)
- Defaults to session effort level if omitted

```yaml
maxTurns: <positive integer>
```
- Maximum agentic turns before agent stops
- Inherits session default if omitted

---

### Tool & Capability Restrictions

```yaml
tools: Read, Grep, Glob, Bash
# or YAML array:
tools:
  - Read
  - Grep
  - Glob
  - Bash
```
- **Allowlist** — agent can ONLY use these tools
- Inherits all tools from parent if omitted
- To restrict subagent spawning: `Agent(agent1, agent2)` (allowlist) or `Agent` (allow all)

```yaml
disallowedTools: Write, Edit
# or YAML array:
disallowedTools:
  - Write
  - Edit
```
- **Denylist** — tools to remove from inherited or specified list
- Applied before `tools` (if a tool is in both, it is removed)
- To prevent spawning subagents: omit `Agent` from `tools` entirely

**Tools NOT available to subagents** (even if listed):
- `Agent` (subagents cannot spawn subagents)
- `AskUserQuestion`
- `EnterPlanMode` / `ExitPlanMode` (ExitPlanMode only available when `permissionMode: plan`)
- `ScheduleWakeup`
- `WaitForMcpServers`

---

### Permissions & Execution Control

```yaml
permissionMode: default | acceptEdits | auto | dontAsk | bypassPermissions | plan
```

| Mode | Behavior | Parent can override? |
|------|----------|----------------------|
| `default` | Standard prompts | No |
| `acceptEdits` | Auto-accept file edits/fs in working dir | Yes (parent's acceptEdits wins) |
| `auto` | Background classifier auto-blocks/allows | Yes (parent's auto applies) |
| `dontAsk` | Auto-deny permission prompts | No |
| `bypassPermissions` | Skip all checks (use with caution) | Yes (parent's bypassPermissions wins) |
| `plan` | Read-only exploration mode | No |

```yaml
background: true | false
```
- Run agent as non-blocking background task (default: `false`)
- Background agents auto-deny any tool call that would prompt

```yaml
isolation: worktree
```
- Run agent in isolated temporary git worktree
- Branched from default branch (not parent's HEAD)
- Auto-cleanup if agent makes no changes
- Useful for parallel safe mutations

---

### Integrations & External Resources

```yaml
mcpServers:
  # Inline definition (scoped to this agent):
  - playwright:
      type: stdio
      command: npx
      args: ["-y", "@playwright/mcp@latest"]
  # Reference by name (reuses parent session's connection):
  - github
```
- Inline servers connect at agent startup, disconnect at finish
- String references reuse parent session's connection
- Ignored for plugin subagents
- Uses same schema as `.mcp.json` (`stdio`, `http`, `sse`, `ws`)

```yaml
skills:
  - api-conventions
  - error-handling-patterns
```
- Preload skill content into agent context at startup (full content injected)
- Agent can still invoke unlisted skills via `Skill` tool at runtime
- Cannot preload skills with `disable-model-invocation: true`

---

### Memory & Learning

```yaml
memory: user | project | local
```

| Value | Path | Notes |
|-------|------|-------|
| `user` | `~/.claude/agent-memory/<agent-name>/` | Shareable across projects |
| `project` | `.claude/agent-memory/<agent-name>/` | Project-specific, version-controlled |
| `local` | `.claude/agent-memory-local/<agent-name>/` | Project-specific, not VCS |

When enabled:
- Read/Write/Edit tools auto-enabled regardless of `tools` field
- First 200 lines or 25KB of `MEMORY.md` loaded into context at startup

---

### Lifecycle & Automation

```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-command.sh $TOOL_INPUT"
  PostToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/run-linter.sh"
  Stop:
    - hooks:
        - type: command
          command: "./scripts/cleanup.sh"
```
- Scoped to this agent only (fire only while agent is active)
- Supported events: `PreToolUse`, `PostToolUse`, `Stop` (converted to `SubagentStop` at runtime when invoked as subagent)
- Ignored for plugin subagents

```yaml
initialPrompt: string
```
- Auto-submitted as first user turn when agent runs as **main session**
- Fires via `--agent` flag or `agent` setting, NOT when invoked as subagent
- Commands and skills in the prompt are processed normally

---

### Display & UI

```yaml
color: red | blue | green | yellow | purple | orange | pink | cyan
```
- Display color in task list and transcript
- Helps visually distinguish agents in the UI

---

## Inheritance: What Subagents Get vs. Don't Get

**Receives:**
- Its own system prompt (markdown body + environment details)
- The task prompt from the `Agent()` tool call
- Project `CLAUDE.md` files
- Tool definitions (inherited or from `tools` field)
- Preloaded skill content (if listed in `skills`)
- Git status snapshot (from parent session start)

**Does NOT receive:**
- Parent's conversation history
- Parent's tool results
- Parent's system prompt
- Built-in agent definitions/behavior modifications

**Exception — Forked subagents:** Inherit full parent conversation history, system prompt, tools, and model.

---

## Complete Annotated Example

```yaml
---
name: code-reviewer
description: >
  Review code changes for correctness, security, and style.
  Use proactively when the user edits production code.
model: opus
effort: high
maxTurns: 20

tools:
  - Read
  - Grep
  - Glob
  - Bash
disallowedTools:
  - Write
  - Edit

permissionMode: acceptEdits
background: false
isolation: worktree

mcpServers:
  - github
  - sonarqube:
      type: stdio
      command: npx
      args: ["-y", "@sonarqube/mcp"]

skills:
  - code-quality-standards
  - security-checklist

memory: project

color: blue

hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "echo PRE: $TOOL_INPUT"
  PostToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/log-tool-use.sh"

initialPrompt: "Load project code quality context and ask what to review."
---

You are a senior code reviewer. Focus on correctness, security, and clarity.
For each finding, include: file, line, severity, and suggested fix.
```

---

## CLI: `--agents` JSON Flag (Ephemeral)

Pass agents as JSON when launching Claude Code (single session, not saved to disk):

```bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer",
    "prompt": "You are a senior code reviewer...",
    "tools": ["Read", "Grep", "Glob"],
    "model": "sonnet",
    "permissionMode": "dontAsk",
    "maxTurns": 15,
    "effort": "high",
    "color": "blue"
  }
}'
```

JSON fields match frontmatter names. `prompt` = system prompt (equivalent to markdown body).

---

## Agent SDK (Programmatic Definition)

In Python/TypeScript SDK, subagents are defined as `AgentDefinition` objects — same fields as frontmatter:

| Field | Type | Required |
|-------|------|----------|
| `description` | string | Yes |
| `prompt` | string | Yes |
| `tools` | string[] | No |
| `disallowedTools` | string[] | No |
| `model` | string | No |
| `skills` | string[] | No |
| `memory` | `'user' \| 'project' \| 'local'` | No |
| `mcpServers` | (string \| object)[] | No |
| `maxTurns` | number | No |
| `background` | boolean | No |
| `effort` | `'low' \| 'medium' \| 'high' \| 'xhigh' \| 'max'` | No |
| `permissionMode` | PermissionMode | No |

Note: Do not include `Agent` in a subagent's `tools` — subagents cannot spawn other subagents.

---

## Plugin Subagent Restrictions

Plugin subagents **ignore** these fields:
- `hooks`
- `mcpServers`
- `permissionMode`

To use those features, copy the agent into `.claude/agents/` or `~/.claude/agents/`.

---

## Minimal Valid Agent

```yaml
---
name: helper
description: General coding assistant
---

You are a helpful coding assistant.
```

---

## Field Quick Reference

| Field | Type | Required | Default |
|-------|------|----------|---------|
| `name` | string | **Yes** | — |
| `description` | string | **Yes** | — |
| `model` | string | No | `inherit` |
| `effort` | string | No | session default |
| `maxTurns` | number | No | session default |
| `tools` | string / string[] | No | inherit all |
| `disallowedTools` | string / string[] | No | none |
| `permissionMode` | string | No | `default` |
| `background` | boolean | No | `false` |
| `isolation` | string | No | none |
| `mcpServers` | array | No | none |
| `skills` | string[] | No | none |
| `memory` | string | No | disabled |
| `hooks` | object | No | none |
| `initialPrompt` | string | No | none |
| `color` | string | No | none |
