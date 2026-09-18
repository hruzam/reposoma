# @Cartan Research Report — Gemini CLI Headless Cold-Start Mechanics

Date: 2026-09-17
State: RESEARCH-SNAPSHOT
Runtime checked: `@google/gemini-cli` `0.56.0` on Linux x86_64
Triggered by: native Gemini CLI cold-start and automation study
Researcher: @Cartan (Codex)

---

## Core question

What does Gemini CLI do when it enters headless mode, how do `-p`, stdin and TTY detection interact, what ambient context and agent surfaces load, and what is the actual process shape on this host?

## Executive finding

Gemini has two independent headless triggers: explicit `-p/--prompt`, and a non-TTY environment. Its installed JavaScript makes the branch visible. Interactive mode loads a dynamically imported UI and enables raw stdin only when interactive and attached to a TTY. Headless mode bypasses that UI and calls the non-interactive runner.

The installed launcher is not a single Node process: it normally starts as a parent launcher, computes memory arguments, then spawns a child Node process with inherited stdin/stdout/stderr plus IPC. The parent can relaunch the child on a designated exit code. This is a launcher/worker pair for one CLI invocation, not evidence of a persistent daemon or socket service.

Confidence: **H** for installed-bundle observations and official headless behavior.

## 1. Entry point and process shape

```text
~/.npm-global/bin/gemini
  -> @google/gemini-cli/bundle/gemini.js
```

On a normal unsandboxed launch, `gemini.js`:

1. reads user memory settings to calculate a Node `--max-old-space-size` value;
2. installs signal listeners in the launcher;
3. pauses launcher stdin;
4. spawns a child Node process with `stdio: ['inherit','inherit','inherit','ipc']`;
5. resumes launcher stdin when the child closes;
6. relaunches only when the child returns the special relaunch exit code; otherwise it exits with the child code.

The child imports the main CLI bundle. It parses settings and arguments, initializes configuration, then chooses interactive, ACP, or non-interactive execution.

Testable path:

```bash
gemini --version
gemini --help
ps -o pid,ppid,stat,cmd --forest -C node
```

Set `GEMINI_CLI_NO_RELAUNCH=true` only in a controlled probe if the goal is to isolate the child path; doing so changes the normal launcher topology.

## 2. Mode selection

Official documentation says headless mode is triggered when either:

- `-p/--prompt` supplies a prompt; or
- the CLI runs in a non-TTY environment.

Installed source refines the boundary:

- `-i/--prompt-interactive` forces an initial prompt followed by the interactive UI and is rejected when stdin is piped;
- ACP is its own interactive protocol mode;
- a positional query defaults to interactive on a TTY, but becomes a prompt in detected headless mode;
- headless mode excludes the ask-user tool because no human response channel is available.

```text
TTY + no -p       -> interactive UI
TTY + -p PROMPT   -> headless runner
pipe + prompt     -> headless runner
-i + pipe         -> fatal input error
--acp             -> ACP stdio protocol, not headless text mode
```

This mode boundary is specific to Gemini CLI and should be tested through Gemini's own flags and emitted events.

## 3. Prompt and stdin composition

Installed help says the `-p` prompt is appended to input from stdin. The current bundle reads non-TTY stdin and composes:

```text
<stdin bytes>

<--prompt text>
```

If there is no argv prompt and no stdin content, headless mode exits with a fatal input error. When sandbox relaunch is enabled, the outer process reads stdin first and injects it into the relaunched arguments so the inner process does not depend on the original pipe remaining readable.

Testable path, with authentication and cost controls in place:

```bash
printf 'A' | gemini -p 'B' --output-format stream-json
printf 'B' | gemini --output-format stream-json
```

Capture the emitted user message in stream JSON to verify order and separators. Always close the producer’s stdout.

## 4. TTY and raw mode

The installed bundle calls `process.stdin.setRawMode(true)` only when configuration says interactive, stdin was not already raw, and `process.stdin.isTTY` is true. The raw state is registered for synchronous cleanup. Headless mode reaches `runNonInteractive` instead of dynamically importing the interactive UI.

| Invocation | `stdin.isTTY` | Result |
|---|---:|---|
| `gemini` in tmux | true | interactive UI |
| `tmux send-keys` to it | true | existing UI key path |
| `gemini -p '...'` in tmux | true | headless path |
| `cat x | gemini -p '...'` | false | headless; stdin prepended |
| `cat x | gemini` | false | inferred headless path |

`tmux pipe-pane` observes pane output only. A pipe connected directly to Gemini replaces the PTY on that file descriptor even if the shell itself is inside tmux.

## 5. Ambient cold-start context

Gemini context files default to `GEMINI.md`. Current official hierarchy is:

1. global `~/.gemini/GEMINI.md`;
2. environment/workspace files in configured workspaces and parent directories;
3. just-in-time files discovered when a tool accesses a directory, scanning its ancestors to the trusted root.

All found content is concatenated and sent with prompts. `/memory show` exposes the current concatenated memory in an interactive session, and `/memory reload` rescans it. `context.fileName` can replace the default with a list such as `AGENTS.md`, `CONTEXT.md`, and `GEMINI.md`.

Gemini’s just-in-time layer is a material difference from Codex’s documented once-per-run AGENTS chain. A cold-start transcript alone may not contain every instruction later added after a tool crosses into another subtree.

Other startup surfaces include settings scopes, trust state, extensions, hooks, MCP servers, policy files, authentication, session storage, and workspace inclusion. `--skip-trust` trusts the workspace for the invocation; it is not a clean-room flag. There is no documented one-switch clean-room mode.

## 6. Skills and subagents

Gemini skill precedence, lowest to highest:

1. built-in;
2. extension;
3. user (`~/.gemini/skills/` or `~/.agents/skills/`);
4. workspace (`.gemini/skills/` or `.agents/skills/`).

Skills can be reloaded in-session. Current documentation states that every skill activation requires permission to access its resources. That consent boundary is important for automation: discovering a skill does not guarantee a headless run can activate it without an approval strategy.

Gemini subagents have a separate context loop, system prompt/persona, and restricted/specialized tools. Each is exposed to the main agent as a tool. Delegation can be automatic when the task matches the specialist, or nudged explicitly with `@name` at the beginning of a prompt. Official docs say the `@` form injects a system note urging the primary model to call that subagent; it is not described as bypassing the primary process or directly replacing the root agent.

Descriptive metadata influences model routing, while the concrete mechanism is a named tool exposed to the parent.

## 7. Sessions and lifetime

Gemini supports persisted session continuity with `--resume`, `--session-file`, `--session-id`, `--list-sessions`, and `--delete-session`. The first three session-selection flags are mutually exclusive. Resume starts another CLI invocation that loads stored state; it is not reconnection to the prior launcher PID.

The normal process ends by running registered cleanup, including a SessionEnd hook. The top-level error path applies a five-second cleanup timeout before forcing exit. Exact descendant termination under SIGTERM is not stated as a public compatibility contract and should be tested against the pinned version.

Testable path:

1. start `gemini -p` under a process-group supervisor;
2. record launcher and child PIDs;
3. send SIGINT/SIGTERM separately;
4. capture exit status, SessionEnd evidence, and surviving descendants;
5. repeat with sandbox relaunch enabled and disabled.

## 8. Structured output

Official headless formats are:

- text;
- one JSON object containing response, stats, and optional error;
- streaming JSONL with `init`, `message`, `tool_use`, `tool_result`, `error`, and final `result` events.

Documented headless exit codes are `0` success, `1` general/API error, `42` input error, and `53` turn-limit exceeded. Supervisors should still treat any undocumented non-zero code as failure.

## 9. Current claims and confidence

| Claim | Confidence | Test |
|---|---:|---|
| `-p` or non-TTY selects headless | H | official docs + installed bundle |
| headless bypasses interactive UI/raw mode | H | installed bundle branch |
| piped stdin precedes `-p` text | H | installed help/source; stream event probe |
| normal launch uses launcher + child with inherited stdio and IPC | H | installed `bundle/gemini.js`; process tree |
| launcher/child is not a persistent daemon | H | child-close loop + process tree after exit |
| GEMINI.md includes JIT discovery | H | official docs; subtree access probe |
| skill activation always requests consent | H for documented state | headless skill probe |
| `@subagent` is a primary-model routing nudge | H | official subagent docs |
| exact SIGTERM cleanup of tool descendants | L until pinned probe | process-group signal trial |

## 10. Refresh triggers

Refresh when:

- the installed Gemini CLI version changes;
- mode-selection code or `--prompt` help changes;
- Google changes skill activation consent;
- GEMINI.md JIT behavior or context filename settings change;
- subagents leave preview or change their explicit-call syntax;
- launcher relaunch and signal code changes.

## Sources

| Source | Use |
|---|---|
| https://geminicli.com/docs/cli/headless/ | trigger, formats, exit codes |
| https://geminicli.com/docs/cli/gemini-md/ | context hierarchy and JIT discovery |
| https://geminicli.com/docs/cli/using-agent-skills/ | skill precedence and consent |
| https://geminicli.com/docs/core/subagents/ | subagent isolation and routing |
| local `@google/gemini-cli` bundle `0.56.0` on 2026-09-17 | launcher, branch, stdin, raw mode, cleanup |
