# nabLarva — Brokered Rooms for Independent Terminal Agents

## Core position

The primary object in nabLarva should not be an agent session or a shared transcript.

It should be a **room event journal**.

Every human and agent session is an independent participant attached to that room. The room broker records messages, assigns order, applies addressing rules, and delivers a participant-specific projection of the journal.

```text
 OpenCart CLI adapter ─┐
                       │
 Laravel CLI adapter ──┼── Unix socket ── larvad ── append-only journal
                       │                      │
 Human CLI ────────────┘                      ├── filtered deliveries
                                              ├── checkpoints
                                              └── audit transcript
```

The agents remain peer sessions:

* each runs in its own project directory;
* neither is a subprocess or subagent of another;
* neither owns the communication state;
* the broker transports text but does not reason on behalf of the participants.

This distinction matters. nabLarva is a **communication substrate with regulation**, not another AI orchestrator.

---

# A. Architecture

## A.1 Components

### 1. `larvad` — room broker

One small foreground process owns a room.

Its responsibilities are deliberately narrow:

* accept participant connections;
* authenticate participant identity locally;
* validate addressing;
* assign a monotonic room sequence number;
* append accepted events to the journal;
* fan events out only to eligible recipients;
* track delivery cursors;
* enforce consultation budgets and control states;
* produce derived human-readable views.

It does not parse repositories, summarize projects, invoke models, or decide which agent is correct.

For version 1, `larvad` listens on a Unix domain socket:

```text
$XDG_RUNTIME_DIR/nablarva/nablarva.sock
```

It can run in a `tmux` pane rather than as a permanent system service.

### 2. `larva` — human command-line client

The human uses a small CLI:

```sh
larva send @all "Compare the migration boundaries."
larva send @opencart --private "Check the legacy tax calculation."
larva tail
larva audit --all
larva consult open MIG-004 --blind --budget 8
larva consult extend MIG-004 4
larva checkpoint accept MIG-004
```

`larva tail` is the primary live interface. It works with a normal terminal, `less`, `tmux`, or shell redirection.

The room state directory can be opened directly in Sublime Text.

### 3. Agent adapters

Each live agent session has one adapter process:

```text
larva-agent-claude
larva-agent-codex
```

An adapter:

1. starts one CLI session inside the configured project directory;
2. owns its pseudo-terminal;
3. receives clean room messages from `larvad`;
4. injects those messages into the interactive session;
5. observes the CLI response;
6. extracts the meaningful final text;
7. submits that text back to the broker as a room event.

The adapter is transport-specific. The room protocol is not.

Where a CLI offers a stable structured event stream, the adapter should consume it. Otherwise, it uses a PTY parser profile with tested prompt and completion boundaries.

The adapter must not forward:

* spinners;
* ANSI redraws;
* token counters;
* tool progress;
* shell command echoes;
* status bars;
* repeated prompt decorations.

A raw PTY capture may be retained for debugging, but it is not part of the room conversation.

### 4. Optional `tmux`

`tmux` is useful as a process host and emergency observation surface:

```text
┌ larvad / room events ┐
├ OpenCart agent       ┤
├ Laravel agent        ┤
└ human shell          ┘
```

It is not the routing layer.

Using `tmux send-keys` and `capture-pane` as the primary protocol would couple nabLarva to screen rendering and make clean extraction unreliable.

---

## A.2 Durable state

A room lives under:

```text
$XDG_STATE_HOME/nablarva/rooms/<room-id>/
├── room.toml
├── participants.toml
├── goal.md
├── state.md
├── journal.ndjson
├── transcript.md
├── cursors/
│   ├── human-majkee.json
│   ├── agent-opencart.json
│   └── agent-laravel.json
├── adapters/
│   ├── agent-opencart.json
│   └── agent-laravel.json
└── raw/
    ├── agent-opencart.log
    └── agent-laravel.log
```

### Authoritative state

`journal.ndjson` is the source of truth.

It is append-only and written by one process. Every accepted event receives a monotonically increasing `seq`.

### Materialized views

The following are derived and recoverable:

* `transcript.md` — complete readable audit history;
* `state.md` — current goal, accepted decisions, open questions and active consultations;
* participant catch-up views;
* delivery cursors.

The journal can regenerate them.

### Project repositories

The room state should not live inside either participant repository by default. Otherwise, one project accidentally becomes the owner of the shared conversation.

Accepted decisions can later be exported deliberately into files such as:

```text
ARCHITECTURE.md
DECISIONS.md
MIGRATION_PLAN.md
AI_HANDOFF.md
```

---

## A.3 Event format

An event might look like this:

```json
{
  "seq": 184,
  "id": "01K1E6MZ4Y6J9TM38W7V21QF9R",
  "time": "2026-07-31T19:42:11+02:00",
  "room": "opencart-laravel-migration",
  "kind": "message",
  "from": "agent:opencart",
  "to": ["agent:laravel"],
  "scope": "private",
  "goal_rev": 3,
  "consultation": "MIG-004",
  "reply_to": 181,
  "body": "The current admin writes stock history inside the order-status transition."
}
```

Relevant event kinds include:

```text
message
goal
consultation_opened
consultation_paused
consultation_extended
checkpoint_draft
checkpoint_accepted
decision
participant_online
participant_offline
delivery_attempt
delivery_ack
```

Control events and conversational events share the same ordering.

---

## A.4 End-to-end message travel

Consider a private question from the human to the OpenCart agent.

### 1. Human submits

```sh
larva send @opencart --private \
  "Does the old admin have side effects outside the order transaction?"
```

### 2. Broker accepts

`larvad`:

* identifies the sender;
* validates that `@opencart` exists;
* confirms that private delivery has exactly one recipient;
* attaches the active goal and consultation revisions;
* appends the event to `journal.ndjson`;
* assigns sequence number 185.

### 3. Projection is calculated

The message is eligible for:

* the OpenCart agent;
* the sender’s audit view;
* the owner’s later full audit.

It is not delivered to:

* the Laravel agent;
* the ordinary shared human live stream;
* unrelated participants.

### 4. Adapter injects

The OpenCart adapter receives a framed event and injects something like:

```text
[nabLarva · private from human:majkee · MIG-004 · message 185]

Does the old admin have side effects outside the order transaction?

Reply to the sender. Keep this answer inside MIG-004.
```

The agent is not shown:

* its own previous output;
* unrelated room messages;
* messages addressed to the Laravel agent;
* the complete journal.

### 5. Agent answers

The adapter extracts the meaningful response and sends it to the broker.

By default, an agent response goes to the sender of the message being answered. Explicit addressing uses a small transport header:

```text
@@nablarva to=@laravel visibility=private

The stock-history write is outside the transaction and can survive rollback.
```

The adapter removes the header before storing the body.

---

# B. Addressing and visibility model

## B.1 Addressing

Every event has an explicit recipient set.

Supported forms:

```text
@all
@human
@agents
@opencart
@opencart,@laravel
```

Named groups are expanded by the broker at append time. This preserves the actual recipients even if group membership later changes.

An empty recipient set is invalid.

## B.2 Scope

`scope` is one of:

```text
shared
private
```

### Shared

A shared event can target all participants or a subset. Only the named recipients receive it.

### Private

A private event has exactly one recipient.

Private means:

> Do not inject this traffic into any non-recipient’s working context or ordinary live view.

It does not mean cryptographic secrecy from the room owner.

That distinction is necessary because the brief simultaneously requires private lines and complete later auditability.

For version 1, all participants run under the same operating-system user. Private routing is therefore a context and visibility boundary, not a hostile-security boundary.

## B.3 Per-participant projections

For participant `P`, the broker delivers event `E` only when:

```text
E.seq > P.cursor
AND P is in E.to
AND E.from != P
AND E is not administratively held
```

This immediately provides:

* no replay of the participant’s own answers;
* no traffic addressed elsewhere;
* no accidental private-message leakage;
* incremental consumption using a cursor.

The full room transcript is never injected into an agent merely because it reconnects.

## B.4 Auditability

The complete journal contains all accepted communication, including private traffic.

The human owner can run:

```sh
larva audit --all
```

A rendered transcript could show:

```text
[184] [PRIVATE] agent:opencart → agent:laravel
The current admin writes stock history inside the order-status transition.
```

Ordinary live observation uses:

```sh
larva tail
```

That view omits private exchanges not addressed to the human.

Thus private messages remain absent from live working context while remaining inspectable later.

---

# C. Anti-drift regulation

I would not attempt to detect drift primarily with embeddings, topic classifiers, or another supervising model.

That turns a control problem into a probabilistic opinion.

nabLarva should regulate agent exchanges structurally.

## C.1 Versioned room goal

Each room has a human-owned goal revision containing:

* objective;
* explicit non-goals;
* constraints;
* required outputs;
* completion criteria.

Example:

```md
# Goal revision 3

Produce a migration plan for the legacy OpenCart admin.

Constraints:

- preserve current order-processing behaviour;
- identify hidden side effects before proposing Laravel replacements;
- do not design implementation code yet.

Done when:

- migration boundaries are agreed;
- disputed behaviours are recorded;
- each decision names its evidence source.
```

Every consultation and every agent message is tagged with `goal_rev`.

Changing the goal pauses existing consultations until the human explicitly carries them forward.

## C.2 Consultation leases

Agents do not receive an unlimited right to converse.

The human opens a bounded consultation:

```sh
larva consult open MIG-004 \
  --question "Where should the transaction boundary move?" \
  --participants @opencart,@laravel \
  --budget 8 \
  --blind
```

The consultation has:

* one concrete question;
* a participant set;
* a message budget;
* a goal revision;
* a phase;
* an owner.

Each agent-originated message consumes one budget unit.

When the budget reaches zero, further agent-to-agent traffic is held rather than delivered.

The human must choose:

```text
extend
reframe
decide
close
```

This creates real control points instead of merely asking agents to “stay focused.”

## C.3 Blind triangulation protocol

For important decisions, the consultation runs in four phases.

### Phase 1 — Independent positions

Each participant receives the same question but not the others’ answers.

Each produces:

* proposed answer;
* assumptions;
* project-specific evidence;
* principal risk.

The broker holds these responses.

### Phase 2 — Simultaneous reveal

Once all positions arrive, or the human closes the phase, the broker releases the positions to the other participants.

No agent gets to anchor the others by answering first.

### Phase 3 — Bounded challenge

Agents may challenge assumptions and evidence inside the remaining consultation budget.

The broker warns when two messages remain.

### Phase 4 — Position closure

At budget exhaustion, each agent receives a final constrained request:

```text
State your final recommendation.

Include:
- what you changed your mind about;
- the strongest unresolved disagreement;
- the evidence needed to settle it.

Do not open a new topic.
```

The consultation then pauses.

A draft checkpoint is generated from the final positions, but it does not become authoritative until accepted or edited by the human.

## C.4 Accepted checkpoints

A checkpoint records:

```text
goal revision
consultation question
accepted decisions
rejected alternatives
unresolved disputes
next action
relevant journal sequence range
```

A checkpoint is not an AI summary silently replacing history. It is a human-accepted room event referencing the underlying messages.

This checkpoint becomes the cheap re-entry boundary for participants.

---

# D. Failure and restart story

## D.1 Agent session dies

The adapter reports the participant offline.

Messages remain in the journal and are not lost.

When the participant restarts with the same identity:

1. the adapter loads its last durable cursor;
2. the broker finds the latest accepted checkpoint visible to that participant;
3. it sends the checkpoint if the old context cannot be resumed;
4. it sends only subsequent eligible events;
5. the adapter resumes normal delivery.

The participant does not receive the full room history.

## D.2 Uncertain delivery

Perfect exactly-once injection into an interactive terminal is not realistically provable.

A crash can occur after bytes reach the PTY but before a response is observed.

nabLarva should prefer **at-least-once delivery with explicit message IDs** over silent loss.

Delivery state is recorded as:

```text
queued
injected
responded
```

On restart, an `injected` but unanswered event is resent with a replay marker:

```text
[nabLarva replay · message 185]

This message may have been visible before the previous session ended.
Answer only if it was not already handled.
```

The duplicate and both delivery attempts remain visible in the audit log.

## D.3 Broker dies

Because the broker is the only journal writer:

* adapters retain unsent outbound events locally;
* clients reconnect to the Unix socket;
* the broker reopens the journal;
* an incomplete final NDJSON line is discarded;
* the highest valid sequence number is recovered;
* client-generated event IDs prevent duplicate appends.

Derived files are regenerated if necessary.

## D.4 Human observer disconnects

Nothing special happens. Observation is not ownership.

`larva tail` resumes from a local cursor or from a requested sequence number.

## D.5 Long absence

A returning participant receives:

1. the current goal revision;
2. the newest accepted checkpoint visible to it;
3. open decisions relevant to it;
4. eligible messages after that checkpoint.

A full replay remains possible through an explicit command, but it is never the default.

## D.6 Remote-machine extension

The room remains centrally ordered by one broker.

A remote adapter connects over a framed JSON stream transported through SSH:

```text
remote agent adapter
        │
        └── SSH channel ── central larvad
```

SSH supplies authentication, encryption, host identity and operational familiarity. nabLarva does not need to invent a new security protocol.

During a network partition:

* outgoing events are queued with stable client IDs;
* incoming delivery resumes from the participant cursor;
* the broker deduplicates queued submissions on reconnect.

No distributed consensus is needed because a room has one authoritative broker.

---

# E. Version 1 cut

## E.1 Technologies

I would implement the first version using:

* Python 3 standard library;
* Unix domain sockets;
* `asyncio` or `selectors`;
* `pty`, `termios` and `subprocess`;
* JSON framing over sockets;
* append-only NDJSON storage;
* atomic cursor-file replacement;
* `tmux` as an optional process host;
* adapter-specific golden transcript tests.

Python is not my ideal permanent terminal-runtime language, but it is the correct first implementation choice here: PTY support is available, iteration is fast, and version 1 can avoid third-party dependencies.

Rust becomes justified if terminal edge cases, memory safety, packaging, or long-running reliability become actual problems.

## E.2 First supported topology

```text
one machine
one room
one human owner
two agents
Claude Code adapter
Codex CLI adapter
one active consultation at a time
```

Support more participants in the data model immediately, but do not optimize the first interface around large rooms.

## E.3 First usable command surface

```sh
larva room create migration
larva participant add opencart \
  --adapter claude \
  --cwd ~/src/legacy-opencart

larva participant add laravel \
  --adapter codex \
  --cwd ~/src/new-admin

larva up migration
larva goal edit migration
larva consult open MIG-001 --blind --budget 8
larva send @all "Begin independent analysis."
larva tail
larva audit --all
```

## E.4 Validation required before calling version 1 usable

The implementation should prove:

* directed messages reach only intended participants;
* private messages do not enter non-recipient adapters;
* self-originated messages are not replayed;
* restart resumes from the correct cursor;
* journal order remains stable;
* duplicate client submissions are deduplicated;
* budget exhaustion pauses agent traffic;
* ANSI and known process noise are removed;
* meaningful multiline answers survive unchanged;
* a checkpoint plus delta reconstructs useful context.

## E.5 Explicitly deferred

Version 1 should not include:

* browser UI;
* Electron application;
* general workflow graphs;
* autonomous task allocation;
* vector database;
* semantic drift classifier;
* automatic “best answer” selection;
* multi-room federation;
* end-to-end encrypted private traffic;
* hostile multi-user permissions;
* arbitrary third-party plugin framework;
* distributed broker replication.

Those features either contradict the operating culture or solve problems not yet demonstrated.

---

# F. Most contestable decisions

## F.1 A broker instead of pure files and FIFOs

### My choice

Use one small broker process.

### Why

Pure files and FIFOs become awkward once the system needs:

* multiple recipients;
* private filtering;
* total ordering;
* participant cursors;
* reconnect replay;
* delivery acknowledgement;
* backpressure;
* future remote transport.

The broker centralizes those semantics without centralizing agent intelligence.

### Strongest argument against it

A daemon creates lifecycle management, a protocol, and another failure point. A directory of append-only mailboxes plus filesystem watchers would be more visibly Unix-like.

That objection is valid. I reject the files-only approach because the complexity does not disappear; it leaks into locking, fan-out, cursor races and restart handling.

## F.2 Owning the agent PTY

### My choice

The adapter launches and owns the CLI session.

### Why

Clean extraction and deterministic message injection require control of terminal boundaries.

Attaching externally to arbitrary pre-existing sessions would make it difficult to know:

* whether the session is idle;
* which output belongs to which injected message;
* whether text is final output or process noise;
* whether an injection interrupted an active command.

### Strongest argument against it

Users lose some freedom to start and manage sessions however they prefer. CLI updates may also break adapter parsers.

This is the largest operational risk in the design. The correction is to keep adapters thin, fixture-tested and replaceable, while preferring native structured output wherever a CLI exposes it.

## F.3 Append-only NDJSON instead of SQLite

### My choice

Use NDJSON as the authoritative room journal.

### Why

It is:

* directly inspectable;
* streamable;
* recoverable;
* easy to archive;
* easy to transform;
* independent of an application schema browser.

A single writer removes most concurrency concerns.

### Strongest argument against it

SQLite would provide stronger transactions, indexing and queryability with little deployment cost.

If rooms grow large or concurrent operational state becomes complicated, SQLite may become the better authority. I would not adopt it pre-emptively. The journal can later be imported into an append-only SQLite event table without changing the transport protocol.

---

# Final boundary

nabLarva should not become a place where agents converse indefinitely.

Its job is to let independent project-rooted intelligences exchange precisely addressed evidence inside a controlled consultation, while preserving a complete durable record.

The central invariant is:

> One immutable room history, many sparse participant views, and human-owned control over when exchange continues.
