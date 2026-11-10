# Native execution: automatic forks without terminal injection

**Documentation checked 2026-10-27 · installed-host qualification still owed**

## 1. Direct answers

Both tasks can be automated. An interactive command is not the only interface. Use explicit source identities rather than selecting whichever session happened to run last.

### Codex shell route

The documented scripted form is:

```bash
codex exec fork "$SESSION_ID" \
  "Review the parser invariants. Report defects; do not edit files."
```

An omitted prompt creates the copy without starting work; `-` accepts a prompt from stdin. This is distinct from the interactive `codex fork` interface. [O1]

The review instruction is not an enforced sandbox. Before using this example, select and test the actual read-only permissions/profile in a disposable workspace. Do not rely on a sentence in a prompt to protect files or networking.

### Codex persistent programmatic route

The app-server supports initialization, `thread/fork` with optional completed `lastTurnId`, and `turn/start` on the returned child `thread.id`. `excludeTurns` reduces response payload; it does not mean “exclude the child's context.” Model and effort can be supplied for the new turn. [O2]

```text
connect → initialize → initialization response → initialized
        → thread/fork(source, boundary)
        → read returned child thread.id
        → turn/start(child, task, configured settings)
        → consume notifications and terminal outcome
```

Representative request bodies, not a complete RPC client:

```json
{"method":"thread/fork","id":12,"params":{"threadId":"SOURCE_THREAD_ID","lastTurnId":"COMPLETED_TURN_ID","excludeTurns":true}}
```

```json
{"method":"turn/start","id":13,"params":{"threadId":"RETURNED_CHILD_THREAD_ID","input":[{"type":"text","text":"Review the parser invariants. Report defects only."}],"model":"AVAILABLE_MODEL_ID","effort":"high"}}
```

An in-progress boundary is rejected. Inspect the installed protocol schema before constructing a client; keep the connection alive through results. Do not use a one-shot pipe that closes before the child finishes. [O2]

### Claude shell route

The native background-session route supports an explicit copied session:

```bash
claude --resume "$SESSION_ID" --fork-session --bg \
  "Review the parser invariants. Report defects; do not edit files."
```

Use the full source session UUID. `--bg` is incompatible with print mode; this route does not require `-p`. An untrusted workspace can reject unattended startup. The documented CLI exposes model/effort settings, subject to model support. [A1][A2]

```bash
claude --resume "$SESSION_ID" --fork-session --bg \
  --model "$MODEL" --effort "$EFFORT" \
  "Review the parser invariants. Report defects; do not edit files."
```

This starts an independent background session. It is not the same return channel as a parent-managed subagent. `/subtask` is an interactive entry for the latter; Claude can also delegate via its agent tool. Do not assume passing a slash command to a shell-print prompt reproduces that interface. [A1][A3]

## 2. Qualification, not adoption

The examples have not been run here. Neither CLI is installed in this workspace. Documentation availability is not proof of installed-version support, account entitlement, cache reuse, permissions, or equivalent quota consumption.

No authentication should change merely to make an experiment pass. In particular, do not silently replace the user's subscriber/native route with an API-key route, do not remove approval restrictions, and do not inject into an already-running pane as an automatic fallback. A rejected launch is useful evidence about the proposed path.

Minimal local inspection, run by the authorized operator/team:

```bash
codex --version
codex exec fork --help
claude --version
claude --help
```

Save these outputs with the run. For an app-server implementation, export the installed schema and keep its hash with the adapter's tests. Use model discovery/local configuration rather than copying a model name from this report.

## 3. Capability table the team should produce

Populate from actual trials rather than assuming vendor parity:

| Capability | Result to record |
|---|---|
| Copy a known saved context | Supported / absent / rejected; exact source and new child identity. |
| Choose a completed checkpoint | Supported boundary granularity and whether inherited context is compacted. |
| Begin work automatically | One initial assignment without another manual terminal. |
| Select model and effort | Actual effective settings, not merely requested flags. |
| Continue a known worker | Whether later work reaches the intended child and retains its relevant history. |
| Observe result | Terminal status, response/artifact reference, identity correlation, errors. |
| Stop/recover | Cancellation outcome, partial artifacts, no silent resubmission after ambiguity. |
| Isolate filesystem effects | Actual workspace/worktree and allowed paths; conversation copying is not disk rollback. |
| Inspect usage | Exposed input/cache/output/reasoning metrics; missing metrics explicitly unavailable. |
| Preserve usage path | Auth mode and account route recorded without credentials or secrets. |

## 4. A minimal disposable testbed

Use one synthetic repository or directory containing harmless text and a tiny deterministic task. Do not test first on a live cSharp, a shared working tree, or a task with external effects.

Suggested experiment files (proposed names, not created in the user's repository):

```text
native-inheritance-test/
  README.md                    purpose, authority and allowed effects
  manifest.json                versions, source boundary, workspace identities
  task.md                      fixed assignment and acceptance rubric
  source-fixture.md            synthetic background facts
  expected.json                independently prepared expected answers
  runs/<run-id>/
    launch.json                exact argv or RPC requests; sanitized settings
    observed.ndjson            captured output/events, no secrets
    result.json                normalized result, preserving raw evidence links
    verdict.md                 independent check and residual uncertainty
```

The fixture should contain a harmless canary fact introduced before the child assignment, plus a constraint and an obsolete fact superseded later. The assignment must not repeat the canary. Check whether the child finds the correct applicable fact and distinguishes superseded information. Success demonstrates a bounded form of inheritance, not complete fidelity to every parent token.

Include a source/workspace mismatch case: the transcript describes revision A while the child sees B. A safe receiver detects or declares the mismatch; it must not treat inherited confidence as fresh verification.

### Failure cases

Test unavailable source ID, ambiguous selection, source still busy, cancellation, duplicate launch attempt, lost launch response, blocked permission, missing result, stale artifact, and parent/child concurrently present. A no-edit request must also be tested against real permissions. Do not claim “exactly once” because a request has an ID; recovery must establish whether the first launch happened before retrying.

## 5. Completion has two levels

**Execution completion:** the chosen runtime reports a correlated terminal outcome and a usable response record exists.

**Task acceptance:** the output passes the independently specified criteria, including file revision and applicable constraints.

A runtime can finish successfully with the wrong answer. A child can finish a turn while delegated external work is unresolved. Represent failure, interruption, timeout, and unknown separately rather than reducing all terminal signals to `done`.

This separation is a design requirement grounded in the lab's interactive-interposition study and the VIST observation principle; the exact runtime event names must remain adapter-specific.

## 6. Context, computation and independence

A native fork is a context-inheritance mechanism. A provider cache hit is a computation-reuse observation. Neither establishes cross-model KV transfer. Claude documents a same-model full-history fork subagent with cache sharing and a fresh custom-subagent route with different configuration; the two should not be conflated. [A3]

Caches depend on compatible request prefixes and settings. Claude documents model-switch invalidation and model/provider-specific effort behavior. Measure warm/cold cases separately and record unavailable metrics; do not infer a cache hit from fast output. [A4]

A full fork is usually a reasonable candidate for continuation. It is a poor default for an experiment claiming a fresh independent review of the parent's conclusion. Give such a reviewer source evidence and rubric without the parent verdict, and record exposure.

## 7. Release boundary

Before execution, the session owner should name: the disposable source, supported launch surface, permitted models/settings, spending/quota limit, effective permissions, allowed artifact locations, stop condition and cleanup responsibility. No approval of this document authorizes modifying production configuration or current repository canon.

## Sources

- [O1 — Codex CLI reference](https://developers.openai.com/codex/cli/reference), `codex exec` fork subsection.
- [O2 — Codex app-server](https://developers.openai.com/codex/app-server), initialization, fork and turn-start sections.
- [A1 — Claude agent view](https://code.claude.com/docs/en/agent-view), shell dispatch and background-copy sections.
- [A2 — Claude CLI reference](https://code.claude.com/docs/en/cli-reference), resume/fork/model/effort flags.
- [A3 — Claude subagents](https://code.claude.com/docs/en/sub-agents), fork/fresh distinction.
- [A4 — Claude prompt caching](https://code.claude.com/docs/en/prompt-caching), request compatibility and invalidation.

All checked 2026-10-27. Capability descriptions above are intentionally short; the qualification design is Wave's proposal. See `sources-and-coverage.json` for the committed lab sources and reading limits.
