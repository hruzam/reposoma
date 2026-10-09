---
card: card.claude-code
brand: Anthropic — Claude Code (CLI)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~1-3 weeks (ships ~1 version/day — cadence roughly tripled since July)
half_life_days: 14
recheck:
  - https://code.claude.com/docs/en/changelog        # generated from repo CHANGELOG.md
  - https://github.com/anthropics/claude-code
  - https://code.claude.com/docs/en/claude-directory
verify_cmd: claude --version
model_floor: claude-sonnet-5   # confirmed 2026-09-02 via github.com/anthropics/claude-code changelog (still the CLI's non-Max default; Opus 5 is default for Max-subscriber sessions specifically — see Refresh delta) | 2026-10-08: API defaults now claude-opus-5-5 / claude-sonnet-5-5 / claude-haiku-5-5 (see Refresh delta 2026-10-08); floor value itself unchanged
corpus:
  fork_branch_study: raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md
  # ^ source corpus for §Session fork / branch / rewind; cards carry the bond, the corpus carries the argument
---

# Claude Code — native build surface

## Refresh delta 2026-10-08
_Since last verify 2026-09-02 (card was at v2.1.258). Source: `code.claude.com/docs/en/changelog`, live-fetched 2026-10-08 by @Epoch. Itemized v2.1.259–2.1.293 across two passes (v2.1.262 and v2.1.264 absent from the fetched excerpt; v2.1.279 block only partly visible, items marked "likely"). Local `claude --version` not re-run — upstream latest ≠ local truth._
- **Latest upstream v2.1.293** (Oct 7, 2026); ~35 releases in 36 days, ~1/day cadence holds. H
- **New models:** Opus 5.5 `claude-opus-5-5` (v2.1.280, Sep 22; default Opus; 1M ctx; $4/$20 per Mtok, $0.20 cache reads) · Sonnet 5.5 `claude-sonnet-5-5` (v2.1.284, Sep 28; default Sonnet on API; 1M; $2/$10; cache reads $0.20 per changelog, but OpenRouter lists $0.10 (cache write $2.50) on every provider — unresolved) · Haiku 5.5 `claude-haiku-5-5` (v2.1.293, Oct 7; default Haiku on API; 1M; $0.10/$0.50, $0.50/$2.50 for prompts >100K). H per changelog. Source conflict: a web search of ~Sep 28 said Haiku 5.5 "coming weeks"/unconfirmed — changelog is newer + primary, trusted. Opus 5.5 date corroborated by trade press (M).
- **Auto mode:** interactive + VS Code sessions with no configured mode now START IN AUTO MODE on every plan/provider (v2.1.284; `permissions.defaultMode` overrides). Classifier ignores an `ANTHROPIC_DEFAULT_SONNET_MODEL` pin to 5.5 and uses Sonnet 5 (v2.1.288). Server-side classifier default on direct API with telemetry off; `CLAUDE_CODE_AUTO_MODE_SERVER=0` opts out (v2.1.282).
- **Hooks (watch):** PreToolUse and PermissionRequest hooks now BLOCK the call when matcher evaluation fails (was: skipped) — fail-closed (v2.1.288); relevant to whitelist/leash hooks. TeammateIdle no longer fires from subagents (v2.1.290). Elicitation/ElicitationResult `{"decision":"block"}` now declines (v2.1.284).
- **New primitive: Claude Mods** (v2.1.287) — plugins modifying deeper behavior; surface seen: `$.tool.register`, `$.model.complete`, `$.agent.spawn`/`$.agent.list()`, `$.ui.selection()`, `prompt.autocomplete` event; built-in `cc-plugin-you-should-know@builtin`. Details thin — CONFIDENCE M; read docs before building on it.
- **Permissions:** `rm` on command-substitution output prompts even with an allow rule (v2.1.281); dangerous `rm` in skip-permissions/auto waits 2 min then denies; writes through symlinks judged by real destination; Bash prompts before `pyright` (v2.1.290).
- **Settings/env:** `attribution:false` (281) · managed `availableModelsMatch:"exact"` + `deniedModels` (283) · managed `allowedProviders` (285) · `CLAUDE_CODE_DISABLE_WEB_FETCH` (285) · `CLAUDE_CODE_WEB_SEARCH_REFILLS_PER_HOUR` (100/hr default, 290) · `CLAUDE_CODE_DISABLE_STRUCTURED_OUTPUTS` (288) · `CLAUDE_CODE_OVERLOADED_RETRY_BASE_DELAY_MS` (292) · `CLAUDE_CODE_MAX_MCP_DESCRIPTION_LENGTH` (280; cap 2048) · OTel/telemetry vars in project settings ignored (282) · `CLAUDE_CODE_DISABLE_ATTACHMENTS` no longer settable from repo settings (290).
- **Commands/flags:** `/doctor prompt-audit` (283) · `/effort ultracode [on|off]`, `/rate-limit-options`, `/mcp reconnect all` (284) · `claude --desktop`, `claude plugin configure`, `claude plugin install --config|--marketplace` (285/292) · `claude purge` (renamed from `claude project purge`, 288) · `claude attach|logs <partial-name>` (290) · `--bare` now connects only CLI-named MCP servers, no reminders/bg tasks (286) · Agent tool gained `effort` param, agent names ≤256 chars (292).
- **Removed/namespace:** skill folders in `anthropic-skills` / `claude-ai` namespaces no longer load locally (v2.1.282).
- **MCP:** stdio servers negotiate protocol 2026-07-28 by default, opt-out `MCP_PROTOCOL_NEGOTIATION=legacy` (292) · tool names >128 chars excluded (292) · `alwaysLoad:false` defers all of a server's tools behind tool search (287).
- **Not re-verified:** Mythos 5/5.1 access status (absent from anthropic.com/news, L); headless `model: fable` pin behavior. Fable 5.1 confirmed in `/model` picker (v2.1.260) and in OpenRouter catalog (created 2026-09-01, M); anthropic.com/news (Sep 22) says Opus 5.5 performs at Fable 5.1 level on most work at 40% lower cost than Opus 5, Sonnet 5.5 ~30% faster and up to 30% cheaper for most work (H).
- **Corrections found 2026-10-08 (sub-agents docs, live, H):** nesting default is 3 layers, not 5 (see primitive #1, fixed). Subagent results are framed/indented as subagent output (v2.1.277); `TaskOutput` removed (use `Read` on the task output file). Pro/Team Standard default model changed Sonnet→Opus (v2.1.279, "likely" — block partially visible). v2.1.259–267 now itemized in the next bullet.
- **v2.1.259–267 (Sep 2–9), H:** 259 — managed `managedMcpServers` (outranks local/project/user/plugin/connector; entries naming a command skipped), `allowedMcpServers` now governs only user-added servers, `--permission-prompts none` (auto-deny anything that would prompt, for unattended hosts), unparseable managed settings now STOP startup, skill/command frontmatter `model:` works interactively, `/claude-api build-eval|hillclimb` · 260 — Fable 5.1 in `/model`, text `/advisor` in -p/SDK, parentheses in permission paths, invalid rules like `Bash(ls) x` reported as settings errors · 261 — `bashOutputMaxChars`/`taskOutputMaxChars` (taskOutputMaxChars later made inert in 277), `--append-subagent-system-prompt-file`, `/skill-doctor` (skills docs tag it v2.1.252+; changelog lists it in 261 — minor source conflict) · 265 — `--plugin-dir` accepts a folder of plugins, http MCP falls back to legacy SSE, `forceLoginGatewayUrl` · 266 — hotfix: `CLAUDE_CODE_USE_GATEWAY` ignored unless `ANTHROPIC_BASE_URL`+`ANTHROPIC_AUTH_TOKEN` set · 267 — `maxEffortLevel` setting (all providers), `--system-prompt-snapshot off`, `effort:` frontmatter now works on Opus 4.7/4.8/Fable 5, `StopFailure` matcher `cloud_credential_error`.
- **Hooks reference (docs, live 2026-10-08, H; first 100K of 250K chars read):** 33 events — adds `DirectoryAdded` (missing from this card's list, fixed). Exit 2 is NOT honored for `PermissionRequest`; `http` hooks are non-blocking on non-2xx/connection errors; unparseable stdout is a non-blocking error (v2.1.248); `prompt` hook default timeout 30s, `agent` hook 60s (experimental); SessionStart on resume/fork carries `seconds_since_last_response`, `context_tokens`, `prompt_cache_likely_expired`, `estimated_cache_write_usd` (v2.1.251); `scratchpad_dir` input field (v2.1.257); `Edit(src/**)` matches only top-level `src` — use `**/src/**` (v2.1.214). The fail-closed matcher section of the page was in the unread part; v2.1.288 changelog is the source for that claim.
- **MCP docs (live, H):** v2 runtime (SDK 2.0, protocol 2026-07-28) default in sessions that do not fetch feature flags — Bedrock/Vertex/Foundry/apps-gateway/telemetry-off (v2.1.274); override `MCP_SDK_GENERATION=v1|v2`, `MCP_PROTOCOL_NEGOTIATION=auto|legacy`. Same-name precedence local > project > user > plugin > connector (not merged for the same name); `managedMcpServers` ranks above all (v2.1.259). `claude mcp add --transport http` falls back to SSE (v2.1.265); `/mcp` shows `${VAR}` by name (v2.1.268); `/mcp reconnect all` (v2.1.284). Wording check: this card's MCP-scope section says scopes are "merged (additive)" — true for DIFFERENT servers, not for same-named ones.
- **Skills docs (live, H):** description+`when_to_use` truncated at 1,536 chars; frontmatter adds `arguments`, `disallowed-tools`, `paths`, `shell`, `model`, `effort`; forked skills background by default (v2.1.218+); claude.ai skills sync to `~/.claude/skills/synced/` (~10 min active / ~40 min idle; `syncClaudeAiSkills:false`; `CLAUDE_CODE_SYNC_SKILLS=1` for -p); claude.ai uploads accept only name, description, license, compatibility, metadata, allowed-tools; skills named `verify` or `simplify` run before each commit (v2.1.286).
- **Memory / settings / commands docs (pass 3, live 2026-10-08, H):** `AGENTS.md` is read natively since v2.1.277 only when no `CLAUDE.md`/`CLAUDE.local.md` exists at or above the working dir; setting `instructionFiles` = `claude-md-or-agents-md` (default) | `claude-md-and-agents-md` | `claude-md` | `managed-only` (user/`--settings`/managed only; plugin id `cc-plugin-agents-md@builtin`). CLAUDE.md >4 MiB is skipped; combined-size warning exists. `permissions.defaultMode` values `auto` and `bypassPermissions` are honored only from user/managed settings or `--permission-mode` (ignored in project/local). `/agents` only prints a reminder; `/fork` = background session copy, `/subtask` = forked subagent, `/branch` = in-place branch (all v2.1.212+). Removed: `/pr-comments`, `/vim`, `/ultraplan`. New since the card's last pass: `/workflow-authoring` (248), `/skill-doctor` (252), `/design` + `/slides` (265), `/output-style` (269), `/doctor prompt-audit` (283), `/plugin-authoring` (287). Remote Control: Trusted Devices is beta on Pro/Max/Team/Enterprise; server mode gives up after ~10 min offline.

## Refresh delta 2026-09-02
_Since last verify 2026-07-16 (card was at v2.1.210). Sources: `code.claude.com/docs/en/changelog`,
`github.com/anthropics/claude-code/releases` (both live-fetched 2026-09-02) unless noted._
- **Local truth confirmed:** `claude --version` → `2.1.258 (Claude Code)`, office machine, 2026-09-02. CONFIDENCE H.
- **Latest version v2.1.258** (Sep 1, 2026), up from v2.1.210 (Jul 14) — 48 releases in 49 days, ~1/day. Prior "~10/month" cadence estimate is stale; `half_life_days` lowered 21→14. CONFIDENCE H.
- **Subagent fork is now DEFAULT** in interactive sessions (v2.1.232, Aug 14) — non-teammate spawns inherit full parent conversation + prompt cache, run backgrounded by default. `CLAUDE_CODE_FORK_SUBAGENT` is now an override, not an opt-in: `1` forces fork-on in headless/`-p`/Agent-SDK (still off there by default), `0` forces fork-off everywhere. Card's old "enable via env var" framing was stale. CONFIDENCE H.
- **Claude Opus 5** released 2026-07-24 ($5/$25 per Mtok, 1M ctx, 128K max output, adaptive thinking default) — becoming default for Claude Max subscribers. Supersedes "Opus 4.8" in the tier list below. CONFIDENCE H (anthropic.com/news/claude-opus-5).
- **Claude Fable 5.1** (`claude-fable-5-1`) landed as default Fable model (v2.1.257, Sep 1) — 1M ctx, $10/$50 per Mtok, $0.25/Mtok cache reads. Un-updated gateways still resolve `fable`/`"best"` to Fable 5. Supersedes Fable 5 at the top of the tier list. CONFIDENCE H.
- **Sonnet 5 promo pricing ($2/$10 per Mtok) made PERMANENT** mid-Aug 2026 — the scheduled Sep-1 hike to $3/$15 was cancelled. Card's old "through 2026-08-31" line read as expiring; it isn't. CONFIDENCE M (trade-press aggregation; anthropic.com/news/claude-sonnet-5 not directly re-fetched this pass).
- New hook events **PreModelSwitch / PostModelSwitch** (v2.1.251, Aug 28) — block/confirm/annotate a model switch. CONFIDENCE H.
- **`--restricted` CLI mode** added (v2.1.248, Aug 27) — limits tools/permissions for a session. CONFIDENCE H.
- **Auto mode: Containment Escape rule** added (v2.1.257, Sep 1) — cloud-metadata fetches, egress evasion, cross-tenant reach now require approval even under auto mode. CONFIDENCE H.
- Bash **`[[ ]]` conditional auto-approval removed** (v2.1.257) — now prompts like any other Bash command (closes a permission-bypass footgun). CONFIDENCE H.
- Cross-session **`@`-mention messaging** added (v2.1.232, Aug 14). CONFIDENCE H.
- `/permissions` gained an **Auto mode tab** for classifier rules (v2.1.246-247, Aug 25-26). CONFIDENCE H.
- Linux x64 build shrunk ~4.5x (~75MB), lower per-session memory (weeks 32-33, early Aug) — perf note, not a behavior change. CONFIDENCE M (release-digest source, not primary changelog).
- Model-tier list is a partial re-verify — Opus 5 and Fable 5.1 confirmed live; **Mythos 5** status not re-checked this pass. CONFIDENCE L on the Mythos line specifically.

## Config homes (NOT XDG)
- User/global: `~/.claude/`        → applies to all projects (personal config).
- Project:     `<repo>/.claude/`   → commit to git; shared with team.
- Relocate all: `CLAUDE_CONFIG_DIR=<path>` → every `~/.claude` path moves under it. ← my-env-sync lever.
- Binary: `~/.local/bin/claude` (XDG). Config is NOT — `~/.config/claude/...` is NOT read.

## The five native primitives
1. **Subagent** (identity / master prompt) — `<.claude|~/.claude>/agents/<name>.md`
   - YAML frontmatter: name, description, model, tools, color, optional hooks/memory. Body = system prompt.
   - Resolution precedence: session > project > user > plugin.
   - Invoked via the Agent tool (renamed from Task in v2.1.63; `Task(...)` aliases still work); own context window; returns a summary.
   - `background: true`, `maxTurns: N`. **Manage: ask Claude to create/edit, or edit `.claude/agents/*.md` directly.**
   - `/agents` wizard removed v2.1.198. `/agents` command still opens the management TUI (Running/Library tabs), creation wizard gone; now also shows agent model + effort level per subagent (v2.1.243).
   - Nested spawning defaults to **3 levels deep** (v2.1.219; was 5 in v2.1.172–216, 1 in v2.1.217–218; `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`, `1` disables; 20 concurrent cap via `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`). **`subagent_type: "fork"` = in-session fork, now DEFAULT for non-teammate spawns in interactive sessions (v2.1.232)** — inherits the ENTIRE parent conversation, reuses parent prompt-cache; runs backgrounded by default. Off by default in headless/`-p`/Agent-SDK; `CLAUDE_CODE_FORK_SUBAGENT=1` forces it on there, `=0` forces it off anywhere. ⚠ **NAME SWAP at v2.1.212 still holds:** `/fork` is a *background SESSION copy* (see "Session fork / branch / rewind"), NOT the subagent fork — that's `/subtask` / `subagent_type: "fork"`. Old tutorials have these backwards.
2. **Skill** (on-demand expertise) — `<.claude|~/.claude>/skills/<name>/SKILL.md`  (Agent Skills open standard)
   - Slash commands MERGED into skills: `.claude/commands/x.md` and `skills/x/SKILL.md` both create `/x`.
   - Auto-loads when description matches, or invoked as `/x`. `/reload-skills` re-scans skill dirs without restart (v2.1.152).
3. **Hook** (determinism) — in `settings.json` under `hooks`. Shell command on a lifecycle event (model can't skip).
4. **MCP** (capability) — `<repo>/.mcp.json` (project) or `claude mcp add` (user/project/local scope).
   - `claude mcp login <name>` / `logout <name>` — CLI auth without interactive menu; `--no-browser` for SSH (v2.1.186).
   - Project `.mcp.json` `headersHelper` and inline MCP servers now require trust-dialog approval (v2.1.238).
5. **Plugin** (packaging unit for a complex build) — bundles all of the above:
   `.claude-plugin/plugin.json` + skills/ + agents/ + commands/ + hooks/hooks.json + .mcp.json + bin/ (on PATH) + settings.json + output-styles/
   - Local test: `claude --plugin-dir <path>` (no global install; accepts .zip). Scaffold: `claude plugin init <name>` (v2.1.157).

## Settings hierarchy
`~/.claude/settings.json` (global) → `<repo>/.claude/settings.json` (team) → `settings.local.json` (personal, gitignored). Hooks + permissions live here.
Precedence (high→low): Managed → CLI args → Local → Project → User.
**New (v2.1.251):** managed settings now require org approval for settings that terminate sandbox TLS, route sandbox traffic through a proxy, inject credentials, weaken sandbox isolation, or set credential/org/routing headers via `ANTHROPIC_CUSTOM_HEADERS`.

## MCP scope (`.mcp.json`)
All applicable scopes are **merged** at session start (additive, not override):

| Scope | File | Notes |
|-------|------|-------|
| Managed (org-wide) | `managed-mcp.json` (system dir) | highest trust |
| User (global) | `~/.claude.json` | all projects |
| Project (team) | `<repo>/.mcp.json` | **repo root** — NOT inside `.claude/`; commit to git |
| Local (per-project) | `~/.claude.json` per-project key | `claude mcp add --scope local`; not committed |

Scope perspective mirrors agents/settings: CWD at session start determines which project `.mcp.json` loads.
`CLAUDE_CONFIG_DIR` relocates `~/.claude/` paths but does NOT move `<repo>/.mcp.json` (repo-rooted) or `~/.claude.json` (user MCP store).

## Always-on context (the "circle" at invocation)
AGENTS.md / CLAUDE.md (always) → subagent body → skills (on-demand) → MCP → hooks.
- CLAUDE.md merge: `~/.claude/CLAUDE.md` + `<repo>/CLAUDE.md` + subdir + `.claude/CLAUDE.md`.
- **AGENTS.md read as fallback** when no CLAUDE.md in a dir → one lean AGENTS.md = cross-tool contract; keep CLAUDE.md thin.
- Budget: ~150-200 instructions reliably followed; system prompt uses ~50 → keep contract < ~300 lines.
- **CLAUDE.md cap:** 200 lines per-file (soft, adherence degrades — no hard truncation). All files concatenate; cumulative load degrades proportionally. Official mitigation: `.claude/rules/<name>.md` with `paths:` frontmatter for path-scoped loading. Length warning scales with model context window (v2.1.169). Markdown `.claude/rules` file as a symlink now refused with an error (v2.1.251).
- **MEMORY.md cap (different system):** hard 200-line / 25KB truncation — content beyond that is NOT loaded. Do not conflate with CLAUDE.md. *(verified 2026-07-02)*
- **Startup context budget** (context-window visualization, code.claude.com/docs/en/context-window):
  System prompt ~4,200 tok · MEMORY.md ~680 tok · Environment info ~280 tok · MCP tool names (deferred) ~120 tok.
  Total overhead before any user content: ~5,300 tokens. MCP full schemas stay deferred via tool search.

## Context loading by scope — agent perspective

**Invariant:** CLAUDE.md/settings.json/.mcp.json loading is **CWD-based, not agent-file-location-based.**
The agent receives whatever context stack was assembled from the working directory at session start.

| Scenario | Agent loads? | CLAUDE.md received | Settings / MCP |
|----------|-------------|-------------------|----------------|
| Global agent (`~/.claude/agents/`) in project folder | Yes — priority 4 | global + project stack | global + project (project overrides) |
| Project agent invoked **outside** its project folder | **No** — not scanned | — | — |
| Project agent in its own project folder | Yes — priority 3, wins over same-name global twin | global + project stack | global + project |

**Exception:** `--agents <JSON>` CLI flag injects any agent spec regardless of CWD (priority 2).
Context received = CWD stack at invocation — NOT the agent's original project.

*Synthesizing agents: read this section when reasoning about what context a subagent actually received,
or why an agent behaved as if it didn't know its home project's rules.*

## Hooks — events (updated 2026-09-02); the ones you'll use
PostToolUse(Edit|Write)=format/lint · PreToolUse(Bash)=deny rm -rf/sudo · PreToolUse(Edit|Write)=scope-leash ·
SessionStart=inject context · SessionEnd=journal · UserPromptSubmit=enrich prompt · Stop/StopFailure=gate "done" ·
SubagentStart/Stop · TeammateIdle=lifecycle · PreCompact=backup transcript · PostCompact · PermissionRequest=auto-approve ·
Notification=Slack (now also fires on permission prompts, v2.1.246) · TaskCreated/TaskCompleted · WorktreeCreate/WorktreeRemove · MessageDisplay ·
PostToolBatch · PostToolUseFailure · UserPromptExpansion · InstructionsLoaded · ConfigChange ·
CwdChanged · FileChanged · DirectoryAdded · PermissionDenied · Elicitation/ElicitationResult · Setup · StopFailure ·
**PreModelSwitch/PostModelSwitch** (v2.1.251, new) = block/confirm/annotate a model switch.

Exit 0 = proceed; exit 2 = block. stdout injected as context only for UserPromptSubmit / UserPromptExpansion / SessionStart.

**Handler types (5):** `command` · `http` · `mcp_tool` · `prompt` · `agent` (experimental — spawns subagent as hook handler).

**BREAKING (v2.1.139):** `/dev/tty` no longer accessible from command hooks on macOS/Linux. Use `terminalSequence` field instead (requires v2.1.141+).

**New env vars in hooks:** `CLAUDE_EFFORT` · `CLAUDE_CODE_SESSION_ID` (stdio MCP servers also receive these).

## Permission rules — key syntax (updated 2026-09-02)
- `permissions.allow|deny|ask` in `settings.json`. Deny-first is the safe default.
- Standard: `Tool(name)`, `Bash(npm run *)`, `Read(/path/**)`, `Write(src/**)`.
- **`Tool(param:value)` parameter matching** (v2.1.178) — e.g., `Agent(model:opus)` blocks Opus subagents, `Agent(type:researcher)` blocks by type. WebFetch domain wildcards: `domain:*.example.com` (v2.1.172).
- **Destructive git now blocked by default** (v2.1.183): `git reset --hard`, `git checkout -- .`, `git clean -fd`, `git stash drop`, `git commit --amend` (when not agent-authored this session).
- `terraform destroy` / `pulumi destroy` / `cdk destroy` blocked unless specific stack requested (v2.1.183).
- **`sandbox.credentials` setting** — block sandboxed commands from reading credential files and secret env vars (v2.1.187).
- **`Write()`, `NotebookEdit()`, `Glob()` permission rules emit startup warnings** (v2.1.210) — use `Edit()` or `Read()` instead.
- **Auto mode:** GA on Bedrock/Vertex/Foundry; classifier defaults to Sonnet 5 for external sessions (v2.1.210). Now has its own tab in `/permissions` (v2.1.246-247). **Containment Escape rule (v2.1.257):** cloud-metadata fetches, egress evasion, cross-tenant reach require approval even under auto mode.
- **`--restricted` CLI flag** (v2.1.248) — launches a session with tools/permissions pre-limited.
- Bash `[[ ]]` conditionals no longer auto-approved (v2.1.257) — now prompt like any other Bash command.

## Claude Code Artifacts (launched Jun 18, 2026)
A session's output becomes a self-contained HTML page published to a private URL on claude.ai, updating
in place as the session continues. Available on Team/Enterprise (launched) and Pro/Max (expanded July 2026).
16 MB cap. All CSS/JS inlined. Cannot call external APIs or serve multiple routes. Public sharing
off by default on Team/Enterprise — Owner must enable external sharing. See `code.claude.com/docs/en/artifacts`.

## Session fork / branch / rewind / navigation (added 2026-08-05)
`corpus → raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md (full study + case studies, updated 2026-08-20)`

**The fork family — mind the v2.1.212 pivot:**
| Command | Kind | Behaviour |
|---|---|---|
| `/branch [name]` | SESSION fork, same process | Copies transcript to this point, switches running process to the copy; original stays in picker. **Carries** in-session "allow" grants + in-flight bg subagents. |
| `claude --continue --fork-session` | SESSION fork, new process | Flag form of `/branch` but fresh process — **grants do NOT carry, re-approve.** |
| `/fork` (v2.1.212+) | SESSION fork → background | Copies conversation into a **new independent background session** (own row in `claude agents`), own git worktree under `.claude/worktrees/`. Now keeps original conversation's prompt cache in the new background session (v2.1.251); fixed starting-empty bug when forking an already-forked session (v2.1.246). Refuses sessions launched w/ replaced system-prompt or `--tools` allowlist. Requires agent-view on. |
| `/subtask <task>` / `subagent_type: "fork"` | SUBAGENT fork, in-session | (see primitive #1) — the old pre-2.1.212 `/fork`. **Default-on for interactive non-teammate spawns since v2.1.232.** |

**Resume / navigate:** `-c`/`--continue` (most recent in cwd) · `--resume`/`-r` (picker; or `<name-or-id>`) · `--from-pr <n>` · `/resume`. Name with `-n`/`--name`/`/rename` (auto-title is NOT a resume handle; sessions now also keep unique `name-word-word` variants, v2.1.232). Picker keys: Ctrl+A all projects · Ctrl+W all worktrees · Ctrl+B current branch · paste PR-URL to search. **Resume restores** history/model/agent/permission-mode (except plan/bypass); **does NOT restore** bg tasks, `--mcp-config`, `--settings`, `--plugin-dir`, `--fallback-model`, `--add-dir` — re-pass these.

**Rewind / checkpoints:** `/rewind` or **Esc-Esc on EMPTY input** (Esc-Esc with text = wipes draft — recover via Up). Snapshots code before every prompt, auto; 100 most recent, 30-day (`cleanupPeriodDays`). Menu: restore code/conversation/both · summarize from/up-to. ⚠ **NOT tracked: bash-tool file changes, subagent edits, symlinks** — and fails even in-scope on multi-file (#70727/#18516). **Git stays source of truth; `/rewind` is best-effort undo, not reliable restore.**

**Transcripts on disk:** `~/.claude/projects/<project-slug>/<session-id>.jsonl` (subagents nest at `.../<sessionId>/subagents/agent-<id>.jsonl`). `~/.claude/sessions/` is NOT a real path. Format internal — use `/export` or `-p --output-format json`, don't parse. Session transcripts no longer silently overwritten on directory relocation (v2.1.251).

**Footguns (watch):** forks can vanish from `/resume` (#23692 closed not-planned, #27339, #48270 stale-branch); resume of a long thinking-heavy session replays ~156k tok incl. ~25% invisible thinking-signatures (#42260, not-planned) — **fresh+brief beats resume for a context PIVOT; resume/continue wins for continuous same-file work.**

## VOLATILE / watch (updated 2026-09-02)
- **Latest version: v2.1.293** (Oct 7, 2026). Changelog at `code.claude.com/docs/en/changelog`. Release cadence roughly tripled vs. mid-July (~1/day now vs ~10/month then) — treat this card's half_life as short.
- **Sonnet 5 is the CLI's non-Max default** (v2.1.197, released 2026-06-30); model strings rotate fast — never hardcode dated strings, set a floor. **Claude Opus 5** (released 2026-07-24) is now default for Max-subscriber sessions. **Claude Fable 5.1** (`claude-fable-5-1`, v2.1.257) is now the default Fable-tier model. **As of 2026-10-08:** API defaults are Opus 5.5 (`claude-opus-5-5`), Sonnet 5.5 (`claude-sonnet-5-5`), Haiku 5.5 (`claude-haiku-5-5`) — see Refresh delta 2026-10-08.
- **v2.1.257 (Sep 1):** Fable 5.1 added as default Fable model; time-format settings (12/24h, UTC, strftime); Containment Escape rule in auto mode; `[[ ]]` Bash auto-approval removed; 100+ fixes.
- **v2.1.251 (Aug 28):** PreModelSwitch/PostModelSwitch hooks; managed-settings approval gate for sandbox/credential-weakening settings; spend-limit bar in `/usage`; per-session prompt-cache line in `/cost`; `/fork` keeps prompt cache.
- **v2.1.248 (Aug 27):** `--restricted` mode; `experimental.cacheTtl` for agent-level prompt-cache TTL; self-hosted runner `--client-label`.
- **v2.1.232 (Aug 14):** subagent fork DEFAULT-ON for interactive non-teammate spawns; cross-session `@`-mention messaging; nested git repos no longer inherit trust from parent.
- **Explore agent model (v2.1.198, still current):** inherits main session model (capped at Opus) — was Haiku. Exploration passes are no longer Haiku-cheap; factor into context budgets.
- **`/agents` wizard removed (v2.1.198):** create/manage subagents by asking Claude or editing `.claude/agents/` files directly; TUI now also shows model + effort per subagent (v2.1.243).
- **`ultracode` keyword (v2.1.160):** replaces `workflow` as the trigger word. "workflow" no longer triggers.
- Moving fast: background sessions (Ctrl+T pin), `--fallback-model`, `--bg --exec <cmd>`, implicit agent teams, `/schedule` routines.

## Rate caps & fallback strategy (2026-10-08)

**Current status:** Good rate — ceiling not a day-to-day constraint. Token spend can be used aggressively for big-brain tasks.

**Model tier as of 2026-10-08 (partial re-verify — Fable/Mythos not re-checked):**
Mythos 5 (vetted partners only, unconfirmed this pass) > Fable 5.1 (`claude-fable-5-1`, default Fable — v2.1.257) > Opus 5.5 (`claude-opus-5-5`, default Opus) > Sonnet 5.5 (`claude-sonnet-5-5`, default Sonnet) > Opus 5 / Sonnet 5 (prior gen) > Haiku 5.5 (`claude-haiku-5-5`) > Haiku 4.5 (legacy).
Sonnet 5 pricing $2/$10 per Mtok is now **permanent** (scheduled Sep-1 hike to $3/$15 cancelled mid-Aug 2026 — CONFIDENCE M, reverify next cycle). Fable 5.1: $10/$50 per Mtok, $0.25/Mtok cache reads. Opus 5: $5/$25; **Opus 5.5: $4/$20** ($0.20 cache reads); Sonnet 5.5: $2/$10; Haiku 5.5: $0.10/$0.50.

**Fallback ladder when Fable ceiling is hit:**
- Houston (planning loops) → route to Janus (Opus)
- Agol (continuous synthesis) → route to Janus (Opus)
- Janus (deliberation) → already Opus; no lower fallback needed
- Epoch (research) → stays Sonnet 5; not Fable-tier
- Trajectory (implementation) → stays Sonnet 5; not Fable-tier

**Practical rule:** same agent body, lower model tier. The agent's prompt does not
change when falling back — only the `model:` override changes at spawn time.

**Tokenizer note (from Opus 4.7+):** same text produces ~30% more tokens vs
pre-4.7 models. Recalibrate any hardcoded token budgets in prompts.

**`fallbackModel` setting** (`["sonnet", "haiku"]`) handles model *unavailability*,
not rate limits — these are separate concerns. Rate-limit fallback is operational
routing, not a settings.json field.

**advisorModel alias:** `"fable"` resolves to Fable 5.1 where gateways are updated (v2.1.257+),
else falls back to Fable 5. Works from Claude Code v2.1.170+; use full ID `claude-fable-5-1`
(or `claude-fable-5` on older gateways) where precision matters.

## Recommendation for LARVA
Thin agent shells; specialization in portable skills; model floor in ONE place per agent; pack a project
bundle (FO, freya) as a plugin only once stable. Sync `~/.claude` via CLAUDE_CONFIG_DIR → my-env-sync.
