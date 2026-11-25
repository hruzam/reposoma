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
  - https://code.claude.com/docs/en/remote-control   # RC requirements/timeouts/Trusted Devices
  - https://code.claude.com/docs/en/costs   # source of the "~7x agent teams" figure; cache-read cost framing
  - https://code.claude.com/docs/en/checkpointing   # /rewind limitations
  - https://learn.chatgpt.com/docs/developer-commands?surface=cli   # Codex fork/resume (developers.openai.com/codex/cli/reference 308-redirects here)
  - https://cursor.com/docs/models-and-pricing   # MAX mode, cache pricing
# companion cards: card.claude-code · card.cursor-ide · card.gemini-cli
# relate-to-canon: canon.context-economy (gate-shape + scoped delegation) · canon.cost-gradient (spend by demand)
---

# Session hygiene — token distro and context isolation across tools

## Refresh delta 2026-11-25

_PARTIAL (pass 2 of 2). Run by @Epoch's sibling for this one card, NOT the `/refresh session-hygiene` pipeline (no substrate written). Confidence: H = live official docs / issue page read this run; M = reliable second-hand or an inference from an H page; L = inferred. Pass 1 covered Claude Code sub-agents/context-window/model-config/prompt-caching docs, Gemini subagents + #8609; pass 2 closed the Cursor, Remote Control, /rewind, Codex and third-party gaps below. Still unverified: see Manual-check._

**Lead:** the card's central cost claim is STALE. **Forks share the parent's prompt cache** and are *cheaper* than fresh subagents for context-heavy work (H, sub-agents + prompt-caching docs). Fork mode is default-on since **v2.1.302** (interactive terminal since 232). Auto-compact is user-tunable (`/autocompact`, per-model, v2.1.288); default-1M models compact at ~967K, not at a 200K wall. **Second lead (pass 2):** three load-bearing third-party figures are weaker than the card says (see "Third-party figures") and the Cursor "mode switch = fresh context" claim has no source.

**Claude Code - subagent / fork mechanics (H, sub-agents docs, live 2026-11-25):**
- Fork = inherits full conversation, same system prompt, tools, model; fork's tool calls stay out of parent, only the final result returns. Fork vs non-fork table: context full vs fresh; **prompt cache shared with parent vs separate**. "Because a fork's system prompt and tool definitions are identical to the parent, its first request reuses the parent's prompt cache. Because of that reuse, a fork costs less than a fresh subagent for tasks that need the same context."
- Fork mode "on by default from Claude Code v2.1.302, and in an interactive terminal session from v2.1.232". Off: `CLAUDE_CODE_FORK_SUBAGENT=0` (settings.json `env`, new session) or stop forks only with `Agent(fork)` in `permissions.deny`. While fork mode is on, Claude cannot wait for a non-`web-fetch` subagent in interactive terminal / VS Code / desktop. The `-p`/SDK default is NOT stated on the page text read (M, sibling changelog lead only).
- Forks cannot spawn forks; may take `isolation: "worktree"` via the Agent tool. `/subtask <task>` = in-session fork (works whether or not fork mode is on; takes a concurrency slot, never blocked by the limit). **Verbatim qualifier (H, "Fork the current conversation" note, read this pass): "When agent view is turned off, `/subtask` isn't available and `/fork` starts the forked subagent instead; otherwise `/fork` copies the whole session into a new background session."** Fork panel: `Enter` opens a fork's transcript; `/compact`, `/clear`, `/rewind` from that view act on the MAIN conversation (confirm prompt); `/model` and `/fast` do not run there.
- Fresh subagent receives: its own prompt + env details (NOT the Claude Code system prompt), the delegation prompt, the full CLAUDE.md/AGENTS.md hierarchy (Explore, Plan, web-fetch skip it; `omitClaudeMd: true` removes it), a git-status snapshot (Explore/Plan skip), preloaded skills only from its `skills` field. NOT inherited: output style, auto memory, parent's window size.
- **Built-in Explore model (H, verbatim, sub-agents docs):** "the parent conversation's model. When the parent conversation runs Fable, Explore runs on Opus or stays on Fable, based on how you connect." Claude subscription / Anthropic Console / LLM gateway via `ANTHROPIC_BASE_URL` -> the Opus model the `opus` alias resolves to; Bedrock / Google Cloud Agent Platform / Foundry / Claude Platform on AWS / Claude apps gateway -> stays Fable. So the old VOLATILE shorthand "Explore = main model (Opus when main is Fable)" is TRUE only for subscription/Console/gateway-by-base-URL connections. The footnote "Changed v2.1.198 - was Haiku" was NOT re-confirmed: the only v2.1.198 reference on the page is for `CLAUDE_CODE_DISABLE_EXPLORE_PLAN_AGENTS`.
- Other built-ins: Plan = parent's model, read-only; general-purpose = parent's model, all tools; statusline-setup = Sonnet; claude-code-guide and web-fetch = Haiku (web-fetch: parent's model if it cannot use Haiku) (pass 1, H).
- Model order (re-confirmed pass 1): per-invocation `model` (aliases only) > definition `model` (incl. `inherit`) > `CLAUDE_CODE_SUBAGENT_MODEL` > parent/spawner model; `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` (v2.1.257+) overrides all, except forks and `inherit` skills keep the parent model. Nesting default 3 (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`; `1` = off); concurrency default 20 (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`, v2.1.217+; ultracode exempt).
- Per-call `effort` on the Agent tool (v2.1.292+; non-fork subagents only), `CLAUDE_CODE_EFFORT_LEVEL` outranks. Subagent auto-compact: frontmatter `autoCompactWindow` >= `100000`, plain integer (`200k` is read as 200 and ignored; check `claude --debug` for `invalid autoCompactWindow`), v2.1.296+; no effect under `--agent`; with `CLAUDE_CODE_AUTO_COMPACT_WINDOW` also set the lowest of the three wins (before v2.1.312 the variable alone won). Transcript logs `compact_boundary` with `preTokens` (H).

**Context window and auto-compact (H, context-window + model-config docs, pass 1):**
- 1M window native on Fable models, Sonnet 5 and later, Haiku 5.5, Opus 4.7 and later; Opus 4.6 / Sonnet 4.6 reach 1M only via `[1m]`. No premium beyond 200K on the API except Haiku 5.5 (costlier above 100K-token prompts).
- Default auto-compact: native-1M models at about 967K; Sonnet/Opus 4.6 without 1M at 200K; unrecognised model IDs compact at the assumed window - **1M since v2.1.323 (was 200K)**; fix with `modelOverrides`, `[1m]` or `CLAUDE_CODE_MAX_CONTEXT_TOKENS`.
- Set the window: `/autocompact <n>` (per model under `modelSettings` since v2.1.288; the RC doc says `/autocompact` works from mobile/web with an argument from v2.1.221), `/autocompact auto`, `--autocompact`, `autoCompactWindow` setting, `CLAUDE_CODE_AUTO_COMPACT_WINDOW` (highest precedence; `k`/`M` suffix v2.1.304+). Min 100K. `CLAUDE_CODE_DISABLE_1M_CONTEXT=1` makes native-1M models compact at 200K.
- Survives compaction: system prompt/output style, project-root CLAUDE.md + unscoped rules + auto memory, skill descriptions (v2.1.304+), git-status, plan, up to 5 recent files, invoked skill bodies (5,000 each / 25,000 total), background tasks, `compact` SessionStart hooks. **Lost into the summary: path-scoped (`paths:`) rules, nested CLAUDE.md, hook-added context.** Idle compaction: `idleCompaction` setting (v2.1.290+).

**Prompt caching and cost (H, prompt-caching docs pass 1 + costs docs pass 2):**
- Prefix match, exact; each model has its own cache - `/model` switch = full uncached re-read; effort change keeps the cache on Fable 5.1+, Opus 5.5, Sonnet 5.5, Haiku 5.5 (v2.1.260+). MCP add/remove, tool deny, many images, Claude Code upgrade invalidate; CLAUDE.md edits, permission mode, output style, skills, `/recap`, `/rewind`, spawning a subagent do not.
- TTL: main = 1 hour only on a subscription within plan usage, else 5 min. **Subagents, forks, compaction, teammates, workflows = 5 minutes** unless `subagentPromptCacheTtl` / `CLAUDE_CODE_SUBAGENT_PROMPT_CACHE_TTL` / frontmatter `experimental.cacheTtl` (v2.1.248+); `FORCE_PROMPT_CACHING_5M=1` wins.
- Fresh subagent: first request does NOT read the parent's cache. Fork: first request reads it. `/compact` warm = cheap; cold = full uncached reprocess (costliest).
- **Billing implication of "re-sent every turn" (H, costs docs, verbatim sense):** "Claude Code sends your full conversation with every request ... With prompt caching, Claude Code re-reads that history at the cached token rate, so a one-line question in a session that has been open all day still draws usage for the whole conversation." A first message after a break longer than the cache lifetime misses and reprocesses the full context. So for Claude Code the accumulation is real but billed at cache-read rate while warm. The card's Cursor line "re-sent in full ... (billed each time)" is NOT confirmed for Cursor (see Cursor).
- `/usage` shows the `Prompt cache (main)` line (v2.1.251+; likely-cause text v2.1.260+); it covers the main conversation only, not subagents (costs docs).
- Spinner token count shown beside the spinner is OUTPUT only (live approximate, resets per turn); it excludes history and context (costs docs, H) - do not use it to judge session size.

**Third-party figures - original sources re-read (pass 2):**
- **"~7x" (H for the true source):** the figure originates in Anthropic's own costs docs: "Agent teams use approximately 7x more tokens than standard sessions when teammates run in plan mode, because each teammate maintains its own context window and runs as a separate Claude instance" (code.claude.com/docs/en/costs, live 2026-11-25). MindStudio "Why Claude Code Sub-Agents Cost 7x More Tokens" (2026-08-23) repeats it as "agent teams ... roughly seven times ... when teammates run in plan mode", attributing it to Anthropic docs without a link. **The card's use ("~7x for multi-agent workflows", "not Anthropic-official") is wrong on both counts: it is Anthropic-official and it is about agent teams in plan mode, not subagents.** "Three subagents x 2K = 6K (MindStudio)": not in the MindStudio article read - source not found - unverifiable (arithmetic only).
- **"20-35%" (M):** CheesecakeLabs "Plan Mode is the Deal-Breaker ..." (cheesecakelabs.com/blog/plan-mode-claude-code/, published 2026-05-26, updated 2026-08-24, NOT Jun 2026): "plan mode consistently runs 20 to 35% cheaper in raw tokens than direct mode" - author experience across client engagements, no client named, no method. The **$0.62 vs $0.49 example (79K in/25K out vs 55K in/22K out) is a modeled hypothetical priced at Sonnet 4.6 rates, NOT client data** (the saving it shows is ~21%). "$40 -> $8" is an anecdote from client work, no client named. "~200 tokens vs ~50,000" is an illustrative figure. Treat as one consultancy's observation. A vendor (MorphLLM) estimates 20-30% net after the extra planning turn (search summary only, L).
- **"80% vs 12%" (M):** InfoQ "Cursor 3 ..." (infoq.com/news/2026/04/cursor-3-agent-first-interface/): "estimating 12% daily usage for a workflow in Claude Code versus 80% for the same workflow in Cursor" - a Reddit user's estimate, anecdotal, not measured; InfoQ's own conclusion is only that "how a harness constructs context and manages tool calls can have a significant impact on effective cost". The card's "measured ... attributed to Cursor's context construction overhead" overstates it.
- **"<50% effective window" (L):** no Cursor-specific source found. MorphLLM's generic pages cite RULER (effective context ~50-65% of advertised) and a "roughly half" heuristic - vendor, not Cursor-specific (search summary; page not read). Cursor forum threads show reserved tokens shrinking the usable window (e.g. 175K of 200K) - user reports. **"150K by the 50th tool call": source not found - unverifiable.**

**/rewind and resume - issues read (pass 2):**
- anthropics/claude-code **#70727** (H): "Rewind to here does not revert file changes made by Claude in the same session"; opened 2026-06-25 (v1.150, macOS), "this never worked"; closed "not planned" by stale automation, later locked; no maintainer response. Workaround in thread: treat rewind as conversation-only, run `git status` after rewinding, commit/stash at checkpoints.
- **#18516** (H): "rewind of code doesn't work most of the time" (multi-file, v2.1.9, Linux); opened 2026-01-16, closed 2026-01-19 as duplicate of #15489 (related #15403, #14002), locked.
- Official limits (H, code.claude.com/docs/en/checkpointing): `/rewind` (alias `/undo`) or Esc Esc; file snapshots for the 100 most recent checkpoints; snapshots swept ~30 days (`cleanupPeriodDays`); Bash-only changes to files Claude never edited are NOT tracked; subagent edits usually NOT restored (foreground forked skill excepted); external/concurrent-session edits not tracked; symlinked/hard-linked paths skipped; "Not a replacement for version control". Menu also offers **Summarize from here / up to here**. Use `/branch` or `claude --continue --fork-session` to branch. Card verdict "best-effort, not reliable; git is truth" HOLDS.
- **#42260** (H): "Resume of long sessions loads disproportionate tokens from opaque thinking signatures", opened 2026-04-01, closed "not planned" by stale automation 2026-05-18, locked 2026-07-08. The ~156K-token / ~25% (~38.8K signature) figures are ONE reporter's estimate for one ~24-hour, 480-message session; commenters reported 2.6% in one dataset, up to 20% in some sessions; cache-bug explanation is community-reported and unverified; one commenter says v2.1.90 fixed the non-resume cache regression but `--resume` stayed affected. Read as "can be large", not "~25% typical".
- openai/codex **#31982** (H): "Codex resumes from a stale conversational checkpoint after hard shutdown while VCS state is newer"; opened 2026-07-10, OPEN, labels bug/app/session; reporter env "Codex CLI 26.707.31428" (a build string, different scheme from the card's 0.146.0), Enterprise plan.

**Codex fork table (pass 2):** docs: learn.chatgpt.com/docs/developer-commands?surface=cli (developers.openai.com/codex/cli/reference 308-redirects there).
- Confirmed (H): `codex fork` = "Fork a previous interactive session into a new chat" (picker by default; `--last`, `--all`, `SESSION_ID`, `--worktree` needs an explicit session id); `codex resume` (`--last`, `--all`, `--include-non-interactive`, `SESSION_ID` = UUID or name); `codex exec resume`, `codex exec fork <SESSION_ID> [PROMPT]`.
- **CORRECTION (H): Codex DOES have an in-session fork: `/fork` "Clones the current chat into a new chat with a fresh ID, leaving the original transcript unchanged"** (optional checkout choice: current dir or new worktree) and `/resume` (picker with Cwd/Repo/All scopes). The card's "In-session branch | none" for Codex is wrong. `/undo`, `/rewind`, `/branch`: not mentioned on the page (so "NONE - /undo shipped then removed; /rewind unshipped FR" is neither confirmed nor refuted; Codex 0.171.0 shipped composer text undo/redo, unrelated).
- Version: latest stable **0.172.0 (2026-11-24)** per github.com/openai/codex/releases (H); card.codex-cli was verified at 0.171.0 (Nov 20); the table's "0.146.0" is stale. 0.172.0 notes mention `codex exec resume` restoring saved sandbox permissions and "keep authorization evidence local to agent forks" (#62314).
- NOT checked: `forked_from_id`, "edit-a-past-prompt auto-creates a branch", the on-disk path (docs page says only that `$CODEX_HOME` holds config and `--ephemeral` avoids persisting rollout files), "public RPC still copies history", subagent docs.

**Gemini CLI (H, geminicli.com subagents + issue #8609, live 2026-11-25):**
- Subagents on unless disabled: `experimental.enableAgents: false` in settings.json; `.gemini/agents/*.md` and `~/.gemini/agents/*.md`; policies `~/.gemini/policies/`; inline MCP servers in agent frontmatter; browser agent exists but **disabled by default**; remote subagents via A2A; recursion guard holds even with `*`.
- **Banner text, verbatim (two notices):** (1) "Unpaid tier and Google One users: Gemini CLI was replaced by Antigravity CLI on June 18th, 2026." (2) "Gemini CLI has not been optimized for Gemini 4 Argon. To use Gemini 4 Argon, please use Antigravity."
- **#8609 (H):** CLOSED, state_reason **completed**, closed by SandyTao520 on **2025-10-15** (maintainer status not verified from the page). Rationale: all 2.5 models have 1M context and the router only selects Flash or Pro, so auto-switching could not pick a smaller-context model. No linked PR/branch (Relationships: "None yet"); parent #9033 ("Fix memory compression edge cases and usability issues", added 2025-09-22); #8132 marked duplicate 2025-10-02. Last comment 2026-03-22 (community script that compacts a session manually). **Wording fix:** not "closed without a linked fix" in the sense of unknown date/reason - it is closed as completed with a premise-based rationale and no fix linked; the `/compress` maxOutputTokens failure was not shown fixed. Keep manual `/compress` checkpoints.

**Remote Control + Trusted Devices (H, code.claude.com/docs/en/remote-control, live 2026-11-25; read to ~line 550 of 590):**
- Plans: **Pro, Max, Ultra, Team, Enterprise** (card omitted Ultra); API keys unsupported; Team/Enterprise need an Owner toggle (off by default); custom roles need both cloud-sessions and "Claude Code remote control" permissions. Unavailable on Bedrock/Agent Platform/Foundry, `ANTHROPIC_BASE_URL` off api.anthropic.com, Claude apps gateway; ZDR and HIPAA orgs cannot enable it. Feature-flag vars: `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` or `CLAUDE_CODE_DISABLE_FEATURE_FLAGS` make it unavailable (troubleshooting also lists `DISABLE_GROWTHBOOK`); `DISABLE_TELEMETRY`/`DO_NOT_TRACK` OK from v2.1.283 (v2.1.304 in Desktop) unless the org requires Trusted Devices.
- Server mode flags: `--name`, `--remote-control-session-name-prefix`, `-c/--continue` and `--session-id` (v2.1.200+; not combinable with `--spawn`/`--capacity`/`--create-session-in-dir`), `--spawn same-dir|worktree|session`, `--capacity` (default 32), `--[no-]create-session-in-dir`, `--permission-mode`, **`--settings <file>` (v2.1.321+, passed AFTER `remote-control`)**, `--chrome/--no-chrome` (v2.1.273+), `-d/--debug` (v2.1.282+), `--debug-file`, `--verbose`; **`--sandbox/--no-sandbox` removed in v2.1.300 (errors)**. Alias `claude rc`. Global flags placed before `remote-control` are not carried over and most stop the server starting. Interactive: `claude --remote-control`/`--rc`; in-session `/remote-control` or `/rc`.
- Timeouts (all re-confirmed): server mode gives up after ~10 min offline and exits; interactive retries until the network returns; HTTP 403 retried up to 3 min; presence-heartbeat failure ~30 min; forwarded dialogs expire after 5 min (`dialogExpiry`, v2.1.224+); resume window ~4 hours, `--continue`/`--session-id` unarchive from v2.1.228; crashed server-mode session re-served when a device messages it (v2.1.238+). `claude --continue`/`--resume` reconnect to the RC session recorded in the conversation. Tmux/screen advice is on the page, paraphrased: "If you run `claude` from a terminal on a remote machine, start it inside `tmux` or `screen` to keep the session running after you disconnect from SSH." (the card's quotation does not match the current text).
- New: browser **Fork** of a session (v2.1.277+; declined if session busy or VS Code/SDK-hosted); RC disconnects on `/resume` or `/teleport` when a share link exists (v2.1.324+ check); `remoteControlAtStartup` setting; mobile push notifications.
- **Trusted Devices (H, read in full):** available on **Pro, Max, Ultra, Team, Enterprise**, off by default; Owner enables org-wide (Organization settings > Capabilities > Remote sessions) or an individual turns on "Require trusted devices". Enrolled device + sign-in no more than 18 hours old; Face ID/Touch ID/Windows Hello/passkey step-up refreshes it; hardware key fallback; the CLI host gets its credential automatically at sign-in; sessions already running when the toggle flips are not retroactively protected. **The current page carries NO "beta" label** - card wording "still BETA" is unsupported as of today.

**Cursor (pass 2):**
- Changelog pages 2 and 3 read (H): page 2 = Oct 6 "Remote control for local agents"; Sep 23 "Rollouts and Security Review" (usage credits "roughly 50 and 500 changes"); Sep 10 "Cursor Projects"; Sep 2 "Self-hosted machines"; Aug 27 "Start from scratch, without a repo". Page 3 = Aug 19 "Cloud Agents and Cursor Harness Improvements" (Custom modes pin a skill; `/goal`); Aug 17 "Origin Code Hosting"; Aug 13 "Cloud Agents Start 3x Faster with Builds"; Aug 3 "Google Workspace Plugins"; Jul 29 "Cursor, now on iPad". **Oct 6-13 gap closed: the only entry is Oct 6 (page 1 starts Oct 13).** No entry on pages 2-3 mentions context window, summarisation, mode-switch context or token billing. (Page 1 entries Oct 13 - Nov 6 are from pass 1, not re-read.)
- Docs: cursor.com/docs/agent/modes (H): says nothing about context on mode switch; names Shift+Tab (Plan Mode) and the mode picker, not Cmd+./Ctrl+. . cursor.com/docs/agent/overview (H): "There is no limit on the number of tool calls Agent can make during a task"; nothing on context window, truncation or MAX. cursor.com/docs/models-and-pricing (H): MAX mode "extends a model's context window beyond the default limit and is billed at the model's API rate plus 20%"; "Max Mode is available only on legacy request-based plans"; per-model cache pricing is listed (e.g. "Cache: writes 1.25x, reads 0.1x" on the Haiku 4.5 row), so a warm re-send is at a cache-read rate (M, inference); the page does not describe agent history re-send.
- **Therefore unverified/unsourced in the card body:** "mode switch starts a fresh context window (confirmed, Cursor docs)"; "MAX removes ... tool-call cap (200 tools)"; "150K by the 50th tool call"; "<50% window". Treat as practitioner lore, L.

**Stale cross-references - true dates (H, frontmatter `verified:` read this run):** card.cursor-ide verified **2026-11-23**; card.gemini-cli verified **2026-10-08** (frontmatter not yet bumped; it may be the next to refresh); card.codex-cli verified **2026-11-23** (companion not listed in the old "refresh alongside" block).

**Convergence:** n/a. **Quiet:** Cursor local-IDE context mechanics (no change visible in Aug 19 - Oct 6 entries read; Oct 13 - Nov 6 per pass 1).
**Manual-check:** MorphLLM page (Cursor window claim) read directly; Cursor forum/docs for mode-switch context behaviour (test in-product); Codex `forked_from_id`, past-prompt branching, on-disk path, `/undo` history; RC doc troubleshooting tail + "Ultraplan disconnects RC" and sshd SIGHUP claims; Claude Code commands page rows for `/branch`/`/fork`/`/subtask`; v2.1.277 subagent-result framing; Cursor changelog page 1 re-read; whether SandyTao520 is a maintainer.

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
- **GitHub bug #8609 (CLOSED; see the 2026-10-08 bullet below):** Gemini CLI long session → auto model-switch → crash; `/compress` recovery also failed (requested maxOutputTokens 100117 vs API max 65536) → session unrecoverable. Marked p2. Closed as completed on 2025-10-15 (by SandyTao520) with NO linked fix/PR; the closing rationale was that an auto-switch to a smaller-context model cannot occur (2.5 models are 1M; router returns flash/pro only), not that the `/compress` maxOutputTokens failure was fixed — do not assume it is fixed; re-test long unattended sessions and keep manual `/compress` checkpoints.
- **Cursor context mechanics** are not published. The <50% effective-window figure has no Cursor-specific source on file (2026-11-25); 80% vs 12% is one Reddit user's estimate relayed by InfoQ (2026-04), not a measurement; "mode switch = fresh context" and "200-tool cap" are unsourced (cursor.com/docs agent pages say nothing / "no limit on tool calls").
- **Claude Code Plan subagent isolation** is GA and documented (code.claude.com); the ~7x figure is Anthropic-official (code.claude.com/docs/en/costs) but applies to AGENT TEAMS with teammates in plan mode, not to subagents; MindStudio (2026-08-23) merely repeats it.
- **Subagent model resolution order (v2.1.251+, 2026-09-02, H):** per-invocation `model` → subagent frontmatter `model` → `CLAUDE_CODE_SUBAGENT_MODEL` env → main-conversation model. Env var no longer outranks frontmatter. `CLAUDE_CODE_SUBAGENT_MODEL_FORCE=1` (v2.1.257) is the hard override. Explore = parent's model; only when the parent runs Fable does it switch to the `opus`-alias model (subscription / Console / `ANTHROPIC_BASE_URL` gateway) or stay on Fable (Bedrock/Agent Platform/Foundry/Claude Platform on AWS/apps gateway) (H, 2026-11-25; the "v2.1.198 cap" was not re-confirmed).
- **Cursor Cloud Agents (2026-08-19, M):** subagents run in an isolated project copy with clean context in their own cloud env (+ `/goal`, Custom Modes, mid-run steering). Different surface from the local-IDE mechanics in §Cursor below — not yet covered by this card.
- **Fork cost claim partly stale (2026-10-08, H):** fork mode is on by default from v2.1.302 (interactive terminal since v2.1.232); `CLAUDE_CODE_FORK_SUBAGENT=0` turns it off; `Agent(fork)` in `permissions.deny` stops forks only, and **forks share the parent's prompt cache**, so they are cheaper than fresh subagents for context-heavy work. The §Claude Code lines "Long parent + fork = full re-read cost" and the table's "Expensive for long parents" predate this — read them as cache-miss worst case. Forks cannot spawn forks.
- **Subagent limits (2026-10-08, H):** nesting default 3 layers (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`); 20 concurrent (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`). Subagent results now arrive framed/indented as subagent output (v2.1.277). Built-in Explore = parent's model, except with a Fable parent: Opus-alias model on subscription/Console/`ANTHROPIC_BASE_URL` gateway, Fable on Bedrock/Agent Platform/Foundry/Claude Platform on AWS/apps gateway (2026-11-25, H); still skips CLAUDE.md + git status; Plan inherits.
- **Gemini CLI subagents (2026-10-08, H):** enabled by default, no preview/enterprise label on the docs page; disable via `experimental.enableAgents:false`; `.gemini/agents/*.md`; recursion guard holds even with `*` tool wildcard; new: browser agent, inline `mcpServers` in agent frontmatter, subagent policy rules (`~/.gemini/policies/`), remote subagents over A2A. Banner (2026-11-25): "Unpaid tier and Google One users: Gemini CLI was replaced by Antigravity CLI on June 18th, 2026." and "Gemini CLI has not been optimized for Gemini 4 Argon. To use Gemini 4 Argon, please use Antigravity." Browser agent is disabled by default.
- **Bug #8609 (2026-10-08, H):** confirmed CLOSED; opened 2025-09-17, label priority/p2. The issue page shows NO linked PR/branch/milestone; closed as completed on 2025-10-15 (2026-11-25 recheck) with a premise-based rationale, not a stated fix. Earlier "treat as resolved" wording is too strong: treat as closed-without-evidence-of-fix; keep manual `/compress` checkpoints.
- **Remote Control requirements (docs, re-read 2026-11-25, H; to ~line 550):** Pro/Max/Ultra/Team/Enterprise (Team/Ent need an Owner toggle), no API keys; ZDR/HIPAA orgs cannot enable it. NOT available on Bedrock/Vertex/Foundry, with `ANTHROPIC_BASE_URL` pointing off api.anthropic.com (gateway/proxy), or via the Claude apps gateway; unavailable when `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` or `CLAUDE_CODE_DISABLE_FEATURE_FLAGS` is set (troubleshooting also lists `DISABLE_GROWTHBOOK`); `DISABLE_TELEMETRY`/`DO_NOT_TRACK` are OK from v2.1.283 unless the org requires Trusted Devices. Server mode `claude remote-control` flags: `--spawn same-dir|worktree|session`, `--capacity` (default 32), `-c/--continue` and `--session-id` (v2.1.200+), `--permission-mode`, `--chrome` (v2.1.273+), `--debug` (v2.1.282+). Interactive: `claude --remote-control`/`--rc`; in-session `/remote-control` or `/rc`. Untrusted directory → trust prompt (exits with an error without a TTY). Global flags placed before `remote-control` are not carried over and most make it refuse to start; `--settings <file>` is supported AFTER `remote-control` (v2.1.321+); `--sandbox/--no-sandbox` were removed in v2.1.300 (they error). Timeouts (docs, pass 3, H): server mode `claude remote-control` gives up after roughly 10 minutes without network and the process exits; interactive sessions retry for as long as the outage lasts; HTTP 403 retries up to 3 min; presence heartbeat unreachable ~30 min → disconnect; forwarded dialogs expire after 5 min (`dialogExpiry`, v2.1.224); server-session resume window ~4 hours (v2.1.228+: `--continue`/`--session-id` can unarchive); a crashed server-mode session is re-served when a connected device sends a message (v2.1.238); outside server mode, one remote session per interactive process. Resume: `claude remote-control` restores all sessions the server was serving, `--continue` only the starting one, `--session-id <id>` one specific; sessions begun with `/remote-control` or `claude --remote-control` resume via `claude --continue`/`--resume`.
- **Trusted Devices (docs, re-read 2026-11-25, H):** available on Pro, Max, Ultra, Team AND Enterprise, off by default (an Owner enables it org-wide on Team/Enterprise, an individual turns on "Require trusted devices" on Pro/Max/Ultra); the page carries no "beta" label (the earlier "still BETA" is unsupported). Needs an enrolled device credential + a sign-in ≤18 h old; biometric step-up (Face ID / Touch ID / Windows Hello / passkey) refreshes the session; the CLI host receives its credential automatically at sign-in. The older "Team/Enterprise only" wording in §Remote session restore is WRONG (corrected below).
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

¹ Was Haiku in earlier versions; no longer Haiku-cheap. The "v2.1.198" attribution was NOT re-confirmed 2026-11-25 (docs tie v2.1.198 only to `CLAUDE_CODE_DISABLE_EXPLORE_PLAN_AGENTS`).

**Plan mode mechanics:**
The built-in Plan subagent does all exploration in its own context window. When plan mode returns to the main session, only the plan text arrives — no file contents, no grep output, no tool chain.

**Orchestrator accumulation math:**
Three subagents × 2K return each = 6K tokens added to orchestrator per cycle (illustrative arithmetic; not found in the MindStudio article read 2026-11-25 — source not found, unverifiable).
Anthropic's costs docs: agent TEAMS use ~7x more tokens than standard sessions when teammates run in plan mode (each teammate has its own context window). This is NOT a measured multiplier for ordinary subagents; subagent results return only a summary + small trailer.

**Quantified plan-mode savings (CheesecakeLabs blog, published 2026-05-26, updated 2026-08-24; author experience, not a controlled study):**
- 20–35% cheaper than direct mode on typical features
- Example (modeled hypothetical at Sonnet 4.6 rates, NOT client data; ~21% saving): direct ~79K input + 25K output ≈ $0.62 → plan ~55K input + 22K output ≈ $0.49
- Complex features with reverts: $40 → $8 switching to plan-then-execute
- Correction cost: ~200 tokens to fix a plan vs ~50K to revert a half-executed implementation (illustrative figure in the post, not measured; "$40 → $8" is an unnamed-client anecdote)

---

## Cursor IDE — effective context and mode switching

**Effective vs. advertised window:**
Cursor injects system prompt + codebase index results + conversation history + auto-included file
contents before any user content reaches the model. Effective available window = consistently
**< 50% of advertised** (L: no Cursor-specific source found 2026-11-25; MorphLLM's generic pages cite RULER ~50–65% effective context; forum reports show reserved tokens, e.g. 175K of 200K).

**Accumulation in a single session:**
By the 50th tool call in a session, conversation history alone can exceed 150K tokens (source not found — unverifiable) — re-sent
on every subsequent call. Billing: Cursor's models-and-pricing page lists per-model cache rates (e.g. reads 0.1x), so a warm re-send is billed at a cache-read rate, not full price (M, inference; the page does not describe agent re-send explicitly). For Claude Code the same holds while the cache is warm (costs docs, H).

**Mode switching:**
Mode switching: UNVERIFIED (2026-11-25) — cursor.com/docs/agent/modes says nothing about context on a mode switch and names Shift+Tab, not Cmd+./Ctrl+.; the "fresh context window" claim has no source on file (source not found — unverifiable). Treat as practitioner lore (L).
Continuity is lost at the switch; cost resets. Switching is a hard boundary, not a handoff.

**Real-world comparison (InfoQ, Cursor 3 launch, Apr 2026):**
One Reddit user, relayed by InfoQ (2026-04), estimated the same workflow at 12% daily usage in Claude Code vs **80% in Cursor** — anecdotal, no method; both on
comparable models. InfoQ's own conclusion is only that harness context construction and tool-call handling can significantly affect effective cost; the per-turn-overhead attribution is this card's inference, not a measurement.

**MAX mode:** per cursor.com/docs/models-and-pricing (2026-11-25), extends the context window beyond the default and is billed at the model's API rate plus 20%, available only on legacy request-based plans. "Removes the tool-call cap (200 tools)": source not found — cursor.com/docs/agent/overview says "There is no limit on the number of tool calls Agent can make during a task". Original line continues: uses token-based API
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
Marked p2, closed as completed 2025-10-15 with no fix linked (rechecked 2026-11-25; rationale = smaller-model switch cannot occur). Do NOT treat the `/compress` failure as resolved; re-test long
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
| Cursor — after mode switch | UNVERIFIED (no Cursor doc found stating a reset) | — | Treat as lore (L) |
| Gemini CLI — no subagents | Accumulates per turn | — | Highest crash risk at scale |
| Gemini CLI — subagents (standard) | Isolated per subagent | Return summary | Mirrors Claude Code clean pattern |
| Gemini CLI — shell-spawned | Per-spawn fresh | Explodes per spawn | Expensive/call, clean across |

---

## Session fork / branch / rewind — cross-tool (added 2026-08-05)

`full study: raw.research/cli-fork-branch/report/raw.cli-fork-branch.2026-08-05.md · companion: card.codex-cli (seeded this pass)`

Distinct axis from the subagent-context table above: this is **SESSION-level** branching (a whole conversation transcript forked to a new ID), not subagent context isolation. Claude Code and Codex CLI diverge sharply.

| Axis | Claude Code (v2.1.212+) | Codex CLI (card verified at 0.146.0; latest stable 0.172.0, 2026-11-24) |
|---|---|---|
| Session fork | `/branch` (in-session) · `--fork-session` (new process) · `/fork` (→ background session) — TUI-first, **full transcript copy** | `codex fork [ID]/--last/--all` — standalone subcommand, headless-first, `forked_from_id` lineage; public RPC still **copies** history |
| In-session branch | `/branch [name]` | `/fork` — "Clones the current chat into a new chat with a fresh ID" (H, learn.chatgpt.com 2026-11-25); edit-a-past-prompt auto-branch NOT checked |
| Rewind / undo | `/rewind` (alias `/undo`) + Esc-Esc, code+convo checkpoints per prompt; limits documented (Bash-only, subagent edits, symlinks) | `/undo`, `/rewind`, `/branch` not mentioned on the Codex command page (2026-11-25); "shipped then removed" NOT re-checked. Use git. |
| On-disk | `~/.claude/projects/<slug>/<id>.jsonl` | `~/.codex/sessions/YYYY/MM/DD/rollout-<ts>-<uuid>.jsonl[.zst]` |
| Remote/cross-machine | `--teleport` (cloud→local) · `--cloud` (local→cloud, fresh) · `remote-control` (steer local from web) | none in CLI (`codex cloud` = cloud chats only; SSH in separate Codex App alpha) |

**⚠ v2.1.212 name swap (Claude):** `/fork` and `/subtask` swapped — `/subtask` = in-session subagent fork; `/fork` = background SESSION copy, EXCEPT when agent view is turned off: then `/subtask` is unavailable and `/fork` starts the forked subagent (H, sub-agents docs 2026-11-25). Pre-2.1.212 tutorials have them backwards. (The v2.1.212 attribution itself was not re-checked.)

**Hygiene implications (reinforce the plan→MD→fresh pattern):**
- **`/rewind` is best-effort, NOT reliable** — official docs list Bash-only changes, subagent edits, external edits and symlinks/hard links as not restored; #70727 (2026-06-25, "never worked", closed not-planned by stale automation) and #18516 (multi-file, closed as duplicate of #15489) report code restore failing. Git remains source of truth. Verdict *refuted that rewind reliably restores* HOLDS (H, 2026-11-25).
- **Fresh+brief beats resume for a context PIVOT; resume/continue wins for continuous same-file work** (holds-with-caveats). Resume tax on long thinking-heavy Claude sessions: one reporter's estimate of ~156k tok replay with ~25% opaque thinking-signatures for a single ~24h/480-message session (#42260, closed not-planned by stale automation; other commenters saw 2.6–20%+); read as "can be large", not typical.
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

The ~7x agent-teams multiplier (Anthropic docs; plan-mode teammates) and the 20-35% plan-mode savings (one consultancy's experience) are **directional support** — not measured proof — for why these
gates are load-bearing — not just procedural discipline.

---

## Cards to refresh alongside this one

- `card.cursor-ide` — verified 2026-11-23 (read 2026-11-25). Add: effective context window (unsourced), mode-switch token-reset behavior (unsourced), real-world 80% vs 12% comparison (Reddit anecdote via InfoQ); also fix the sibling-card claims listed above.
  mode-switch token-reset behavior, real-world 80% vs 12% comparison.
- `card.gemini-cli` — verified 2026-11-25 (read 2026-11-25; frontmatter not bumped). Add: bug #8609 (closed as completed 2025-10-15, no fix linked), `/compress`
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
- **Trusted Devices** (Pro/Max/Ultra/Team/Enterprise, off by default; no "beta" label on the 2026-11-25 docs page): RC viewing/steering bound to an enrolled device + sign-in ≤18 h old with biometric step-up. Orthogonal to recovery; matters only if the org toggles it on.
- **Prevent it:** `tmux new -s work` → then `claude` inside it. Docs (paraphrase, 2026-11-25 text): "If you run `claude` from a terminal on a remote machine, start it inside `tmux` or `screen` to keep the session running after you disconnect from SSH." (The "Ultraplan disconnects active RC" and remote-`sshd` SIGHUP statements in the Clocks bullet were not found in the doc text read; unverified.)

**Full guide (dated, sourced):** `raw.research/harness/reports/2026-08-01-remote-control-tmux-ssh-persistence.md`
**Recheck source:** https://code.claude.com/docs/en/remote-control
