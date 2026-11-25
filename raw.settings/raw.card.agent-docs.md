---
card: card.agent-docs
brand: Research — Claude Code agent harness (scope: agent-docs)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-11-25
half_life: ~30 days
half_life_days: 30
recheck:
  - ~/reposoma/raw.research/agent-docs/draft/sources.jsonl
  - https://code.claude.com/docs/en/changelog
verify_cmd: "curl -s https://code.claude.com/docs/en/changelog | grep -c 'v2\.'"
---

# agent-docs — synthesis log

Skill: `/refresh agent-docs` · Data: `raw.research/agent-docs/draft/sources.jsonl`
Substrate: `raw.research/agent-docs/report/`

## Refresh delta 2026-11-25

_PARTIAL: versions 2.1.297, 2.1.298, 2.1.315, 2.1.320, 2.1.324 NOT itemised (no version header seen in fetched chunks). Covered by header: 2.1.294–296, 299–314, 316–319, 321–323, 325–332 (changelog offsets 0–600000 of ~1.44M chars via WebFetch summaries; trailing/leading un-headed blocks at chunk joins folded into their neighbours; 2.1.327 and 2.1.323 only partly visible). Run by @Epoch's sibling for this one card, NOT the `/refresh agent-docs` pipeline. Hooks/skills/MCP/settings/memory docs NOT re-fetched; their card entries remain 2026-10-08 state. Confidence: H = live official page via summariser, M where item sits at a chunk boundary._

**Lead:** Freshness anchor v2.1.293 (Oct 7) -> **v2.1.332 (Nov 25)**. Headliners: **Code Mode** (experimental opt-in v2.1.323; fixes/expansion through 332, bedrock/foundry support 331, works with agent teams 326, doc: /docs/en/code-mode); **MCP-served skills** (beta, `server:skill` in `/` menu, 332); **`PreSkillShellCommand` hook event** (332; a settings file naming it opens a dialog on <=2.1.331); **per-invocation `effort` on the Agent tool** (292); **fork subagents default-on beyond the terminal** (302).

**Subagents / Agent tool (H unless noted):**
- Agent tool `effort` parameter (v2.1.292); persists across resume per docs; effort resolution (docs): `CLAUDE_CODE_EFFORT_LEVEL` > per-call `effort` > frontmatter `effort` > parent/skill effort > `CLAUDE_CODE_SUBAGENT_EFFORT` (new env, v2.1.316). `effort` ignored for named agent-team teammates until fixed in 329/330. Subagents/teammates on a different model use that model's saved effort (317).
- Frontmatter now documented: `name` (<=256, no `:`, no leading `-`), `description`, `tools`, `disallowedTools`, `model` (incl. `fable`, `inherit`), `permissionMode`, `maxTurns`, `autoCompactWindow` (>=100000 plain integer, v2.1.296; `200k` read as 200 in frontmatter; lowers `CLAUDE_CODE_AUTO_COMPACT_WINDOW` from 312), `skills` (max 32 preloaded, v2.1.295), `mcpServers`, `hooks`, `memory`, `background`, `omitClaudeMd`, `effort`, `isolation: worktree`, `color`, `initialPrompt`, `experimental.cacheTtl`. Plugin subagents ignore `hooks`/`mcpServers`/`permissionMode`. (docs sub-agents)
- Priority on name collision: managed > `--agents` (JSON or file path in -p, v2.1.281) > project `.claude/agents/` > user `~/.claude/agents/` > plugin. Nesting default 3 layers (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`), concurrent cap 20 (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`) - both re-confirmed live. Memory paths re-confirmed (`~/.claude/agent-memory/<n>/`, `.claude/agent-memory/<n>/`, `.claude/agent-memory-local/<n>/`; 200 lines/25KB).
- **Fork:** on by default in `claude -p`, Agent SDK, desktop and VS Code too (v2.1.302; interactive terminal since 232); `CLAUDE_CODE_FORK_SUBAGENT=0` disables; `claude mcp serve` never offers forks. With `=0`, subagents in -p/SDK/desktop/VS Code wait for their own subagents by default and -p counts them against one 10-min wait (`CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS`) (v2.1.328). Forks can't spawn forks; can take `isolation: "worktree"`; stop forks only with `Agent(fork)` in `permissions.deny`. Docs: when agent view is off, `/subtask` is unavailable and `/fork` starts the forked subagent. Fork launches told which launch is theirs (307). Headless foreground-fork "finished at start" bug fixed (332).
- Background subagents: shell commands auto-backgrounded after 3 min on all providers (318); subagents stop rather than switch models when "Switch models when flagged" = Ask each time (318); `CLAUDE_CODE_DISABLE_AGENT_PROGRESS_SUMMARIES=1` (323); `CLAUDE_CODE_WORKFLOW_SUBAGENT_MODEL` (296); subagent model fallback carries to model-less agents and forks (330); skills with `model` (non-fork) stay on session model for subagents/forks/compaction (330); `ExitWorktree` refuses while a background subagent may be in the worktree (326); worktree subagents refuse some branch-rewriting git (326); `permissions.denyInsteadOfPrompting` for subagents and teammates (319); `subagentStatusLine` setting REMOVED (in 2.1.323 un-headed block, M); plugin `agent` setting deprecated (warns at startup, same block, M).
- Docs: `/btw` answers from an open subagent transcript (>=314); Ctrl+Enter / Ctrl+X Ctrl+S sends a message to a viewed agent early (>=286); `/list-agents` output shown only to you (328).

**Hooks (H/M):** `PreSkillShellCommand` (332); `onFailure: "block"` for command/HTTP (295), SDK callbacks (317), `mcp_tool` (328) - Code Mode PreToolUse errors no longer refuse unless `onFailure: "block"` (329); prompt hooks accept model aliases (330); prompt/agent hooks capped 24 concurrent per session (312; 12 per event in 302); `UserPromptSubmit` runs before skill/slash expansion (299); `turn.start` fires for subagents (299); PostToolUse managed hooks no longer fire for pre-refused calls, `PostToolBatch` gets them (328); `PermissionDenied` `retry:true` semantics narrowed (331); `PreCompact`/`PostCompact` now carry `agent_id`/`agent_type` (323 block, M); `SubagentStop` double-fire fixed (311) and now waits for last reply in Desktop (331); `updatedInput` validated like Claude's own input (299 block, M); skill source max 1,024 hooks (304); `CLAUDE_CODE_DISABLE_DEFERRED_TOOL_RESUME` (328); `/hooks` lists `--settings` hooks (326+).

**Skills / MCP:** MCP skills beta (332); `computer-use` reserved skill name on Mac (332); scheduled tasks/`/loop` ask before running a skill with `allowed-tools`/hooks - add `Skill(name)` to allow (325); `CLAUDE_CODE_SYNC_SKILLS` cache 10 min (311); claude.ai skill sync ~40 min idle (293); `/skill-doctor`/`plugin eval --disallow-tools` (299). MCP: `deniedMcpServers` URL/name semantics tightened (318/330); allow rules match only the named server, use `mcp__<server>__*`, agent `tools:` follows (299); MCP tasks backgrounded in terminal (319; `CLAUDE_CODE_DISABLE_MCP_TASKS=1`); tool-description cap 4,096 chars (296), 16,384 via tool search (295); `claude mcp add-json <name> -` stdin (327); `MCP_SDK_GENERATION=v1` = v2-client compat mode (323); cloud/RC connectors negotiate 2026-07-28 (295/299).

**Models:** Haiku 5.5 (293) - already in card; Fable 5.2 `claude-fable-5-2` now default Fable (321); fast mode Opus 4.8 deprecated, removal **2026-11-30**, migrate to Opus 5.5 (316 notice); default context for unrecognised model IDs 200K -> 1M (323). Sonnet 5.5 cache-read $0.10/M (296).

**Auto mode / permissions:** interactive starts in auto when unconfigured (284, in card); `claude -p`/SDK reverted: start in `default` on third-party providers or telemetry-off installs (302; had been auto since 285).

**Convergence:** n/a (single-domain tier-1).
**Quiet:** none.
**Feed flags:** changelog page now ~1.44M chars (was ~991K); full v2.1.294–332 needs ~6 fetches at 100K offsets 0–500000+; sources.jsonl changelog note still says latest v2.1.206 (stale, now stale by ~126 versions); sub-agents docs read fully, 114.8K chars.
**Manual-check:** hooks/skills/mcp/settings/commands docs not re-read - Code Mode doc page `/docs/en/code-mode` and `/docs/en/agent-view` unread; `/agents`/`claude agents` agent-view status needs a docs re-read.

---

## 2026-10-08

_Manual two-pass run by @Epoch (NOT the `/refresh agent-docs` pipeline). Pass 1 fetched the changelog (itemized v2.1.268–2.1.293) and sub-agents docs; pass 2 (same day) fetched changelog v2.1.259–267 and ALL other sources.jsonl pages (hooks, settings, mcp, memory, skills, commands). Depth varies: hooks read 100K of 250K chars, mcp 100K of 118K, skills 100K of 106K; settings, memory and commands were digested in full in pass 3 (below). Changelog 2.1.262/2.1.264 absent from excerpt; 2.1.279 block partly visible ("likely" items)._

**Lead:** Freshness anchor v2.1.258 (Sep 1) → **v2.1.293 (Oct 7)**. Subagents (docs, live): nesting default is **3 layers** (was 5 in v2.1.172–216, 1 in 217–218, 3 since v2.1.219; `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`, `1` disables); **20** concurrent cap (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`, v2.1.217+; ultracode exempt); frontmatter now documents `omitClaudeMd` (v2.1.271), `isolation: worktree`, `initialPrompt`, `effort`, `experimental.cacheTtl`, `name` ≤256 chars with no `:`; `--agents` accepts a JSON file path non-interactively (v2.1.281); subagent results are now framed/indented as subagent output so they cannot pass as session instructions, and `TaskOutput` was removed — use `Read` on the task output file (v2.1.277); fork default-on interactive (v2.1.232; default-on also in `-p`, Agent SDK, desktop and VS Code from v2.1.302), forks share parent prompt cache; model-resolution order and `CLAUDE_CODE_SUBAGENT_MODEL_FORCE` confirmed. Hooks: PreToolUse/PermissionRequest now fail-closed on matcher failure (v2.1.288); `PermissionRequest` agent-type hooks error out (v2.1.279, likely); `SubagentStop` empty-type matcher fix (v2.1.275); TeammateIdle not fired from subagents (v2.1.290). Skills: `AGENTS.md` read when no `CLAUDE.md`, toggle in `/config` (v2.1.277/278); `syncClaudeAiSkills`/`syncClaudeAiPlugins` opt-outs (v2.1.275); cloud skills named `anthropic-skills:<name>`, and `anthropic-skills`/`claude-ai` namespace folders no longer load locally (v2.1.282). New primitive: **Claude Mods** (v2.1.287). Models: Opus 5.5 (v2.1.280), Sonnet 5.5 (v2.1.284), Haiku 5.5 (v2.1.293); Pro/Team Standard default Opus (v2.1.279, likely); Fable always shown in `/model` on Anthropic API (v2.1.277). Auto mode: starts by default in interactive sessions with no configured mode (v2.1.284), server-side classifier default (v2.1.278). Plugins: `claude plugin eval` (v2.1.269, git 2.31+ from 283), `--accept-command <sha256>`. MCP: protocol 2026-07-28 default for stdio (v2.1.292).

**Convergence:** n/a — single-domain tier-1 official docs scope

**Pass 2 additions:** changelog v2.1.259–267 (Sep 2–9) — `managedMcpServers` managed setting outranks every other MCP scope (259); `--permission-prompts none` (259); unparseable managed settings stop startup (259); Fable 5.1 in `/model` (260); `maxEffortLevel` (267); `--system-prompt-snapshot off` (267); `effort:` frontmatter now works on Opus 4.7/4.8/Fable 5 (267); `--plugin-dir` folder-of-plugins (265). Hooks docs: 33 events incl. `DirectoryAdded`; exit 2 not honored for `PermissionRequest`; unparseable stdout = non-blocking error (v2.1.248); `scratchpad_dir` input (v2.1.257). MCP docs: v2 runtime (protocol 2026-07-28) default where feature flags are not fetched (v2.1.274), `MCP_SDK_GENERATION`, `MCP_PROTOCOL_NEGOTIATION`; `/mcp reconnect all` (284). Skills docs: 1,536-char description cap; claude.ai skills sync to `~/.claude/skills/synced/`; `verify`/`simplify` skills run before each commit (286); `anthropic-skills` reserved namespace. Settings docs: precedence managed > CLI > project-local > shared project > user (matches card.claude-code).

**Pass 3 additions (settings / memory / commands / Remote Control docs, live 2026-10-08, H):**
- *Settings:* precedence managed > `--settings` CLI > project-local > shared project > user. `auto` and `bypassPermissions` as `permissions.defaultMode` take effect only from user/managed settings or `--permission-mode` (ignored in project/local; before v2.1.257 `bypassPermissions` worked from any file). Managed-precedence exceptions: `permissions.blockReadsOutsideWorkingDirectories` `true` from any scope wins (v2.1.257); `disableArtifact` `true`-over-`enableArtifact`-style exception (v2.1.242); `modelPicker` taken whole from managed/`--settings`/user, ignored in project/local (v2.1.242); `maxEffortLevel` lowest cap across scopes wins (v2.1.267); `remoteControlAtStartup` `false` from project/local honored over managed `true`; `crossSessionInbound` stricter value wins on the ladder accept < hold < refuse; `useAutoModeDuringPlan`/`syncClaudeAiSkills`/`syncClaudeAiPlugins` `false` honored from managed/`--settings`/user/local but ignored from shared project settings; `autoMode.classifyAllShell` `true` from user/`--settings` wins over managed. Local settings file now kept at repo root (v2.1.211). `claudeMd` key honored only from managed scope. Only server-managed settings reach cloud sessions.
- *Memory:* `MEMORY.md` first 200 lines or 25KB, whichever first (error on write asks Claude to rewrite the index). CLAUDE.md: target <200 lines (soft); >4 MiB is skipped; a warning fires when combined size of loaded files exceeds a combined limit. `AGENTS.md` read natively since v2.1.277 only when no `CLAUDE.md`/`CLAUDE.local.md` exists at or above the working dir; `instructionFiles` = `claude-md-or-agents-md` (default) | `claude-md-and-agents-md` | `claude-md` | `managed-only`, read from user/`--settings`/managed only; built-in plugin id `cc-plugin-agents-md@builtin` (was `agents-md@builtin`, both accepted from v2.1.285). `.claude/rules` `paths:` is the only frontmatter field read; 1,000 expanded patterns / 4 MiB per list; brace-group crash fixed v2.1.217; one invalid pattern used to break Read before v2.1.207. Auto memory records `type: user|feedback|project|reference` and a `modified` ISO timestamp (v2.1.214).
- *Commands:* `/agents` now only prints a reminder (interactive UI gone after v2.1.197). `/fork` = copy to a new background session (v2.1.212+); `/subtask` = forked subagent (v2.1.212+; was `/fork` in v2.1.161–211); `/branch` = in-place branch. Removed: `/pr-comments` (v2.1.91), `/vim` (v2.1.92), `/ultraplan`. Added (version tags per docs): `/workflow-authoring` 248 · `/skill-doctor` 252 (+ feature-flag fetch) · `/design`,`/slides` 265 · `/output-style` 269 · `/doctor prompt-audit` 283 · `/plugin-authoring` 287 · `/artifact-diagramming`,`/autocompact` 221 · `/auto-mode-setup` 228 · `/list-agents` (alias `/peers`) 224 · `/focus on|off` from Remote Control 281 · `/review` became an alias of `/code-review` at 223.
- *Remote Control docs:* server mode gives up after ~10 min without network and the process exits; interactive mode retries indefinitely; HTTP 403 retries up to 3 min; heartbeat unreachable ~30 min → disconnect; forwarded dialogs expire after 5 min (`dialogExpiry`, v2.1.224); server-session resume window ~4 h; Trusted Devices is beta and available on Pro/Max/Team/Enterprise.

**Quiet:** none — all 8 sources.jsonl entries returned content (hooks/mcp/skills only partially read, see top note)

**Feed flags:** claude-code-changelog (page is ~991K chars; fetch with offsets 0/100000/200000/300000 to cover v2.1.259–2.1.293; 2.1.262 and 2.1.264 missing from excerpt) · sources.jsonl changelog note still says latest v2.1.206 (stale — update the note)

**Manual-check:** none

---

## 2026-09-02

**Lead:** Freshness anchor jumped from v2.1.220 (Jul 25) to v2.1.258 (Sep 1) — 38 versions in five weeks. Biggest shifts: subagent forking is now on by default (v2.1.232, inherits full conversation + prompt cache) and the MCP client moved to its v2 runtime by default (v2.1.232, SDK 2.0, protocol revision 2026-07-28, persistent `list_changed` streams). New `CLAUDE_CODE_SUBAGENT_MODEL_FORCE` (v2.1.257) forces every subagent onto one model regardless of frontmatter. New hook events `PreModelSwitch`/`PostModelSwitch` (v2.1.251) let you gate model switches. New `--restricted` CLI flag (v2.1.248) strips code-running tools and refuses `bypassPermissions` for locked-down sessions; `bypassPermissions` itself can no longer be set from project/local settings as of v2.1.257 (user/managed only, or `--permission-mode`). Claude Fable 5.1 (`claude-fable-5-1`) became the default Fable model (v2.1.257, 1M ctx, $10/$50/Mtok). Subagent memory paths are now concrete: `~/.claude/agent-memory/<agent-name>/` (user), `.claude/agent-memory/<agent-name>/` (project), `.claude/agent-memory-local/<agent-name>/` (local) — this substrate's first documentation of exact paths (was abstract "scope" language before). Skills gained `metadata`/`license`/`compatibility` frontmatter fields tracking the Agent Skills open spec, plus a hard-error restriction: uploads to claude.ai/Skills API only accept 6 spec-legal fields. `/design`, `/design-sync`, `/import [codex|gemini]`, `/claude-api cost-optimize`, `/list-agents` are new bundled commands. Auto memory now types its notes (`user`/`feedback`/`project`/`reference`) in frontmatter. Changelog fetch for this run was truncated below v2.1.232 — the v2.1.221–231 band is reconstructed from cross-references in other docs pages, not the primary changelog listing (lower confidence, flagged for re-fetch).

**Convergence:** n/a — single-domain tier-1 official docs scope, no cross-source convergence check applicable (see prior run note)

**Quiet:** none — all 8 sources returned content

**Feed flags:** claude-code-changelog (full listing exceeded single-fetch capture below v2.1.232; re-fetch with pagination next run for full v2.1.221–231 detail)

**Manual-check:** none

---

## 2026-08-01

**Lead:** Claude Sonnet 5 (v2.1.197, June 30) and Claude Opus 5 (v2.1.219, July 24) are live — Sonnet 5 is the current default with 1M context; Opus 5 replaces the default Opus model. Sub-agents now run in the background by default (v2.1.198) with a cap of 20 concurrent / 200 per session; nested subagent spawning is re-enabled to depth 3 (v2.1.219 reversed v2.1.217's disable). Skills gained `background`, `context: fork`, and full `yes/no/on/off/1/0` boolean support in frontmatter (v2.1.218); `context: fork` skills run in the background by default since v2.1.218. Permission mode default changed to "Manual" (v2.1.200); `AskUserQuestion` no longer auto-continues; sandbox hardened with `sandbox.network.strictAllowlist` (v2.1.219) and `sandbox.filesystem.disabled` (v2.1.216). Settings schema substantially expanded: `availableModels`/`enforceAvailableModels`/`fallbackModel`/`advisorModel`/`effortLevel`/`alwaysThinkingEnabled`/`fastMode` added; `claudeMd` key enables org-wide CLAUDE.md inline in managed-settings.json; 5-tier scope precedence fully documented. Auto memory enhanced: YAML frontmatter and HTML comments no longer count toward the 200-line/25KB MEMORY.md load limit (v2.1.211), and a `modified` ISO timestamp is written on every memory-file write (v2.1.214). `/verify` and `/code-review` no longer auto-invoked by Claude (v2.1.215). Changelog freshness anchor: v2.1.220 (July 25, 2026).

**Convergence:** none in window (first run — no prior substrates)

**Quiet:** none — all 8 sources returned content

**Feed flags:** none

**Manual-check:** none

---

<!-- older runs appended below this line, newest first -->
