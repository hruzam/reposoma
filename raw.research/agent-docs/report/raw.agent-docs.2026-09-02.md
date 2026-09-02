# agent-docs — substrate
_Fetched: 2026-09-02 | Window: snapshot (no date filter) | Sources: 8/8_

## claude-code-docs

### claude-code-sub-agents — Create custom subagents
URL: https://code.claude.com/docs/en/sub-agents

**Frontmatter fields (name+description only required):**

| Field | Notes |
|---|---|
| `name` | Lowercase+hyphens; no leading `-`, no `:` |
| `description` | Contributes to 15,000-token combined description budget (warning shown at startup when exceeded) |
| `tools` | Allowlist; supports `Agent(type1, type2)` to restrict subagent spawning |
| `disallowedTools` | Denylist, applied before `tools`; `mcp__<server>` / `mcp__*` patterns |
| `model` | alias/full ID/`inherit` |
| `permissionMode` | `default`/`acceptEdits`/`auto`/`dontAsk`/`bypassPermissions`/`plan`/`manual`(v2.1.200+); ignored for plugin subagents |
| `maxTurns` | Returns partial output marked as such on limit (v2.1.246+), resumable |
| `skills` | Preloaded full content; can't include `disable-model-invocation:true` skills |
| `mcpServers` | Inline defs require folder trust (v2.1.238+); ignored for plugin subagents |
| `hooks` | `PreToolUse`/`PostToolUse`/`Stop`; requires folder trust for project `.claude/agents/` (v2.1.218+) |
| `memory` | `user`/`project`/`local` |
| `background` | `true` = force background even if Claude requests foreground |
| `effort` | `low`/`medium`/`high`/`xhigh`/`max` |
| `isolation` | `worktree` |
| `color` | 8 named colors |
| `initialPrompt` | Auto-submitted first turn via `--agent` |
| `experimental.cacheTtl` | **NEW v2.1.248+** — `5m`/`1h` prompt-cache lifetime override |

**Scope precedence:** Managed(1) > `--agents` CLI(2) > `.claude/agents/` project(3) > `~/.claude/agents/` user(4) > plugin `agents/`(5). Nested project dirs: closest to CWD wins (v2.1.178+). Plugin agents: `plugin-name:agent-name` (`:` reserved, can't appear in a name).

**Built-ins:** `Explore` (read-only, model capped at Opus on API since v2.1.198, can override with user/project `Explore` def pinned to haiku), `Plan` (read-only), `general-purpose` (full tools), `claude` (catch-all, full tools), `statusline-setup` (Sonnet), `claude-code-guide` (Haiku).

**Tools always stripped:** `Agent`(at depth limit), `AskUserQuestion`, `EndConversation`, `EnterPlanMode`, `ExitPlanMode`(unless plan mode), `ScheduleWakeup`, `TaskOutput`, `WaitForMcpServers`, `Workflow`.

**Background tool pool:** `Read/Grep/Glob/Bash/PowerShell/Edit/Write/NotebookEdit/WebFetch/WebSearch/TodoWrite/Skill/ToolSearch/EnterWorktree/ExitWorktree/Monitor/TaskStop/SendMessage/Artifact` + all MCP tools. Forks skip both filters entirely.

**Model resolution order (updated):** 1) per-invocation `model` param, 2) subagent frontmatter `model` (`inherit`=main), 3) `CLAUDE_CODE_SUBAGENT_MODEL` env, 4) main conversation model. **New v2.1.257+:** `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` forces ALL subagents onto `CLAUDE_CODE_SUBAGENT_MODEL` regardless of other sources (except forks / `model: inherit` skills).

**Limits:**
- Concurrent: 20 default (ultracode sessions exempt); override `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS` (v2.1.217+)
- Nesting depth: 3 (v2.1.219+ default); history: v2.1.172–216 was 5 (fixed), v2.1.217–218 was 1; override `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`
- 200 spawns/session cap (v2.1.212)

**Permission mode precedence:** parent `bypassPermissions`/`acceptEdits` wins over child frontmatter; parent auto mode inherited (frontmatter override ignored); `permissions.disableBypassPermissionsMode` blocks `bypassPermissions` entirely (v2.1.223+).

**Memory paths (concrete, was abstract before):** `user`→`~/.claude/agent-memory/<agent-name>/`; `project`→`.claude/agent-memory/<agent-name>/`; `local`→`.claude/agent-memory-local/<agent-name>/`. First 200 lines/25KB of subagent's own `MEMORY.md` injected.

**Fork subagents:** inherit entire conversation history + system prompt + all tools + model + permission mode. Use `/subtask` (v2.1.212+, replaced `/fork` v2.1.161–211 for this purpose). Keep `Agent` tool at depth limit (unlike other subagents).

**Transcript persistence:** `~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl`, retained per `cleanupPeriodDays` (default 30).

**Key CLI/env additions since 2026-08-01:**
- `--restricted` flag (v2.1.248): strips built-in command/code-running tools, confines file tools to CWD, refuses `bypassPermissions`
- `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` (v2.1.257+)
- `experimental.cacheTtl` (v2.1.248+)

---

### claude-code-settings — Settings reference
URL: https://code.claude.com/docs/en/settings

**5 sources, in precedence order (highest→lowest):** Managed → Command line (`--settings`) → Project local (`.claude/settings.local.json`) → Shared project (`.claude/settings.json`) → User (`~/.claude/settings.json`). Lists merge across scopes EXCEPT: `fallbackModel` (whole value from highest-precedence file), `modelPicker` (**new key**, v2.1.242+, whole-value-wins among managed/`--settings`/user only), `availableModels` (managed list wins outright if managed source sets it), `modelSettings` (resolved per-model together with `effortLevel`).

**Security-sensitive exceptions (stricter value always wins regardless of scope):** `disableClaudeAiConnectors`, `enableArtifact`/`disableArtifact` (v2.1.242+), `isolatePeerMachines`, `remoteControlAtStartup` (only from project/local), `crossSessionInbound` (ladder accept<hold<refuse), `useAutoModeDuringPlan`, `syncClaudeAiSkills`.

**Local settings file location fix (v2.1.211+):** now written at the git repo ROOT (was: starting directory, pre-v2.1.211). `/cd` moving the session re-targets project files at the new directory (v2.1.246+).

**Cloud sessions read only:** shared project settings (`.claude/settings.json`, committed) + server-managed settings. NOT read: user settings, project-local settings, on-device managed-settings.json/MDM.

**`bypassPermissions` restriction (v2.1.257+):** no longer takes effect from project/local settings — must be set in user or managed settings, or passed via `--permission-mode`. (Before v2.1.257: any file could set it.)

**JSON Schema:** `https://json.schemastore.org/claude-code-settings.json` (may lag newest releases — a validation warning isn't proof of an invalid config).

**Config change detection:** most edits (permissions, hooks, `apiKeyHelper`) hot-reload without restart; fires `ConfigChange` hook per file change (not for MDM/console-delivered managed settings, which arrive on their own schedule). `model`/`effortLevel`/`modelSettings`/`outputStyle` still need `/model`, `/effort`, or `/clear`/restart respectively to take effect mid-session.

*(Full settings-key table not re-extracted this run — page structure changed to a narrative "settings reference" split across `/docs/en/settings` (concepts/precedence) and `/docs/en/settings-reference` (full key table, not fetched this run — flag for next pass).)*

---

### claude-code-hooks — Hooks reference
URL: https://code.claude.com/docs/en/hooks

**5 handler types unchanged:** `command`, `http`, `mcp_tool`, `prompt`, `agent`.

**New/changed hook events since 2026-08-01:**
- **`PreModelSwitch`** / **`PostModelSwitch`** — **NEW (v2.1.251, Aug 28 2026)**. Block, confirm, or annotate model switches; matcher = model canonical name. `PreModelSwitch` can block (exit 2).
- `StopFailure` — matcher is now documented as an error-type enum: `rate_limit`, `overloaded`, `authentication_failed`, `oauth_org_not_allowed`, `account_on_hold`, `billing_error`, `invalid_request`, `model_not_found`, `server_error`, `max_output_tokens`, `unknown`
- `Setup` event (matchers `init`/`maintenance`) now documented — fires on `--init-only` / maintenance mode
- `DirectoryAdded` matcher values: `slash_command`, `register_repo_root`
- `ConfigChange` matcher values: `user_settings`, `project_settings`, `local_settings`, `policy_settings`, `skills`
- `InstructionsLoaded` matcher values: `session_start`, `nested_traversal`, `path_glob_match`, `include`, `compact`
- `agent` handler type now explicitly marked **experimental**

**Events that CAN block (exit 2) — updated list:** `PreToolUse`, `UserPromptSubmit`, `UserPromptExpansion`, `Stop`, `SubagentStop`, `TeammateIdle`, `TaskCreated`, `TaskCompleted`, `ConfigChange`, `PostToolBatch`, `WorktreeCreate`, **`PreModelSwitch`** (new). `PermissionRequest` moved to the CANNOT-block list in this pass's fetch (was listed as blocking in Aug 1 substrate — flag as a doc-language shift, not necessarily a behavior change; `permissionDecision` field still applies to it per the decision-control table).

**Exit 1 explicitly called out as NOT blocking** — use exit 2 for policy enforcement (new clarifying note).

**JSON output — new field:** `hookSpecificOutput.retry` (boolean) — `PermissionDenied` event only.

**Timeouts confirmed:** command/http/mcp_tool default 600s; `prompt` 30s (also now: `UserPromptSubmit`, `PreModelSwitch`, `PostModelSwitch` default 30s); `agent` 60s; `MessageDisplay` 10s; `SessionEnd` shares 1.5s budget (up to 60s if configured longer).

**Workspace trust requirement (v2.1.218+):** frontmatter hooks in project `.claude/agents/` and skills require folder trust before running.

---

### claude-code-mcp — MCP reference
URL: https://code.claude.com/docs/en/mcp

**Runtime generations — NEW section, not in prior substrate:**
- **v1 runtime** (pre-v2.1.232): MCP TypeScript SDK 1.x, no protocol negotiation, no `list_changed` stream
- **v2 runtime** (v2.1.232+, now current): SDK 2.0, supports MCP protocol revision **2026-07-28**, negotiates newer revision with compatible servers, persistent `list_changed` notification stream (reopens: <10s closure retries ×3, ≥10s closure retries ×5/hour), can't deliver channel messages on newer revision. Control: `MCP_SDK_GENERATION=v1|v2`, `MCP_PROTOCOL_NEGOTIATION=auto|legacy`.

**Reserved names unchanged:** `workspace`, `claude-in-chrome`, `computer-use`, `Claude Preview`, `Claude Browser`.

**Idle timeout:** 5 min (HTTP/SSE/WebSocket/connectors), 30 min (stdio); `CLAUDE_CODE_MCP_TOOL_IDLE_TIMEOUT` env, `0` disables; per-server `timeout`≥1000ms floors it. Requires v2.1.187+.

**Output limits:** warn 10,000 tokens (fixed), default cap 25,000, `MAX_MCP_OUTPUT_TOKENS` override. **New:** per-tool `_meta["anthropic/maxResultSizeChars"]` annotation overrides the token cap for text content only, ceiling 500,000 chars.

**OAuth — expanded:** dynamic client registration default; `claude mcp login/logout <name>`; pre-configured `--client-id`/`--client-secret`/`--callback-port` (v2.1.229+); dynamic `headersHelper` script for custom auth (10s timeout, sets `CLAUDE_CODE_MCP_SERVER_NAME`/`CLAUDE_CODE_MCP_SERVER_URL`, re-run every connection, no caching).

**Env var expansion in `.mcp.json`:** `${VAR}` / `${VAR:-default}` now documented explicitly, applies to `command`/`args`/`env`/`url`/`headers`.

**Version highlights since Aug 1:** v2.1.246 plugin server reload on `/cd`; v2.1.238 inline MCP server trust requirement + `MCP_DISCOVERY_CACHE` default change; v2.1.232 v2 runtime default.

---

### claude-code-memory — Memory reference
URL: https://code.claude.com/docs/en/memory

**Auto memory now has 4 typed note kinds** (new — was undifferentiated before): `user` (role/expertise/preferences), `feedback` (corrections/confirmed approaches), `project` (ongoing work/deadlines/decisions not derivable from code), `reference` (external pointers — issue tracker, dashboard). Type recorded in each topic file's frontmatter.

**Storage path refinement:** `~/.claude/projects/<project>/memory/` where `<project>` derives from the git repo (shared across all worktrees/subdirs of that repo); outside git, project root is used. **New:** `CLAUDE_CODE_PROJECT_DIR_NAME` (paired with `CLAUDE_CONFIG_DIR`, requires **v2.1.234+**) lets you force a custom `<project>` name so multiple checkouts share one memory dir.

**Auto memory is machine-local** — not synced across machines/cloud environments (explicit statement, was implicit before).

**CLAUDE.md size guidance — new explicit target:** under 200 lines per file; CLAUDE.md itself capped at 4 MiB load (larger files skipped entirely) — this is distinct from the MEMORY.md 200-line/25KB limit.

**`/init` with Cursor/Copilot/AGENTS.md ingestion — confirmed + expanded:** always reads Cursor rules (`.cursor/rules/`, `.cursorrules`) and Copilot rules (`.github/copilot-instructions.md`); with `CLAUDE_CODE_NEW_INIT=1` also reads `AGENTS.md`, `.devin/rules/`, `.windsurf/rules/`/`.windsurfrules`, `.clinerules`.

**New: `/import [codex|gemini] [--dry-run] [--yes]`** (v2.1.213+) — one-time import of another coding agent's config (instruction files, MCP servers, commands, subagents, skills) into the matching CLAUDE.md/settings. Unavailable on Bedrock/GCP/Foundry/AWS.

**`claudeMdExcludes` symlink fix (v2.1.239+):** pattern matches against either the rules file's own path or its symlink target (before: only the link target matched).

**`.claude/rules/` brace-expansion budget confirmed:** 1,000 patterns / 4 MiB per rule; pre-v2.1.217 many brace groups could stall/crash CLI startup; pre-v2.1.207 one invalid `[`-bracket pattern broke Read tool for the WHOLE rule (now: only that pattern is skipped).

**What survives `/compact`:** project-root CLAUDE.md re-read from disk and re-injected after compaction. Nested CLAUDE.md and `paths:`-scoped rules reload only as matching files are touched again.

---

### claude-code-skills — Skills reference
URL: https://code.claude.com/docs/en/skills

**Frontmatter — new fields since 2026-08-01:**
- `metadata` — free-form YAML map for caller tooling; Claude Code ignores contents
- `license` — Agent Skills spec field, accepted but unused by Claude Code
- `compatibility` — env-requirement string, ≤500 chars, accepted but unused

**Agent Skills spec restriction (new section):** outside Claude Code (claude.ai skill uploads, Skills API, `package_skill.py`), only 6 fields are legal: `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`. Any other field (e.g. `argument-hint`) causes a hard upload error.

**Skill name resolution precedence (expanded):** enterprise > personal > project; a skill at any level also overrides a same-named bundled skill (but not the bundled skill's aliases — e.g. project `code-review` doesn't hijack `/review`); plugin skills use `plugin-name:skill-name` namespace (never conflicts); skill beats same-named `.claude/commands/` file; any local/plugin skill overrides a claude.ai-synced skill of the same name.

**Nested `.claude/skills/` directories:** load on first file access in that subdir; if name clashes with root skill, nested one gets directory-qualified name (`apps/web:deploy`) and BOTH stay invocable; invoking the unqualified name auto-appends an instruction for Claude to also consider matching nested variants.

**`synced/` folder name reserved** (any case) in enterprise/personal/project skill dirs — used for `CLAUDE_CODE_SYNC_SKILLS` downloads to `~/.claude/skills/synced/`.

**Run/verify skill trio (new since last pass):** `/run` (launch+drive app), `/verify` (build+run to confirm a code change works, no test fallback), `/run-skill-generator` (records a reusable launch recipe to `.claude/skills/run-<name>/` after inferring it once). `/verify` can self-record its own recipe to `.claude/skills/verify/SKILL.md`, replacing the bundled `/verify` at repo root (v2.1.200+; pre-v2.1.205 caused merge-conflict-prone edits every run).

**Cowork/cloud session skill loading:** don't read `~/.claude/skills/` at all — Cowork loads claude.ai-account-enabled skills at session start; cloud sessions additionally load project-committed `.claude/skills/`. Desktop *scheduled tasks* (different from Cowork/routines) run locally and use normal local skill locations.

**Boolean frontmatter:** `yes/no/on/off/1/0` (any case) + `true/false`, since v2.1.218 (confirmed).

*(Bundled skills / commands list — see claude-code-commands section below, more current there.)*

---

### claude-code-commands — Commands reference
URL: https://code.claude.com/docs/en/commands

**New commands since 2026-08-01:**
- `/design [brief]` — **[Skill]**, draft UI mockups as artboards (v2.1.234+, requires artifact support)
- `/design-login`, `/design-sync [hint]` — auth + React design-system sync to Claude Design (**[Skill]**; unavailable on Bedrock/GCP/Foundry/AWS)
- `/import [codex|gemini] [--dry-run] [--yes]` — config import from other coding agents (v2.1.213+)
- `/claude-api [migrate|upgrade|managed-agents-onboard|prompt-audit|cost-optimize]` — **[Skill]**; `cost-optimize` v2.1.247+, `upgrade` v2.1.236+, `prompt-audit` v2.1.221+
- `/deep-research <question>` — now a **[Workflow]** (fans web-search subagents in background), explicit-only since v2.1.218 (was auto-invocable before)
- `/list-agents` — list subagents/teammates/reachable sessions for cross-session `@`-mention messaging (v2.1.224+; teammate rows v2.1.239+)
- `/autocompact [auto|<tokens>]` — set auto-compact window (v2.1.221+)
- `/auto-mode-setup` — draft `autoMode.environment` entries (v2.1.228+, Windows-native v2.1.233+)
- `/artifacts` — list/attach/open artifacts (v2.1.208+)
- `/insights`, `/radio`, `/powerup` — session-analysis report / lo-fi radio / interactive feature tour
- `/plugin [list|install|enable|disable]`, `/reload-plugins`

**`/verify` and `/deep-research` both now explicit-only** (v2.1.215 and v2.1.218 respectively) — Claude no longer auto-invokes either.

**Bundled explicit-only skills (updated list):** `/batch`, `/code-review`, `/claude-api`, `/dataviz`, `/debug`, `/design`, `/design-sync`, `/doctor`, `/fewer-permission-prompts`, `/loop`, `/verify`, `/deep-research`.

**Mid-turn command application (new, v2.1.242+ feature-flagged):** `/model`, `/effort`, `/fast` can apply immediately mid-turn on flag-enabled providers (always deferred to next turn on non-flag-fetching providers, e.g. some Bedrock/Vertex/Foundry configs — though v2.1.239 also made these three run immediately specifically on Bedrock/Vertex/Foundry).

**`/agents` behavior change (v2.1.198+):** prints a reminder to ask Claude or edit `.claude/agents/` directly, replacing the old interactive management UI (v2.1.197 and earlier).

---

### claude-code-changelog — Freshness anchor
URL: https://code.claude.com/docs/en/changelog

**Latest: v2.1.258 (September 1, 2026)** — fixed macOS 12 (Monterey) launch regression from v2.1.255; fixed remote/scheduled session "non-empty content" error after re-sent permission approval.

**Key releases since last run's anchor (v2.1.220, 2026-07-25) → today, newest first:**

| Version | Date | Key changes |
|---|---|---|
| 2.1.258 | 2026-09-01 | macOS 12 launch fix; remote/scheduled session content-error fix |
| 2.1.257 | 2026-09-01 | **Claude Fable 5.1** (`claude-fable-5-1`) default Fable model, 1M ctx, $10/$50/Mtok, $0.25/Mtok cache reads; time-format settings; Containment Escape auto-mode rule (cloud metadata-credential fetches, cross-tenant reach); subagents auto-continue after mid-stream cutoff; `CLAUDE_CODE_SUBAGENT_MODEL_FORCE` now forces every subagent |
| 2.1.252 | 2026-08-31 | Bash "task output swap refused" fix; "always allow" save fix; Remote Control stall fix on degraded connections |
| 2.1.251 | 2026-08-28 | **`PreModelSwitch`/`PostModelSwitch` hook events**; live streaming of foreground subagent tool calls to Remote Control; spend-limit bar in `/usage`; per-session prompt-cache line in `/cost`; per-model effort defaults (each model keeps own setting) |
| 2.1.250 | 2026-08-28 | Bug fixes |
| 2.1.248 | 2026-08-27 | **`--restricted` flag**; `experimental.cacheTtl` agent frontmatter; server-managed-settings diagnostics in `/doctor`/`/status`; cross-session messaging on Bedrock/Vertex/Foundry; Workflow tool prompt footprint cut ~1k vs 5.7k tokens |
| 2.1.247 | 2026-08-26 | `SendFeedback` tool; `/claude-api cost-optimize`; customizable spinner tips |
| 2.1.246 | 2026-08-25 | Startup warning for wildcard-before-subcommand Bash allow rules; Auto mode tab in `/permissions`; `/cd` project-file re-targeting |
| 2.1.245 | 2026-08-25 | Fixed Linux glibc 2.44 startup crash (Arch/CachyOS/Fedora Rawhide) |
| 2.1.243 | 2026-08-25 | Loops breakdown in `/usage`; `modelPicker` setting; `promptCacheTtl`/`subagentPromptCacheTtl` settings; keyless Console sign-in; native install ~75MB (zstd, was 340MB) |
| 2.1.239 | 2026-08-21 | `/claude-api upgrade` (Python 0.x→1.x); cloud-synced plugins shown as `name@synced`; 1.1× US-only-inference cost premium |
| 2.1.238 | 2026-08-20 | `keybindingFlavor: "readline"`; plugin marketplace `headersHelper` |
| 2.1.237 | 2026-08-20 | "Concise" output style (Claude leads with results, skips preamble) |
| 2.1.236 | 2026-08-19 | `ANTHROPIC_DEFAULT_MODEL` env var; `notify_when_idle` for cross-session `SendMessage` |
| 2.1.235 | 2026-08-18 | Optional `spellcheck` setting (aspell/hunspell/ispell) |
| 2.1.234 | 2026-08-17 | `CLAUDE_CODE_PROJECT_DIR_NAME` env var; GitLab MR badge; automatic session continuation at claude.ai usage-limit reset; Windows NT namespace path rejection (security) |
| 2.1.233 | 2026-08-14 | GitLab MR URL support for `--worktree`/`claude agents`; opt-in Linux memory cgroup for Bash tool |
| 2.1.232 | 2026-08-13 | **Subagent forking on by default** (inherits full conversation + prompt cache); `@`-mention other Claude sessions by name; new GitLab token redaction families; **MCP v2 runtime default** |
| 2.1.230–231 | (referenced, not detailed) | OAuth redirect URI fix (231); discovery cache `cached` status (221 range) |
| 2.1.229 | ~2026-08 | `--callback-port` OAuth flag added |
| 2.1.228 | ~2026-08 | `/auto-mode-setup` |
| 2.1.224 | ~2026-08 | `/list-agents` |
| 2.1.223 | ~2026-08 | `permissions.disableBypassPermissionsMode` |
| 2.1.221 | ~2026-08 | `/autocompact`; discovery cache `cached` status |
| 2.1.220 | 2026-07-25 | (prior anchor) Bug fixes |

**Note:** changelog fetch truncated below v2.1.232; versions 2.1.221–2.1.231 partially reconstructed from cross-references in other pages (sub-agents/mcp docs), not from the changelog page directly — flag as lower-confidence for that band.

---

## Run metadata
- No items in window: none (snapshot mode — all sources fetched in full)
- Feed flags: `claude-code-changelog` — full page output exceeded single-fetch capture; entries below v2.1.232 partially reconstructed from cross-references, not the primary changelog listing. Re-fetch with pagination/offset next run if full v2.1.221–231 detail is needed.
- Manual-check (not fetched): none
- Convergence: see card run block (this scope's sources are single-domain, all `claude-code-docs` tier-1 official docs — no cross-source convergence check applicable; convergence logic is more relevant to the ai-news scope)
