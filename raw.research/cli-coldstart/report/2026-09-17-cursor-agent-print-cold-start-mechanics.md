# @Cartan Research Report — Cursor Agent Print Cold-Start Mechanics

Date: 2026-09-17
State: RESEARCH-SNAPSHOT
Runtime checked: Cursor Agent `2026.07.01-41b2de7` on Linux x86_64
Triggered by: native Cursor Agent cold-start and automation study
Researcher: @Cartan (Codex)

---

## Core question

What does `cursor-agent -p` select, what context and routing surfaces load, how do pipes and PTYs affect it, what persists, and how far can process-level claims go when the installed binary is closed?

## Executive finding

Cursor Agent’s explicit non-interactive switch is `-p/--print`. The installed help says print mode can access all tools, including write and shell. Official documentation also says output/print behavior may be inferred when stdout is non-TTY or stdin is piped.

The implementation boundary is opaque: the installed executable is a vendor native binary, not an inspectable JavaScript/Rust source tree. Therefore this report distinguishes documented behavior, local CLI schema, and unresolved process internals and does not claim an unseen daemon.

There is a current first-party documentation conflict about writes. The CLI usage and permissions pages say print mode has write and shell access; the headless guide says changes are only applied with `--force`. Until a disposable-worktree trial resolves the pinned build, `-p` must be treated as write-capable, and `--mode=ask` or `--mode=plan` should be used for an explicitly read-only probe.

## 1. Entry point and mode selection

The local commands `agent`, `cursor-agent`, and `cursor` expose the same installed release family. The inspected binary is:

```text
~/.local/bin/cursor-agent
  -> ~/.local/share/cursor-agent/versions/2026.07.01-41b2de7/cursor-agent
```

Public CLI modes:

```text
agent                  interactive Agent mode
agent --mode=plan      interactive/read-only planning mode
agent --mode=ask       interactive/read-only Q&A mode
agent -p PROMPT        print/non-interactive mode
agent acp              ACP server over stdio/JSON-RPC
```

`-p` changes the interaction/output mode. `--force` changes approval behavior; it is not the definition of print mode. `--trust` is only accepted for print/headless mode. ACP is a protocol server and must not be conflated with a one-shot print invocation.

Testable path:

```bash
cursor-agent --version
cursor-agent --help
cursor-agent acp --help
```

## 2. Stdin, stdout and TTY boundary

Official output documentation says print mode is explicit with `--print` and can also be inferred when stdout is non-TTY or stdin is piped. It does not currently specify, with the precision of Codex or Gemini docs, how piped stdin is combined with a positional prompt.

Accordingly, these are separate questions:

| Question | Current state |
|---|---|
| Does `-p` select non-interactive output? | documented, H |
| Can pipe/non-TTY infer print mode? | documented, H |
| Is stdin the prompt, prefixed context, suffixed context, or a transport protocol? | unresolved for pinned build |
| Must stdin close before execution starts? | likely for ordinary pipe consumption, but not documented precisely |

Testable path, with a no-write mode and a disposable account budget:

```bash
printf 'TOKEN_A' | cursor-agent -p --mode=ask --output-format stream-json 'Return the exact ordering of TOKEN_A and TOKEN_B. TOKEN_B'
printf 'TOKEN_A' | cursor-agent --mode=ask --output-format stream-json
```

Capture the user-message event, exit status, stderr, and whether the process waits for EOF. Do not use a production checkout for this probe.

## 3. TTY and tmux

The externally testable matrix is:

| Invocation | Expected adapter |
|---|---|
| `agent` in a terminal/tmux pane | interactive UI |
| `tmux send-keys` to it | existing UI input via pane PTY |
| `agent -p '...'` in a pane | print mode |
| piped stdin or non-TTY stdout | print may be inferred |
| `tmux pipe-pane` | output observation only |

Because the binary is closed, internal raw-mode libraries, signal handlers, and branch function names are unknown. A PTY/no-PTY behavioral trial can establish outcomes; it cannot justify naming an internal framework.

## 4. Cold-start instructions and rules

Cursor Agent CLI supports the editor’s rules system. Current official surfaces include:

- project `.cursor/rules/*.mdc`, selected by configuration, paths, or relevance;
- user rules;
- team rules where the account supports them;
- project-root `AGENTS.md` and `CLAUDE.md` in the CLI;
- nested `AGENTS.md` files, combined with parent instructions and made more specific by subtree.

The rules documentation says applied rules are included at the start of model context. Nested AGENTS instructions are applied when working with files in their directory or children. This is closer to path-scoped context than a simple one-time root concatenation, so a single boot prompt should not be assumed to enumerate all instructions that a later file access can activate.

There is no documented `--bare` switch. A clean-room Cursor probe requires an isolated workspace, controlled user CLI configuration, no project rules/plugins, explicit mode, and declared auth. `--trust` only bypasses the workspace trust prompt.

## 5. Skills

Cursor loads skills from:

- project `.agents/skills/` and `.cursor/skills/`;
- user `~/.agents/skills/` and `~/.cursor/skills/`;
- compatibility locations under `.claude/skills/`, `.codex/skills/`, and their user equivalents.

It recursively discovers nested skill directories and scopes skills found inside nested project directories to that subtree. A `SKILL.md` uses `name` and `description` frontmatter followed by instructions, with optional scripts, references, and assets.

This compatibility breadth is a contamination risk in controlled trials: the same nominal project can expose Cursor to compatibility-located skills with different scoping rules. A reproducible cold-start probe must inventory every compatible skill root, not only `.cursor/skills`.

## 6. Subagents and routing

Cursor custom subagents are markdown files in `.cursor/agents/` or `~/.cursor/agents/` with `name` and `description` frontmatter plus a prompt body. The main agent may delegate automatically; a user can also invoke a named agent explicitly. Current docs tell authors to put “Use proactively” style cues in the description, which is direct evidence that description text participates in routing guidance.

Subagents have separate context, can run in foreground or background, and can be resumed by agent ID. Background state is written under `~/.cursor/subagents/`. Current docs allow one nested child level: the root and its direct subagents may launch subagents, while grandchildren cannot launch another level.

The description remains a model-facing routing hint rather than a deterministic matcher. The test for a routing claim is repeated controlled prompts plus explicit invocation as a control, with the actual spawned agent identity recorded.

## 7. Permissions curvature: `-p` versus `--force`

Three current first-party surfaces do not form one unambiguous contract:

1. installed help: print mode “has access to all tools, including write and shell”;
2. usage/permissions docs: print mode can use write and shell; permissions and `--force` control what runs without prompts;
3. headless guide: without `--force`, changes are proposed rather than applied.

“Tool is available” and “tool call is auto-approved” can coexist, but “won’t modify files” is stronger and conflicts with reports that `-p` did write without `--force`. The safe operational conclusion is that `-p` is **not a read-only guarantee**.

Testable path:

1. create a disposable Git worktree with one sentinel file;
2. snapshot hash and permissions;
3. run `agent -p` asking for one edit, without `--force`;
4. repeat with `--mode=ask`, `--mode=plan`, and `--force` as separate cells;
5. record tool events, prompts/classifier decisions, diff, and exit status.

Until that cell is run against the pinned release, automation that must not write should use read-only mode plus filesystem containment.

## 8. Output and persistence

Print output supports text, one final JSON result, and streaming JSON/NDJSON events. Stream events include initialization, user/assistant messages, tool-call lifecycle, and a terminal result. Failure may end the stream without a terminal result and writes an error to stderr, so consumers must check both exit status and terminal-event presence.

Sessions persist across invocations and can be resumed with `--resume`, `--continue`, `agent resume`, or `agent ls`. Persisted chat state is not evidence that the original process remains alive. Subagent state has its own documented on-disk location.

The product also offers Cloud Agent handoff, private workers, and ACP. Those are distinct mechanisms. Their existence must not be used to infer that a local one-shot `agent -p` is backed by a local daemon.

## 9. Process and signal boundary

The public docs do not expose the local print runner’s internal process tree, terminal library, or signal cleanup algorithm. Establish them observationally:

1. run a bounded print task under `strace -f` or a process-tree sampler;
2. record local parent/child processes and network endpoints without capturing secrets;
3. send SIGINT/SIGTERM to a new process group;
4. record exit status, stream terminator, and survivors;
5. repeat with a tool child process and a background subagent.

Confidence stays **L** for unseen internal names and **M** for observed version-specific behavior. Cursor updates can replace the binary without preserving private internals.

## 10. Current claims and confidence

| Claim | Confidence | Test |
|---|---:|---|
| `-p/--print` is explicit non-interactive mode | H | installed help + official docs |
| pipe/non-TTY can infer print output | H | official output docs; PTY matrix |
| exact stdin composition | L/unresolved | stream-json token-order probe |
| CLI reads root AGENTS/CLAUDE and `.cursor/rules` | H | official CLI docs |
| nested AGENTS and nested skills are path-scoped | H | official rules/skills docs |
| compatibility skill roots include Claude and Codex | H | official skills docs |
| subagent descriptions guide routing | H | official examples; controlled routing trials |
| `-p` without `--force` never writes | contested | disposable-worktree matrix |
| ordinary local `-p` uses a resident daemon | unknown; no evidence | process tree/socket trace |
| exact signal/descendant cleanup | L until pinned probe | process-group signal trial |

## 11. Refresh triggers

Refresh when:

- Cursor Agent version changes;
- help changes the meaning of print, force, trust, or sandbox;
- headless and permissions docs resolve their write conflict;
- stdin composition is officially specified;
- skill compatibility roots or subagent nesting change;
- the executable distribution/process topology changes.

## Sources

| Source | Use |
|---|---|
| https://cursor.com/docs/cli/overview | modes, sessions, sandbox |
| https://cursor.com/docs/cli/using | rules, history, non-interactive mode |
| https://cursor.com/docs/cli/headless | print automation and disputed force claim |
| https://docs.cursor.com/en/cli/reference/output-format | print inference and event formats |
| https://prod.cursor.com/docs/cli/reference/permissions | write/shell permissions |
| https://cursor.com/docs/rules | rule and nested AGENTS semantics |
| https://cursor.com/docs/skills | skill roots and nesting |
| https://prod.cursor.com/docs/subagents | subagent format, routing, resume, nesting |
| local `cursor-agent --version`, `cursor-agent --help` on 2026-09-17 | installed CLI contract |
