# raw.research/claude-code-coldstart

Research into Claude Code CLI internals — process lifecycle, cold start paths, TTY/PTY mechanics, and tmux interaction layer.

## What is here

**Question:** What does `claude -p` trigger at the process level? How does it differ from interactive mode? Does tmux change which Node.js handlers are hit?

## Layout

```
claude-code-coldstart/
├── README.md                        ← you are here
├── report/
│   └── 2026-07-21-claude-p-cold-start-mechanics.md   ← full sourced report
└── draft/                           ← scratch / working notes (empty)
```

## Key findings (one-liner per section)

1. **Divergence point** — Commander.js parses `-p` → `runHeadless()` in `src/cli/print.ts`; no Ink, no React ever initialized.
2. **Cold start load** — without `--bare`: full CLAUDE.md + hooks + MCP discovery (same as interactive). With `--bare`: skipped entirely.
3. **Shell detection subprocess bug** — non-bare startup spawns child processes that inherit stdin; can consume it before the main process (issue #12507, open).
4. **Signal handlers** — interactive: SIGWINCH + Ink raw mode on PTY. Headless: stdout guard + SIGTERM kills Bash child tree (fixed v2.1.212).
5. **No daemon, no socket** — each `claude -p` is a standalone Node.js process. Sessions persist as JSON; no reconnect.
6. **TTY detection** — `process.stdin.isTTY` via `isatty()` syscall. Interactive without `-p` crashes on pipe. `-p` ignores TTY state.
7. **tmux** — `send-keys` to interactive session hits the same Ink raw handler as a human keypress. `pipe-pane` is output-only, invisible to the process. `claude -p` in a tmux pane sees PTY but ignores it — prompt is the CLI arg, not keypresses.

## Open issues to watch

| # | Title | Status |
|---|---|---|
| #12507 | Shell-detection subprocesses consume stdin | Open |
| #36001 | stream-json headless triggers Ink raw mode crash | Not planned |
| #36156 | Windows hooks always isTTY=true in pipe context | Open |

## Anchored on

- Official headless docs: https://code.claude.com/docs/en/headless
- Official changelog: https://code.claude.com/docs/en/changelog
- Latest version range researched: up to v2.1.212

Last updated: 2026-07-21
