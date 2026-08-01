# agent-docs — substrate
_Fetched: 2026-08-01 | Window: snapshot (no date filter) | Sources: 8/8_

## claude-code-docs

### claude-code-sub-agents — Create custom subagents
URL: https://code.claude.com/docs/en/sub-agents

**Concept:** Each subagent runs in its own context window with custom system prompt, specific tool access, and independent permissions. Background by default since v2.1.198.

**Scope precedence (highest→lowest):**
| Scope | Location | Priority |
|---|---|---|
| Managed | managed settings `.claude/agents/` | 1 |
| CLI | `--agents` JSON flag | 2 |
| Project | `.claude/agents/` | 3 |
| User | `~/.claude/agents/` | 4 |
| Plugin | plugin `agents/` dir | 5 |

**Frontmatter fields (only `name` + `description` required):**

| Field | Required | Notes |
|---|---|---|
| `name` | Yes | Lowercase + hyphens only; cannot contain `:` (v2.1.218+) |
| `description` | Yes | When Claude should delegate |
| `tools` | No | Allowlist; inherits all if omitted |
| `disallowedTools` | No | Denylist; `mcp__<server>` pattern removes whole server |
| `model` | No | `sonnet`/`opus`/`haiku`/`fable`/full ID/`inherit`; default `inherit` |
| `permissionMode` | No | `default`/`acceptEdits`/`auto`/`dontAsk`/`bypassPermissions`/`plan`/`manual` (alias v2.1.200+) |
| `maxTurns` | No | Max agentic turns before stop |
| `skills` | No | Skills preloaded at startup (full content injected) |
| `mcpServers` | No | MCP servers scoped to this subagent (ignored for plugin agents) |
| `hooks` | No | Lifecycle hooks scoped to this subagent (ignored for plugin agents) |
| `memory` | No | `user`/`project`/`local` for cross-session learning |
| `background` | No | `true` = always background; default: Claude chooses (background since v2.1.198) |
| `effort` | No | `low`/`medium`/`high`/`xhigh`/`max`; overrides session effort |
| `isolation` | No | `worktree` = isolated git worktree (branched from default branch) |
| `color` | No | `red`/`blue`/`green`/`yellow`/`purple`/`orange`/`pink`/`cyan` |
| `initialPrompt` | No | Auto-submitted first turn when agent runs as main session via `--agent` |

**CLI `--agents` flag fields:** same as above, plus `prompt` (= system prompt body).

**Built-in subagents:**
- `Explore`: read-only, inherits model (capped at Opus on Claude API) since v2.1.198
- `Plan`: read-only, used during plan mode research
- `general-purpose`: full tool access
- `statusline-setup`: Sonnet; for `/statusline`
- `claude-code-guide`: Haiku; for Claude Code feature questions

**Tools always removed from subagents (regardless of `tools` field):**
`AskUserQuestion`, `EndConversation`, `EnterPlanMode`, `ExitPlanMode` (unless `permissionMode: plan`), `ScheduleWakeup`, `TaskOutput`, `WaitForMcpServers`, `Workflow`; `Agent` at depth limit.

**Background subagent tool pool** (second filter, on top of first):
Keeps only: `Read`, `Grep`, `Glob`, `Bash`, `PowerShell`, `Edit`, `Write`, `NotebookEdit`, `WebFetch`, `WebSearch`, `TodoWrite`, `Skill`, `ToolSearch`, `EnterWorktree`, `ExitWorktree`, `Monitor`, `TaskStop`, `SendMessage`, `Artifact`. Agent teams additionally keep task/cron tools.

**Concurrent caps:** 20 concurrent subagents (v2.1.217); 200 spawns per session (v2.1.212).

**Nested subagent depth:**
- v2.1.217: disabled nested spawning by default
- v2.1.219: re-enabled, default depth 3

**Model resolution order:**
1. `CLAUDE_CODE_SUBAGENT_MODEL` env var
2. Per-invocation `model` parameter
3. Subagent definition `model` frontmatter
4. Main conversation's model

**Env vars:** `CLAUDE_CODE_DISABLE_EXPLORE_PLAN_AGENTS=1` (removes Explore+Plan built-ins); `CLAUDE_AGENT_SDK_DISABLE_BUILTIN_AGENTS=1` (SDK headless mode — removes all built-ins).

**Hook context:** subagents receive `agent_id` and `agent_type` in hook inputs. `Stop` hooks auto-convert to `SubagentStop` in subagents.

**Memory:** subagents can have their own auto memory via `memory` field; main conversation auto memory not loaded into subagents (fork inherits parent).

**`--append-subagent-system-prompt`**: appends text to every subagent's system prompt (v2.1.205+).

---

### claude-code-settings — Settings reference
URL: https://code.claude.com/docs/en/settings

**5-tier scope (highest→lowest):**
| Scope | Location | Notes |
|---|---|---|
| Managed | Server/MDM/plist/`/etc/claude-code/` | Cannot be overridden |
| CLI | `--model`, `--effort`, `--settings`, etc. | Session overrides |
| Local | `.claude/settings.local.json` | Gitignored |
| Project | `.claude/settings.json` | Committed, team-shared |
| User | `~/.claude/settings.json` | Personal defaults |

**Permission rules merge (not override) across all scopes.**

**Special files:**
- `~/.claude.json` — OAuth session, MCP servers, caches, per-project state
- `.mcp.json` — Project-scoped MCP servers
- `CLAUDE.md` / `.claude/CLAUDE.md` — Project memory
- `~/.claude/agents/` — User subagents
- `~/.claude/skills/` — User skills

**Core settings (selected):**

_Model & AI:_
| Key | Type | Notes |
|---|---|---|
| `model` | string | Session model |
| `availableModels` | string[] | Restrict model selection |
| `enforceAvailableModels` | boolean | Apply allowlist to default model |
| `fallbackModel` | string[] | Fallback chain (max 3) |
| `advisorModel` | string | Model for `/advisor` tool |
| `alwaysThinkingEnabled` | boolean | Enable extended thinking by default |
| `effortLevel` | string | `low`/`medium`/`high`/`xhigh` |
| `fastMode` | boolean | Enable fast mode |
| `fastModePerSessionOptIn` | boolean | Per-session opt-in to fast mode |

_Permissions:_
```json
{
  "permissions": {
    "allow": ["Bash(npm run *)", "Read(~/.zshrc)"],
    "deny": ["Bash(curl *)", "Read(./.env*)"]
  }
}
```
| Key | Managed only? | Notes |
|---|---|---|
| `permissions.allow` | No | Tool allowlist patterns |
| `permissions.deny` | No | Tool denylist patterns |
| `allowManagedPermissionRulesOnly` | Yes | Block user/project rules |
| `autoMode` | No | Customize auto-mode classifier |
| `autoMode.classifyAllShell` | No | Route all shell through classifier (v2.1.193+) |
| `disableAutoMode` | No | Set `"disable"` to prevent auto mode |
| `askUserQuestionTimeout` | No | `"60s"`/`"5m"`/`"10m"`/`"never"` (default) |

_MCP:_
| Key | Managed only? | Notes |
|---|---|---|
| `allowedMcpServers` | Yes | Allowlist `[{"serverName":"github"}]` |
| `deniedMcpServers` | Yes | Denylist (takes precedence) |
| `allowManagedMcpServersOnly` | Yes | Only managed servers |
| `disableClaudeAiConnectors` | No | Disable claude.ai auto-fetch (v2.1.182+) |
| `enableAllProjectMcpServers` | No | Auto-approve all `.mcp.json` servers |
| `enabledMcpjsonServers` | No | Approve specific servers |
| `disabledMcpjsonServers` | No | Reject specific servers |

_Hooks & Plugins:_
| Key | Managed only? | Notes |
|---|---|---|
| `disableAllHooks` | No | Disable all hooks and custom status lines |
| `allowManagedHooksOnly` | Yes | Only managed/SDK/force-enabled hooks |
| `allowedHttpHookUrls` | Yes | URL pattern allowlist for HTTP hooks |
| `allowedChannelPlugins` | Yes | Allowlist channel plugins |
| `blockedMarketplaces` | Yes | Block marketplace sources |
| `strictKnownMarketplaces` | Yes | Restrict to official marketplaces only |

_Memory & Context:_
| Key | Default | Notes |
|---|---|---|
| `autoMemoryEnabled` | true | Enable auto memory |
| `autoMemoryDirectory` | unset | Custom memory path |
| `autoCompactEnabled` | true | Auto-compact near context limit |
| `claudeMd` | unset (Managed) | Org-wide CLAUDE.md content in managed-settings.json |
| `claudeMdExcludes` | unset | Glob patterns to skip CLAUDE.md files |
| `cleanupPeriodDays` | 30 | Session file retention |

_Sandbox (new):_
| Key | Notes |
|---|---|
| `sandbox.network.strictAllowlist` | Deny non-allowlisted hosts without prompting (v2.1.219) |
| `sandbox.filesystem.disabled` | (v2.1.216) |
| `sandbox.credentials` | (v2.1.187) |
| `sandbox.allowAppleEvents` | macOS opt-in (v2.1.181) |

_UI & Display:_
| Key | Notes |
|---|---|
| `tui` | TUI/fullscreen rendering (v2.1.181+) |
| `axScreenReader` | Screen reader mode (v2.1.181+) |
| `editorMode` | `"normal"` or `"vim"` |
| `vimInsertModeRemaps` | Vim mode remaps (v2.1.208) |
| `emojiCompletionEnabled` | Emoji shortcodes (v2.1.217+) |
| `awaySummaryEnabled` | Recap on return |
| `autoScrollEnabled` | default true |
| `companyAnnouncements` | Startup announcement rotation |

_Tools & Features:_
| Key | Notes |
|---|---|
| `disableArtifact` / `enableArtifact` | Artifact tool |
| `disableAgentView` | Background agents & agent view |
| `disableBundledSkills` | All bundled skills except `/doctor` |
| `disableWorkflows` | Dynamic workflows |
| `disableSkillShellExecution` | Block inline shell in skills |
| `disableSideloadFlags` | Block `--plugin-dir`/`--plugin-url`/`--agents`/`--mcp-config` (v2.1.193+) |
| `agent` | Run as named subagent; default for `claude agents` |
| `fileCheckpointingEnabled` | `/rewind` checkpoints (v2.1.119+) |
| `workflowSizeGuideline` | Dynamic workflow size (v2.1.219) |
| `teammateMode` | e.g., `"iterm2"` (v2.1.186) |
| `attribution` | Git commit/PR attribution |

_Other:_
| Key | Notes |
|---|---|
| `autoUpdatesChannel` | `"stable"` or `"latest"` |
| `defaultShell` | `"bash"` or `"powershell"` |
| `env` | Environment variables for all sessions |
| `apiKeyHelper` | Custom command to generate auth token |
| `awsCredentialExport` / `awsAuthRefresh` | AWS credential scripts |
| `forceLoginOrgUUID` | Enforce org login (Managed) |
| `requiredMinimumVersion` / `requiredMaximumVersion` | Version enforcement (Managed) |
| `disableDeepLinkRegistration` | Set `"disable"` |
| `fileSuggestion` | Custom `@` file autocomplete script |

**Key environment variables:**
```
CLAUDE_CODE_ENABLE_TELEMETRY    enable OTEL export
CLAUDE_CODE_EFFORT_LEVEL        low/medium/high/xhigh
CLAUDE_CODE_DISABLE_AUTO_MEMORY disable auto memory (1)
DISABLE_AUTO_COMPACT            disable auto-compacting (1)
CLAUDE_CODE_DISABLE_ARTIFACT    disable Artifact tool (1)
CLAUDE_CODE_DISABLE_AGENT_VIEW  disable background agents (1)
CLAUDE_CODE_DISABLE_BUNDLED_SKILLS
CLAUDE_CODE_DISABLE_WORKFLOWS
CLAUDE_CODE_DISABLE_FILE_CHECKPOINTING
CLAUDE_AX_SCREEN_READER         enable screen reader (1)
CLAUDE_CODE_SKIP_PROMPT_HISTORY skip session history writes (1)
MAX_THINKING_TOKENS             set 0 to disable extended thinking
DISABLE_AUTOUPDATER
DISABLE_DOCTOR_COMMAND
```

**CLI flags:**
`--model`, `--effort`, `--fallback-model`, `--permission-mode` (`ask`/`auto`/`strict`), `--remote-control`, `--settings`, `--mcp-config`, `--plugin-dir`, `--plugin-url`, `--agents`, `--bg`, `--ax-screen-reader`, `--no-session-persistence`, `--add-dir`, `--append-subagent-system-prompt` (v2.1.205+), `--forward-subagent-text` (v2.1.211+)

**Validation:** `/status` → "Setting sources" line; `/doctor` → stripped/invalid entries.
**JSON Schema:** `{"$schema":"https://json.schemastore.org/claude-code-settings.json"}`

---

### claude-code-hooks — Hooks reference
URL: https://code.claude.com/docs/en/hooks

**5 handler types:** `command`, `http`, `mcp_tool`, `prompt`, `agent`

**Hook events:**

_Session-level:_
- `SessionStart` (matchers: `startup`/`resume`/`clear`/`compact`/`fork`)
- `Setup` (matchers: `init`/`maintenance`)
- `SessionEnd` (matchers: `clear`/`resume`/`logout`/`prompt_input_exit`/`bypass_permissions_disabled`/`other`)

_Per-turn:_
- `UserPromptSubmit`, `UserPromptExpansion`, `Stop`, `StopFailure`

_Agentic loop (every tool call):_
- `PreToolUse` (can block), `PermissionRequest`, `PermissionDenied`
- `PostToolUse`, `PostToolUseFailure`, `PostToolBatch`
- `SubagentStart`, `SubagentStop`, `TaskCreated`, `TaskCompleted`, `TeammateIdle`

_Async:_
- `FileChanged`, `CwdChanged`, `ConfigChange`, `WorktreeCreate`, `WorktreeRemove`
- `InstructionsLoaded` — fires when CLAUDE.md or `.claude/rules/*.md` loads
- `DirectoryAdded` — fires after `/add-dir` or SDK `register_repo_root` (v2.1.219)

_MCP/Display:_
- `Elicitation`, `ElicitationResult`, `MessageDisplay`, `Notification`
- `PreCompact`/`PostCompact` (matchers: `manual`/`auto`)

**Config structure:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/check.sh",
            "if": "Bash(git *)",
            "timeout": 600,
            "statusMessage": "Checking...",
            "once": false
          }
        ]
      }
    ]
  }
}
```

**Matcher patterns:**
- `"*"`, `""`, omitted → match all
- Exact strings (letters/digits/`_`/`-`/spaces/`,`/`|`) → exact match or list
- Other chars → JavaScript regex (unanchored)
- MCP tools: `mcp__<server>__<tool>` or `mcp__<server>__.*`
- SubagentStart/Stop: agent type

**Common hook fields:**
| Field | Notes |
|---|---|
| `type` | `command`/`http`/`mcp_tool`/`prompt`/`agent` |
| `if` | Permission rule `"Bash(git *)"` (tool events only) |
| `timeout` | Default 600 (command/http/mcp_tool), 30 (prompt), 60 (agent) |
| `statusMessage` | Custom spinner message |
| `once` | Runs once per session then removed (skill frontmatter only) |

**Command hook specifics:**
- Shell form (no `args`): shell tokenization, pipes, `&&` work
- Exec form (with `args`): no shell, each arg literal
- `async: true` → background, non-blocking
- `asyncRewake: true` → background, wakes Claude on exit code 2
- Path placeholders: `${CLAUDE_PROJECT_DIR}`, `${CLAUDE_PLUGIN_ROOT}`, `${CLAUDE_PLUGIN_DATA}`

**HTTP hook:** `url`, `timeout`, `headers` (supports `$ENV_VAR` expansion), `allowedEnvVars`

**MCP tool hook:** `server`, `tool`, `input` (with `${tool_input.field}` interpolation)

**Prompt hook:** `prompt` (use `$ARGUMENTS` for JSON), optional `model`

**Exit codes:**
- `0` → success, parse stdout JSON, proceed
- `2` → blocking error (use stderr as reason)
- Other → non-blocking, show stderr, continue

**JSON output schema (stdout):**
```json
{
  "continue": true,
  "stopReason": "message",
  "suppressOutput": false,
  "systemMessage": "warning",
  "terminalSequence": "...",
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow|deny|ask|defer",
    "permissionDecisionReason": "...",
    "updatedInput": {"command": "modified"},
    "additionalContext": "..."
  }
}
```

**Events that CAN block (exit 2):**
`PreToolUse`, `PermissionRequest`, `UserPromptSubmit`, `UserPromptExpansion`, `Stop`, `SubagentStop`, `TeammateIdle`, `TaskCreated`, `TaskCompleted`, `ConfigChange`, `PreCompact`, `PostToolBatch`, `Elicitation`, `ElicitationResult`, `WorktreeCreate`

**Events that CANNOT block:** `PostToolUse`, `PostToolUseFailure`, `PermissionDenied`, `Notification`, `SubagentStart`, `SessionStart`, `SessionEnd`, `CwdChanged`, `FileChanged`, etc.

**Deduplication:** command hooks by command+args string; HTTP hooks by URL. All matching hooks run in parallel.

**Timeouts:**
- Default command/HTTP/MCP tool: 600s
- `UserPromptSubmit`: lowered to 30s
- `MessageDisplay`: lowered to 10s
- `SessionEnd`: share 1.5s budget (up to 60 if configured longer)

**Env vars available to hook processes:**
```
CLAUDE_PROJECT_DIR, CLAUDE_PLUGIN_ROOT, CLAUDE_PLUGIN_DATA
CLAUDE_EFFORT, CLAUDE_CODE_REMOTE, CLAUDE_CODE_BRIDGE_SESSION_ID (v2.1.199+)
```
OTEL exporter variables removed from hook processes.

**Locations & scope:**
| Location | Scope | Shared? |
|---|---|---|
| `~/.claude/settings.json` | All projects | No |
| `.claude/settings.json` | Single project | Yes |
| `.claude/settings.local.json` | Single project | No |
| Managed policy | Organization | Yes |
| Plugin `hooks/hooks.json` | Plugin enabled | Yes |
| Skill/agent frontmatter | Component active | Yes |

**`if` field Bash matching:** checks leading assignments, subcommands, `$()`, backticks.

**Disable all hooks:** `"disableAllHooks": true` (cannot disable managed policy hooks).

---

### claude-code-mcp — MCP reference
URL: https://code.claude.com/docs/en/mcp

**4 transport types:**
| Type | Notes |
|---|---|
| `http` (`streamable-http`) | Recommended for remote; supports OAuth, `claude mcp add --transport http` |
| `sse` | Deprecated; still works for legacy servers |
| `stdio` | Local processes; `-- <command> [args...]` after options |
| `ws` (WebSocket) | Persistent bidirectional; no OAuth, `--transport` flag; config via JSON only |

**Add commands:**
```bash
claude mcp add --transport http <name> <url> [--header "K: V"]
claude mcp add --transport sse <name> <url>
claude mcp add --scope user|project|local <name> -- <cmd> [args]
claude mcp add-json <name> '<json>'
```

**Scopes:**
| Scope | Stored in | Shared |
|---|---|---|
| `local` (default) | `~/.claude.json` (per-project entry) | No |
| `project` | `.mcp.json` in project root | Yes (committed) |
| `user` | `~/.claude.json` (global entry) | No |

**Reserved server names:** `workspace`, `claude-in-chrome`, `computer-use`, `Claude Preview`, `Claude Browser`

**Key settings fields:**
```json
{
  "type": "http",
  "url": "https://...",
  "headers": {"Authorization": "Bearer $TOKEN"},
  "headersHelper": "path/to/script.sh",
  "timeout": 600000,
  "alwaysLoad": true,
  "request_timeout_ms": 30000
}
```

**`CLAUDE_PROJECT_DIR` env var:** set in spawned server's environment (not Claude's own env).

**Automatic backgrounding:** MCP calls >2 min move to background task (v2.1.212+). Control via `CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS` (default 120000) or `0` to disable.

**Idle timeout:** 5 min for HTTP/SSE/WebSocket; 30 min for stdio. Override: `CLAUDE_CODE_MCP_TOOL_IDLE_TIMEOUT` env var (ms), `0` to disable.

**Output limits:** 25,000 tokens default; warning at 10,000. Override: `MAX_MCP_OUTPUT_TOKENS` env var.

**Tool naming for plugin-bundled servers:** `mcp__plugin_<plugin-name>_<server-name>__<tool-name>`
**Server identifier:** `plugin:<plugin-name>:<server-name>`

**OAuth:** use `/mcp` in session to authenticate. `claude mcp login <name>` / `claude mcp logout <name>` (v2.1.186+).

**Dynamic tool updates:** `list_changed` notifications auto-refresh tool list without disconnect.

**Reconnection:** HTTP/SSE: exponential backoff, up to 5 attempts (2x from 1s). Stdio: not auto-reconnected.

**`roots/list`:** returns launch dir + all `--add-dir` dirs; sends `notifications/roots/list_changed` on change (v2.1.203+).

**Workspace trust:** `.mcp.json` servers from untrusted workspaces blocked until trust accepted. Settings from `~/.claude/settings.json`, managed settings, or `--settings` override for approvals.

---

### claude-code-memory — Memory reference
URL: https://code.claude.com/docs/en/memory

**Two systems:**
| | CLAUDE.md | Auto memory |
|---|---|---|
| Who writes | You | Claude |
| Contains | Instructions/rules | Learnings/patterns |
| Scope | Project/user/org | Per repo (shared across worktrees) |
| Loaded into | Every session (full) | Every session (first 200 lines or 25KB of MEMORY.md) |

**CLAUDE.md scopes (load order, broadest→specific):**
| Scope | Location | Notes |
|---|---|---|
| Managed policy | `/etc/claude-code/CLAUDE.md` (Linux) etc. | Cannot be excluded |
| User | `~/.claude/CLAUDE.md` | Personal, all projects |
| Project | `./CLAUDE.md` or `./.claude/CLAUDE.md` | Team-shared via VCS |
| Local | `./CLAUDE.local.md` | Personal, gitignored |

**Load order within directory tree:** walks up from CWD; files ordered filesystem-root→CWD; `CLAUDE.local.md` appended after `CLAUDE.md` at each level. Subdirectory CLAUDE.md files load on demand when files in those dirs are accessed.

**Import syntax:** `@path/to/file` (relative to the importing file; max 4-hop recursion). Backtick wrapping prevents import: `` `@README` ``. External imports (outside working dir) show approval dialog.

**Block-level HTML comments** stripped before context injection (human-maintainer notes don't consume tokens). Code block comments preserved.

**`.claude/rules/` directory:**
- `.md` files = rules, loaded recursively
- Without `paths:` frontmatter: loaded at launch like `.claude/CLAUDE.md`
- With `paths:` frontmatter: conditional, loads when Claude accesses matching files
- Supports symlinks (circular symlinks detected)
- Glob patterns in `paths:` with brace expansion (budget: 1,000 patterns/4 MiB per rule)

**Path-specific rule triggers:** on file read, not every tool use. Symlinked paths resolve since v2.1.198.

**User-level rules:** `~/.claude/rules/` — apply to every project, loaded before project rules.

**`claudeMdExcludes`:** glob patterns against absolute paths; arrays merge across settings layers. Managed policy CLAUDE.md cannot be excluded.

**AGENTS.md compatibility:** Claude reads CLAUDE.md, not AGENTS.md. Import pattern: `@AGENTS.md` at top of CLAUDE.md.

**`--add-dir` + CLAUDE.md:** not loaded by default; set `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` to load.

**Managed org CLAUDE.md:** `claudeMd` key in `managed-settings.json` (string value; same effect as managed CLAUDE.md file). Only honored in managed settings.

**Auto memory storage:** `~/.claude/projects/<project>/memory/MEMORY.md` (index) + topic files. All worktrees of same repo share one directory.
- MEMORY.md: first 200 lines or 25KB loaded at session start
- YAML frontmatter + HTML comments stripped before measuring (v2.1.211+) — don't count toward limit
- `modified` ISO 8601 timestamp added to frontmatter on each write (v2.1.214+)
- Over-limit: write succeeds, Claude Code returns error telling Claude to rewrite index

**Custom storage:** `autoMemoryDirectory` (absolute or `~/`-prefixed). Respected at any settings scope.

**Toggle:** `/memory` command → auto memory toggle (saves `autoMemoryEnabled` to user settings). Or env: `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1`.

**`/memory` command:** lists CLAUDE.md and memory file locations; toggle auto memory; open auto memory folder; create missing files.

**`/context` command:** shows which files actually loaded into current session.

**`/init` with `CLAUDE_CODE_NEW_INIT=1`:** interactive multi-phase setup (skills, hooks, personal memory, CLAUDE.md). Reads Cursor rules, Copilot rules, AGENTS.md, `.devin/rules/`, `.windsurf/rules/`, `.clinerules`.

**`/doctor`:** proposes CLAUDE.md trims (strips codebase-derivable content; keeps pitfalls + conventions) (v2.1.206+).

---

### claude-code-skills — Skills reference
URL: https://code.claude.com/docs/en/skills

**Structure:** `SKILL.md` file with YAML frontmatter + markdown body. Optional supporting files in same directory.

**Scopes (precedence: Enterprise > Personal > Project > Plugin):**
| Scope | Location |
|---|---|
| Enterprise | Managed settings |
| Personal | `~/.claude/skills/<name>/SKILL.md` |
| Project | `.claude/skills/<name>/SKILL.md` |
| Plugin | `<plugin>/skills/<name>/SKILL.md` (namespaced `plugin-name:skill-name`) |

Legacy `.claude/commands/<name>.md` still works; skills take precedence on name clash.

**Follows [agentskills.io](https://agentskills.io) open standard.**

**Frontmatter fields (all optional except `description` recommended):**
| Field | Notes |
|---|---|
| `name` | Display label (command comes from dir name; plugin: `name` = last segment) |
| `description` | When Claude should use; truncated at 1,536 chars in listing |
| `when_to_use` | Additional trigger context; counts toward 1,536 cap |
| `argument-hint` | Autocomplete hint e.g. `[issue-number]` |
| `arguments` | Named positional args for `$name` substitution (space-separated or YAML list) |
| `disable-model-invocation` | `true` = user-only invocation; not preloaded to subagents (v2.1.196+) |
| `user-invocable` | `false` = hidden from `/` menu; Claude-only |
| `allowed-tools` | Tools pre-approved for the skill turn (clears on next message) |
| `disallowed-tools` | Tools removed while skill active (clears on next message) |
| `model` | Model override for skill turn (session model resumes after) |
| `effort` | Effort level override for skill turn |
| `context` | `fork` = run in forked subagent context |
| `agent` | Subagent type when `context: fork` |
| `background` | `false` = wait for forked result (requires v2.1.218+; default `true`) |
| `hooks` | Lifecycle hooks scoped to skill |
| `paths` | Glob patterns limiting auto-activation by file type |
| `shell` | `bash` (default) or `powershell` for inline shell blocks |

**Boolean fields:** `yes/no/on/off/1/0` accepted (v2.1.218+), in addition to `true/false`.

**Invocation control:**
| Frontmatter | User invoke | Claude invoke |
|---|---|---|
| (default) | Yes | Yes |
| `disable-model-invocation: true` | Yes | No |
| `user-invocable: false` | No | Yes |
| Both set | No | No |

**Dynamic context injection:** `` !`command` `` or `` ```! `` block → Claude Code runs command and inlines output before Claude sees skill content. `disableSkillShellExecution` setting blocks this.

**String substitutions:**
| Variable | Description |
|---|---|
| `$ARGUMENTS` | All arguments as typed |
| `$ARGUMENTS[N]` / `$N` | Argument by 0-based index |
| `$name` | Named argument from `arguments` frontmatter |
| `${CLAUDE_SESSION_ID}` | Current session ID |
| `${CLAUDE_EFFORT}` | Current effort level (ultracode reports as `xhigh`) |
| `${CLAUDE_SKILL_DIR}` | Directory containing SKILL.md |
| `${CLAUDE_PROJECT_DIR}` | Project root (v2.1.196+) |

**Discovery:** parent dirs up to repo root; nested dirs load on first file access. `--add-dir` dirs also scanned. Cowork/cloud: syncs from claude.ai account; doesn't load `~/.claude/skills/`.

**Stacked skill invocations:** up to 6 skills in one command (v2.1.199+): `/skill-a /skill-b do XYZ`.

**`context: fork` + `background: true` (default since v2.1.218):** skill runs as background subagent without blocking session.

**Bundled skills:** `/code-review`, `/verify`, `/batch`, `/debug`, `/doctor`, `/loop`, `/claude-api`, `/design-sync`, `/dataviz`, `/fewer-permission-prompts`, `/deep-research`, `/run`, `/verify`, `/run-skill-generator`, `/security-review`. Control: `disableBundledSkills` (all except `/doctor`), `DISABLE_DOCTOR_COMMAND` env or `skillOverrides: {"doctor": "off"}`.

**Since v2.1.215:** `/verify` and `/code-review` no longer auto-invoked by Claude.

---

### claude-code-commands — Commands reference
URL: https://code.claude.com/docs/en/commands

**Basics:** `/` at start of message; type `/` to list; up to 6 skills can be stacked (v2.1.199+).

**Session management:**
- `/clear [name]` — new conversation (aliases: `/reset`, `/new`)
- `/compact [instructions]` — free context, keep rules/skills/memory
- `/model [model]` — switch model; `s` for session-only; arrows adjust effort
- `/effort [level|auto]` — `low`/`medium`/`high`/`xhigh`/`max`/`ultracode`/`auto`
- `/config [key=value]` — settings UI or direct set (alias: `/settings`)
- `/plan` — enter plan mode
- `/fast [on|off]` — toggle fast mode

**Context & memory:**
- `/context [all]` — visualize context usage; warns when over limit (v2.1.216+)
- `/memory` — edit CLAUDE.md files; toggle auto-memory; browse auto-memory
- `/cd <path>` — move working dir (tab-complete v2.1.206+; preserves prompt cache)
- `/add-dir <path>` — add working directory (tab-complete)

**Navigation & branching:**
- `/branch [name]` — conversation branch (return with `/resume`)
- `/fork [prompt]` — copy to new background session (v2.1.212+)
- `/resume` — return to earlier conversation
- `/background [prompt]` — detach as background agent (alias: `/bg`)
- `/subtask` — side task to subagent with result back to conversation

**Diff & review:**
- `/diff` — interactive diff viewer (auto-refresh on git changes v2.1.198+)
- `/code-review [effort] [--fix] [--comment] [target]` — [Skill]
- `/security-review` — check diff for vulnerabilities
- `/review` — fast read-only GitHub PR review

**Workflow & background:**
- `/batch <instruction>` — [Skill] large parallel codebase changes
- `/goal [condition|clear]` — persistent goal until condition met
- `/loop [interval] [prompt]` — [Skill] repeated prompt (alias: `/proactive`)
- `/tasks` — list background work

**Setup:**
- `/init` — initialize CLAUDE.md (`CLAUDE_CODE_NEW_INIT=1` for interactive)
- `/permissions` — set approval rules
- `/mcp [reconnect|enable|disable]` — manage MCP connections

**Debug & troubleshoot:**
- `/debug [description]` — [Skill] enable debug logging
- `/doctor` — [Skill] full setup checkup (v2.1.205+): health, PATH, settings, slow hooks, CLAUDE.md trim, pre-approval proposals
- `/heapdump` — JS heap snapshot (contains credentials — don't share)
- `/feedback [report]` / `/bug [report]` — report feedback or bug

**Utility:**
- `/copy [N]` — copy Nth-last response to clipboard
- `/export [filename]` — export conversation as text
- `/btw [question]` — side question without history; bare `/btw` reopens overlay (v2.1.212+)
- `/color [color|default]` — set prompt bar color
- `/focus` — toggle focus view
- `/keybindings` — open keyboard shortcuts file
- `/rewind` — roll back to checkpoint (v2.1.119+)

**Platform:**
- `/advisor [model|off]` — enable/disable advisor tool (second model)
- `/desktop`, `/mobile`, `/chrome`, `/teleport`, `/remote-control`
- `/autofix-pr [prompt]` — web session watching PR, push fixes on CI failure
- `/install-github-app`, `/install-slack-app`
- `/agents` — (v2.1.198+) reminder to ask Claude or edit `.claude/agents/`

**Bundled auto-invocable skills:** `/batch`, `/debug`, `/doctor`, `/loop`, `/claude-api`, `/design-sync`, `/dataviz`, `/fewer-permission-prompts`, `/deep-research`
**Bundled explicit-only (v2.1.215+):** `/verify`, `/code-review`

---

### claude-code-changelog — Freshness anchor
URL: https://code.claude.com/docs/en/changelog

**Latest: v2.1.220 (July 25, 2026)** — bug fixes and reliability improvements

**Key releases (newest→oldest, to June 2026):**

| Version | Date | Key changes |
|---|---|---|
| 2.1.220 | 2026-07-25 | Bug fixes |
| 2.1.219 | 2026-07-24 | Claude Opus 5 (`claude-opus-5`), 1M ctx, $10/$50/Mtok; `sandbox.network.strictAllowlist`; `DirectoryAdded` hook; nested subagent depth 3; `workflowSizeGuideline` setting; Opus 4.7 removed from fast mode |
| 2.1.218 | 2026-07-22 | `/code-review` as background subagent; `context: fork` skills background by default; agent names cannot contain `:`; `yes/no/on/off/1/0` for frontmatter booleans |
| 2.1.217 | 2026-07-21 | Emoji shortcode autocomplete; cap 20 concurrent subagents; subagents no longer spawn nested by default; `--max-budget-usd` fixes background agents; brace group pattern budget |
| 2.1.216 | 2026-07-20 | `sandbox.filesystem.disabled`; `/context` warns when over context window; fixed `isolation: worktree` Bash command redirect checks |
| 2.1.215 | 2026-07-19 | `/verify` and `/code-review` no longer auto-invoked by Claude |
| 2.1.214 | 2026-07-18 | `modified` timestamp in memory frontmatter; `EndConversation` tool added; periodic progress heartbeat; permission check hardening; OTel enhancements |
| 2.1.212 | 2026-07-17 | `/fork` copies conversation to background; 200 WebSearch calls/session cap; 200 subagent spawns/session cap; MCP calls >2min auto-background; `claude auto-mode reset` |
| 2.1.211 | 2026-07-15 | `--forward-subagent-text`; nested `.claude/rules/*.md` loading fixed; "always allow" rules save at repo root; YAML frontmatter stripped from MEMORY.md before limit check |
| 2.1.210 | 2026-07-14 | Live elapsed-time counter; isolation worktree check covers full repo; `DirectoryAdded`... wait this is 2.1.219; `EndConversation` behavior fix; `isolation: worktree` working-directory extended coverage |
| 2.1.209 | 2026-07-14 | Fixed `/model` and dialogs blocked in background sessions |
| 2.1.208 | 2026-07-14 | Screen reader mode; `vimInsertModeRemaps` setting; `CLAUDE_CODE_PROCESS_WRAPPER` env var; mouse-click support multi-select |
| 2.1.207 | 2026-07-11 | Auto mode available without opt-in on Bedrock/Vertex/Foundry; compound `cd` commands no longer prompt permission |
| 2.1.206 | 2026-07-09 | `/cd` tab-complete; `/doctor` CLAUDE.md trim check; `EnterWorktree` confirmation |
| 2.1.205 | 2026-07-08 | Auto-mode rule blocking transcript tampering; `/doctor` full setup checkup; `--append-subagent-system-prompt`; `/doctor` reports duplicate agent name files |
| 2.1.204 | 2026-07-08 | Hook events now stream during SessionStart hooks in headless |
| 2.1.203 | 2026-07-07 | Login expiry warning; `additionalDirectories` in MCP `roots/list`; `notifications/roots/list_changed` |
| 2.1.202 | 2026-07-06 | "Dynamic workflow size" in `/config`; `workflow.run_id`/`workflow.name` OTel attrs |
| 2.1.201 | 2026-07-03 | Sonnet 5 sessions no longer use mid-conversation system role |
| 2.1.200 | 2026-07-03 | `AskUserQuestion` no longer auto-continues by default; permission mode default → "Manual"; `manual` alias for `permissionMode` |
| 2.1.199 | 2026-07-02 | Stacked slash-skill invocations (up to 5+leading); `CLAUDE_CODE_RETRY_WATCHDOG`; agent view PR links |
| 2.1.198 | 2026-07-01 | Subagents background by default; Claude in Chrome GA; `/dataviz` skill; background agents commit/push/open draft PR; `CLAUDE_CODE_DISABLE_EXPLORE_PLAN_AGENTS`; Explore inherits main model |
| 2.1.197 | 2026-06-30 | Claude Sonnet 5 as default model, 1M context, promotional pricing |
| 2.1.196 | 2026-06-29 | Org default models; readable default session names; clickable file attachments; `CLAUDE_CODE_SUBAGENT_MODEL=inherit` fix |
| 2.1.195 | 2026-06-26 | `CLAUDE_CODE_DISABLE_MOUSE_CLICKS`; hook matchers with hyphens fixed |
| 2.1.193 | 2026-06-25 | `autoMode.classifyAllShell` setting; auto-mode denial reasons to transcript; `claude_code.assistant_response` OTel log event; live file path autocomplete in bash mode; MCP auth startup notice |
| 2.1.191 | 2026-06-24 | `/rewind` support for resuming from before `/clear` |
| 2.1.187 | 2026-06-23 | `sandbox.credentials` setting; org-configured model restrictions |
| 2.1.186 | 2026-06-22 | `claude mcp login/logout <name>`; `teammateMode: "iterm2"` setting; `!` bash commands trigger Claude to respond |
| 2.1.185 | 2026-06-20 | Stream-stall hint triggers at 20s (was 10s) |
| 2.1.183 | 2026-06-19 | `attribution.sessionUrl` setting; `/config --help`; deprecated model warning |
| 2.1.181 | 2026-06-17 | `/config key=value` syntax; `sandbox.allowAppleEvents`; `CLAUDE_CLIENT_PRESENCE_FILE`; Bun 1.4 bundled; `tui`/`axScreenReader` settings (fullscreen mode) |

---

## Run metadata
- No items in window: none (snapshot mode — all sources fetched in full)
- Feed flags: none
- Manual-check (not fetched): none
- Convergence: none in window (first run — no prior substrates)
