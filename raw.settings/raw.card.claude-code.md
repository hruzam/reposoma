---
card: card.claude-code
brand: Anthropic — Claude Code (CLI)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-16
half_life: ~2-4 weeks (ships ~10 versions/month)
half_life_days: 21
recheck:
  - https://code.claude.com/docs/en/changelog        # generated from repo CHANGELOG.md
  - https://github.com/anthropics/claude-code
  - https://code.claude.com/docs/en/claude-directory
verify_cmd: claude --version
model_floor: claude-sonnet-5   # CONFIRM current string via changelog; do NOT hardcode dated strings
---

# Claude Code — native build surface

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
   - `/agents` wizard removed v2.1.198. `/agents` command still opens the management TUI (Running/Library tabs), but creation wizard is gone.
   - Nested spawning up to **5 levels deep** (v2.1.172). **In-session subagent fork = `/subtask`** (inherits the ENTIRE parent conversation; reuses parent prompt-cache on first call; one level only; enable `CLAUDE_CODE_FORK_SUBAGENT=1`). ⚠ **NAME SWAP at v2.1.212:** `/fork` USED to be this subagent fork; it is now a *background SESSION copy* (see "Session fork / branch / rewind" below). Old tutorials have `/fork`↔`/subtask` backwards.
2. **Skill** (on-demand expertise) — `<.claude|~/.claude>/skills/<name>/SKILL.md`  (Agent Skills open standard)
   - Slash commands MERGED into skills: `.claude/commands/x.md` and `skills/x/SKILL.md` both create `/x`.
   - Auto-loads when description matches, or invoked as `/x`. `/reload-skills` re-scans skill dirs without restart (v2.1.152).
3. **Hook** (determinism) — in `settings.json` under `hooks`. Shell command on a lifecycle event (model can't skip).
4. **MCP** (capability) — `<repo>/.mcp.json` (project) or `claude mcp add` (user/project/local scope).
   - `claude mcp login <name>` / `logout <name>` — CLI auth without interactive menu; `--no-browser` for SSH (v2.1.186).
5. **Plugin** (packaging unit for a complex build) — bundles all of the above:
   `.claude-plugin/plugin.json` + skills/ + agents/ + commands/ + hooks/hooks.json + .mcp.json + bin/ (on PATH) + settings.json + output-styles/
   - Local test: `claude --plugin-dir <path>` (no global install; accepts .zip). Scaffold: `claude plugin init <name>` (v2.1.157).

## Settings hierarchy
`~/.claude/settings.json` (global) → `<repo>/.claude/settings.json` (team) → `settings.local.json` (personal, gitignored). Hooks + permissions live here.
Precedence (high→low): Managed → CLI args → Local → Project → User.

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
- **CLAUDE.md cap:** 200 lines per-file (soft, adherence degrades — no hard truncation). All files concatenate; cumulative load degrades proportionally. Official mitigation: `.claude/rules/<name>.md` with `paths:` frontmatter for path-scoped loading. CLAUDE.md length warning now **scales with model context window** (v2.1.169).
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

## Hooks — events (updated 2026-07-16); the ones you'll use
PostToolUse(Edit|Write)=format/lint · PreToolUse(Bash)=deny rm -rf/sudo · PreToolUse(Edit|Write)=scope-leash ·
SessionStart=inject context · SessionEnd=journal · UserPromptSubmit=enrich prompt · Stop/StopFailure=gate "done" ·
SubagentStart/Stop · TeammateIdle=lifecycle · PreCompact=backup transcript · PostCompact · PermissionRequest=auto-approve ·
Notification=Slack · TaskCreated/TaskCompleted · WorktreeCreate/WorktreeRemove · MessageDisplay ·
PostToolBatch · PostToolUseFailure · UserPromptExpansion · InstructionsLoaded · ConfigChange ·
CwdChanged · FileChanged · PermissionDenied · Elicitation/ElicitationResult · Setup · StopFailure.

Exit 0 = proceed; exit 2 = block. stdout injected as context only for UserPromptSubmit / UserPromptExpansion / SessionStart.

**Handler types (5):** `command` · `http` · `mcp_tool` · `prompt` · `agent` (experimental — spawns subagent as hook handler).

**BREAKING (v2.1.139):** `/dev/tty` no longer accessible from command hooks on macOS/Linux.
Use `terminalSequence` field instead (requires v2.1.141+).

**New env vars in hooks:** `CLAUDE_EFFORT` · `CLAUDE_CODE_SESSION_ID` (stdio MCP servers also receive these).

## Permission rules — key syntax (updated 2026-07-16)
- `permissions.allow|deny|ask` in `settings.json`. Deny-first is the safe default.
- Standard: `Tool(name)`, `Bash(npm run *)`, `Read(/path/**)`, `Write(src/**)`.
- **New (v2.1.178): `Tool(param:value)` parameter matching** — e.g., `Agent(model:opus)` blocks Opus subagents, `Agent(type:researcher)` blocks by type. WebFetch domain wildcards: `domain:*.example.com` (v2.1.172).
- **Destructive git now blocked by default** (v2.1.183): `git reset --hard`, `git checkout -- .`, `git clean -fd`, `git stash drop`, `git commit --amend` (when not agent-authored this session).
- `terraform destroy` / `pulumi destroy` / `cdk destroy` blocked unless specific stack requested (v2.1.183).
- **`sandbox.credentials` setting** — block sandboxed commands from reading credential files and secret env vars (v2.1.187).
- **v2.1.210 warning:** `Write()`, `NotebookEdit()`, `Glob()` permission rules now emit startup warnings — use `Edit()` or `Read()` instead.
- **Auto mode:** GA on Bedrock/Vertex/Foundry; classifier defaults to Sonnet 5 for external sessions (v2.1.210).

## Claude Code Artifacts (launched Jun 18, 2026)
A session's output becomes a self-contained HTML page published to a private URL on claude.ai, updating
in place as the session continues. Available on Team/Enterprise (launched) and Pro/Max (expanded July 2026).
16 MB cap. All CSS/JS inlined. Cannot call external APIs or serve multiple routes. Public sharing
off by default on Team/Enterprise — Owner must enable external sharing. See `code.claude.com/docs/en/artifacts`.

## Session fork / branch / rewind / navigation (added 2026-08-05)
`full study + Codex comparison: raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md`

**The fork family — mind the v2.1.212 pivot:**
| Command | Kind | Behaviour |
|---|---|---|
| `/branch [name]` | SESSION fork, same process | Copies transcript to this point, switches running process to the copy; original stays in picker. **Carries** in-session "allow" grants + in-flight bg subagents. |
| `claude --continue --fork-session` | SESSION fork, new process | Flag form of `/branch` but fresh process — **grants do NOT carry, re-approve.** |
| `/fork` (v2.1.212+) | SESSION fork → background | Copies conversation into a **new independent background session** (own row in `claude agents`), own git worktree under `.claude/worktrees/`. Refuses to fork sessions launched w/ replaced system-prompt or `--tools` allowlist. Requires agent-view on. |
| `/subtask <task>` | SUBAGENT fork, in-session | (see primitive #1) — the old pre-2.1.212 `/fork`. |

**Resume / navigate:** `-c`/`--continue` (most recent in cwd) · `--resume`/`-r` (picker; or `<name-or-id>`) · `--from-pr <n>` · `/resume`. Name with `-n`/`--name`/`/rename` (auto-title is NOT a resume handle). Picker keys: Ctrl+A all projects · Ctrl+W all worktrees · Ctrl+B current branch · paste PR-URL to search. **Resume restores** history/model/agent/permission-mode (except plan/bypass); **does NOT restore** bg tasks, `--mcp-config`, `--settings`, `--plugin-dir`, `--fallback-model`, `--add-dir` — re-pass these.

**Rewind / checkpoints:** `/rewind` or **Esc-Esc on EMPTY input** (Esc-Esc with text = wipes draft — recover via Up). Snapshots code before every prompt, auto; 100 most recent, 30-day (`cleanupPeriodDays`). Menu: restore code/conversation/both · summarize from/up-to. ⚠ **NOT tracked: bash-tool file changes, subagent edits, symlinks** — and fails even in-scope on multi-file (#70727/#18516). **Git stays source of truth; `/rewind` is best-effort undo, not reliable restore.** (Note: `fileCheckpointingEnabled` from older notes does NOT verify against live docs — checkpointing documented as unconditional.)

**Transcripts on disk:** `~/.claude/projects/<project-slug>/<session-id>.jsonl` (subagents nest at `.../<sessionId>/subagents/agent-<id>.jsonl`). `~/.claude/sessions/` is NOT a real path. Format internal — use `/export` or `-p --output-format json`, don't parse.

**Footguns (watch):** forks can vanish from `/resume` (#23692 closed not-planned, #27339, #48270 stale-branch); resume of a long thinking-heavy session replays ~156k tok incl. ~25% invisible thinking-signatures (#42260, not-planned) — **fresh+brief beats resume for a context PIVOT; resume/continue wins for continuous same-file work.**

## VOLATILE / watch (updated 2026-07-16)
- **Latest version: v2.1.210** (July 14, 2026). Changelog at `code.claude.com/docs/en/changelog`.
- **Sonnet 5 is default** (v2.1.197, released 2026-06-30). Model strings rotate fast — never hardcode dated strings; set a floor.
- **v2.1.210:** live elapsed-time counter on collapsed tool summaries; startup warnings for Write()/NotebookEdit()/Glob() permission rules; fixed `isolation: 'worktree'` subagents mutating main repo; fixed `ultracode` keyword firing on non-human input (webhooks, PR comments).
- **v2.1.208:** screen reader mode (`--ax-screen-reader` or `CLAUDE_AX_SCREEN_READER=1` or `"axScreenReader": true`); `vimInsertModeRemaps` setting; `CLAUDE_CODE_PROCESS_WRAPPER` env var for corporate launchers; background agent reply queuing on delivery failure; memory leak fixes (MCP stderr, LSP docs, async hook output).
- **Explore agent model changed (v2.1.198):** now inherits main session model (capped at Opus) — was Haiku. Exploration passes are no longer Haiku-cheap; factor into context budgets.
- **`/agents` wizard removed (v2.1.198):** create/manage subagents by asking Claude or editing `.claude/agents/` files directly.
- **`ultracode` keyword (v2.1.160):** replaces `workflow` as the trigger word. "workflow" no longer triggers.
- Moving fast: background sessions (Ctrl+T pin), `--fallback-model`, `--bg --exec <cmd>`, implicit agent teams.

## Rate caps & fallback strategy (2026-07-16)

**Current status:** Good rate — ceiling not a day-to-day constraint. Token spend
can be used aggressively for big-brain tasks.

**Model tier as of 2026-07-16:**
Mythos 5 (vetted partners only) > Fable 5 (`claude-fable-5` / alias `"fable"`) > Opus 4.8 > **Sonnet 5** (default; alias `"sonnet"`) > Sonnet 4.6 (legacy) > Haiku 4.5.
Sonnet 5 promotional pricing: $2/$10 per Mtok through 2026-08-31.

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

**advisorModel alias:** `"fable"` works from Claude Code v2.1.170+. Use full ID
`claude-fable-5` on older installs.

## Recommendation for LARVA
Thin agent shells; specialization in portable skills; model floor in ONE place per agent; pack a project
bundle (FO, freya) as a plugin only once stable. Sync `~/.claude` via CLAUDE_CONFIG_DIR → my-env-sync.
