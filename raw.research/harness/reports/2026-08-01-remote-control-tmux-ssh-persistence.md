# Restoring a frozen or dropped remote Claude Code session — Remote Control + tmux + SSH persistence
**Date:** 2026-08-01
**Filed under:** raw.research / harness
**Dedicated to:** architects routed here; operators running Claude Code on a remote box over SSH/Tailscale
**Status:** VERIFIED — all mechanics live-fetched from official Claude Code docs on 2026-08-01; environment-specific facts (§7) inferred from `ia-sync/AGENTS.md`, not live-verified

**Research origin:** @Epoch, 2026-08-01. Triggered by operator incident — connected home→office over Tailscale, home client froze, terminal lost, but the Claude session stayed visible/steerable on the mobile app. Question: how to rewire a terminal back to a still-living remote session, and is it alive *because* it was in remote-control regime.

**Companion:** `raw.settings/raw.card.session-hygiene.md` carries the terse card entry + pointer here.

---

## 1 — Why the session survives when your terminal dies

If a remote Claude Code session stays alive and steerable on your phone after your SSH client freezes, that is the signature of **Remote Control** (shipped 2026-02-25, research preview, Pro/Max/Team/Enterprise — API keys not supported).

Remote Control is a **synchronization layer**, not cloud compute. The `claude` process keeps running on your machine (execution + filesystem stay local); it makes **outbound HTTPS only** to `api.anthropic.com` and **opens no inbound ports**. claude.ai/code and the mobile app are just a window into that local process. The transcript is stored server-side so devices stay in sync and the session can reconnect after a network drop.

**So:** your frozen home machine killed the *client* end of the SSH pipe. The `claude` process on the office box kept running and kept talking to Anthropic over its own HTTPS link — which is what the phone shows (computer icon + green status dot = host process online). The terminal did **not** survive; the session did, independently of your SSH terminal.

---

## 2 — Diagnosis decision tree

```
Session visible + green on phone?
├── YES → host process is alive. Recover terminal (§3). Steer from phone meanwhile (§3.0).
└── NO / grey → host process likely exited (see §5 timeouts). Restart + resume (§3.2).

How was `claude` launched on the remote box?
├── Inside tmux / screen        → clean reattach (§3.1). Best case.
└── Directly in the SSH shell   → cannot re-grab the dead PTY; resume by conversation (§3.2).
```

---

## 3 — Restore paths

### 3.0 First move — steer from the phone (safety net)
You already have a live window. Send messages, approve tool calls, keep the turn moving from the mobile app / claude.ai/code while you recover the terminal. Nothing is lost; the transcript is server-side.

### 3.1 If you launched inside tmux/screen — reattach (clean path)
SSH back into the remote box, then:
```bash
tmux ls              # list sessions, find the name
tmux attach          # or: tmux attach -t <name>
#   screen -ls  →  screen -r <name>   for screen
```
Terminal fully restored, still synced to the phone. This is the case to engineer for (§6).

### 3.2 If you launched directly in the SSH shell — resume by conversation
You cannot reattach a terminal to a PTY-orphaned process. But because it is Remote Control, the conversation is recoverable server-side. From the **same project directory** on the remote box, in a **fresh shell**:
```bash
claude -c            # --continue: resume most recent session in this dir
claude --resume      # pick the session from the list
```
Official behavior: *"When you resume a conversation with `claude --resume` or `claude --continue`, Claude Code reconnects to the Remote Control session recorded in that conversation."* You may lose an in-flight turn, not the thread. If reconnect fails with *"Couldn't reconnect to your Remote Control session,"* your local session keeps running without RC — run `/remote-control` to retry, or start clean.

There is also a **server mode** resume for RC specifically (v2.1.200+): `claude remote-control -c` / `--continue` resumes the most recent Remote Control session started from that directory instead of creating a new one; or `claude remote-control --session-id <id>` for a specific one.

### 3.3 Note on the `!` prefix
`! claude --resume` with a leading `!` is the **run-a-shell-command-from-inside-an-existing Claude session** form. That is for spawning a shell from a session you are already in — **not** the recovery path here. To restore a *lost* session you run `claude --resume` / `claude -c` from a **plain shell** (optionally inside `tmux`), as in §3.1–3.2.

---

## 4 — Ways to start Remote Control (so you recognize the regime)

| Form | Command | Notes |
|---|---|---|
| Server mode | `claude remote-control` | Stays running, serves remote connections; spacebar shows QR. Supports `-c`, `--session-id`, `--spawn worktree`, `--capacity`. |
| Interactive + RC | `claude --remote-control` (`--rc`) | Normal local session, also controllable remotely. Optional name arg. |
| From existing session | `/remote-control` (`/rc`) | Carries over current conversation history. |
| Auto for all sessions | `/config` → **Enable Remote Control for all sessions = true** | Every interactive session registers one remote session. |

Connect from another device: open the session URL, scan the QR, or open claude.ai/code / the app and pick the session by name (green dot = online). `/rc active` sits in the footer while connected.

---

## 5 — Timeouts & failure modes (know the clocks)

- **~10-minute network rule:** if the **host** machine is awake but cannot reach the network for ~10 min, the RC session times out and the process exits → then only §3.2 (restart + resume) applies. In the frozen-client incident this clock does **not** run, because it is the *host's* link to Anthropic that matters, and the office host had network — only the home client froze.
- **Host process must keep running:** closing the terminal / quitting VS Code / killing `claude` ends the session. Hence tmux (§6).
- **SIGHUP risk without a multiplexer:** when your client froze, the remote `sshd` may not tear down the TCP connection immediately — it holds the PTY open until keepalive (`ClientAliveInterval`) declares it dead. A `claude` that is a direct child of that shell, not under tmux/`nohup`/`disown`, can get SIGHUP when that fires. **Reconnect sooner rather than later, or hold it from the phone.**
- **Ultraplan disconnects RC:** starting an ultraplan session drops any active Remote Control session (both occupy claude.ai/code; only one connects at a time).
- **Local-only commands:** `/plugin`, `/resume` work only in the local CLI. Many others (`/model`, `/effort`, `/compact`, `/mcp reconnect`, etc.) work from mobile/web with an argument.

---

## 6 — Prevention (removes the whole failure class)

Always launch on the remote box as:
```bash
tmux new -s work     # then, inside it:
claude               # (+ --remote-control if you want phone control too)
```
Official guidance is explicit: *"To keep a session running on a remote machine after you disconnect from SSH, start it inside tmux or screen."* A frozen client then never costs you the terminal — you just `tmux attach` on reconnect (§3.1).

---

## 7 — This environment (from `ia-sync/AGENTS.md` — project context, NOT live-verified)

| | office (hruzam-120922) | home (hruzam) |
|-|-|-|
| Tailscale IP | 100.126.182.111 | 100.110.27.60 |
| claude | `~/.local/bin/claude` | via `office` alias |

Typical incident shape here: SSH home→office over Tailscale (`office` alias / `100.126.182.111`), run `claude` on the office box. If home freezes, reconnect over Tailscale and reattach per §3. **Confidence M** — machine facts from harness doc, not checked live this run; verify the `office` alias behavior and office `sshd` keepalive on the box (shell job → @Maxwell/@Delta) if precision matters.

---

## 8 — Eligibility gotchas (why RC might refuse)

RC needs claude.ai OAuth (`/login`) — **not** an API key or `CLAUDE_CODE_OAUTH_TOKEN`. It is disabled when `ANTHROPIC_BASE_URL` points off `api.anthropic.com` (LLM gateway/proxy), on Bedrock/Vertex/Foundry, and when any of `DISABLE_TELEMETRY` / `DO_NOT_TRACK` / `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` / `DISABLE_GROWTHBOOK` is set (they kill the feature-flag eval RC depends on). Run `claude doctor` to see which check failed.

---

## 9 — Sources (live-fetched 2026-08-01, CONFIDENCE H unless noted)

- Continue local sessions from any device with Remote Control — https://code.claude.com/docs/en/remote-control (primary; all §1–§5, §8 mechanics)
- Claude Code Remote Control — Simon Willison, 2026-02-25 — https://simonwillison.net/2026/Feb/25/claude-code-remote-control/ (M — commentator, ship date)
- Keep Claude Code running across SSH disconnects — https://cdmckay.org/how-to-keep-claude-code-running-across-ssh-disconnects/ (M — tmux pattern)
- `ia-sync/AGENTS.md` — office/home machine facts (§7, project context, not live-verified)

---

## Freshness / sections to refresh

RC is **research preview** — flags, the ~10-min timeout, and `--resume` reconnect behavior shift per release. Re-verify against `code.claude.com/docs/en/remote-control` on any CLI upgrade or after ~4 weeks. The min-version notes in the doc (2.1.196 / .200 / .207 / .208 / .211+) move fast — treat exact version gates as the most perishable claims here.
