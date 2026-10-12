# 02 — Parser & gate

Nabla.Tmux handoff · 2 of 5 · uses 01 (semantics, codes), 03 (door), 04 (resolve, scope)

## Position

Hand sketch, frame 2: A → C → B → C → A, where C is parser + gate. Replies are messages too: same parser, same gate, same door.

```
bus send / bus submit ─► parser ─► gate ─(hold)─► human: bus approve ─► door ─► target pane
                           │          └─(promoted class, phase 2)─────► door
                           └─► rejected: verdict at once, logged, file to dead/

target:  bus working 0042 20m       ─► parser ─► log          (signal: no hold, no delivery)
target:  bus reply 0042 < result.md ─► parser ─► gate ─► door ─► sender pane
```

The parser checks form only. The gate (prompt control) decides hold or deliver. Both run inline in the sender's command, so the verdict needs no daemon.

## Message file

Header: flat `key: value` lines between `---`. Valid YAML, but no nesting and no multiline values, so zsh and Python read it without dependencies. Payload: between two marker lines carrying the same nonce.

```markdown
---
bus: 1
to: atlas
type: task
budget: 15m
created: 2026-10-10T17:32:05+02:00
---
Notes here are outside the payload: kept in the file, never delivered.

<!-- bus:begin 7f3a -->
Check 02_PARSER_GATE.md against the failure catalogue in 01.
List every code the parser can emit that the catalogue lacks.
<!-- bus:end 7f3a -->

Anything after the end marker is outside too.
```

| Field | Required | Written by | Notes |
|---|---|---|---|
| `bus` | yes | writer | format version `1` |
| `to` | yes | writer | agent name or instance id |
| `type` | yes | writer | `task`, `info`, `result`, `working`, `cancel` |
| `parent` | for result, working, cancel | writer | the id being answered or acknowledged |
| `budget` | no | writer | task only, e.g. `15m` |
| `hold` | no | writer | `true` asks for human review even in a promoted class |
| `created` | yes | writer or `bus send` | ISO 8601 with offset |
| `from` | no | derived | taken from the sending pane; if written, it must match |
| `id`, `thread` | — | tooling | written on acceptance; a model-written value is rejected |

Two entry points, one format: `bus send` builds the file from flags and stdin; `bus submit <file>` takes a file the agent wrote itself (the existing bus discipline). Both run in the sender's pane, so the sender is always derived, never declared.

## Zones

| Zone | Where | Parser | Receiver |
|---|---|---|---|
| header | front matter at the top | the only place control is read | gets a rendered envelope, not the raw header |
| payload | between `<!-- bus:begin N -->` and `<!-- bus:end N -->`, same nonce N | opaque: size, encoding and control bytes checked; never scanned for commands | the only delivered content |
| outside | everything else | ignored; byte count logged | never sees it |

- Thinking that leaks around the prompt lands outside: never delivered, still visible to the human in the file.
- Inside the payload, anything that looks like a marker, header or command is plain text. A marker with a different nonce cannot close the payload.
- The two marker lines are the only reserved strings anywhere, and the nonce protects them. Nothing else needs escaping. `bus send` generates the nonce; hand-written files use any 4–8 characters from `[a-z0-9]`.

## Addressing (assignation)

| Token | Meaning |
|---|---|
| `atlas` | agent name; resolves if exactly one live instance is in the sender's range, else TARGET_AMBIGUOUS |
| `atlas#b2` | one specific instance |
| `%12`, `nabla:2.1` | raw tmux targets: never accepted from agents |

## Control verbs instead of magic words

The slash-command idea, implemented as CLI verbs, so control never travels inside text:

```sh
bus send --to atlas --type task --budget 15m < prompt.md   # verdict JSON, exit code per 01
bus submit draft.md                                          # hand-written file, same checks
bus reply 0042 < result.md                                   # type=result; to and parent derived from 0042
bus working 0042 20m                                         # working signal; sets or extends the budget
bus cancel 0042                                              # sender withdraws an open message
bus status 0042                                              # pull: state and timeline
bus inbox                                                    # pull: open messages addressed to me
bus who                                                      # pull: live instances in my range (04)
```

Agents get this list (verb, purpose, arguments) in their definition or in a short reference file. No hooks and no skill needed: a verb that needs a skill to be used correctly is doing too much.

## Parser: checks in order, fail fast

1. **Envelope.** First line `---`, flat header parses, `bus: 1` → HEADER_INVALID
2. **Sender.** `$TMUX_PANE` → pane option `@bus_instance` (via 03). Unlabeled pane → SENDER_UNKNOWN; differs from `from` → SENDER_MISMATCH
3. **Fields.** Required ones present and well-formed; no `id` or `thread` → FIELD_MISSING, FIELD_INVALID
4. **Boundary.** Exactly one begin/end pair, same nonce, whole-line match → BOUNDARY_INVALID
5. **Payload.** Present for task/info/result, absent for working/cancel; UTF-8; within the size limit; no control bytes except `\n` and `\t` → PAYLOAD_EMPTY, FIELD_INVALID, ENCODING_INVALID, PAYLOAD_TOO_LARGE, CONTROL_CHARS. ESC is rejected because `ESC[201~` ends a bracketed paste and turns the rest of the text into keystrokes.
6. **Freshness.** `created` within the limit → STALE
7. **Idempotency.** Dedup key (sender, target, parent, payload sha256) seen within the window → original verdict with `"duplicate": true`
8. **Lineage.** Parent exists; thread is inherited; a result goes back to the parent's sender → PARENT_UNKNOWN, FIELD_INVALID
9. **Addressing.** Registry `resolve` (04): known, unique, in scope, alive → the TARGET_* codes
10. **Brand.** Target's brand not flagged down → BRAND_UNAVAILABLE
11. **Stamp.** Sender's tier → `OK` or `QUARANTINE`

The parser never calls tmux directly; it uses the 03 and 04 contracts.

## Gate: prompt control

**Phase 1, now.** Every message with a payload (task, info, result) is held for the human, whoever sent it. Signals (working, cancel) carry no instructions: parser only, no hold, logged.

| Command | Does |
|---|---|
| `bus pending` | lists held messages: stamp (OK / QUARANTINE), from → to, type, size, age |
| `bus show <id>` | header, payload and outside zone |
| `bus approve <id>` | queue → door |
| `bus decline <id> "<reason>"` | dead/, plus a notice to the sender |
| `bus edit <id>` | edit a copy in `$EDITOR`, re-run the parser, log `edited`, hold again |

Attractor for the human: tmux `status-right` shows the pending count via `#(bus pending --count)`.

**Phase 2, later, driven by evidence.** A class is (sender agent, target agent, type). From the log, classes with at least N approvals, zero declines and zero edits become candidates. The human promotes a candidate explicitly in the policy file; promoted classes go straight to the door. Promotion is never automatic. Results from proven agents are the natural first candidates.

Held even after promotion: QUARANTINE stamp · class not promoted · `hold: true` · payload above a soft size.

```toml
# policy.toml
[promote]
candidate_min_approvals = 30
classes = [
  # { from = "oraculum", to = "atlas", type = "info" },
]

[tiers]   # by model, as observed so far
proven     = ["fable", "sonnet", "codex", "astra"]
quarantine = ["haiku", "terra", "luna", "jev"]   # plus any model not listed
```

JEV is a non-LLM decision model: it needs its own adapter (03) and its own tests rather than the LLM notice format.

## Delivery

On approval the gate writes a delivery copy, `deliver/<id>.md`: rendered envelope + payload, outside zone stripped, read-only, sha256 logged. Then it calls the door (03).

| Mode | The door types | For |
|---|---|---|
| nudge (recommended default) | one line pointing at the delivery copy | agents with file tools: Claude Code, Codex |
| paste | envelope + payload as a bracketed paste | adapters with verified bracketed-paste support only |

Why nudge by default: one line carries no newline, escape or paste-size risk; the TUI context stays small; and it fits the existing discipline where the bus file stands in for the live prompt. The nudge is the missing attractor.

```
[bus] task 0042 from oraculum#a1 · budget 15m · read ~/.local/state/bus/deliver/0042.md · when done: bus reply 0042 < file
```

Claude Code variant, to test before adopting: the nudge is `/bus-inbox 0042`, and a custom slash command holds the handling procedure (read the copy, `bus working`, do the task, `bus reply`). The protocol text then lives in one versioned file instead of in every nudge.

Until input-while-busy behavior is measured per CLI (03, adapters), the gate releases the next queued message to a target only after that target's previous task has completed.

Envelope authenticity is positional: the system writes the nudge line and the first line of the delivery copy, and agents are told to trust only those. A fake envelope inside a payload is plain text below the real one. This is not cryptographic, but it is adequate for cooperating agents.

## Timing

| Beat | Who | How | If missing |
|---|---|---|---|
| 1 · verdict | sender's command | JSON + exit code, about 1 s | — |
| approval | human | `bus approve` | stays in pending/, counted in the status line |
| 2 · working | target | `bus working <id> <budget>`, repeatable to extend | NO_ACK after the ack window |
| 3 · result | target | `bus reply <id>` → parser → gate → door → sender | TIMED_OUT at budget → dead/, notice to the sender |

## Notices back to the sender

Injected, because they change the sender's next move: result · declined · timed_out · failed · delivery_failed once its retries are exhausted.

Pull only (`bus status`, `bus inbox`): accepted/held · approved · delivered · working · no_ack.

## Must test: agent behavior (tier by results)

- Sends `bus working` on start and `bus reply` on finish, prompted only by the nudge.
- Acts sensibly on declined, timed_out and failed notices.
- Keeps ids straight with several open tasks (forks).
- In hand-written files, keeps its thinking outside the payload.

Models that pass get longer budgets and heavier tasks. Models that stumble get short tasks or a tuned notice format.

## Existing material

The current bus discipline lives in reposoma `raw.guides/runbook/` (bus markdown). It was not read for this handoff. Reconcile the field names; `id`, `parent` and `thread` replace hand numbering, and the helper view groups by thread.

## Must not forget

- Control comes only from the header; the payload is never re-scanned; the outside zone is never delivered.
- `from` is derived, not declared.
- The parser uses contracts, never tmux.
- Replies pass the same parser and gate.
- Phase 1 holds everything; promotion happens only by explicit human decision on logged evidence.
- QUARANTINE never auto-delivers.
