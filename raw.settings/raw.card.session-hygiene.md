---
card: card.session-hygiene
brand: Cross-tool — Claude Code CLI · Cursor IDE · Gemini CLI (session hygiene + token distro)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~3-4 weeks (Claude Code ships ~daily; Cursor mechanics underdocumented; numbers shift on each release)
half_life_days: 28
recheck:
  - https://code.claude.com/docs/en/sub-agents          # Claude Code — subagent isolation mechanics
  - https://code.claude.com/docs/en/context-window      # Claude Code — context window visualization
  - https://geminicli.com/docs/core/subagents/          # Gemini CLI — subagent docs (standard since 2026-08; enterprise track only — individuals moved to agy)
  - https://github.com/google-gemini/gemini-cli/issues/8609  # known model-switch crash bug
  - https://cursor.com/changelog                         # Cursor — most opaque; changelog is primary signal
  - https://code.claude.com/docs/en/prompt-caching   # Claude Code — cache TTL, fork/subagent cache sharing
  - https://code.claude.com/docs/en/model-config  # Claude Code — 1M context, auto-compact window
# companion cards: card.claude-code · card.cursor-ide · card.gemini-cli
# relate-to-canon: canon.context-economy (gate-shape + scoped delegation) · canon.cost-gradient (spend by demand)
---

# Session hygiene — token distro and context isolation across tools

## Refresh delta 2026-11-25

_PARTIAL: Cursor changelog page 1 only (entries Oct 6-13 unseen); Cursor mechanics, third-party figures, remote-control/Trusted Devices, /rewind and Codex-fork rows NOT re-checked. Run by @Epoch's sibling for this one card, NOT the `/refresh session-hygiene` pipeline (no substrate written). Confidence: H = live official docs page via summariser; M = changelog/sibling lead not re-read here; L = inferred._

**Lead:** the card's central cost claim is STALE. **Forks share the parent's prompt cache** and are *cheaper* than fresh subagents for context-heavy work (H, sub-agents + prompt-caching docs). Fork mode is default-on since **v2.1.302** (interactive terminal since 232). Auto-compact is now user-tunable (`/autocompact`, per-model, v2.1.288) and default-1M models compact at ~967K, not at a 200K wall.

**Claude Code - subagent / fork mechanics (H, sub-agents docs, live 2026-11-25):**
- Fork = inherits full conversation, same system prompt, tools, model; fork's tool calls stay out of parent, only the final result returns. Fork vs non-fork table: context full vs fresh; **prompt cache shared with parent vs separate**. "Because a fork's system prompt and tool definitions are identical to the parent, its first request reuses the parent's prompt cache ... a fork costs less than a fresh subagent for tasks that need the same context."
- Fork mode "on by default from Claude Code v2.1.302, and in an interactive terminal session from v2.1.232". Off: `CLAUDE_CODE_FORK_SUBAGENT=0` (settings.json `env`, new session) or stop forks only with `Agent(fork)` in `permissions.deny`. While fork mode is on, Claude cannot wait for a non-`web-fetch` subagent in interactive terminal / VS Code / desktop. Per-surface `-p`/SDK default-on is from the sibling changelog lead (M; page text I read lists terminal/VS Code/desktop only).
- Forks cannot spawn forks; may take `isolation: "worktree"` via the Agent tool; at the nesting limit a fork keeps `Agent` in its tool list but the call errors. `/subtask <task>` = in-session fork (takes a concurrency slot, never blocked). **When agent view is off, `/subtask` is unavailable and `/fork` starts the forked subagent; otherwise `/fork` copies the whole session to a new background session.**
- Fresh subagent receives: its own prompt + env details (NOT the Claude Code system prompt), the delegation prompt, the full CLAUDE.md/AGENTS.md hierarchy (Explore, Plan, web-fetch skip it; `omitClaudeMd: true` removes it), a git-status snapshot (Explore/Plan skip), preloaded skills only from its `skills` field. NOT inherited: output style, auto memory, parent's window size (sized by the subagent's own model).
- Built-ins: Explore = read-only, parent's model, except on subscription/Console/`ANTHROPIC_BASE_URL` gateway it runs on the **Opus alias** model, and on Bedrock/Vertex/Foundry it stays Fable when parent is Fable; Plan = parent's model (unless forced), read-only; general-purpose = parent's model, all tools, loads CLAUDE.md; statusline-setup = Sonnet; claude-code-guide and web-fetch = Haiku (web-fetch: parent's model if it cannot use Haiku).
- Model order (re-confirmed): per-invocation `model` (aliases only) > definition `model` (incl. `inherit`) > `CLAUDE_CODE_SUBAGENT_MODEL` > parent/spawner model; `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` (v2.1.257+) overrides all, except forks and `inherit` skills keep the parent model. Nesting default 3 (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`; `1` = off); concurrency default 20 (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`, any positive int v2.1.217+; ultracode exempt).
- Per-call `effort` on the Agent tool (v2.1.292+; non-fork subagents only): overrides frontmatter `effort`, persists across resume; `CLAUDE_CODE_EFFORT_LEVEL` outranks both. Forks/forked skills/teammates not covered.
- Subagent auto-compact (H): subagents compact on their own as their window fills (`CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` applies); frontmatter `autoCompactWindow` >= `100000`, plain integer (`200k` is read as 200 and ignored; check `claude --debug` for `invalid autoCompactWindow`), v2.1.296+; no effect when the whole session runs as `--agent`; with `CLAUDE_CODE_AUTO_COMPACT_WINDOW` also set, the lowest of the three wins (before v2.1.312 the variable alone won). Compaction logged in the subagent transcript as `compact_boundary` with `preTokens`.

**Context window and auto-compact (H, context-window + model-config docs):**
- 1M window native (no `[1m]` suffix) on Fable models, Sonnet 5 and later, Haiku 5.5, Opus 4.7 and later (incl. Bedrock/Agent Platform/Foundry/apps gateway). Opus 4.6 / Sonnet 4.6 reach 1M only via `[1m]` and plan/usage-credit rules. Standard pricing, no premium beyond 200K on the API **except Haiku 5.5, costlier above 100K-token prompts**.
- Default auto-compact: native-1M models compact **at about 967K tokens**; Sonnet/Opus 4.6 without 1M at 200K; cloud sessions near the model limit; unrecognised model IDs compact at the window Claude Code assumes - **assumed window is 1M since v2.1.323 (was 200K before)**; fix with `modelOverrides`, `[1m]` suffix or `CLAUDE_CODE_MAX_CONTEXT_TOKENS`.
- Set the window: `/autocompact <n>` (e.g. `500k`, `1M`, bare 100-1000 = thousands; saved **per model** under `modelSettings` since v2.1.288, before that one global `autoCompactWindow`); `/autocompact auto` resets; `--autocompact` flag per launch; `autoCompactWindow` setting for every model; `CLAUDE_CODE_AUTO_COMPACT_WINDOW` (scripts; highest precedence; `k`/`M` suffix from v2.1.304; unsuffixed `200` = 200 tokens). Min 100K; capped at the model's window. Managed-settings scope can pre-empt `/autocompact` but not `--autocompact`.
- `CLAUDE_CODE_DISABLE_1M_CONTEXT=1`: removes `[1m]` variants and makes native-1M models compact at 200K (window cannot be raised above it; with auto-compact off, hits the context-limit error).
- What survives compaction: system prompt/output style, project-root CLAUDE.md + unscoped rules + auto memory (re-injected from disk), skill descriptions rebuilt (v2.1.304+), fresh git-status, plan-mode plan, up to 5 most-recent files re-read (files >5,000 tokens come back as a path reference), invoked skill bodies capped 5,000/skill and 25,000 total (oldest dropped), background commands/subagents keep running, SessionStart hooks matching `compact` re-run. **Lost into the summary: path-scoped (`paths:`) rules, nested CLAUDE.md, hook-added context.** Subagents keep large reads out of the main window; only summary + small metadata trailer return.
- Idle compaction exists (`idleCompaction` setting; off with `false`, v2.1.290+; applies to conversations on the one-hour TTL).

**Prompt caching and cost (H, prompt-caching docs):**
- Prefix match, exact; layers: system prompt/tools > CLAUDE.md+memory+unscoped rules > conversation. Each model has its own cache - `/model` switch (incl. `opusplan` plan-mode toggles, automatic model fallback, skill/command `model` override) = full uncached re-read; confirm prompt appears only while cache is warm (v2.1.238+). Effort change keeps the cache on Fable 5.1+, Opus 5.5, Sonnet 5.5, Haiku 5.5 (API key or subscription; v2.1.260+), otherwise invalidates. Fast mode has a separate cache. MCP add/remove, plugin MCP, entire-tool deny, many images, Claude Code upgrade invalidate; CLAUDE.md edits mid-session, permission mode, output style, skills, `/recap`, `/rewind` (hits the earlier cache entry), spawning a subagent do not.
- TTL: main conversation = 1 hour only on a Claude subscription within plan usage, else 5 min (API key, cloud provider, or usage credits). **Subagents, forks, compaction, teammates, workflows = "everything else" bucket = 5 minutes** unless `subagentPromptCacheTtl` / `CLAUDE_CODE_SUBAGENT_PROMPT_CACHE_TTL` / frontmatter `experimental.cacheTtl` (v2.1.248+); `promptCacheTtl` / `CLAUDE_CODE_PROMPT_CACHE_TTL` for main (v2.1.242+); `FORCE_PROMPT_CACHING_5M=1` wins.
- Fresh subagent: first request does NOT read the parent's cache; warms its own; parent prefix unaffected (call + result append). Fork: first request reads parent cache. Resumed subagent can read the cache of its earlier run. `/fork` session copy keeps the original cache (isolation instruction appended as a message).
- `/compact` warm = cheap (summary request reads the cached prefix); cold (after TTL, e.g. resumed old session) = reprocesses full history uncached - the costliest case. Rebuilt cache after compaction covers only the short new history. Advice from docs: pick model/effort at the start, compact at natural breaks, `/rewind` instead of compaction to abandon a path.
- Cache scope: effectively per machine + directory (memory paths and cwd in the prefix); parallel same-dir sessions can share it; sequential sessions share only when the startup git-status snapshot matches.
- `/usage` shows `Prompt cache (main)` hit ratio (v2.1.251+; likely-cause text v2.1.260+).

**Gemini CLI (H, geminicli.com subagents + issue #8609, live 2026-11-25):**
- Subagents "enabled by default" (disable `experimental.enableAgents:false` in settings.json); no preview/enterprise label on the page; `.gemini/agents/*.md` (project) and `~/.gemini/agents/*.md` (user); policies `~/.gemini/policies/` (subagents are virtual tool names for policy matching); inline MCP servers in agent frontmatter; browser agent exists but is **disabled by default**; remote subagents via A2A; recursion guard holds even with `*` wildcard ("subagents cannot call other subagents").
- Banner: "Gemini CLI was replaced by Antigravity CLI on June 18th, 2026" (Unpaid-tier and Google One users); new second notice: "Gemini CLI has not been optimized for Gemini 4 Argon" - points to Antigravity for that model.
- **#8609: closed as "completed" by a maintainer on 2025-10-15** (not first noticed 2026-08-01). Closing rationale: all 2.5 models have 1M context and the router only returns flash or pro, so an auto-switch to a smaller-context model could not occur; another maintainer suggested `@`-referencing specific files instead of an all-files flag. No linked branch/PR (Development: "No branches or pull requests"); parent issue #9033 (memory-compression edge cases); #8132 duplicate. Last comment 2026-03-22 (community script that manually compacts a saved session, 90% -> 13%). Read: closed because the premise (smaller-model switch) was disputed, not because `/compress` maxOutputTokens was fixed - keep the manual `/compress` checkpoint advice.

**Cursor (H for entries, L for mechanics; page 1 only):** changelog since Oct 6: Oct 13 Origin App Marketplace; Oct 16 Cloud Agent Canvases + environment improvements; Oct 20 Agent SDK (sessions keep a complete record of every message and tool call); Nov 5 Build Live Apps; Nov 6 Voice Chat with Agents (switch between "workers" in a Project). No entry mentions context window size, truncation, summarisation mechanics or mode-switch context behaviour. Oct 6-13 entries NOT seen.

**Convergence:** n/a. **Quiet:** Cursor local-IDE context mechanics (no change visible).
**Manual-check:** cursor.com/changelog page 2 (Oct 6-13); Cursor mode-switch fresh-context claim ("confirmed, Cursor docs") never re-fetched from docs.cursor.com; Remote Control + Trusted Devices docs (card body 2026-10-08 state); `/rewind` reliability issues and Codex fork table; v2.1.277 subagent-result framing; 80%/12% and 7x/20-35% third-party figures.

---

## Research origin

**Session:** @Epoch, 2026-07-02. All sources live-fetched; no training-data recall.

**Refresh:** @Epoch, 2026-10-08 — manual live-fetch pass (NOT `/refresh` snapshot; no substrate file written). Fetched: sub-agents docs, geminicli.com subagents docs, cursor.com/changelog, remote-control docs (intro only). Deltas listed under VOLATILE. Second pass same day re-checked bug #8609 and Remote Control requirements (VOLATILE bullets below). Third pass (same day) re-checked RC timeouts, resume commands and Trusted Devices (VOLATILE bullets). Still NOT re-checked: all quantified third-party figures (CheesecakeLabs/MindStudio/InfoQ/MorphLLM).

**Refresh:** @Epoch substrate + @Atlas hand re-synthesis, 2026-09-02 (structured-card exception) — `/refresh session-hygiene` snapshot, 6/6 sources live. Deltas: Remote Control is **GA on all plans** (preview language gone); RC timeout **scoped to server mode** (interactive mode retries indefinitely); NEW Trusted Devices (beta, Team/Enterprise); NEW subagent model-resolution order (v2.1.251+); Cursor Cloud Agents subagent isolation (2026-08-19, different surface — coverage gap, not contradiction); Gemini subagents + #8609 hold. Substrate: `raw.research/session-hygiene/report/raw.session-hygiene.2026-09-02.md`.

**Refresh:** @Epoch, 2026-08-01 — re-fetched doc/issue sources via `/refresh session-hygiene` (snapshot). Deltas this pass: Gemini CLI subagents no longer flagged PREVIEW (now standard; `.gemini/agents/*.md`; recursion guard intact); GitHub bug #8609 now CLOSED (was open); Cursor changelog (Jul 2026) shows no context-mechanics change — new "Cursor Router" routes per request by task type/complexity. Built-in Explore/Plan model defaults NOT re-confirmed this pass. Quantified metrics (CheesecakeLabs / MindStudio / InfoQ / MorphLLM) carried unchanged (one-off studies). Substrate: `raw.research/session-hygiene/report/raw.session-hygiene.2026-08-01.md`.

**Triggered by:** Operator question — does the intuition hold that switching agents in an
interactive session (Cursor IDE / Claude Code CLI) causes whole-context re-reads and costs
more than the plan→MD-taskline→fresh-executor pattern? How does this compare to Gemini CLI,
where long conversations before switching to an executive subagent can cause massive token bloat?

**Core sources fetched this session:**
- Claude Code sub-agents docs — `code.claude.com/docs/en/sub-agents` (live, 2026-07-02)
- Claude Code plan mode — CheesecakeLabs enterprise study (Jun 2026, real client data)
- Gemini CLI subagents — Google Developers Blog + geminicli.com (Apr 2026 launch)
- Gemini CLI crash bug — `github.com/google-gemini/gemini-cli/issues/8609` (open, confirmed)
- Cursor 3 context mechanics — InfoQ (Apr 2026) + MorphLLM context window analysis (2026)
- Multi-agent token multiplier — MindStudio enterprise analysis (2026)

**Cross-checked against temple canon:** `canon.context-economy`, `canon.one-direction`,
`canon.cost-gradient`. Operator intuition confirmed on all three tools. Card captures
quantified findings, comparative isolation table, and canon mapping.

---

## ⚠ VOLATILE — read first

- **Gemini CLI subagents** = now a standard feature (no PREVIEW flag) as of 2026-08-01 (launched Apr 2026 as preview). Config `.gemini/agents/*.md`; recursion guard still enforced.
- **GitHub bug #8609 (CLOSED; see the 2026-10-08 bullet below):** Gemini CLI long session → auto model-switch → crash; `/compress` recovery also failed (requested maxOutputTokens 100117 vs API max 65536) → session unrecoverable. Marked p2. Closed with NO linked fix/PR/date on the issue page — do not assume it is fixed; re-test long unattended sessions and keep manual `/compress` checkpoints.
- **Cursor context mechanics** are not fully published. The <50% effective window and 80% vs 12% numbers are practitioner-measured, not Cursor-official.
- **Claude Code Plan subagent isolation** is GA and documented (code.claude.com); the 7× multi-agent multiplier is from MindStudio enterprise analysis (not Anthropic-official).
- **Subagent model resolution order (v2.1.251+, 2026-09-02, H):** per-invocation `model` → subagent frontmatter `model` → `CLAUDE_CODE_SUBAGENT_MODEL` env → main-conversation model. Env var no longer outranks frontmatter. `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` (v2.1.257) is the hard override. Explore stays "inherits main model, capped at Opus" (v2.1.198, confirmed).
- **Cursor Cloud Agents (2026-08-19, M):** subagents run in an isolated project copy with clean context in their own cloud env (+ `/goal`, Custom Modes, mid-run steering). Different surface from the local-IDE mechanics in §Cursor below — not yet covered by this card.
- **Fork cost claim partly stale (2026-10-08, H):** fork mode is on by default from v2.1.302 (interactive terminal since v2.1.232); `CLAUDE_CODE_FORK_SUBAGENT=0` turns it off; `Agent(fork)` in `permissions.deny` stops forks only, and **forks share the parent's prompt cache**, so they are cheaper than fresh subagents for context-heavy work. The §Claude Code lines "Long parent + fork = full re-read cost" and the table's "Expensive for long parents" predate this — read them as cache-miss worst case. Forks cannot spawn forks.
- **Subagent limits (2026-10-08, H):** nesting default 3 layers (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`); 20 concurrent (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`). Subagent results now arrive framed/indented as subagent output (v2.1.277). Built-in Explore = main model (Opus when main is Fable), still skips CLAUDE.md + git status; Plan inherits.
- **Gemini CLI subagents (2026-10-08, H):** enabled by default, no preview/enterprise label on the docs page; disable via `experimental.enableAgents:false`; `.gemini/agents/*.md`; recursion guard holds even with `*` tool wildcard; new: browser agent, inline `mcpServers` in agent frontmatter, subagent policy rules (`~/.gemini/policies/`), remote subagents over A2A. Banner: Gemini CLI "was replaced by Antigravity CLI on June 18th, 2026" for Unpaid-tier and Google One users.
- **Bug #8609 (2026-10-08, H):** confirmed CLOSED; opened 2025-09-17, label priority/p2. The issue page shows NO linked PR/branch/milestone and no closing date — closed with no stated fix. Earlier "treat as resolved" wording is too strong: treat as closed-without-evidence-of-fix; keep manual `/compress` checkpoints.
- **Remote Control requirements (docs, live 2026-10-08, H; first ~120 lines read):** Pro/Max/Team/Enterprise (Team/Ent need an Owner toggle), no API keys. NOT available on Bedrock/Vertex/Foundry, with `ANTHROPIC_BASE_URL` pointing off api.anthropic.com (gateway/proxy), or via the Claude apps gateway; unavailable when `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` or `DISABLE_GROWTHBOOK` is set; `DISABLE_TELEMETRY`/`DO_NOT_TRACK` are OK from v2.1.283 unless the org requires Trusted Devices. Server mode `claude remote-control` flags: `--spawn same-dir|worktree|session`, `--capacity` (default 32), `-c/--continue` and `--session-id` (v2.1.200+), `--permission-mode`, `--chrome` (v2.1.273+), `--debug` (v2.1.282+). Interactive: `claude --remote-control`/`--rc`; in-session `/remote-control` or `/rc`. Untrusted directory → trust prompt (exits with an error without a TTY). Passing global flags such as `--settings` before `remote-control` makes it refuse to start. Timeouts (docs, pass 3, H): server mode `claude remote-control` gives up after roughly 10 minutes without network and the process exits; interactive sessions retry for as long as the outage lasts; HTTP 403 retries up to 3 min; presence heartbeat unreachable ~30 min → disconnect; forwarded dialogs expire after 5 min (`dialogExpiry`, v2.1.224); server-session resume window ~4 hours (v2.1.228+: `--continue`/`--session-id` can unarchive); a crashed server-mode session is re-served when a connected device sends a message (v2.1.238); outside server mode, one remote session per interactive process. Resume: `claude remote-control` restores all sessions the server was serving, `--continue` only the starting one, `--session-id <id>` one specific; sessions begun with `/remote-control` or `claude --remote-control` resume via `claude --continue`/`--resume`.
- **Trusted Devices (docs, pass 3, H):** still BETA, but available on Pro, Max, Team AND Enterprise (off by default; an Owner enables it org-wide on Team/Enterprise, an individual turns on "Require trusted devices" on Pro/Max). Needs an enrolled device credential + a sign-in ≤18 h old; biometric step-up (Face ID / Touch ID / Windows Hello / passkey) refreshes the session; the CLI host receives its credential automatically at sign-in. The older "Team/Enterprise only" wording in §Remote session restore is WRONG (corrected below).
- **Cursor (2026-10-08, H for items, L for mechanics):** changelog Aug 27–Oct 6 shows no local-IDE context-mechanics change; new surfaces are Cursor Projects beta (Sep 10, cloud coordinator agent delegating to other agents with shared context files) and remote control of local agents from iOS (Oct 6).

---

## Claude Code CLI — subagent context isolation

**Fresh subagent (default):**
- Receives its own prompt + env details (not the Claude Code system prompt), the delegation prompt, the CLAUDE.md/AGENTS.md hierarchy (Explore/Plan/web-fetch skip it; `omitClaudeMd: true` removes it), a git-status snapshot (Explore/Plan skip it), and only skills named in its `skills` field. No parent conversation, output style or auto memory.
- Internal tool-call chain stays in its own window; never enters parent.
- Orchestrator context grows by the return-value size only — not by the subagent's working chain.

**Fork subagent:**
- Inherits the ENTIRE parent conversation to date.
- Use when a fresh subagent would need too much background, or to try approaches in parallel. A fork's first request reads the parent's prompt cache, so it costs less than a fresh subagent for same-context work; it still carries the full parent history in its own window (cache-miss worst case: cold cache after the TTL, or a fork's own later turns on the 5-minute subagent/fork TTL bucket).

**Built-ins and their isolation:**
| Subagent | Model | Reads CLAUDE.md? | Isolated context? |
|---|---|---|---|
| Explore | parent's model; on subscription/Console/gateway runs on the Opus alias model; on Bedrock/Vertex/Foundry stays Fable if parent is Fable ¹ | No (skips) | Yes |
| Plan | inherits | No (skips) | Yes |
| General-purpose | inherits | Yes | Yes |

¹ Changed v2.1.198 — was Haiku. Explore passes are no longer Haiku-cheap.

**Plan mode mechanics:**
The built-in Plan subagent does all exploration in its own context window. When plan mode returns to the main session, only the plan text arrives — no file contents, no grep output, no tool chain.

**Orchestrator accumulation math:**
Three subagents × 2K return each = 6K tokens added to orchestrator per cycle (MindStudio, 2026).
Rule of thumb: **~7× token multiplier** for multi-agent workflows vs single-thread session.

**Quantified plan-mode savings (CheesecakeLabs, 2026, client data):**
- 20–35% cheaper than direct mode on typical features
- Example: direct ~79K input + 25K output ≈ $0.62 → plan ~55K input + 22K output ≈ $0.49
- Complex features with reverts: $40 → $8 switching to plan-then-execute
- Correction cost: ~200 tokens to fix a plan vs ~50K to revert a half-executed implementation

---

## Cursor IDE — effective context and mode switching

**Effective vs. advertised window:**
Cursor injects system prompt + codebase index results + conversation history + auto-included file
contents before any user content reaches the model. Effective available window = consistently
**< 50% of advertised** (practitioner measurement; Cursor does not publish breakdown).

**Accumulation in a single session:**
By the 50th tool call in a session, conversation history alone can exceed 150K tokens — re-sent
in full on every subsequent call (billed each time).

**Mode switching:**
Each mode switch (Cmd+. / Ctrl+.) starts a **fresh context window** (confirmed, Cursor docs).
Continuity is lost at the switch; cost resets. Switching is a hard boundary, not a handoff.

**Real-world comparison (InfoQ, Cursor 3 launch, Apr 2026):**
Same workflow measured at 12% daily usage cap in Claude Code vs **80% in Cursor** — both on
comparable models. Gap attributed to Cursor's context construction overhead on every turn.

**MAX mode:** removes context truncation and tool-call cap (200 tools); uses token-based API
pricing with 20% margin. Does not change the accumulation-per-turn billing math.

---

## Gemini CLI — context accumulation and subagent isolation

**Without subagents (standard interactive session):**
Every prompt + every response appended to the running context. No isolation.
Mitigation commands: `/compress` (summarize in place) · `/chat save` → `/clear` → `/chat resume`
(branching). Context rot sets in on long sessions; model performance degrades.

**With subagents (standard as of 2026-08-01; launched Apr 2026 as preview):**
- Subagent runs in an isolated context loop.
- Intermediate tool calls (reading files, running greps) are **purged from main session history**.
- Orchestrator receives only the concise return summary.
- Subagents cannot spawn sub-subagents (recursion guard — prevents token cascade).

**Shell-spawned isolated sessions (advanced pattern):**
Orchestrator writes a task prompt to a file → spawns a fresh `gemini` process via shell tool.
Token usage per spawn "explodes" (full system context reload each time) but sessions are
hermetically isolated — no history carries across.

**Known crash pattern (bug #8609, closed as completed 2025-10-15):**
Long session on large-context model → CLI auto-switches to smaller model → accumulated context
(documented: 8.1M tokens) exceeds smaller model's cap → API error. `/compress` recovery also
failed (requested `maxOutputTokens = 100K+`; API max = 65,536), leaving the session unrecoverable.
Marked p2, Closed with no fix linked (confirmed 2026-10-08). Do NOT treat as resolved; re-test long
unattended sessions; keep manual `/compress` checkpoints as belt-and-suspenders.

---

## Canonical hygiene pattern — plan → MD artifact → fresh executor

The cheapest execution shape across all three tools:

```
1. Plan phase (read-only subagent / plan mode)
   — exploration stays isolated from main context
   — operator reviews the plan

2. Write durable MD artifact (the taskline)
   — survives the session; no re-derivation needed
   — operator gates here (Force 4 / canon.one-direction)

3. Fresh execution session / subagent
   — reads taskline cold (no accumulated history)
   — no fork; no inherited conversation
   — execution chain stays in its own context
```

This is NOT missing automation — the operator gate between phases is deliberate (`canon.one-direction`).
The durable MD file is the continuity mechanism; the fresh session is the cost-reset mechanism.

---

## Isolation comparison

| Pattern | Context inheritance | Orchestrator grows by | Hygiene ceiling |
|---|---|---|---|
| Claude Code — fresh subagent | None (system prompt only) | Return value size | Bounded — clean |
| Claude Code — fork subagent | Full parent conversation | Inherited + return value | Cheaper than fresh for same-context work (shares parent cache); grows the fork's own window by the full history |
| Claude Code — plan mode | Plan subagent isolated | Plan text only | Cleanest built-in pattern |
| Plan → MD → fresh session | None (reads task doc cold) | N/A (new session) | Optimal |
| Cursor — within one session | Accumulates per turn | — | Degrades past ~50 turns |
| Cursor — after mode switch | Fresh (mode resets) | — | Continuity lost at reset |
| Gemini CLI — no subagents | Accumulates per turn | — | Highest crash risk at scale |
| Gemini CLI — subagents (standard) | Isolated per subagent | Return summary | Mirrors Claude Code clean pattern |
| Gemini CLI — shell-spawned | Per-spawn fresh | Explodes per spawn | Expensive/call, clean across |

---

## Session fork / branch / rewind — cross-tool (added 2026-08-05)

`full study: raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md · companion: card.codex-cli (seeded this pass)`

Distinct axis from the subagent-context table above: this is **SESSION-level** branching (a whole conversation transcript forked to a new ID), not subagent context isolation. Claude Code and Codex CLI diverge sharply.

| Axis | Claude Code (v2.1.212+) | Codex CLI (0.146.0) |
|---|---|---|
| Session fork | `/branch` (in-session) · `--fork-session` (new process) · `/fork` (→ background session) — TUI-first, **full transcript copy** | `codex fork [ID]/--last/--all` — standalone subcommand, headless-first, `forked_from_id` lineage; public RPC still **copies** history |
| In-session branch | `/branch [name]` | none; edit-a-past-prompt **auto-creates a contextual branch** (Claude has no equivalent) |
| Rewind / undo | `/rewind` + Esc-Esc, code+convo checkpoints per prompt | **NONE** — `/undo` shipped then removed; `/rewind` unshipped FR. Use git. |
| On-disk | `~/.claude/projects/<slug>/<id>.jsonl` | `~/.codex/sessions/YYYY/MM/DD/rollout-<ts>-<uuid>.jsonl[.zst]` |
| Remote/cross-machine | `--teleport` (cloud→local) · `--cloud` (local→cloud, fresh) · `remote-control` (steer local from web) | none in CLI (`codex cloud` = cloud chats only; SSH in separate Codex App alpha) |

**⚠ v2.1.212 name swap (Claude):** `/fork` and `/subtask` swapped — `/subtask` = in-session subagent fork; `/fork` = background SESSION copy. Pre-2.1.212 tutorials have them backwards.

**Hygiene implications (reinforce the plan→MD→fresh pattern):**
- **`/rewind` is best-effort, NOT reliable** — leaves bash-made changes, subagent edits, symlinks on disk; fails in-scope on multi-file (#70727/#18516). Git remains source of truth. Verdict this study: *refuted* that rewind reliably restores.
- **Fresh+brief beats resume for a context PIVOT; resume/continue wins for continuous same-file work** (holds-with-caveats). Resume tax on long thinking-heavy Claude sessions: ~156k tok replay, ~25% invisible thinking-signatures (#42260, not-planned).
- **Fork is not cheap on either tool** — Claude `/branch` full-copies; Codex public `thread/fork` copies history (the `history_base` reference-fork is dormant for the JSONL store).
- **After a crash, sanity-check `git status` before trusting a resumed Codex session** — stale-resume vs VCS (#31982).

## Canon mapping

| This card's finding | Canon gate |
|---|---|
| Fresh subagent / plan-mode isolation | `canon.context-economy` → "scoped delegation: scope + mode on every subtask" |
| Plan → MD → fresh executor | `canon.context-economy` → "pull, don't eager-load" + "files are continuity" |
| Operator gate between phases | `canon.one-direction` (Force 4 — human holds the gate) |
| Route cheap-first, heavy on demand | `canon.cost-gradient` (Force 1 — Explore on inherited/capped; synthesis on Fable/Opus) |
| Ask before reading inboxes/RAG | `canon.mail-protocol` → "ask-first" (token starvation valve) |

The 7× multiplier and 20-35% plan savings are the **quantitative justification** for why these
gates are load-bearing — not just procedural discipline.

---

## Cards to refresh alongside this one

- `card.cursor-ide` — verified 2026-06-02 (stale: 30 days hit). Add: effective context window,
  mode-switch token-reset behavior, real-world 80% vs 12% comparison.
- `card.gemini-cli` — verified 2026-06-27. Add: bug #8609 (unrecoverable session), `/compress`
  failure mode, subagent recursion guard.

---

## Remote session restore — SSH/tmux persistence + Remote Control resume

**Verified 2026-09-02 (@Epoch substrate · @Atlas hand re-synthesis); first verified 2026-08-01.**

Fills the gap these cards assumed away: recovering a Claude Code session running on a *remote* box when the SSH client drops/freezes.

- **Remote Control** (shipped 2026-02-25; **GA on all plans as of 2026-09-02** — Team/Enterprise behind an Owner-enabled toggle; no API keys) is a sync layer, not cloud compute. The `claude` process stays on your machine (outbound HTTPS only, no inbound ports); claude.ai/code + mobile are a window into it. A session that stays green on the phone after your terminal dies = the host process is still alive and RC-connected.
- **Recover the terminal:**
  - Launched inside `tmux`/`screen` → SSH back, `tmux attach` (or `tmux attach -t <name>`). Clean path.
  - Launched directly in the SSH shell → cannot re-grab the dead PTY. From the same project dir in a fresh shell: `claude -c` (`--continue`) or `claude --resume` — reconnects to the RC session recorded in that conversation (transcript is server-side). Server-mode variant: `claude remote-control -c` (v2.1.200+).
- **`! claude --resume`** with a leading `!` is the run-shell-from-inside-a-session form — NOT the recovery path. Restore from a plain shell.
- **Clocks (split, 2026-09-02):** *server mode* (`claude remote-control`) — host offline >~10 min → gives up, process exits (restart + resume). *Interactive mode* (`claude --remote-control`) — retries indefinitely and self-reconnects when the network returns. No multiplexer → remote `sshd` can SIGHUP `claude` once keepalive declares the frozen client dead, so reconnect promptly or hold from phone. Ultraplan disconnects active RC.
- **Trusted Devices** (beta, Pro/Max/Team/Enterprise [corrected 2026-10-08], off by default): RC viewing/steering bound to an enrolled device + sign-in ≤18 h old with biometric step-up. Orthogonal to recovery; matters only if the org toggles it on.
- **Prevent it:** `tmux new -s work` → then `claude` inside it. Official: "To keep a session running on a remote machine after you disconnect from SSH, start it inside tmux or screen."

**Full guide (dated, sourced):** `raw.research/harness/reports/2026-08-01-remote-control-tmux-ssh-persistence.md`
**Recheck source:** https://code.claude.com/docs/en/remote-control
