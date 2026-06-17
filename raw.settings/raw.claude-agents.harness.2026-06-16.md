# Claude Code — Agent Harness: Complete YAML Frontmatter Reference
_Fetched: 2026-06-16 | Sources: code.claude.com/docs/en/{sub-agents, settings, hooks, mcp, memory} (all redirected 301 from docs.anthropic.com/en/docs/claude-code/*)_

> Snapshot for RAG ingestion + agent authoring. Volatile — re-verify version-gated notes (`v2.1.x`) against today.

---

## 1. File locations & scope

### Subagents

| Location | Scope | Priority | Create via |
|---|---|---|---|
| Managed settings `…/.claude/agents/` | Org-wide | 1 (highest) | Managed settings deploy |
| `--agents` CLI flag (JSON) | Current session | 2 | Pass JSON at launch (not saved to disk) |
| `.claude/agents/` | Current project | 3 | `/agents` or manual `.md` |
| `~/.claude/agents/` | All your projects | 4 | `/agents` or manual `.md` |
| Plugin `agents/` dir | Where plugin enabled | 5 (lowest) | Installed with plugin |

- Both project + user dirs scanned **recursively**; subfolders do NOT affect identity — identity comes only from the `name` field. Duplicate `name` in one scope → one silently kept, other discarded.
- Plugin subfolders DO scope the identifier: `agents/review/security.md` in `my-plugin` → `my-plugin:review:security`.
- Files added/edited on disk load at **session start** → restart to pick up. `/agents` interface edits take effect immediately.
- `--add-dir` grants file access only; those dirs are NOT scanned for subagents.

### Other harness files (scope summary)

| Feature | User | Project | Local | Managed |
|---|---|---|---|---|
| Settings | `~/.claude/settings.json` | `.claude/settings.json` | `.claude/settings.local.json` | `managed-settings.json` (system dir) |
| MCP servers | `~/.claude.json` (user scope) | `.mcp.json` (repo root) | `~/.claude.json` (per-project = "local") | `managed-mcp.json` |
| Subagents | `~/.claude/agents/` | `.claude/agents/` | — | managed `.claude/agents/` |
| Memory | `~/.claude/CLAUDE.md` | `./CLAUDE.md` or `./.claude/CLAUDE.md` | `./CLAUDE.local.md` | policy `CLAUDE.md` / `claudeMd` key |

Managed system dirs: macOS `/Library/Application Support/ClaudeCode/`, Linux/WSL `/etc/claude-code/`, Windows `C:\Program Files\ClaudeCode\`.

**Settings precedence (high→low):** Managed → CLI args → Local → Project → User. (`model`, `outputStyle` need restart; most others reload live.)

---

## 2. Subagent YAML frontmatter — all fields

Only `name` + `description` required. `--agents` JSON accepts the same fields (`prompt` = system prompt / md body).

| Field | Req | Type / values | Default | Meaning |
|---|---|---|---|---|
| `name` | ✅ | lowercase + hyphens | — | Unique id. Hooks see it as `agent_type`. Filename need not match |
| `description` | ✅ | string | — | When Claude should delegate. "use proactively" encourages auto-delegation |
| `tools` | — | comma/array list | inherit all | Allowlist. To preload Skills use `skills`, not `Skill` here |
| `disallowedTools` | — | list | — | Denylist; removed from inherited/specified pool |
| `model` | — | `sonnet`/`opus`/`haiku`/`fable` / full id (`claude-opus-4-8`, `claude-sonnet-4-6`) / `inherit` | `inherit` | Model for this subagent |
| `permissionMode` | — | `default`/`acceptEdits`/`auto`/`dontAsk`/`bypassPermissions`/`plan` | inherit | Permission handling. Ignored for plugin subagents |
| `maxTurns` | — | int | — | Max agentic turns before stop |
| `skills` | — | list | — | Preload full skill content at startup (not just description) |
| `mcpServers` | — | list (string ref or inline def) | — | MCP servers for this agent. Ignored for plugin subagents |
| `hooks` | — | hook map | — | Lifecycle hooks scoped to this agent. Ignored for plugin subagents |
| `memory` | — | `user`/`project`/`local` | off | Persistent cross-session memory dir |
| `background` | — | bool | `false` | Always run as background task |
| `effort` | — | `low`/`medium`/`high`/`xhigh`/`max` | inherit | Overrides session effort (levels depend on model) |
| `isolation` | — | `worktree` | — | Run in temp git worktree (branched from default branch); auto-removed if no changes |
| `color` | — | red/blue/green/yellow/purple/orange/pink/cyan | — | Display color in task list/transcript |
| `initialPrompt` | — | string | — | Auto-submitted first user turn when run as main session (`--agent`/`agent` setting); commands+skills processed |

**Model resolution order:** `CLAUDE_CODE_SUBAGENT_MODEL` env → per-invocation `model` param → frontmatter `model` → main conversation model.

---

## 3. Tool restrictions

- Subagents inherit internal + MCP tools by default.
- **Never available to subagents** (UI/session-bound), even if listed: `AskUserQuestion`, `EnterPlanMode`, `ExitPlanMode` (unless `permissionMode: plan`), `ScheduleWakeup`, `WaitForMcpServers`.
- `tools` = allowlist, `disallowedTools` = denylist. If both set: `disallowedTools` applied first, then `tools` resolved against remainder; a tool in both is removed.
- **Spawning control** (`Agent` tool, renamed from `Task` in v2.1.63; `Task(...)` still aliases):
  - `tools: Agent(worker, researcher)` → allowlist of spawnable types (only when run as main thread via `--agent`).
  - `tools: Agent` (no parens) → spawn any.
  - `Agent` omitted → cannot spawn any subagents.
- Disable a built-in/custom subagent globally: `permissions.deny: ["Agent(Explore)"]` or `--disallowedTools "Agent(Explore)"`. Deny the `Agent` tool entirely to stop all delegation.
- Nested subagents: as of v2.1.172 a subagent can spawn its own (resolves from same scopes). Background subagent at depth 5 loses the Agent tool (fixed cap). A fork cannot spawn another fork.

---

## 4. Permission modes

| Mode | Behavior |
|---|---|
| `default` | Standard prompts |
| `acceptEdits` | Auto-accept edits + common fs cmds in cwd/`additionalDirectories` |
| `auto` | Background classifier reviews commands + protected-dir writes |
| `dontAsk` | Auto-deny prompts (explicitly allowed tools still work) |
| `bypassPermissions` | Skip prompts (dangerous; still prompts root/home `rm -rf` + explicit `ask` rules) |
| `plan` | Read-only exploration |

Parent `bypassPermissions`/`acceptEdits` takes precedence and can't be overridden by child. Parent `auto` → child inherits auto, its `permissionMode` ignored.

**Permission rule syntax:** `Tool(name)`, `Bash(npm run *)`, `Read(/path/**)`, `Write(src/**)` in `permissions.allow|deny|ask` arrays. `*` wildcard, `**` glob. `allowManagedPermissionRulesOnly: true` ignores user/project rules.

---

## 5. Memory (CLAUDE.md + auto memory)

**CLAUDE.md load order (broad→specific, all concatenated):** Managed policy → User (`~/.claude/CLAUDE.md`) → Project (`./CLAUDE.md` or `./.claude/CLAUDE.md`) → Local (`./CLAUDE.local.md`). Walks up dir tree; root→cwd order; `CLAUDE.local.md` appended after `CLAUDE.md` per dir. Subdir CLAUDE.md load on demand when Claude reads files there.

- **Imports:** `@path/to/file` syntax, relative-to-importing-file, recursive, **max 4 hops**. First external import shows approval dialog.
- **AGENTS.md:** not read directly — `@AGENTS.md` import or symlink `CLAUDE.md`. `/init` incorporates `AGENTS.md`, `.cursorrules`, `.windsurfrules` etc.
- `.claude/rules/*.md` (recursive): same priority as `.claude/CLAUDE.md`; optional `paths:` frontmatter for path-scoped loading; symlink-shareable; `~/.claude/rules/` for user-level.
- Target **<200 lines** per CLAUDE.md. Block-level HTML comments stripped before injection.
- `claudeMdExcludes` (glob, any settings layer, arrays merge) skips ancestor files; managed policy CLAUDE.md cannot be excluded.
- `--add-dir` CLAUDE.md loaded only if `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1`.

**Auto memory** (v2.1.59+, on by default; `autoMemoryEnabled:false` / `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` to disable):
- Stored at `~/.claude/projects/<project>/memory/` (override `autoMemoryDirectory`). Machine-local, shared across worktrees of the repo.
- `MEMORY.md` index loaded every session (**first 200 lines or 25KB**); topic files read on demand.
- Subagents can have their own auto memory via `memory` field.

`/memory` lists loaded files + toggles auto memory. `#` shortcut / "remember…" → auto memory. CLAUDE.md is context (not enforced) — for hard enforcement use a PreToolUse hook.

---

## 6. Hooks

### Events (by cadence)
- **Per session:** `SessionStart` (matchers: startup/resume/clear/compact), `SessionEnd`, `Setup` (init/maintenance).
- **Per turn:** `UserPromptSubmit`, `UserPromptExpansion`, `Stop`, `StopFailure`.
- **Per tool:** `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PostToolBatch`, `PermissionRequest`, `PermissionDenied`.
- **Async:** `Notification`, `MessageDisplay`, `SubagentStart`, `SubagentStop`, `TaskCreated`, `TaskCompleted`, `PreCompact`, `PostCompact`, `InstructionsLoaded`, `ConfigChange`, `CwdChanged`, `FileChanged`, `WorktreeCreate`, `WorktreeRemove`, `Elicitation`, `ElicitationResult`, `TeammateIdle`.

### Config structure (3-level nesting)
```json
{ "hooks": { "EventName": [ { "matcher": "pattern",
  "hooks": [ { "type": "command|http|mcp_tool|prompt|agent", "if": "Bash(git *)", "timeout": 600, "statusMessage": "…" } ] } ] } }
```

### Matchers
- `*`/`""`/omitted = all. Letters/digits/`_`/`|` = exact or `|`-list (`Edit|Write`). Other chars = JS regex (`^Notebook`, `mcp__.*`).
- MCP tool pattern: `mcp__<server>__<tool>` (regex needed for wildcards: `mcp__memory__.*`).

### Handler types
| `type` | Key fields | Notes |
|---|---|---|
| `command` | `command`, `args`?, `async`?, `asyncRewake`?, `shell`? | `args` present → exec form (no shell); absent → shell form. Default timeout 600s |
| `http` | `url`, `headers`?, `allowedEnvVars`? | POSTs event JSON. 2xx+JSON→decision, 2xx+text→context, non-2xx→non-blocking error |
| `mcp_tool` | `server`, `tool`, `input`? | Calls connected MCP tool; `${…}` substitution. 600s |
| `prompt` | `prompt`, `model`? | yes/no model eval; `$ARGUMENTS`=JSON input. 30s |
| `agent` | `prompt`, `model`? | Spawns subagent to verify. 60s |

Common fields: `if` (permission-rule filter), `timeout`, `statusMessage`, `once` (skills/agents only).

### Exit codes
| Code | Meaning |
|---|---|
| `0` | Success — parse stdout as JSON, else plain text |
| `2` | Blocking error — stderr is the message; blocks (PreToolUse→block call, UserPromptSubmit→block prompt, Stop/SubagentStop→continue convo, PermissionRequest→deny, PreCompact→block, etc.) |
| other | Non-blocking — first stderr line shown |

### JSON output (stdout, exit 0)
Universal: `continue` (false=stop, `stopReason`), `suppressOutput`, `systemMessage`, `additionalContext`, `decision: "block"` + `reason`. `hookSpecificOutput`: `permissionDecision` (allow/deny/ask/defer for PreToolUse), `additionalContext`, `updatedInput`, `updatedToolOutput`, `retry`, `displayContent`, `worktreePath`, `sessionTitle`, `watchPaths`, `reloadSkills`, `initialUserMessage`, `action` (accept/decline/cancel).

Path placeholders: `${CLAUDE_PROJECT_DIR}`, `${CLAUDE_PLUGIN_ROOT}`, `${CLAUDE_PLUGIN_DATA}`. Browse via `/hooks`. Disable all: `disableAllHooks:true` (managed hooks survive).

Subagent frontmatter hooks: `Stop` auto-converts to `SubagentStop`. Project-level `SubagentStart`/`SubagentStop` match by agent-type name.

---

## 7. MCP — inline vs reference

### Scopes (precedence high→low: Local → Project → User → Plugin → claude.ai)
| Scope | Loads in | Shared | Stored |
|---|---|---|---|
| Local (default) | Current project | No | `~/.claude.json` (per project path) |
| Project | Current project | Yes (VCS) | `.mcp.json` at repo root |
| User | All projects | No | `~/.claude.json` |

Whole entry from highest-precedence source wins (no field merge). 3 scopes match by name; plugins/connectors match by endpoint. Project servers from `.mcp.json` need approval (`claude mcp reset-project-choices` to reset).

### Inline server definition (`.mcp.json` schema)
```json
{ "mcpServers": {
  "api-server": { "type": "http", "url": "${API_BASE_URL:-https://api.example.com}/mcp",
    "headers": { "Authorization": "Bearer ${API_KEY}" } },
  "local-cli": { "type": "stdio", "command": "/path/to/cli", "args": ["--flag"], "env": { "K": "v" } } } }
```
Types: `stdio` (command/args/env), `http` (alias `streamable-http`; url/headers/headersHelper/timeout/alwaysLoad), `sse` (deprecated), `ws` (url/headers, add-json only). Env expansion: `${VAR}`, `${VAR:-default}` in command/args/env/url/headers.

### CLI
`claude mcp add --transport http <name> <url>` · `--transport stdio <name> -- <cmd> [args]` (note `--` separator) · `add-json <name> '<json>'` · `add-from-claude-desktop` · `list` / `get` / `remove` · `/mcp` (status, OAuth). Scopes: `--scope local|project|user`.

### Reference vs inline in agent frontmatter
```yaml
mcpServers:
  - playwright: { type: stdio, command: npx, args: ["-y","@playwright/mcp@latest"] }  # inline: scoped to this agent, connect on start / disconnect on finish
  - github   # string reference: reuses already-configured server (shares parent connection)
```
Inline-in-frontmatter keeps the server (and its tool-description context cost) OUT of the main conversation. Managed/`--strict-mcp-config`/`--bare`/allow-deny policies also cover frontmatter servers (v2.1.153+).

**Tool Search** (default on): MCP tool defs deferred until needed; only names+server-instructions load upfront. `ENABLE_TOOL_SEARCH=true|auto|auto:N|false`. `alwaysLoad:true` (per server or per tool `_meta`) exempts from deferral. Output: warn >10k tokens, default cap 25k (`MAX_MCP_OUTPUT_TOKENS`), per-tool `anthropic/maxResultSizeChars` up to 500k chars.

Plugin MCP tool name: `mcp__plugin_<plugin>_<server>__<tool>`. `workspace` is a reserved server name.

---

## 8. Skills: preload vs runtime

- **Preload** (`skills:` frontmatter): full skill content injected into subagent context at startup. Can't preload `disable-model-invocation: true` skills.
- **Runtime**: subagent can still discover/invoke project/user/plugin skills via the `Skill` tool unless `Skill` omitted from `tools` / in `disallowedTools`.
- Inverse direction: a skill with `context: fork` injects its content into a specified agent.

---

## 9. Inheritance — what a (non-fork) subagent gets

| Receives | Does NOT receive |
|---|---|
| Own system prompt (md body/`prompt`) + env details | Full Claude Code system prompt |
| Delegation/task message Claude writes | Conversation history, prior tool results, files already read |
| Full CLAUDE.md + memory hierarchy + managed policy | (Explore & Plan **skip** CLAUDE.md + git status — the only two) |
| Git status snapshot (if repo + `includeGitInstructions`) | — |
| Preloaded `skills` content | Skills the parent already invoked |

- Starts in main convo cwd; `cd` doesn't persist between tool calls or affect parent. `isolation: worktree` = isolated repo copy.
- **Fork** (`/fork`, v2.1.117+; default-on rollout v2.1.161+): inherits ENTIRE conversation, same system prompt/tools/model/history + shares parent prompt cache (cheaper). Fork can't spawn another fork. Resume subagents via `SendMessage` (needs `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`); Explore/Plan are one-shot (no agent ID).
- Transcripts: `~/.claude/projects/{project}/{sessionId}/subagents/agent-{id}.jsonl`; survive main compaction; cleaned per `cleanupPeriodDays` (30d).

---

## 10. CLI `--agents` JSON flag

Session-only, not saved to disk. Same fields as frontmatter; `prompt` = system prompt.
```bash
claude --agents '{
  "code-reviewer": { "description": "Expert reviewer. Use proactively after changes.",
    "prompt": "You are a senior code reviewer…", "tools": ["Read","Grep","Glob","Bash"], "model": "sonnet" },
  "debugger": { "description": "Debugging specialist.", "prompt": "You are an expert debugger…" } }'
```
Other launch patterns: natural language (Claude decides) · `@agent-<name>` mention (guarantees) · `--agent <name>` or `agent` setting (whole session adopts its prompt/tools/model; CLAUDE.md still loads; CLI flag beats setting).

---

## 11. Plugin subagent restrictions

For security, plugin subagents **ignore** `hooks`, `mcpServers`, `permissionMode`. To use them, copy the file into `.claude/agents/` or `~/.claude/agents/`. Plugin agents appear scoped (`my-plugin:code-reviewer`, `my-plugin:review:security`).

---

## 12. Examples

### Minimal valid subagent
```markdown
---
name: code-reviewer
description: Reviews code for quality and best practices
---

You are a code reviewer. Analyze the code and give specific, actionable feedback.
```

### Full annotated subagent
```markdown
---
name: db-reader                          # unique id (= agent_type in hooks)
description: Execute read-only DB queries. Use proactively for analysis.
tools: Read, Grep, Glob, Bash            # allowlist (no Write/Edit/MCP)
disallowedTools: Edit                    # belt-and-suspenders denylist
model: sonnet                            # alias | full id | inherit
permissionMode: default
effort: high
memory: project                          # → .claude/agent-memory/db-reader/
skills: [api-conventions]                # full content preloaded
mcpServers:
  - github                               # reference existing server
isolation: worktree                      # isolated repo copy
color: cyan
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-readonly-query.sh"   # exit 2 blocks
---

You are a database analyst with read-only access. Run SELECT queries only.
Update your agent memory with schema patterns you discover.
```
