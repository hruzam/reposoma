# @Epoch Research Report — Claude Code `-p` Cold Start Mechanics

Date: 2026-07-21
Triggered by: User request — deep technical understanding of `claude -p` cold start and tmux layer
Scope: Default radar + Claude Code internals
Researcher: @Epoch (Sonnet)

---

## Core question

What exactly does `claude -p` trigger at the process level — entry point, divergence from interactive mode, signal handlers, TTY handling — and does running it through tmux (send-keys vs pipe-pane vs stdin redirect) hit the same Node.js code paths?

---

## Findings

### 1. Entry point and the divergence

**Entry point:** `claude` binary → `src/cli.ts` (TypeScript, bundled to `cli.js` via `@anthropic-ai/claude-code` npm package). Argument parsing: Commander.js.

**The single decision point:** After Commander parses flags, one branch:

```
--print / -p present
    → runHeadless()  in  src/cli/print.ts
    → NO Ink, NO React, NO TUI

no --print
    → runTuiInterface()
    → dynamic import of App.tsx
    → ink.render(<App .../>)    ← full React/Ink component tree
```

These are **completely separate execution paths**. `runHeadless()` never initializes Ink or the React tree. It constructs a `StructuredIO` abstraction from the input prompt and runs the agent loop directly, emitting to stdout.

CONFIDENCE: M (code-path names from community mirror of obfuscated source); H (behavioral split confirmed in official headless docs).

SOURCE: [Official headless docs](https://code.claude.com/docs/en/headless) · [community mirror src/cli](https://github.com/yasasbanukaofficial/claude-code/tree/main/src/cli) · [DeepWiki CLI interface guide](https://deepwiki.com/kill136/claude-code-open/4-cli-interface-guide)

---

### 2. What `-p` loads on cold start

**Without `--bare` (default):** Full ambient discovery runs — CLAUDE.md files up the directory tree, hooks, skills, plugins, MCP servers, auto memory, OAuth/keychain. Same context load as interactive.

**With `--bare`:** All ambient discovery skipped — no CLAUDE.md, no hooks, no MCP config, no OAuth/keychain. `ANTHROPIC_API_KEY` must be set explicitly. This is the recommended scripted path and will become the default for `-p` in a future release.

**Session persistence:** On by default in `-p`. Disable with `--no-session-persistence`.

CONFIDENCE: H (official docs explicit on this)

---

### 3. What the cold start shell detection does

**Non-bare only.** At startup, Claude Code spawns **child subprocesses** to introspect the shell environment — alias detection, shell options (shopts), environment gathering.

Known bug (issue #12507): these subprocesses currently **inherit stdin from the parent** rather than redirecting to /dev/null. On HPC/strict-TTY systems (and potentially in some tmux configurations), the subprocess reads from stdin before the main process does, causing the main process to receive premature EOF. Confirmed via strace: `read(0, ...)` calls in the subprocess.

CONFIDENCE: H (official repo issue with strace evidence)

---

### 4. Signal handlers and stdin differences

#### Interactive mode
- Ink calls `process.stdin.setRawMode(true)` — **requires `process.stdin.isTTY === true`**. Hard crash if stdin is a pipe: "Raw mode is not supported on the current process.stdin".
- SIGWINCH handler registered for terminal resize.
- Full Ink rendering loop: Yoga flexbox, ANSI diff patching (LogUpdate), mouse events, raw keypress routing.
- `PromptInput` component routes keypresses to: vim mode, bash-escape (`!`), slash-commands (`/`), at-reference (`@`).
- Anthropic uses a **custom Ink fork** (not vanilla Ink) — handles CSI/OSC codes, `VirtualMessageList` for long sessions.

#### Headless `-p` mode
- No Ink init. No raw mode call. No SIGWINCH.
- Stdin via `StructuredIO` (`getStructuredIO()` in `structuredIO.ts`):
  - Default text format: stdin as readable stream.
  - `--input-format stream-json`: stdin parsed as NDJSON.
- **Stdin cap: 10 MB** (enforced from v2.1.128). Exceeds → non-zero exit with clear error.
- If stdin is disconnected: warning to stderr, continues with command-line prompt only. (Fixed for Windows in v2.1.211.)
- **stdout guard:** diverts stray writes to stderr (prevents pollution of JSON output).
- **SIGTERM:** aborts in-progress turn, kills Bash child process tree, runs SessionEnd hooks, exits code 143. (v2.1.212 — previously orphaned the Bash process tree in print/SDK mode.)
- **Exit:** `gracefulShutdownSync()` → sets `process.exitCode` (0 or 1) → async cleanup.

CONFIDENCE: H for behaviors documented in official changelog/docs; M for internal handler names.

---

### 5. Process model — no daemon, no socket

Each `claude -p` is a **standalone Node.js process**. No background daemon. No socket IPC. No persistent server.

```
claude (Node.js process)
  ↓  cold start shell detection subprocesses (non-bare only, stdin-sharing bug #12507)
  ↓  agent loop turns
  ↓  background Bash tool child processes (if Claude uses Bash tools)
  ↓  gracefulShutdownSync() → exit
```

Background Bash process behavior:
- Processes that don't exit (e.g., dev server side-effect) → 5-second grace period after Claude's final result, then terminated. (Before v2.1.163: held the process open indefinitely.)
- Background subagents → exempt from 5s grace; wait capped at 10 minutes (from v2.1.182). Adjustable via `CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS`.

Session continuity: stored as JSON at `~/.claude/sessions/`. `--continue` / `--resume <id>` reads those files. No persistent process to reconnect to.

CONFIDENCE: H

---

### 6. TTY detection

Node.js exposes `process.stdin.isTTY` — populated by libuv's `isatty(fd)` syscall on the underlying file descriptor.

| `process.stdin.isTTY` | `-p` present | Outcome |
|---|---|---|
| `true` (real TTY or PTY) | no | Interactive TUI, Ink raw mode |
| `false` (pipe or /dev/null) | no | Ink crashes: "Raw mode not supported" |
| `true` or `false` | yes | `runHeadless()` — Ink never called |

**Known crash (not planned fix):** Issue #36001 (v2.1.78–79): even `--output-format stream-json --input-format stream-json` without TTY can trigger the Ink raw mode error in some invocation patterns. Anthropic closed as "not planned". Workaround: use `--bare`.

**Windows bug (open):** Issue #36156 — Hook subprocesses always receive `process.stdin.isTTY === true` on Windows even when invoked as pipes. Hooks never receive tool input data. Open as of 2026-07-21.

CONFIDENCE: H for crash behaviors; M for internal flow not in source.

---

### 7. tmux layer — does it trigger the same processes?

The fundamental split: does the Node.js process's stdin fd point to a **PTY** or a **pipe**?

**tmux always interposes a PTY** between the terminal emulator and any process in a pane. So a process running inside a tmux pane sees `process.stdin.isTTY === true`.

#### `tmux send-keys` to running interactive `claude`

- PTY stdin → `process.stdin.isTTY === true` → Ink in raw mode.
- `send-keys "text" Enter` sends bytes to the tmux PTY master → flows into Node.js as raw stdin keypresses.
- **Ink's raw input handler receives them exactly as a human keypress.** Same code path, same handler.
- Known race: if send-keys is issued before the pane is ready, characters get swallowed. Workaround: split text and Enter into separate `send-keys` calls; add `sleep 0.1` after pane creation (issue #33987 pattern).

#### `tmux pipe-pane` against a running interactive session

- `pipe-pane` hooks the **output side** of the PTY — it tees stdout bytes to a pipe target.
- From Claude Code's process perspective: **invisible**. The process writes to stdout (PTY); tmux silently tees.
- **Cannot inject input.** `pipe-pane` is for capturing output only.

#### `claude -p` launched in a tmux pane (no stdin redirect)

- PTY stdin → `process.stdin.isTTY === true` inside the pane.
- But: `-p` routes to `runHeadless()` regardless. Ink never initializes. Raw mode never called.
- **PTY presence is irrelevant to `-p` behavior.** The prompt comes from the CLI argument, not keypresses.
- Stdin is readable (PTY) but `StructuredIO` reads nothing from it (no data forthcoming from a bare PTY with no user typing).

#### `cat file | claude -p` (piped stdin, inside or outside tmux)

- `process.stdin.isTTY === false` (stdin is a pipe, not the PTY).
- `-p` handles this correctly: `StructuredIO` reads the pipe stream.
- No Ink init → no raw mode error.
- 10 MB stdin cap applies.

#### `spawn('claude', ['-p', ...])` from Node.js with `stdio: 'pipe'`

- `process.stdin.isTTY === false`, stdin is a Node.js pipe.
- **Known hang:** issues #6295 (v1.0.48) and #9026 (v2.0.8) — process enters interruptible sleep (SN state), no output.
- Issue #6295 closed as "not planned" — programmatic spawn from Node.js is not a supported path.
- Recommended alternative: **Agent SDK** (Python or TypeScript packages), not CLI spawn.
- Workarounds if CLI spawn is unavoidable: provide a PTY via `node-pty`, or `script -q /dev/null claude -p '...'` to fake PTY context (community workarounds — M).

#### Full comparison table

| Invocation | `stdin.isTTY` | Ink initialized | Input reaches Claude via |
|---|---|---|---|
| Interactive in tmux pane | true (PTY) | YES — raw mode | Ink raw keypress handler |
| `send-keys` to above | — (pane running) | already up | same Ink raw handler |
| `pipe-pane` against above | — (output only) | already up | n/a (output side only) |
| `claude -p` in tmux pane | true (PTY) | NO — print path | `StructuredIO` (PTY yields nothing) |
| `cat file \| claude -p` | false (pipe) | NO | `StructuredIO` reads pipe |
| `spawn('claude', ['-p'])` | false (pipe) | NO | **hangs** in some versions |

CONFIDENCE: H for `-p` distinctions; M for exact Ink handler path in tmux send-keys.

---

## Notable version anchors (all H — official changelog)

| Version | Event |
|---|---|
| v1.0.48 | Node.js spawn hang first reported |
| v2.0.8 | `-p` TTY-dependency hang still present |
| v2.1.78–79 | stream-json headless Ink crash (closed "not planned") |
| v2.1.128 | 10 MB stdin cap enforced |
| v2.1.163 | Background Bash no longer holds `-p` open indefinitely |
| v2.1.182 | Background subagent wait capped at 10 min; `CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS` |
| v2.1.204 | SessionStart/Setup hooks restored to live delivery in stream |
| v2.1.205 | `system/init` capabilities array; schema format keyword fix |
| v2.1.208 | Truncated stream-json output fixed; Windows CRLF blank-line hang fixed |
| v2.1.211 | Windows unreadable-stdin crash fixed; `--forward-subagent-text` added |
| v2.1.212 | SIGTERM orphaned Bash process tree fixed in print/SDK mode |

---

## Open bugs to watch

| Issue | Status | Summary |
|---|---|---|
| #12507 | Open | Shell-detection subprocesses consume stdin from parent |
| #36001 | Not planned | stream-json headless triggers Ink raw mode crash |
| #36156 | Open | Windows hooks always see `isTTY === true` in pipe context |

---

## Sections to refresh

- Claude Code changelog for v2.1.213+ (check for #12507 fix — stdin in shell detection subprocesses)
- Issue #36001 status (stream-json Ink crash — watch for reversal of "not planned")
- Agent SDK as the correct programmatic path — verify current SDK version and headless API shape

---

## Sources

| Source | Confidence | URL |
|---|---|---|
| Official headless docs | H | https://code.claude.com/docs/en/headless |
| Official CLI reference | H | https://code.claude.com/docs/en/cli-reference |
| Official changelog | H | https://code.claude.com/docs/en/changelog |
| Issue #404 — Ink raw mode error | H | https://github.com/anthropics/claude-code/issues/404 |
| Issue #5925 — raw mode crash piped input | H | https://github.com/anthropics/claude-code/issues/5925 |
| Issue #6295 — spawn from Node.js hangs | H | https://github.com/anthropics/claude-code/issues/6295 |
| Issue #9026 — -p hangs without TTY | H | https://github.com/anthropics/claude-code/issues/9026 |
| Issue #12507 — stdin consumed by shell detection | H | https://github.com/anthropics/claude-code/issues/12507 |
| Issue #33987 — tmux send-keys race | H | https://github.com/anthropics/claude-code/issues/33987 |
| Issue #36001 — stream-json headless Ink crash | H | https://github.com/anthropics/claude-code/issues/36001 |
| Issue #36156 — Windows hooks stdin isTTY bug | H | https://github.com/anthropics/claude-code/issues/36156 |
| DeepWiki CLI interface guide (community mirror) | M | https://deepwiki.com/kill136/claude-code-open/4-cli-interface-guide |
| DeepWiki Interactive REPL & TUI | M | https://deepwiki.com/lttcnly/claude-code/2-interactive-repl-and-tui |
| Community mirror src/cli | M | https://github.com/yasasbanukaofficial/claude-code/tree/main/src/cli |
