---
card: card.session-hygiene
brand: Cross-tool — Claude Code CLI · Cursor IDE · Gemini CLI (session hygiene + token distro)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-02
half_life: ~3-4 weeks (Gemini subagents in preview; Cursor mechanics underdocumented; numbers shift on each release)
half_life_days: 28
recheck:
  - https://code.claude.com/docs/en/sub-agents          # Claude Code — subagent isolation mechanics
  - https://code.claude.com/docs/en/context-window      # Claude Code — context window visualization
  - https://geminicli.com/docs/core/subagents/          # Gemini CLI — subagent docs (preview API)
  - https://github.com/google-gemini/gemini-cli/issues/8609  # known model-switch crash bug
  - https://cursor.com/changelog                         # Cursor — most opaque; changelog is primary signal
# companion cards: card.claude-code · card.cursor-ide · card.gemini-cli
# relate-to-canon: canon.context-economy (gate-shape + scoped delegation) · canon.cost-gradient (spend by demand)
---

# Session hygiene — token distro and context isolation across tools

## Research origin

**Session:** @Epoch, 2026-07-02. All sources live-fetched; no training-data recall.

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

- **Gemini CLI subagents** = PREVIEW as of 2026-07-02 (launched Apr 2026). API shape can change.
- **GitHub bug #8609 (open):** Gemini CLI long session → auto model-switch → crash; `/compress` also fails → session unrecoverable. Not resolved as of this card.
- **Cursor context mechanics** are not fully published. The <50% effective window and 80% vs 12% numbers are practitioner-measured, not Cursor-official.
- **Claude Code Plan subagent isolation** is GA and documented (code.claude.com); the 7× multi-agent multiplier is from MindStudio enterprise analysis (not Anthropic-official).

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

**With subagents (preview, Apr 2026):**
- Subagent runs in an isolated context loop.
- Intermediate tool calls (reading files, running greps) are **purged from main session history**.
- Orchestrator receives only the concise return summary.
- Subagents cannot spawn sub-subagents (recursion guard — prevents token cascade).

**Shell-spawned isolated sessions (advanced pattern):**
Orchestrator writes a task prompt to a file → spawns a fresh `gemini` process via shell tool.
Token usage per spawn "explodes" (full system context reload each time) but sessions are
hermetically isolated — no history carries across.

**Known crash pattern (bug #8609, open):**
Long session on large-context model → CLI auto-switches to smaller model → accumulated context
(documented: 8.1M tokens) exceeds smaller model's cap → API error. `/compress` recovery also
fails (requests `maxOutputTokens = 100K+`; API max = 65,536). Session becomes unrecoverable.
Risk window: any long Gemini CLI session without manual `/compress` checkpoints.

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
| Gemini CLI — subagents (preview) | Isolated per subagent | Return summary | Mirrors Claude Code clean pattern |
| Gemini CLI — shell-spawned | Per-spawn fresh | Explodes per spawn | Expensive/call, clean across |

---

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

**Verified 2026-08-01 (@Epoch). This section only; rest of card still dated 2026-07-02.**

Fills the gap these cards assumed away: recovering a Claude Code session running on a *remote* box when the SSH client drops/freezes.

- **Remote Control** (shipped 2026-02-25, preview; Pro/Max/Team/Enterprise, no API keys) is a sync layer, not cloud compute. The `claude` process stays on your machine (outbound HTTPS only, no inbound ports); claude.ai/code + mobile are a window into it. A session that stays green on the phone after your terminal dies = the host process is still alive and RC-connected.
- **Recover the terminal:**
  - Launched inside `tmux`/`screen` → SSH back, `tmux attach` (or `tmux attach -t <name>`). Clean path.
  - Launched directly in the SSH shell → cannot re-grab the dead PTY. From the same project dir in a fresh shell: `claude -c` (`--continue`) or `claude --resume` — reconnects to the RC session recorded in that conversation (transcript is server-side). Server-mode variant: `claude remote-control -c` (v2.1.200+).
- **`! claude --resume`** with a leading `!` is the run-shell-from-inside-a-session form — NOT the recovery path. Restore from a plain shell.
- **Clocks:** host offline >~10 min → RC times out, process exits (restart + resume). No multiplexer → remote `sshd` can SIGHUP `claude` once keepalive declares the frozen client dead, so reconnect promptly or hold from phone. Ultraplan disconnects active RC.
- **Prevent it:** `tmux new -s work` → then `claude` inside it. Official: "To keep a session running on a remote machine after you disconnect from SSH, start it inside tmux or screen."

**Full guide (dated, sourced):** `raw.research/harness/reports/2026-08-01-remote-control-tmux-ssh-persistence.md`
**Recheck source:** https://code.claude.com/docs/en/remote-control
