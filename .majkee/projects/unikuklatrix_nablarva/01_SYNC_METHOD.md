# 01 — Sync method: message semantics and best practices

Nabla.Tmux handoff · 1 of 5 · status: draft for implementers
Set: 01 Sync method · 02 Parser & gate · 03 Ovitmugen contracts · 04 Registry · 05 Way of thinking

## What this is, in conventional terms

An asynchronous request–reply message system over a file spool, with one delivery path into terminal panes. The closest established analog is mail transfer: submission → queue → delivery → bounce. We borrow its vocabulary and its failure model:

- SMTP's temporary (4xx) vs permanent (5xx) failures → our retryable/terminal flag
- `sysexits.h`, written for mail delivery → our CLI exit codes
- Maildir's write-to-tmp-then-rename → our spool and atomic state changes

## Naming registers

Project names are for humans. Code, CLI verbs, fields and error codes use conventional names, because agents search for those.

| Project name | Conventional name | Appears in |
|---|---|---|
| Nablarva | the whole build | docs |
| Nabla.Tmux, "the animal" | this message relay | docs |
| ovitmugen | tmux primitives module (tool name only) | module name; functions inside use plain verbs |
| prompt control, "another animal" | gate | code: `gate` |
| bus file | message file | code: `message` |
| oraculum | an agent definition (example: main leader) | agent definitions |

`bus` is a placeholder CLI name throughout.

## Locked requirements

**R1 · Async request–reply.** `bus send` and `bus submit` return a verdict within about a second; the parser runs inline, no daemon involved. The target's work comes back later as its own message, threaded by `parent`. Nothing blocks on the target.

**R2 · Three beats.** Verdict (sync) → working signal with a time budget (from the target) → result (threaded). A required human approval sits between verdict and delivery.

**R3 · Typed failures.** Every failure carries a code from the catalogue below and a retryable flag. The sender's next move depends on the code: fix and resend, respawn, wait, or escalate.

**R4 · Idempotency.** Ids are minted by the tooling, never typed by a model. A duplicate submission (same sender, target, parent and payload hash within the dedup window) returns the original id and verdict with `"duplicate": true`.

**R5 · At-most-once delivery, plus detection.** A duplicated prompt makes an agent do the work twice; a lost one is caught by a timeout. An injection that may have landed is never retried automatically. Only failures that prove nothing was written are retried (inject sequence, 03).

**R6 · Timeouts and dead-letter.** Every task has an ack window and a budget, which the target can extend. Expired messages move to `dead/` and the sender is notified. Nothing disappears silently.

**R7 · Durable log from day one.** Append-only JSONL, one line per transition. It is the debugging trail and the evidence base for promoting message classes to auto-delivery (02).

**R8 · Atomic state.** Directory = current state. Every write goes to `tmp/` and is renamed into place; transitions are renames within one filesystem. If directory and log disagree, the log wins and `bus sweep` repairs the directory.

**R9 · One write path.** Only `pane_inject` (03) writes into a live pane, under a per-pane lock.

**R10 · Pull, not poll.** "Who is alive" and "status of 0042" are answered at the moment of asking. History comes from the log, fed by commands and tmux hooks. No snapshot daemon.

**R11 · Backpressure, before the group grows.** Bounded queue per target; above it → `TARGET_BUSY`, retryable.

## Spool and lifecycle

```
$BUS_HOME = ${XDG_STATE_HOME:-$HOME/.local/state}/bus
  tmp/       writes in progress, never read
  pending/   valid, held for human approval
  queue/     approved, waiting for the door
  deliver/   frozen delivery copies: envelope + payload, read-only
  sent/      delivered and open (task awaiting working/result)
  done/      completed
  dead/      rejected, declined, failed, timed out, cancelled
  lock/      per-pane and spool locks
  log/bus.jsonl
```

| State | Directory | Reached by | Next |
|---|---|---|---|
| held | pending/ | parser OK, gate holds | queued, declined |
| queued | queue/ | `bus approve`, or a promoted class | delivered; delivery_failed is retried until the ack window ends |
| delivered | sent/ | door succeeded | completed, failed, timed_out, cancelled |
| completed | done/ | task: its result delivered · info and result: on delivery | — |
| dead | dead/ | rejected, declined, failed, timed_out, cancelled | — |

`working` is an event on a delivered task (ack time, new budget), not a state.

## Failure catalogue

Codes name a condition; the log's `event` says when it occurred (submit, delivery, or while open). Retryable means the same message, sent again after a respawn or a wait, can succeed. Formal errors are never retryable: the message has to change.

| Code | Retry | Exit | Meaning |
|---|---|---|---|
| HEADER_INVALID | no | 65 | front matter missing, unparseable, or unknown `bus:` version |
| FIELD_MISSING | no | 65 | required field absent or empty |
| FIELD_INVALID | no | 65 | malformed value; a field models must not set (`id`, `thread`); a payload on a signal type |
| BOUNDARY_INVALID | no | 65 | markers missing, unpaired, nonce mismatch, or more than one pair |
| PAYLOAD_EMPTY | no | 65 | task, info or result without a payload |
| PAYLOAD_TOO_LARGE | no | 65 | over the size limit |
| ENCODING_INVALID | no | 65 | not UTF-8 |
| CONTROL_CHARS | no | 65 | ESC or other control bytes besides `\n` and `\t` |
| STALE | no | 65 | `created` older than the freshness limit |
| PARENT_UNKNOWN | no | 65 | `parent` id not found |
| SENDER_UNKNOWN | no | 77 | sending pane not registered; run `bus adopt` there |
| SENDER_MISMATCH | no | 77 | declared `from` differs from the sending pane's identity |
| TARGET_UNKNOWN | no | 67 | name not among the agent definitions |
| TARGET_AMBIGUOUS | no | 67 | several live instances match; use the instance id |
| TARGET_OUT_OF_SCOPE | no | 77 | target outside the sender's range (04) |
| TARGET_NOT_RUNNING | yes | 75 | defined, but no live instance |
| TARGET_GONE | yes | 75 | the instance's pane no longer exists |
| TARGET_DEAD | yes | 75 | pane kept, program exited |
| TARGET_NOT_READY | yes | 75 | readiness probe failed (delivery only) |
| TARGET_BUSY | yes | 75 | target queue full |
| BRAND_UNAVAILABLE | no* | 69 | brand flagged down: subscription, auth, quota |
| TMUX_UNAVAILABLE | no | 69 | no tmux server reachable |
| NO_ACK | — | — | warning: no working signal within the ack window |
| TIMED_OUT | careful | — | budget exceeded; the work may be partly done, so check `bus status` before resending |
| DECLINED | no | — | human declined; the detail holds the reason |
| CANCELLED | no | — | sender withdrew |

\* until a human clears the flag (`bus brand up`, 04).

Two honest limits:

- "Stuck" can't be detected instantly. It shows up as NO_ACK, then TIMED_OUT.
- BRAND_UNAVAILABLE is immediate only when the brand is flagged. Unflagged, a lapsed subscription also shows up as NO_ACK → TIMED_OUT.

Exit codes follow `sysexits.h`: 0 OK · 65 data error · 67 addressee unknown · 69 unavailable · 75 temporary failure · 77 permission denied.

Verdicts on stdout:

```json
{"status":"accepted","id":"0042","thread":"0040","state":"held","to":"atlas#b2"}
{"status":"accepted","id":"0042","state":"held","duplicate":true}
{"status":"rejected","code":"BOUNDARY_INVALID","retryable":false,"detail":"end nonce 9c1e != begin 7f3a"}
{"status":"failed","code":"TARGET_DEAD","retryable":true,"detail":"atlas#b2 exited with status 1"}
```

## Log record

```json
{"ts":"2026-10-10T17:32:05+02:00","event":"held","id":"0042","thread":"0040","parent":"0041",
 "from":"oraculum#a1","to":"atlas#b2","type":"task","code":null,"actor":"gate",
 "sha256":"9f2c…","bytes":1840}
```

Message events: submitted, rejected, held, approved, declined, edited, queued, delivered, delivery_failed, working, no_ack, completed, failed, timed_out, cancelled.
Registry events: spawned, adopted, killed, pane_died, pane_exited, brand_down, brand_up.

## Defaults

```toml
[limits]
payload_bytes    = 65536
freshness        = "10m"
dedup_window     = "10m"
ack_window       = "3m"
task_budget      = "15m"
queue_per_target = 3
oneshot_grace    = "10s"
```

## Implementation notes (recommendations — bend)

- Message ids: monotonic, zero-padded (`0042`), minted under the spool lock. Readable on purpose, because agents and the human type them.
- Parser, gate and door in Python 3 stdlib only (`json`, `tomllib`, `hashlib`, `fcntl`, `datetime`), with thin zsh wrappers as the CLI verbs. JSON, hashing, time arithmetic and locking are one-liners there and fragile in zsh.
- No resident daemon. The verdict is computed inside `bus send`, delivery runs inside `bus approve`, and `bus sweep` (expiries, retries of door steps 1–3, one-shot teardown, directory repair) runs from a systemd user timer or a loop in a utility pane.
- Locks via `flock` (util-linux, standard on Arch/Manjaro).

## Must not forget

- Ids come from the tooling; models only reference them.
- The verdict comes before anything slow.
- Never auto-retry an injection that may have landed.
- Every failure gets a code and a retryable flag.
- Log every transition from the first commit.
- tmp + rename for every write; the log wins on disagreement.
