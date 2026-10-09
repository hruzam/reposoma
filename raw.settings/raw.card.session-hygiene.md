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
# companion cards: card.claude-code · card.cursor-ide · card.gemini-cli
# relate-to-canon: canon.context-economy (gate-shape + scoped delegation) · canon.cost-gradient (spend by demand)
---

# Session hygiene — token distro and context isolation across tools

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
- **Fork cost claim partly stale (2026-10-08, H):** docs say fork mode is default-on in interactive sessions (v2.1.232+), OFF in `-p`/SDK (`CLAUDE_CODE_FORK_SUBAGENT=1|0` overrides), and **forks share the parent's prompt cache**, so they are cheaper than fresh subagents for context-heavy work. The §Claude Code lines "Long parent + fork = full re-read cost" and the table's "Expensive for long parents" predate this — read them as cache-miss worst case. Forks cannot spawn forks.
- **Subagent limits (2026-10-08, H):** nesting default 3 layers (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`); 20 concurrent (`CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS`). Subagent results now arrive framed/indented as subagent output (v2.1.277). Built-in Explore = main model (Opus when main is Fable), still skips CLAUDE.md + git status; Plan inherits.
- **Gemini CLI subagents (2026-10-08, H):** enabled by default, no preview/enterprise label on the docs page; disable via `experimental.enableAgents:false`; `.gemini/agents/*.md`; recursion guard holds even with `*` tool wildcard; new: browser agent, inline `mcpServers` in agent frontmatter, subagent policy rules (`~/.gemini/policies/`), remote subagents over A2A. Banner: Gemini CLI "was replaced by Antigravity CLI on June 18th, 2026" for Unpaid-tier and Google One users.
- **Bug #8609 (2026-10-08, H):** confirmed CLOSED; opened 2025-09-17, label priority/p2. The issue page shows NO linked PR/branch/milestone and no closing date — closed with no stated fix. Earlier "treat as resolved" wording is too strong: treat as closed-without-evidence-of-fix; keep manual `/compress` checkpoints.
- **Remote Control requirements (docs, live 2026-10-08, H; first ~120 lines read):** Pro/Max/Team/Enterprise (Team/Ent need an Owner toggle), no API keys. NOT available on Bedrock/Vertex/Foundry, with `ANTHROPIC_BASE_URL` pointing off api.anthropic.com (gateway/proxy), or via the Claude apps gateway; unavailable when `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` or `DISABLE_GROWTHBOOK` is set; `DISABLE_TELEMETRY`/`DO_NOT_TRACK` are OK from v2.1.283 unless the org requires Trusted Devices. Server mode `claude remote-control` flags: `--spawn same-dir|worktree|session`, `--capacity` (default 32), `-c/--continue` and `--session-id` (v2.1.200+), `--permission-mode`, `--chrome` (v2.1.273+), `--debug` (v2.1.282+). Interactive: `claude --remote-control`/`--rc`; in-session `/remote-control` or `/rc`. Untrusted directory → trust prompt (exits with an error without a TTY). Passing global flags such as `--settings` before `remote-control` makes it refuse to start. Timeouts (docs, pass 3, H): server mode `claude remote-control` gives up after roughly 10 minutes without network and the process exits; interactive sessions retry for as long as the outage lasts; HTTP 403 retries up to 3 min; presence heartbeat unreachable ~30 min → disconnect; forwarded dialogs expire after 5 min (`dialogExpiry`, v2.1.224); server-session resume window ~4 hours (v2.1.228+: `--continue`/`--session-id` can unarchive); a crashed server-mode session is re-served when a connected device sends a message (v2.1.238); outside server mode, one remote session per interactive process. Resume: `claude remote-control` restores all sessions the server was serving, `--continue` only the starting one, `--session-id <id>` one specific; sessions begun with `/remote-control` or `claude --remote-control` resume via `claude --continue`/`--resume`.
- **Trusted Devices (docs, pass 3, H):** still BETA, but available on Pro, Max, Team AND Enterprise (off by default; an Owner enables it org-wide on Team/Enterprise, an individual turns on "Require trusted devices" on Pro/Max). Needs an enrolled device credential + a sign-in ≤18 h old; biometric step-up (Face ID / Touch ID / Windows Hello / passkey) refreshes the session; the CLI host receives its credential automatically at sign-in. The older "Team/Enterprise only" wording in §Remote session restore is WRONG (corrected below).
- **Cursor (2026-10-08, H for items, L for mechanics):** changelog Aug 27–Oct 6 shows no local-IDE context-mechanics change; new surfaces are Cursor Projects beta (Sep 10, cloud coordinator agent delegating to other agents with shared context files) and remote control of local agents from iOS (Oct 6).

---

## Claude Code CLI — subagent context isolation

**Fresh subagent (default):**
- Receives only its own system prompt + basic env (CWD, git status). NOT the parent conversation.
- Internal tool-call chain stays in its own window; never enters parent.
- Orchestrator context grows by the return-value size only — not by the subagent's working chain.

**Fork subagent:**
- Inherits the ENTIRE parent conversation to date.
- Use only when the subagent genuinely needs the full history. Long parent + fork = full re-read cost.

**Built-ins and their isolation:**
| Subagent | Model | Reads CLAUDE.md? | Isolated context? |
|---|---|---|---|
| Explore | inherits main (capped Opus) ¹ | No (skips) | Yes |
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

**Known crash pattern (bug #8609, CLOSED 2026-08-01):**
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
| Claude Code — fork subagent | Full parent conversation | Inherited + return value | Expensive for long parents |
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
