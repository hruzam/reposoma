# @Cartan Research Report — Codex `exec` Cold-Start Mechanics

Date: 2026-09-17
State: RESEARCH-SNAPSHOT
Runtime checked: Codex CLI `0.154.0` on Linux x86_64
Triggered by: native Codex cold-start and automation study
Researcher: @Cartan (Codex)

---

## Core question

What does Codex load on a fresh non-interactive invocation, how do stdin and TTY state change the path, what survives after exit, and which claims are observable against the installed native runtime?

## Executive finding

The native non-interactive entry is **`codex exec`**. In Codex CLI, `-p` means `--profile`. The top-level `codex` command launches the interactive TUI; the `exec` subcommand dispatches into the separate non-interactive runner. Both use the same Rust agent core, but they have different UI/input adapters.

`codex exec` is a per-invocation native process. It persists a thread/rollout by default and can resume it later, but persistence is on disk, not proof of a resident CLI daemon. `--ephemeral` suppresses session-file persistence. Current official CLI documentation says remote app-server mode is accepted by the TUI/resume/fork family and rejected by other subcommands, so `codex exec` should not be described as a client reconnecting to the remote app-server path.

Confidence: **H** for the public CLI boundary and local version; **M-H** for source-path detail because upstream `main` may be newer than installed `0.154.0`.

## 1. Entry point and divergence

The installed command resolves to a standalone native binary:

```text
~/.local/bin/codex
  -> ~/.codex/packages/standalone/releases/0.154.0-x86_64-unknown-linux-musl/bin/codex
```

The open-source Rust CLI parses the command at `codex-rs/cli/src/main.rs`. Its command enum routes `exec` to `codex_exec::Cli`; the ordinary command routes to the terminal UI. The non-interactive option schema lives in `codex-rs/exec/src/cli.rs`.

```text
codex [PROMPT]
  -> terminal UI adapter
  -> shared agent/core services

codex exec [PROMPT]
  -> non-interactive event/output adapter
  -> shared agent/core services
```

This is a shared-engine/different-adapter split grounded in Codex's own Rust source.

Testable path:

```bash
codex --version
codex --help
codex exec --help
```

## 2. Prompt and stdin resolution

Installed `0.154.0` exposes three cases:

| Invocation | Prompt source |
|---|---|
| `codex exec 'instruction'` with TTY stdin | argv instruction |
| `producer | codex exec 'instruction'` | argv instruction plus piped bytes appended in a `<stdin>` block |
| `producer | codex exec -` or omitted prompt | stdin is the full instruction |

The argv-plus-stdin behavior is intentional and documented. A caller must close stdin. A pipe that remains open is an incomplete message transport and may leave Codex waiting for EOF before model work begins.

An open upstream issue, #27019, reports `0.133.0`/`0.134.0` hanging at “Reading additional input from stdin...” in some non-TTY launchers even when EOF appears to have been supplied. This host has `0.154.0`; the issue is evidence of a failure mode, not evidence that the current installed build reproduces it.

Testable path, in an isolated repository with a deliberately cheap prompt:

```bash
printf 'context' | timeout 30 codex exec --ephemeral 'reply with one word'
printf 'reply with one word' | timeout 30 codex exec --ephemeral -
```

Record argv, whether stdin was a TTY, whether the writer closed its fd, first stderr, exit status, and elapsed time. Do not infer a TTY defect from a producer that keeps the pipe open.

## 3. TTY behavior

`codex exec` selects non-interactive mode by subcommand, not by TTY inference. A PTY can still affect color and whether optional stdin is considered available, but it does not turn `exec` into the TUI.

| Invocation | stdin | Adapter |
|---|---|---|
| `codex` in a terminal/tmux pane | PTY | TUI |
| `tmux send-keys` to that pane | PTY bytes | existing TUI input path |
| `codex exec '...'` in a pane | PTY | exec adapter |
| `cat x | codex exec '...'` | pipe | exec adapter; pipe appended as context |
| `cat prompt | codex exec -` | pipe | exec adapter; pipe is prompt |

`tmux pipe-pane` observes pane output; it does not become Codex stdin. `tmux send-keys` drives an already-running TUI through its PTY. Launching `codex exec` inside tmux still takes the exec path.

Confidence: **H** for the CLI selection and tmux fd model; **M** for undocumented terminal cleanup details.

## 4. Cold-start instruction and configuration load

Codex builds the `AGENTS.md` instruction chain once per run. Official discovery order is:

1. `AGENTS.override.md` or `AGENTS.md` in `CODEX_HOME` (first non-empty match);
2. from project root down to the working directory, at most one applicable instruction file per directory, preferring `AGENTS.override.md`, then `AGENTS.md`, then configured fallback names.

The chain is bounded by the project-doc byte limit. Nested project instructions are startup context for the working directory; they are not documented as Gemini-style just-in-time context discovered whenever a tool later touches another subtree.

`codex exec` also resolves user/project configuration, rules, authentication, MCP/plugin/app surfaces, and the discovered skill catalog as applicable to the installed configuration. The available isolation flags have narrower meanings:

- `--ignore-user-config` skips `$CODEX_HOME/config.toml`; authentication still uses `CODEX_HOME`.
- `--ignore-rules` skips user/project execpolicy `.rules` files.
- `--ephemeral` disables session persistence.

None suppresses every ambient surface. A reproducible clean-room Codex probe therefore needs a controlled temporary `CODEX_HOME`, explicit config, a known working directory, and a declared auth path; `--ephemeral` alone is insufficient.

Testable path:

```bash
codex debug prompt-input --help
codex exec --ignore-user-config --ignore-rules --ephemeral --help
```

Use `codex debug prompt-input` where available to inspect model-visible input without treating remembered load order as evidence.

## 5. Skills and subagents

Codex skills use progressive disclosure: initial context carries skill name, description, and path under an explicit context budget; full `SKILL.md` is read when the skill is selected. Therefore a skill's description is a routing surface, while its body is deferred operational instruction.

Custom subagents are TOML configuration layers. A standalone agent file requires `name`, `description`, and `developer_instructions`; project agents live under `.codex/agents/`. Official documentation defines `description` as guidance for when Codex should use the agent. It should be treated as a routing signal, but a prose description is not a hard dispatch rule. Explicit controller delegation remains the testable control.

This distinction matters for the two supplied source reports:

- skill metadata and subagent metadata both help selection, but they enter through different registries;
- neither carrier proves that a named agent will be chosen on every semantically similar prompt;
- metadata from another runtime should not be copied into Codex TOML and called parity.

## 6. Persistence and process lifetime

Default `codex exec` runs produce a persisted session/rollout that can be continued with:

```bash
codex exec resume --last 'follow-up'
codex exec resume SESSION_ID 'follow-up'
```

`--ephemeral` prevents rollout files from being persisted. Resume is storage-backed continuity across separate invocations. It does not require the original `codex exec` PID to remain alive.

Agent tool calls may spawn subprocesses during the run. That child-process machinery is separate from the CLI mode question. The existence of Codex `app-server`, `exec-server`, remote control, or tool-process PTYs elsewhere in the product must not be used to claim that an ordinary `codex exec` invocation itself is a daemon client.

Testable path:

```bash
ps -o pid,ppid,stat,cmd --forest -C codex
codex exec --ephemeral --json 'bounded read-only task'
```

Observe process ancestry during the call and verify that the top-level invocation exits after its terminal event.

## 7. Output and termination contract

`--json` emits JSONL events including thread, turn, item, and error lifecycle records. `--output-last-message FILE` separates the final assistant text from the event stream. Structured final output can be constrained with `--output-schema FILE`.

The public documentation gives a stable scripting surface for output but does not promise the exact Unix signal-to-exit-code and descendant-cleanup behavior needed for a process supervisor. That behavior should be probed against the pinned binary.

Testable path:

1. launch a bounded `codex exec --json` in a new process group;
2. send SIGINT and SIGTERM in separate trials;
3. capture terminal JSON event, stderr, exit status, and remaining descendants;
4. repeat after every CLI upgrade that changes process or hook handling.

## 8. Current claims and confidence

| Claim | Confidence | Test |
|---|---:|---|
| `codex exec` is the non-interactive entry; `-p` is profile | H | `codex exec --help` |
| exec and TUI have separate adapters over shared Rust core | H | upstream `cli/main.rs`, `exec/src/cli.rs` |
| prompt-plus-pipe appends a `<stdin>` block | H | installed help + official docs; closed-pipe probe |
| AGENTS chain is assembled once per run | H | official AGENTS.md documentation |
| `--ephemeral` affects persistence, not ambient context | H | official non-interactive docs/help |
| resume is disk-backed across invocations | H | run, exit, `exec resume` |
| ordinary `exec` needs no resident CLI daemon | M-H | process-tree probe; remote-mode command boundary |
| exact SIGTERM descendant cleanup | L until pinned probe | process-group signal trial |
| upstream #27019 affects installed 0.154.0 | L/unresolved | non-TTY closed-stdin probe |

## 9. Refresh triggers

Refresh this report when any of these changes:

- installed Codex CLI version;
- `codex exec --help` stdin wording;
- official AGENTS discovery or skill budget;
- custom-agent schema or routing documentation;
- status of upstream issue #27019;
- availability of an official bare/clean-room mode.

## Sources

| Source | Use |
|---|---|
| https://learn.chatgpt.com/docs/non-interactive-mode | exec, stdin, JSONL, ephemeral, resume |
| https://learn.chatgpt.com/docs/developer-commands?surface=cli | command and flag reference |
| https://learn.chatgpt.com/docs/agent-configuration/agents-md | instruction discovery |
| https://learn.chatgpt.com/docs/build-skills | skill disclosure |
| https://learn.chatgpt.com/docs/agent-configuration/subagents | custom-agent schema |
| https://github.com/openai/codex/blob/main/codex-rs/cli/src/main.rs | top-level Rust dispatch |
| https://github.com/openai/codex/blob/main/codex-rs/exec/src/cli.rs | exec option schema |
| https://github.com/openai/codex/issues/27019 | reported non-TTY stdin hang |
| local `codex --version`, `codex exec --help` on 2026-09-17 | installed behavior contract |
