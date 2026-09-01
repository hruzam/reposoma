# COPY — original authoritative at ~/unikuklatrix/…/a-sym/ until majkee consolidates (temporary dual-hold, majkee's call, 2026-09-01)

# The Codex Bonding Layer: Hooks, Skills, Rules & External Control Planes

**Author:** @asymmetry — focused research artifact  
**Date:** 2026-08-05  
**Scope:** OpenAI Codex CLI and adjacent local Codex runtime surfaces; official mechanisms, community compositions, seams, negative space, and experimental vectors  
**Status:** research snapshot — not a design document  
**Method:** official documentation and source repository first; community repositories and issue reports used as observations, not as guarantees  

---

## 0. Research Contract

This is a sibling investigation to Houston's Claude Code bonding-layer research, not a translation of it.

The question is not:

> Which Claude Code features have Codex equivalents?

The question is:

> Where does Codex become more than the sum of its documented primitives, and where can a user create stable bonds between model judgment, deterministic machinery, persistent state, and external supervisors?

Findings are marked implicitly by section:

- **Official surface** — documented and currently supported.
- **Observed composition** — used or requested in the ecosystem; may expose rough edges.
- **Architectural vector** — plausible composition derived from verified primitives, but not validated here.
- **Negative space** — a missing or incomplete mechanism that changes what can be built.

The report does not map findings to LARVA or any predecessor architecture.

---

## 1. Executive Finding

Codex does not have one named "bonded script" primitive.

Its bonding layer is distributed across four planes:

1. **Instruction plane** — `AGENTS.md`, memories, skills, and custom-agent instructions shape model behavior.
2. **Mechanical plane** — lifecycle hooks, sandbox boundaries, approvals, and command rules intercept or constrain action.
3. **Delegation plane** — custom subagents and multi-agent tools create bounded specialist threads.
4. **Control plane** — `codex exec --json`, resumable sessions, the SDK, MCP-server mode, and the app server let an external program supervise Codex.

The most Codex-native opportunity is not merely "a skill with a script." It is a **closed loop across planes**:

> instructions choose intent → hooks and rules guard execution → JSONL/app-server events expose state → an external supervisor evaluates results → the same thread or a successor is resumed with corrective context.

This composition is stronger than any single primitive. It also creates more failure modes: duplicated policy, event ambiguity, context drift, unsafe external wrappers, and hidden state spread across files and runtime databases.

---

## 2. The Official Four-Plane Stack

### 2.1 Instruction Plane: Persistent Guidance and On-Demand Procedure

#### 2.1.1 `AGENTS.md` — directory-layered durable guidance

Codex loads developer guidance from a global Codex-home file and repository files. Project instructions layer from the repository root toward the current working directory; a nearer file has higher precedence. `AGENTS.override.md` can replace the ordinary file at a given level. Project-local instruction discovery stops at the working directory.

Typical locations:

```text
~/.codex/AGENTS.md
~/.codex/AGENTS.override.md
repo/AGENTS.md
repo/subtree/AGENTS.md
repo/subtree/AGENTS.override.md
```

This is not a passive README. It is injected before work and participates in a precedence chain.

**Trust model:** model-interpreted, persistent, broad scope.  
**Trigger:** session/task startup from a selected working directory.  
**Lifetime:** the active thread context, subject to compaction and session behavior.  
**Bonding role:** stable behavioral defaults and routing instructions.

A useful official pattern is "correct once, persist the correction": recurring mistakes are added to the nearest relevant `AGENTS.md`. OpenAI explicitly describes this as a feedback loop, while recommending deterministic enforcement such as linters and pre-commit hooks for rules that should not remain purely advisory.

#### 2.1.2 Memories — extracted cross-session context

Codex has a memory subsystem with separate controls for generating memories, injecting them into future sessions, choosing an extraction model, limiting source-thread age, and consolidating raw memories. As of this snapshot, the feature is configurable and can be disabled entirely or excluded when external context such as MCP/web usage is involved.

**Trust model:** model-extracted and model-consumed.  
**Trigger:** asynchronous/idle processing of eligible past threads and future-session injection.  
**Lifetime:** cross-session, managed by consolidation and expiry settings.  
**Bonding role:** implicit continuity without requiring a user-maintained learnings file.

This is a material difference from community `learnings.md` loops: Codex memory is runtime-managed rather than transparently stored beside the workflow. That improves convenience but weakens inspectability and version control.

#### 2.1.3 Skills — progressive, reusable workflow packages

A skill is a directory containing `SKILL.md` plus optional scripts, references, assets, and metadata. Codex initially receives the skill name, description, and path; the initial list is budgeted to avoid consuming excessive context. The full `SKILL.md` is loaded after explicit invocation or implicit matching.

```text
my-skill/
├── SKILL.md
├── scripts/
├── references/
├── assets/
└── agents/
    └── openai.yaml
```

Invocation paths include `/skills`, `$skill-name`, and implicit matching against the description.

**Trust model:** model-invoked and model-interpreted.  
**Trigger:** explicit mention or semantic match.  
**Lifetime:** task/turn context.  
**Bonding role:** package instructions with executable helpers and domain material without loading everything eagerly.

Important boundary: the open Agent Skills format makes the directory portable, but Codex behavior around discovery budgets, invocation, dependencies, and plugin packaging remains host-specific.

#### 2.1.4 Profiles and layered configuration — runtime regime selection

Codex configuration resolves through a precedence chain:

1. CLI flags and `--config` overrides
2. project `.codex/config.toml` layers, root to current directory
3. selected profile file
4. user `~/.codex/config.toml`
5. system configuration
6. built-in defaults

A profile is therefore more than convenience. It can atomically switch model, approval policy, sandbox, tools, hooks, agents, and other runtime settings.

**Trust model:** deterministic configuration.  
**Trigger:** process launch or explicit profile selection.  
**Lifetime:** process/session.  
**Bonding role:** coarse-grained operational regime.

---

### 2.2 Mechanical Plane: Hooks, Rules, Sandbox, and Approval

#### 2.2.1 Lifecycle hooks — event-bound command execution

Codex supports hooks loaded from `hooks.json` or inline TOML configuration. Documented event names include:

- `SessionStart`
- `SessionEnd`
- `UserPromptSubmit`
- `PreToolUse`
- `PermissionRequest`
- `PostToolUse`
- `PreCompact`
- `PostCompact`
- `SubagentStart`
- `SubagentStop`
- `Stop`

The configuration is event → matcher group → handler list. Command handlers are currently supported. Prompt and agent handlers may parse but are skipped; asynchronous command hooks are parsed but not yet supported.

Example shape:

```toml
[[hooks.PreToolUse]]
matcher = "^shell$"

[[hooks.PreToolUse.hooks]]
type = "command"
command = ".codex/hooks/check-shell.sh"
timeout = 30
statusMessage = "Checking command policy"
```

Hooks may return structured output such as additional model context or decisions, depending on the event. Large `additionalContext` can be written to disk and represented to the model by a shorter preview, controlled by `additionalContextLimit`.

Project-local hooks load only for trusted projects. Codex also has persisted hook trust and an explicit dangerous bypass flag for already-vetted automation.

**Trust model:** deterministic execution, but only as correct as the hook script and event semantics.  
**Trigger:** runtime lifecycle event.  
**Lifetime:** configuration/process scope.  
**Bonding role:** observe, block, modify, annotate, or validate transitions around model actions.

#### 2.2.2 Rules — deterministic command policy outside the sandbox

Codex `.rules` files use a side-effect-free Starlark subset to classify command prefixes as:

- `allow`
- `prompt`
- `forbidden`

Rules are evaluated against argument vectors. For safely parseable linear shell chains, Codex splits the chain and applies rules to each command, with the most restrictive outcome winning. Complex shell syntax falls back to evaluation as a single `bash -lc` invocation.

Rules can be tested independently:

```bash
codex execpolicy check --pretty \
  --rules ~/.codex/rules/default.rules \
  -- gh pr view 7888 --json title,body,comments
```

**Trust model:** deterministic, declarative, side-effect-free policy.  
**Trigger:** proposed command crossing the sandbox boundary.  
**Lifetime:** configuration/process scope.  
**Bonding role:** turn recurring command judgments into machine-checkable policy.

Rules are narrower than hooks but often safer: they classify commands instead of executing arbitrary policy scripts.

#### 2.2.3 Sandbox and approvals — capability boundary plus human gate

Codex separates two concerns:

- **sandbox:** what spawned commands can technically access;
- **approval policy:** when Codex must stop and ask before crossing a boundary.

Commands launched by tools such as `git`, test runners, and package managers inherit the same sandbox. Additional writable directories may be granted at launch. Subagents inherit the parent turn's live permission choices unless a custom agent applies a narrower override.

**Trust model:** OS-enforced boundary plus interactive policy.  
**Trigger:** every command/tool action.  
**Lifetime:** run/turn, with live overrides.  
**Bonding role:** allow autonomy within a bounded workspace while preserving a human interruption point.

#### 2.2.4 Requirements — organization-level non-bypassable constraints

`requirements.toml` can enforce managed hooks, sandbox modes, network rules, command rules, configuration constraints, and plugin MCP identities. Requirements are restrictive: for example, organization-level command rules may prompt or forbid, not silently widen access.

**Trust model:** administrator-enforced policy.  
**Trigger:** runtime configuration resolution and affected actions.  
**Lifetime:** machine/managed environment.  
**Bonding role:** prevent a user-level or repository-level composition from weakening the organizational boundary.

---

### 2.3 Delegation Plane: Subagents and Custom Roles

Codex has built-in multi-agent collaboration tools and custom role declarations. A role points to a TOML config layer, allowing specialized developer instructions, model choices, and narrower sandbox settings.

Conceptual structure:

```toml
[agents.reviewer]
config_file = "agents/reviewer.toml"

[agents.researcher]
config_file = "agents/researcher.toml"
```

The primary thread can spawn, message, resume, wait for, and close child threads. Subagents inherit the parent sandbox and approval posture, including live overrides, unless narrowed by custom configuration.

**Trust model:** model-directed delegation inside inherited mechanical limits.  
**Trigger:** parent-agent decision or explicit user instruction.  
**Lifetime:** child thread; resumable state may persist.  
**Bonding role:** isolate perspective, context, or responsibility without starting an unrelated process manually.

The boundary is not yet equivalent to a fully isolated worker. Community reports identify gaps around per-subagent working directories, hook identity, and worktree lifecycle.

---

### 2.4 Control Plane: Codex as a Supervised Runtime

This is the most distinctive part of the Codex surface.

#### 2.4.1 `codex exec --json` — newline-delimited event stream

Non-interactive mode can emit newline-delimited JSON events instead of formatted terminal output. Runs can be ephemeral or persisted. Stdin may carry additional context while the prompt argument remains the instruction.

**Trust model:** deterministic process interface around a probabilistic agent.  
**Trigger:** external invocation.  
**Lifetime:** one run or resumed thread.  
**Bonding role:** lets shell scripts, CI jobs, and supervisors consume machine-readable progress and outcomes.

This enables community hook runners and orchestration wrappers even where the native event surface is insufficient.

#### 2.4.2 Codex SDK — start, continue, and resume threads

The TypeScript SDK exposes local Codex threads programmatically. It is intended for CI/CD, internal tools, embedded engineering workflows, and systems where Codex is one specialist among other agents.

**Trust model:** host application controls thread lifecycle; Codex controls reasoning and tool choice within supplied configuration.  
**Trigger:** API call.  
**Lifetime:** application-managed thread.  
**Bonding role:** stable integration without parsing terminal text.

#### 2.4.3 MCP-server mode — Codex as a tool inside another orchestrator

Official guidance recommends running Codex CLI as an MCP server when Codex should act as one coding specialist inside a wider agent workflow.

This reverses the ordinary MCP relationship. Codex is no longer only the host consuming tools; Codex itself becomes a callable tool/runtime.

**Trust model:** external orchestrator decides when to delegate; Codex remains internally agentic.  
**Trigger:** MCP tool call.  
**Lifetime:** orchestrator-managed.  
**Bonding role:** cross-agent composition without pretending every model shares one runtime.

#### 2.4.4 App server — JSON-RPC runtime introspection and control

The app server exposes methods and notifications for threads, skills, hooks, plugins, MCP servers, permissions, configuration, and external-agent migration. Examples include:

- list skills for one or more working directories;
- force skill reloads and watch skill changes;
- list discovered hooks;
- enable or disable a skill by path;
- reload MCP configuration for loaded threads;
- call MCP tools and read MCP resources;
- inspect effective configuration after layer resolution;
- detect and import artifacts from other agent runtimes;
- request user input or permission through the client;
- inspect plugin state, with several plugin methods still marked under development.

**Trust model:** client application controls the runtime through structured protocol operations.  
**Trigger:** JSON-RPC method or server notification.  
**Lifetime:** app-server process and persisted thread state.  
**Bonding role:** the deepest supported seam for building a custom Codex client or supervisor.

The app server changes the architectural picture. A workflow does not need to force every behavior into `AGENTS.md` or `SKILL.md`; it can keep policy and orchestration outside the model context.

---

## 3. The Full Spectrum

| # | Mechanism | Plane | Decision model | Trigger | Persistence |
|---|---|---|---|---|---|
| 1 | System/managed requirements | Mechanical | Admin deterministic | Startup/action | Machine/org |
| 2 | Sandbox | Mechanical | OS-enforced | Command/tool | Run |
| 3 | Execpolicy rules | Mechanical | Declarative deterministic | Boundary-crossing command | File/config |
| 4 | Lifecycle hooks | Mechanical | Script deterministic | Runtime event | File/config |
| 5 | Approval flow | Mechanical/human | Human decision | Requested escalation | Turn/run |
| 6 | Global/project configuration | Instruction/mechanical | Deterministic precedence | Startup | File/config |
| 7 | Profiles | Instruction/mechanical | User-selected preset | Launch | File/config |
| 8 | `AGENTS.md` | Instruction | Model interpretation | Startup/cwd | Repository/home |
| 9 | Memories | Instruction | Model extraction/reuse | Idle/startup | Runtime state |
| 10 | Skills | Instruction | Model selection | Explicit/implicit match | Installed files |
| 11 | Bundled skill scripts | Instruction → action | Model invokes shell/tool | During skill | Skill files |
| 12 | Custom agents | Delegation | Parent model chooses role | Spawn | Config + thread |
| 13 | Multi-agent tools | Delegation | Parent orchestration | Runtime call | Thread state |
| 14 | Plugins | Distribution | Installed package + host selection | Session startup/task | Plugin install |
| 15 | MCP client | External tools | Model tool selection | Runtime call | Config/auth |
| 16 | `codex exec --json` | Control | External process supervision | CLI invocation | Optional rollout |
| 17 | SDK | Control | Host application | API call | Host/thread state |
| 18 | Codex as MCP server | Control | External agent/orchestrator | MCP call | Orchestrator state |
| 19 | App server | Control | Structured client control | JSON-RPC | Process + SQLite/rollouts |
| 20 | Git worktrees / parallel threads | Environment | Host/runtime coordination | Delegation | Filesystem |

---

## 4. Observed Community Composition Patterns

### 4.1 JSONL Hook Runner: Reconstructing Lifecycle Outside the Runtime

**Pattern:** wrap `codex exec --json`, consume its JSONL stream, write a transcript, and emit higher-level events to local scripts.

A community implementation, `codex-hook-runner`, historically filled gaps before native hooks and remains relevant when users need a custom event vocabulary or a supervisor spanning multiple Codex processes.

```text
prompt
  ↓
wrapper starts codex exec --json
  ↓
JSONL events → transcript + derived lifecycle events
  ↓
external scripts / notifications / validation
  ↓
wrapper returns or resumes
```

**Why it matters:** native hooks run inside the Codex lifecycle; the JSONL wrapper observes the lifecycle from outside. It can correlate multiple processes, retain complete telemetry, or kill a run when the native hook contract is insufficient.

**Risk:** duplicated semantics. A wrapper's invented `PreToolUse` may not exactly match native `PreToolUse`; version changes can silently break parsers.

### 4.2 Self-Evolving Repository Discipline: `AGENTS.md` + Hooks + Git Gates

**Pattern:** keep behavioral instructions in `AGENTS.md`, run validation with hooks, and use git/CI gates as the final authority. Community systems describe this as "self-evolving" because corrections are promoted into repository guidance while proof requirements remain deterministic.

**Composition:** model-readable policy + event-triggered checks + external source-control enforcement.

**Key insight:** the best loop does not ask `AGENTS.md` to enforce itself. The file explains intent and remediation; hooks and CI establish whether the result is acceptable.

### 4.3 Memory Checkpoints Around Compaction

**Pattern:** use `PreCompact`/`PostCompact` hooks or an external wrapper to create a structured handoff before context is compressed, then re-inject the checkpoint afterward.

Typical checkpoint fields:

```yaml
goal:
accepted_decisions:
rejected_paths:
files_changed:
tests_run:
open_risks:
next_action:
```

**Why it matters:** native compaction preserves continuity heuristically. A deterministic checkpoint makes the intended continuity explicit and inspectable.

**Risk:** the checkpoint can fossilize an incorrect assumption. It should preserve decisions and evidence, not merely summarize the model's current story.

### 4.4 Hierarchical Multi-Agent Orchestration

Community reports from long-horizon work favor a coordinator → slice leads → specialists structure over a flat swarm. The useful unit is often a user-visible scenario or bounded outcome, not simply one repository or directory.

**Composition:** custom roles + multi-agent tools + worktrees + parent synthesis.

**Key insight:** delegation quality depends less on agent count than on ownership boundaries and integration protocol.

A safe community recommendation is one worker per worktree, limited commands, no ambient secrets, and review before integration.

### 4.5 Skill + MCP Pairing

**Pattern:** a skill describes the procedure and decision rules; an MCP server supplies authenticated actions and structured data.

```text
SKILL.md: when, why, sequence, interpretation
MCP: what can be read or changed
rules/hooks: what may not happen silently
```

This is stronger than embedding raw API calls in skill scripts because authentication, schemas, and audit behavior can live in the tool layer.

**Risk:** the skill may implicitly trust tool output or over-broaden MCP permissions. Tool descriptions and approval boundaries become part of the prompt-injection surface.

### 4.6 Heuristic-to-Deterministic Promotion

A recurring community idea is to treat successful model heuristics as candidates for promotion:

1. model notices a recurring pattern;
2. human confirms it across cases;
3. a script, fixture, linter, rule, or hook is created;
4. the skill/`AGENTS.md` is shortened to reference the deterministic check;
5. CI verifies the invariant independently.

**Key insight:** the durable product of learning is often not more prose. It is a smaller prompt plus a stronger executable invariant.

### 4.7 External Agent Configuration Migration

The app server can detect and import configuration artifacts from other agent runtimes, including instructions, skills, subagents, hooks, commands, MCP configuration, plugins, and sessions.

**Pattern:** use migration as a translator, then keep runtime-native renderings instead of forcing one universal configuration file.

**Risk:** syntactic migration may imply semantic parity where none exists. A Claude hook, Codex hook, and wrapper-generated event can share a name but differ in timing, payload, blocking semantics, and child-agent identity.

---

## 5. Architectural Vectors

These are derived possibilities, not validated recommendations.

### 5.1 Vector: The Two-Sided Hook

**Known:** Codex has internal lifecycle hooks and an external JSONL/app-server event surface.

**Composition:** pair an internal hook with an external supervisor.

- internal hook performs low-latency action-local validation;
- external supervisor correlates the action with session history, other agents, CI state, or budget;
- supervisor can stop, resume, or fork the workflow.

**Example:** `PreToolUse` blocks obvious dangerous shell input locally; an external supervisor watches cumulative behavior and detects a slow privilege-expansion pattern across multiple individually acceptable commands.

**Opportunity:** local certainty plus global context.

**Failure mode:** contradictory policy and race conditions between the two sides.

### 5.2 Vector: Profiles as Operational Regimes

A profile can select an entire operational posture:

```text
review profile:
  read-only sandbox
  reviewer agent defaults
  no network
  strict hooks
  low write permissions

implementation profile:
  workspace-write
  test hooks
  selected MCP servers
  implementation agents
```

This is more reliable than asking the model to "act as reviewer" while leaving write capability unchanged.

**Opportunity:** behavioral instruction and technical capability change together.

**Experiment needed:** determine which live overrides and child-agent settings can unexpectedly weaken or supersede profile intent.

### 5.3 Vector: App-Server Skill Hot Reload as a Skill Laboratory

The app server can list skills, force reload, watch changes, and enable or disable skills by path.

Possible laboratory loop:

1. run a held-out task set;
2. record skill selection, tool sequence, output, and corrections;
3. modify description or procedure;
4. force reload without restarting the whole client;
5. rerun against the same cases;
6. accept only changes that improve held-out behavior.

**Opportunity:** skill development becomes measurable rather than anecdotal.

**Danger:** optimizing against a tiny task set can produce trigger overfitting and brittle instructions.

### 5.4 Vector: Memory as Candidate Generator, Repository as Authority

Codex memory can surface recurring context, but it is opaque and user-specific. Repository files are inspectable and shared.

Proposed boundary:

- memory proposes recurring facts or preferences;
- a periodic review extracts candidates;
- humans promote validated project facts into `AGENTS.md`, tests, or documentation;
- stale personal memories never become team policy automatically.

**Opportunity:** use implicit memory for discovery, not authority.

### 5.5 Vector: Command Rules Generated from Observed Approvals

The event stream and approval history can reveal repeated human decisions.

Possible loop:

1. collect commands that repeatedly receive the same approval outcome;
2. normalize argument vectors;
3. propose a Starlark prefix rule;
4. test it with `codex execpolicy check` against positive and adversarial cases;
5. require human review before installation.

**Opportunity:** reduce approval fatigue without asking the model to remember exceptions.

**Hard boundary:** never auto-install an `allow` rule from behavioral telemetry alone.

### 5.6 Vector: Delegation Contracts as Machine-Checked Artifacts

A subagent prompt can specify ownership in prose, but ownership can also be represented in a file:

```json
{
  "agent": "api-reviewer",
  "cwd": "worktrees/api-review",
  "read": ["src/api/**", "tests/api/**"],
  "write": ["reports/api-review.md"],
  "forbidden": ["git push", "dependency install"],
  "deliverable": "reports/api-review.md"
}
```

Hooks and external supervisors could validate commands and changed paths against this contract.

**Opportunity:** transform "please stay in your lane" into an auditable boundary.

**Current obstacle:** spawned-agent `cwd` and hook identity have had reported gaps; the contract may need an external process/worktree boundary rather than relying only on native child threads.

### 5.7 Vector: Skill Activation Telemetry Without Skill Hooks

Codex's lifecycle surface does not yet clearly provide first-class pre/post skill events. However, activation may be inferred through app-server skill reads, file-access telemetry, event traces, or wrapper instrumentation.

**Opportunity:** measure which descriptions actually trigger, which skills are omitted by the initial-list budget, and where explicit invocation is required.

**Danger:** inference is not equivalent to an official event. It can miss cached or internal loads.

### 5.8 Vector: Codex-as-MCP Recursive Delegation Boundary

Codex can consume MCP tools and can itself be exposed as an MCP server to a broader orchestrator.

This permits a layered architecture:

```text
orchestrator agent
  └── Codex MCP specialist
        ├── local shell/files
        ├── domain MCP tools
        └── Codex subagents
```

**Opportunity:** preserve runtime specialization instead of flattening all agents into one prompt language.

**Danger:** recursive delegation obscures responsibility, cost, permissions, and provenance. Every layer needs explicit depth limits and trace identifiers.

### 5.9 Vector: `SessionEnd` as Promotion Gate, Not Reflection Dump

A naïve end hook appends everything learned. A stricter pattern would produce three outputs:

- **candidate:** possible reusable insight;
- **evidence:** exact failures, corrections, and successful reruns;
- **target:** memory, `AGENTS.md`, skill, rule, test, or nowhere.

Only the candidate and evidence are generated automatically. Promotion remains human-reviewed or test-gated.

**Opportunity:** prevent endless append-only "learnings" files.

### 5.10 Vector: Runtime State Introspection as Wake Contract

Rather than hard-code environment identity into instructions, an external client can query effective configuration, discovered hooks, skills, MCP status, working directory, sandbox, and thread metadata through the app server, then inject a compact verified wake packet.

```yaml
runtime: codex-cli
cwd: /repo
profile: review
sandbox: read-only
hooks: [pretool-policy, session-checkpoint]
skills_enabled: [review, architecture]
mcp_ready: [github]
thread: resumable
```

**Opportunity:** the agent receives resolved reality, not an aspirational configuration file.

---

## 6. Negative Space and Friction

### 6.1 No Stable First-Class Skill Lifecycle Event

Community requests for `PreSkillUse` and `PostSkillUse` indicate a real observability gap. Without them, it is harder to:

- audit skill adoption;
- gate a specific skill;
- inject skill-specific dynamic context;
- measure implicit versus explicit activation;
- trigger post-skill validation reliably.

This is Codex's closest analogue to a missing "SkillActivated" event.

### 6.2 Hook Handler Types Are Not Symmetric Yet

The configuration parser recognizes handler forms that are not executed. Command hooks are supported; prompt and agent handlers are skipped, and async command hooks are not active.

Architecturally, this means hooks can run machinery but cannot yet natively delegate a hook decision to a model/agent handler in the same declarative surface.

### 6.3 Child-Agent Identity in Hooks Has Been Incomplete

Community issue reports describe hook events that lacked enough metadata to distinguish main-thread and subagent activity. Even with dedicated `SubagentStart` and `SubagentStop` events, action-level hooks need stable agent/thread identity to apply differentiated policy.

Until verified in a target version, do not assume a `PreToolUse` hook can safely route based on agent role.

### 6.4 Spawned-Agent Working Directory Is Not a Hard Isolation Primitive

Reports request a `cwd` argument for `spawn_agent`, because prompt-level instructions to work in a specific worktree are not a reliable filesystem, hook, sandbox, or git-root boundary.

For high-integrity parallel work, separate Codex processes launched with explicit `--cd` may remain safer than child threads sharing a parent environment.

### 6.5 Worktree Lifecycle Can Leak

A July 2026 issue reports large numbers of unmanaged temporary repository copies not represented in Codex's managed-worktree state. This is an implementation report, not proof of universal behavior, but it is sufficient to require measurement before trusting long-running parallel orchestration.

### 6.6 Instruction Modularity Remains Awkward

`AGENTS.md` composition is directory-based. Community requests for include directives and modular global instruction directories show the cost of duplicating shared fragments or growing one monolithic global file.

Skills can absorb reusable procedure, but they do not replace always-on modular policy.

### 6.7 Semantic Portability Is Weaker Than File Portability

The same `SKILL.md` may be readable by multiple runtimes, but:

- skill discovery budgets differ;
- invocation syntax differs;
- bundled dependency declarations differ;
- hook availability differs;
- sandbox and approval semantics differ;
- custom-agent composition differs.

"Portable" should mean the core procedure survives, not that operational behavior is identical.

### 6.8 State Is Powerful but Distributed

Relevant state can live in:

- `AGENTS.md` files;
- config and profile TOML;
- hook JSON/TOML;
- `.rules` files;
- skill directories;
- plugin installations;
- MCP auth/config;
- history JSONL;
- rollout files;
- SQLite runtime state;
- memory stores;
- worktrees;
- external supervisor databases.

The bonding layer can become an archaeology layer. Any serious system needs a command or dashboard that explains the effective state for a thread.

---

## 7. Security and Trust Boundaries

### 7.1 Treat Skills and Plugins as Executable Supply Chain

A skill can bundle scripts and influence tool choice. A plugin can add skills, connectors, MCP servers, and hooks. Review package contents and dependency identities before enabling them.

Project trust matters: untrusted projects should not be allowed to activate repository-local configuration, hooks, or rules silently.

### 7.2 Hooks Are More Dangerous Than Their Small Size Suggests

A ten-line hook sits on a privileged lifecycle seam. It can inspect prompts, alter context, block tools, or execute local programs repeatedly.

Minimum practice:

- absolute or repository-pinned script paths;
- no network by default;
- explicit timeout;
- structured logs;
- fail-closed only where a failure cannot deadlock all work;
- test against malformed and oversized payloads;
- verify behavior for main threads, subagents, resume, and compaction.

### 7.3 Do Not Put Long-Lived Secrets in Broad Job Environments

Official non-interactive guidance warns against exposing API keys to jobs that also execute repository-controlled code, because build scripts and dependency hooks can read those variables. Scope credentials to the single Codex invocation and isolate untrusted code.

### 7.4 Rules Are Preferable to Hooks for Simple Command Policy

Use rules when the question is "may this command prefix run outside the sandbox?" Use hooks only when event context or custom computation is necessary.

A side-effect-free rule is easier to audit than a shell script that decides policy.

### 7.5 External Supervisors Need Their Own Sandbox

A wrapper around sandboxed Codex may itself run unsandboxed. The system boundary is only as strong as the most privileged supervising layer.

---

## 8. Experiments Worth Running

### Experiment A — Hook Event Truth Table

Run one minimal hook for every documented event and record:

- event order;
- payload fields;
- blocking semantics;
- stdout/stderr behavior;
- timeout behavior;
- main thread versus subagent;
- new, resumed, compacted, and interrupted sessions;
- TUI versus `exec --json`.

**Output:** versioned event matrix, not prose impressions.

### Experiment B — Skill Activation Observability

Create three skills with overlapping descriptions and one explicitly invoked skill. Measure:

- which metadata enters initial context;
- description truncation under a large skill set;
- implicit selection frequency;
- explicit invocation reliability;
- whether activation can be observed in hooks, JSONL, or app-server notifications.

### Experiment C — Profile Capability Integrity

Create `review`, `build`, and `unsafe-lab` profiles. Spawn custom agents and apply live permission overrides. Verify the effective sandbox, approvals, hooks, MCP servers, and model for parent and child threads.

### Experiment D — Compaction Checkpoint

Compare three long sessions:

1. native compaction only;
2. `PreCompact` checkpoint injected after compaction;
3. external supervisor creates and validates checkpoint.

Score decision retention, rejected-path retention, file-state accuracy, and token overhead.

### Experiment E — Rule Synthesis Safety

Collect repeated approval decisions, generate candidate prefix rules, then adversarially test command chains, quoting, substitutions, redirections, and shell wrappers using `codex execpolicy check`.

### Experiment F — Native Subagents vs Separate Processes

Run parallel workers through:

- native `spawn_agent`;
- separate `codex exec --cd <worktree>` processes;
- app-server-managed threads.

Measure isolation, hook identity, filesystem ownership, approval routing, merge conflicts, cleanup, and recovery after interruption.

### Experiment G — Skill Hot-Reload Evaluation

Use the app server to modify and reload one skill across a fixed benchmark. Track trigger precision, completion quality, tool calls, context usage, and regression cases.

### Experiment H — Effective-State Manifest

Build a read-only inspector that produces one manifest of:

- resolved config layers;
- active profile;
- loaded instruction files;
- discovered/enabled skills;
- hooks and trust status;
- rules;
- MCP servers and auth status;
- plugins;
- sandbox/approval mode;
- thread persistence paths.

This experiment may be more valuable than another orchestration framework: it makes the existing machinery legible.

---

## 9. Decision Gates

### 9.1 Internal hooks or external supervision?

Use internal hooks for low-latency, event-local enforcement. Use external supervision when the decision depends on multiple sessions, other agents, budgets, CI, or historical behavior. Do not duplicate the same policy in both without defining precedence.

### 9.2 Native subagent or separate process?

Use native subagents for perspective and bounded cognitive delegation. Use separate processes/worktrees when filesystem isolation, credentials, independent failure, or strict per-worker policy is load-bearing.

### 9.3 Memory or repository knowledge?

Use memory for personal continuity and candidate discovery. Use versioned repository artifacts for shared facts, procedure, and enforceable expectations.

### 9.4 Skill or `AGENTS.md`?

- `AGENTS.md`: always-relevant local guidance.
- Skill: reusable procedure activated for a class of tasks.
- Rule: command authorization invariant.
- Hook: lifecycle reaction or validation.
- MCP: authenticated external capability.
- Custom agent: delegated role/context.
- Profile: operational posture.
- External supervisor: cross-run orchestration and observation.

### 9.5 Build now or probe first?

Probe first when relying on:

- hook payload identity across subagents;
- skill activation telemetry;
- worktree cleanup;
- prompt/agent hook handlers;
- async hooks;
- plugin app-server methods marked under development;
- exact memory extraction behavior.

These are moving surfaces or known negative spaces.

---

## 10. Final Synthesis

Houston's Claude-side bonding layer is centered on compositions near the skill lifecycle: skill-scoped hooks, shell injection, bundled scripts, and reflection loops.

Codex's center of gravity is different.

The strongest Codex bond is often not *inside* the skill. It spans:

```text
profile/config
  → AGENTS.md / skill / custom agent
  → sandbox + rules + hooks
  → tool and subagent execution
  → JSONL / app-server observation
  → external evaluation
  → resume, correction, or promotion into deterministic policy
```

The hidden opportunity is the **outside edge**. Codex is unusually available as a runtime component: CLI stream, SDK thread, MCP specialist, app-server process. This makes it possible to keep orchestration, measurement, and policy outside the model's narrative context.

The corresponding danger is architectural theatre: wrapping Codex in more agents, hooks, skills, and state stores without improving evidence, isolation, or recoverability.

The useful test is simple:

> Does the bond move a recurring decision from fragile model recollection into an inspectable contract, deterministic check, bounded capability, or resumable state transition?

If not, it is probably another prompt-shaped wheel.

---

## Sources

### Official OpenAI sources

1. Codex configuration reference — https://developers.openai.com/codex/config-reference
2. Customization overview — https://developers.openai.com/codex/customization/overview
3. `AGENTS.md` guidance — https://developers.openai.com/codex/agent-configuration/agents-md
4. Build skills — https://developers.openai.com/codex/build-skills
5. Hooks — https://developers.openai.com/codex/hooks
6. Rules — https://developers.openai.com/codex/rules
7. Sandbox — https://developers.openai.com/codex/concepts/sandboxing
8. Subagents — https://developers.openai.com/codex/subagents
9. CLI/developer commands — https://developers.openai.com/codex/cli/reference
10. Non-interactive mode — https://developers.openai.com/codex/non-interactive-mode
11. Codex SDK — https://developers.openai.com/codex/codex-sdk
12. Codex app server — https://developers.openai.com/codex/app-server
13. Plugins — https://developers.openai.com/codex/plugins
14. Codex source repository — https://github.com/openai/codex

### Community and issue observations

15. Skill lifecycle hook request — https://github.com/openai/codex/issues/17132
16. Hook subagent identity request — https://github.com/openai/codex/issues/16226
17. Spawned-agent `cwd` request — https://github.com/openai/codex/issues/18969
18. Hook parity discussion — https://github.com/openai/codex/issues/21753
19. Composable `AGENTS.md` request — https://github.com/openai/codex/issues/17401
20. Dynamic nested instructions request — https://github.com/openai/codex/issues/12115
21. Compaction checkpoint discussion — https://github.com/openai/codex/issues/14347
22. Long-horizon orchestration discussion — https://github.com/openai/codex/discussions/13287
23. Parallel orchestration discussion — https://github.com/openai/codex/discussions/22749
24. Worktree lifecycle report — https://github.com/openai/codex/issues/35383
25. Community hook runner and skills — https://github.com/troykelly/codex-skills
26. Self-evolving SDLC adapter — https://github.com/BaseInfinity/codex-sdlc-wizard
27. Community skills and heuristic-to-deterministic patterns — https://github.com/jpcaparas/skills

---

*End of research artifact. @asymmetry, 2026-08-05.*
