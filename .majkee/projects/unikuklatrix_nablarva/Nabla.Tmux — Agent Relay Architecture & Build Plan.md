# Nabla.Tmux — Agent Relay: Architecture & Build Plan

Oct 7, 2026 · @Michal Hrůza

## How to review this plan

Eight gated steps take the relay from probes to a unified console; nothing is coded until the Step 0 probes answer. The plan is written for review by Codex and decision by Majkee.

Status tags mark how open each item is:

| Tag | Meaning |
| --- | --- |
| LOCKED | Owner-imposed. Out of scope for review. |
| SETTLED | Agreed in design sessions. Open to challenge with reasons. |
| PROPOSED | New in this document. A veto point, each with a fallback (Ch. 18). |
| OPEN | Undecided. Needs a decision before the step that uses it. |

Section numbers are stable for cross-reference. Each chapter ends with a reserved Codex notes block; any format works there.

### Codex notes

*(reserved)*

## 1. Context and scope

The relay moves selected content between live, interactive coding-agent sessions in tmux, one explicit action per hop. Design sessions call it "the animal".

**1.1 What it does.** It projects each session's transcript into readable markdown and moves a marked span from one session into another. The manual relay and a future automatic relay are the same primitive; only the trigger differs.

**1.2 Members.** Claude Code and Codex CLI are the main brands; Gemini CLI is secondary, and Antigravity can join later through the same brand profile. GEV has no standard CLI, so its wrapper is owner-built. A member is one logical session with a stable tag such as `c1`, however many transcript files it produces.

**1.3 Assumptions.** One Linux host: the office machine where sessions already run inside tmux, reached over SSH. Up to four live members and one human operator. No network transport between bricks, no multi-user access.

**1.4 Grades.** Each grade is a connector over the same core and bed; a higher grade never changes what lies below it.

| Grade | Surface | Built in |
| --- | --- | --- |
| G1 | Plain terminal: tmux, zsh, Python bricks | Steps 1–5 |
| G2 | Editor connector: native selection and composing | Step 6 |
| G3 | Unified console: member views, application-grade input, marking layer | Step 7 |

**1.5 Non-goals for G1–G3.** Autonomous agent-to-agent traffic (Ch. 15). A WASM plugin host. Zellij support, kept reversible behind the multiplexer interface. Screen-scraping as the projection source. A multi-host bus.

### Codex notes

*(reserved)*

## 2. Constraints and invariants

One rule is locked: no vendored agent ever runs in a non-interactive mode. Everything else here is settled design that can still be challenged with reasons.

**2.1 LOCKED — no non-interactive agent modes.** No brick, script, test or helper may run a vendored agent in print, headless or exec mode. That covers Claude Code `-p`/`--print`, `codex exec`, Gemini CLI `-p`/`--prompt`, and vendor SDKs that drive those modes.

- Owner's reason: an announced policy direction under which headless Claude Code use could be billed as standard API usage instead of being covered by the Max subscription. The rule applies to all three vendors for one discipline.
- Consequences: observation means tailing on-disk transcripts; input means injection into the interactive TUI. Any model call inside the tooling (summaries, classification) goes to GEV or a local model.
- Naming collision: tmux `paste-buffer -p` (§9) is tmux's bracketed-paste flag, unrelated to this rule.

**2.2 LOCKED — GEV exempt.** GEV has no standard CLI, so its owner-built wrapper defines the transcript and the input surface. PROPOSED: the wrapper writes the normalized event schema (§5.4) natively and reads bus messages addressed to it, making GEV a first-class member with no adapter and no injection.

**2.3 Policy gate.** Rule 2.1 is necessary, not shown sufficient. Whether an interactive session that receives programmatic input is covered by each vendor's consumer plan is unverified. Probe P6 is a reading task; this plan makes no claim about the terms.

**2.4 SETTLED invariants.**

- Files are the contract: bricks meet only through the bed and never read each other's internals or call each other.
- One writer per file; owners are listed in Ch. 4.
- Atomic visibility: write into `$NT_BED/.tmp/` on the same filesystem, then `rename()` into place.
- Append-only: transcripts are tailed; event logs and projections are appended, never re-rendered in normal operation.
- The transcript is ground truth: vendor hooks may give hints (§11) but are never required for correctness.
- Identity is the member tag; transcript files are transport, and rollover is a rebind.
- Agents are content sources, never protocol participants: envelopes, addresses and acks are written by bricks.
- Every hop needs an explicit release: a human key now, a named rule later; no auto-send on tag detection.
- Nothing is dropped silently: unroutable means held or dead, visibly; an unresolvable anchor stops the release.
- Delivery is not processing: acks record arrival only.
- One brick, one job; the multiplexer sits behind a thin interface; the editor is accounted for, not required.

### Codex notes

*(reserved)*

## 3. Architecture overview

Two flows share one bed: inbound turns transcripts into projections, and outbound turns a human release into an injected, acknowledged message.

&#91;embedded content: architecture · two flows through the bed\]

The loop closes in the agent panes: whatever a recipient answers is tailed back into its own projection. Two secondary paths stay out of the picture: the registrar writes `join` events to the bus, and the deliverer checks the recipient's `events.jsonl` before it acks.

**Layers.** Core: the bricks (Ch. 4). Bed: the folder contract (Ch. 5). Connectors: tmux keys and popups (G1), an editor plugin (G2) and the console (G3), which read the bed and write only through `nt`.

**Staircase at a glance.**

&#91;embedded content: staircase · Steps 0–7 and their gates\]

The side organ (Ch. 14) can start any time after Step 2, and the autonomous regime (Ch. 15) stays unscheduled until its preconditions hold.

### Codex notes

*(reserved)*

## 4. Components (bricks)

Four watchers, one CLI, two libraries and an optional hook make up the core; each owns the files it writes and nothing else. Python is the default, zsh is glue only, and Rust stays in reserve for any brick that proves hot and stable.

| Brick | Job | Reads | Sole writer of | Lang |
| --- | --- | --- | --- | --- |
| `nt` CLI | Human entry point: init, up, launch, bind, view, relay, send, file, spawn, status, dead, retry. Stamps envelopes, resolves anchors | bed | `launch/*.json`; bus `message`, `file`, `spawn`; `files/*` | Python |
| registrar | Recognizes transcript births; classifies new, rollover or unbound; tracks liveness | birth dirs, `launch/`, `hints/`, tmux | bus `join`, `leave` | Python |
| inbound | Tails member sources, runs adapters, appends projections | bus `join`, transcripts | `members/<m>/events.jsonl`, `projection.md`, `tail.json` | Python |
| deliverer | Routes `message` and `file`: idle gate, sanitizing, injection, arrival check | bus, `events.jsonl`, tmux | bus `ack` for message and file | Python |
| spawner | Checks the wallet, calls `nt launch` | bus `spawn`, `wallet.toml` | bus `ack` for spawn | Python |
| adapters (library) | Pure functions: vendor line in, normalized events out; no I/O | — | — | Python |
| mux (library) | The multiplexer interface: list panes, liveness, create pane, pane options, inject | tmux | — | Python |
| hint hook (PROPOSED, optional) | Vendor session-start hook that records which member a new session belongs to | its stdin, `NT_MEMBER` | `hints/<session>.<source>.json` | sh |
| connectors | Human surfaces: tmux keys and popups (G1), editor plugin (G2), console (G3) | bed | through `nt` only | any |

- zsh's role: tmux bindings, popups and thin wrappers around `nt`; no JSON parsing or offset logic.
- A connector never writes bus files itself. All envelope logic lives in `nt`, so connectors stay swappable.
- Bricks meet only through the bed, so any one of them can be rewritten in another language without its neighbours noticing.

### Codex notes

*(reserved)*

## 5. The bed (contract)

The bed is one folder tree, and every interaction between bricks is a file in it. This chapter fixes the layout, the bus event format and the internal event schema that the design sessions left open.

**5.1 Location.** One root, `$NT_BED` (default OPEN, e.g. `~/nt-bed`), mode 0700, outside every agent's writable roots (R5). All atomic writes stage in `$NT_BED/.tmp/`, on the same filesystem as their targets.

**5.2 Layout.**

```
$NT_BED/
  .tmp/                       staging for temp-then-rename
  config.toml                 brand profiles, paths, thresholds   human
  wallet.toml                 who may spawn or message whom       human
  bus/<ulid>.<kind>.<from>-<to>.md   immutable events             per kind
  files/<ulid>.md             file-event bodies, written first    nt
  launch/<member>.json        launch intents, manual binds        nt
  hints/<session>.<source>.json  optional session hints           hint hook
  members/<member>/
    events.jsonl              normalized events                   inbound
    projection.md             rendered view                       inbound
    tail.json                 source, inode, offset               inbound
    notes.md                  scratch                             human
  state/<brick>.json          private state, heartbeat            that brick
  logs/<brick>.log                                                that brick
  outbox/                     optional save-to-release (Step 6)   editor
```

Whole-file writes (events, intents, hints, state) use temp-then-rename. Append-only files get complete lines in one `write()`, and their readers apply the partial-line rule (§8).

**5.3 Bus events.**

- Filename `<ulid>.<kind>.<from>-<to>.md`: `ls bus/` is the chronological event table. A ULID is a time-sortable unique id; member tags are `[a-z0-9]+`.
- Header: flat `key: value` lines between `---` fences, no YAML features, so any language parses it by splitting lines. The header is authoritative; the filename is a convenience.
- Common fields: `v`, `id`, `kind`, `from`, `to`, `time`, plus optional `ref` and `by`.
- Consumers react to rename-into-place only (`IN_MOVED_TO`). A file created directly in `bus/` was not written atomically and is rejected as dead.

| Kind | Written by | To | Injected | Payload fields | Body |
| --- | --- | --- | --- | --- | --- |
| join | registrar | all | no | member, brand, pane, cwd, source, session, basis, continues\_source?, continues\_session? | — |
| leave | registrar | all | no | member, reason | — |
| message | nt | member | yes | by, ref? | text |
| file | nt | member | one pointer line | by, path, ref? | optional note |
| spawn | nt | system | no | by, brand, member, cwd | optional seed |
| ack | deliverer, spawner | system | no | ref, status, reason? | — |

Values: `ack.status` is delivered, held, dead, spawned or denied. `join.basis` is hint, intent, parent-link, cwd or manual. `by` is human, `rule:<name>` or `agent:<member>`; only human exists in G1–G3.

PROPOSED refinements to the design-session envelope:

1. `member` and `source` move from the common header into join and leave; `from` already carries the member tag everywhere else.
2. `by` records who released the hop; loop accounting needs it later.
3. `ack.status` makes held, dead and denied visible on the bus without a seventh kind.
4. A `join` for an existing member is a rebind. It covers both the first source binding after launch and rollover.

PROPOSED — the bus is an immutable log. Events are never moved or edited. Each consumer derives "handled" from its own acks (delivered, dead, spawned, denied), so a restart rescans and resumes with no cursor file.

This replaces archiving into `processed/`: with two consumers and read-only connectors, no single brick can own the move, and the log is the audit trail by construction. ULID order is not a safe cursor, because two producers can rename out of id order.

Example:

```
---
v: 1
id: 01K6ZQ7M2X4N8P0R3S5T7V9W1Y
kind: message
from: c1
to: x1
time: 2026-10-07T14:22:33.512Z
by: human
ref: c1:b14
---
The migration has to run before the seeder, otherwise …
```

**5.4 Normalized events — PROPOSED.** `members/<m>/events.jsonl` is the internal contract between inbound and every downstream consumer: projector, relay, deliverer, console and future rules. Vendor drift is absorbed once, in the adapters.

| Field | Meaning |
| --- | --- |
| `v`, `member`, `seq` | schema version, member tag, per-member counter |
| `anchor` | `b<seq>`; cross-session form `c1:b14` |
| `t` | transcript timestamp, not wall clock |
| `role` | user, assistant, tool\_call, tool\_result, thinking, system, meta |
| `text`, `tool` | content; tool name, id and short arguments when relevant |
| `src` | brand, version, file, byte offset, vendor message id, block index |

Meta events: `turn_end` (the idle signal, §9), `rollover` (source switch), `drift` (unknown vendor record, raw kept), `relay_in` (a user message recognized as an injected relay).

Anchors are minted at first sight, keyed by vendor message id and block index, so re-reads and copied history map to the same anchor. If P1 shows ids change across rollover, a content hash becomes the key. Anchors live in this log; the separate sidecar map is dropped.

**5.5 Projection format.**

- One markdown heading per bubble, so editors show an outline: `#### c1 · assistant · 14:22:07 · b14`.
- A tool call is one line: `▸ Bash: npm test · b15`.
- Tool results over N lines keep head and tail: `… 312 lines elided · full text: b16`.
- Thinking collapses to one line; injected relays render as `◂ relay from x1 · b9`; rollover writes a marker line.
- The projection is a pure function of `events.jsonl`: rebuildable with `nt reproject`, append-only otherwise.

### Codex notes

*(reserved)*

## 6. Step 0 — Probes (gates)

No core code is written until P1–P4 answer, and every capture becomes a test fixture under `fixtures/<brand>/<version>/`. Size: S, one or two evenings.

**P1 Rollover markers — first, highest value.**

- Already reported for Claude Code 2.1.72 on Windows: `/clear` mints a new session id and a new transcript file; `/compact` keeps the session id; a resume reports the source session's id; `--continue` fires both startup and resume ([source](https://dev.classmethod.jp/en/articles/claude-code-session-start-hook-verification/)). Re-verify on Linux and the installed version.
- Procedure: run `inotifywait -m` on the project's transcript directory and snapshot file heads and tails around `/compact`, auto-compaction, `/clear`, `--continue`, `--resume <id>` and `--resume --fork-session`. Repeat the equivalent Codex actions.
- Record per action: new file or same file; any link to the previous session in the new head; history copied or not; vendor message ids preserved; old file still growing.
- Unlocks: registrar classification (§11), dedupe, anchor stability.

**P2 Transcript format.**

- Procedure: one session per brand covering a plain reply, a large tool output, a permission prompt approved and denied, an interrupted turn, parallel tool calls, a subagent and an error.
- Record: role and content-block structure; tool call to result linkage; the turn-end signal; how a pending permission looks; the version field; subagent representation (inline or a separate file).
- Unlocks: adapters v0, the idle signal, subagent policy.

**P3 Birth behavior and binding.**

- Procedure: `inotifywait -m -r -e create,modify,moved_to,close_write` on each birth directory while launching sessions; install the hint hook and launch with `NT_MEMBER` set.
- Record: file created at launch or at the first prompt; empty-then-appended or renamed in; new directories for new cwds; subagent files in the same directory; whether the hook sees `NT_MEMBER`; Codex's first line.
- Known: in interactive mode `--session-id` does not name the transcript file — only print mode honors it, reported on v2.1.92 ([issue #44607](https://github.com/anthropics/claude-code/issues/44607)). The plan therefore does not rely on pinned ids.
- Unlocks: registrar birth handling, intent matching, the hint hook.

**P4 Input injection.**

- Procedure per brand, in a live interactive session: `send-keys -l` plus Enter; multi-line via `load-buffer` and `paste-buffer -p` plus Enter; a payload containing ESC and `ESC[201~`; injection while the agent works; injection while a permission prompt shows (throwaway directory, harmless command); a 10 KB payload; leading `/` and `!`; the recipient reading a file under `$NT_BED/files/`.
- Record: a working recipe per brand; the settle delay before Enter; time until the message appears in the transcript; what a prompt-time injection does; file-read permission behavior.
- Unlocks: deliverer injection, the idle gate, ack timeouts, file events.

**P5 Marker layer (may run alongside Step 3).**

- Procedure: relay twenty spans with tmux copy-mode over a projection pane, then with native editor selection.
- Record: motions per relay; whether wrapped lines join on copy; how the source pane id reaches the command.

**P6 Policy read — gate for the Claude path.**

- Read the current consumer terms and plan documentation of every vendor in use; record clause, URL and date.
- Question: is an interactive session that receives programmatically injected input covered by the subscription?
- Output: a note in the owner's words, not an interpretation by this plan.

**Exit gate.** P1–P4 fixtures committed with a one-page findings note, and the P6 note written. P5 may finish during Step 3.

### Codex notes

*(reserved)*

## 7. Step 1 — The bed

The contract exists and is tested before any watcher runs. Size: S.

- **Builds:** `nt init` (layout, mode 0700); the `nt` core library — ULID, atomic `write_event` and `write_file`, `read_event`, the header parser, a roster fold over the bus, and config and wallet loading with stdlib `tomllib` (Python 3.11 or newer).
- **Missing / decide:** bed location (OPEN); member tag scheme — proposal: brand letter plus number (`c1`, `x1`, `g1`), free tags allowed (OPEN); retention — none in G1.
- **Exit gate:** a reader watching `bus/` never sees a partial file across 10,000 concurrent writes; headers round-trip; a direct, non-rename write is rejected.

### Codex notes

*(reserved)*

## 8. Step 2 — Inbound: read two sessions

Two live sessions, Claude and Codex, are projected as readable markdown and survive restarts. Size: M.

**Builds.**

- `nt launch <member> <brand> [cwd]`: creates the pane, sets the pane option `@nt_member`, sets `NT_MEMBER` in the pane's environment (so later manual resumes in that pane inherit it), writes `launch/<member>.json` (member, brand, pane, cwd, time), then starts the agent interactively.
- registrar v0: watches birth directories, waits for the first complete line, then binds the file by hint, else by a unique pending intent for the same brand and cwd within a time window. Unmatched births become unbound members `u<n>`: observable, not addressable until `nt bind`.
- hint hook (PROPOSED, optional): a few lines of shell registered as the Claude Code session-start hook. When `NT_MEMBER` is set it writes `hints/<session>.<source>.json` with member, session id, transcript path, cwd and source. It never blocks the session and writes nowhere else.
- inbound: consumes joins and tails each source. It keeps byte offset and inode in `tail.json`, parses only up to the last newline and keeps the remainder. Lines are decoded as UTF-8 after assembly, never per read chunk.
- inbound error rules: a bad line becomes a `drift` event, never a crash. A file shorter than the saved offset is treated as truncated and re-read with dedupe.
- adapters v0 for Claude and Codex: pure functions, fixture-tested; unknown records become `drift`.
- projector: appends per §5.5.

**Watching details.** inotify is not recursive: watch each birth root for new directories, add a watch, then scan the new directory once, because files can appear before the watch exists. Start watches before the initial scan and dedupe. Use a minimal binding (`inotify_simple` or ctypes), no framework.

Brand profile in `config.toml` (paths to verify in P3):

```
[brand.claude]
birth   = "~/.claude/projects"
launch  = "claude"          # interactive only, never -p
program = "claude"

[brand.codex]
birth   = "~/.codex/sessions"
launch  = "codex"           # interactive only, never exec
program = "codex"
```

**Missing / decide.**

- Subagent policy: one collapsed line per subagent run, or a linked projection of its own.
- Elision thresholds, thinking display, images (a placeholder line).
- If a session has no transcript until its first prompt (P3), the member exists from its intent with `source: pending`.

**Exit gate.** Two sessions projected live with under 1 s lag. A `kill -9` on inbound mid-stream, then a restart, leaves the projection byte-identical to an uninterrupted run. The replay harness (Ch. 16) passes with random chunking.

### Codex notes

*(reserved)*

## 9. Step 3 — Outbound: the selection-relay, human-gated

Mark a span of one member's output, press K, and it lands in the other member's prompt; this is the core primitive. Size: M.

**Builds.**

- `nt relay`: reads the selection on stdin and takes the source member from the source pane's `@nt_member`. With two live members the target is the other one; with more, a `display-menu` picker. Provenance comes from anchors inside the selection, else from a substring search in `events.jsonl`; when neither finds one, the relay goes without `ref`.
- `nt send`: compose in `$EDITOR` inside `display-popup` (tmux 3.2 or newer); save and quit releases, an empty buffer aborts. G1 thereby gets the console's input semantics early: editing happens in a real editor, and the agent TUI never receives the human's keystrokes directly.
- tmux bindings (sketch; the exact chain is settled in P5):

```
bind -T copy-mode-vi K send-keys -X copy-pipe-and-cancel "nt relay --from-pane '#{pane_id}'"
bind C-k display-popup -E -w 80% -h 60% "nt send"
```

- deliverer v0, per message:
  1. Resolve `to` to a pane; check that the pane exists and runs the expected program.
  2. Idle gate: deliver only if the target's last event is `turn_end` and no tool call awaits its result. Otherwise wait up to W, then hold.
  3. Build the payload: a header line `[relay · from c1 · c1:b14 · <id>]`, then the body with C0 controls removed except LF and TAB, ESC and DEL removed, CRLF normalized.
  4. Inject: `tmux load-buffer -b nt-<id> <payload>`, then `tmux paste-buffer -p -d -b nt-<id> -t <pane>` (add `-r` if P4 shows the TUI wants LF), then the settle delay from P4, then `tmux send-keys -t <pane> Enter`.
  5. Write `ack delivered`. v0 trusts tmux; Step 4 replaces this with a verified ack.

The header line does three jobs: it tells the recipient where the text came from, gives the deliverer a match key, and guarantees the payload never starts with a command character such as `/` or `!`.

**Missing / decide.**

- K as a bare relay, or K-with-note (the popup prefilled with the selection) — OPEN.
- Anchor-token expansion in composed text, e.g. `{{c1:b14}}` replaced by canonical text at release; an unresolvable token stops the release — syntax OPEN.
- Whether elided blocks inside a selection expand at release — OPEN.
- Known G1 limit: half-typed text in an agent pane merges with an injection. Rule: compose only through the popup.

**Exit gate.** Twenty consecutive relays between two members arrive intact, including multi-line text, Unicode and code blocks. An injection attempted during a permission prompt is held, not delivered. A payload containing `ESC[201~` arrives as inert text.

### Codex notes

*(reserved)*

## 10. Step 4 — Delivery semantics and the full event set

The bus behaves like a team: membership, held and dead letters, spawning, verified arrival, four members. Size: M–L.

**Builds.**

- Verified ack: after injection, wait up to T for a `relay_in` event carrying the event id in the target's `events.jsonl`. Seen means `delivered`; timeout means `dead` with reason `not-observed`. No automatic retry, since a retry could double-send; `nt retry <id>` writes a new message whose `ref` points at the dead one.
- Held: a target that is unknown, not yet joined, not live or not idle gets `ack held`. Held messages are re-evaluated on that member's `join` and `turn_end`, and expire to `dead`.
- Semantics: at-least-once. A duplicate is possible only if the deliverer dies between injection and ack. Deliveries to one target are serialized, first in, first out.
- `file` events: the body is written to `files/` before the event, and delivery injects one pointer line. Messages above a size threshold (e.g. 4 KB or 100 lines) automatically become `file` events.
- Liveness: the registrar polls tmux about every 2 s for pane existence, pane process and expected program. On loss the member turns dormant and its messages are held; after grace G with no rebind it emits `leave`. Session-end hooks and tmux `pane-died` can serve as optional early signals.
- Spawn and wallet: `nt spawn <brand> <member>` passes through the spawner, which checks `wallet.toml` (allowed brands per requester, maximum live members), writes `ack spawned` or `denied`, then calls `nt launch`.
- Operator tools: `nt status` (members, panes, sources, idle or busy, held and dead counts, drift counters, brick heartbeats), `nt dead`, `nt retry`.

```
# wallet.toml
max_live = 4

[spawn]
human = ["claude", "codex", "gemini"]
```

**Missing / decide.**

- The recipient's permission to read `$NT_BED/files/`. Claude may need `--add-dir`, which widens its working set beyond reads and conflicts with R5. Options: a read grant for `files/` only, a copy into an ignored folder of the recipient's workspace, or pasting the body inline when size allows (OPEN, after P4).
- Timeout values W, T, G and held expiry, from P4 measurements.

**Exit gate.** Spawn-then-message: the message is held, then delivered after the join. Killing the deliverer between injection and ack shows exactly the documented duplicate. An unroutable message is visible in `nt dead`. Four members run for an afternoon with no silent loss.

### Codex notes

*(reserved)*

## 11. Step 5 — Continuity: rollover rebinding

Compaction, clear, resume and fork never split or merge identities. Size: M, shaped by P1.

**Classification order (registrar).**

1. A hint names the session: new member on `startup`, rebind on `clear` or `resume`, marker only on `compact` (`basis: hint`).
2. The new file's head links to a known member's session: rebind (`parent-link`).
3. Exactly one pending intent for the same brand and cwd within the window: new member (`intent`).
4. Exactly one live or dormant member with the same brand and cwd, and no pending intent: rebind (`cwd`, flagged weak).
5. Anything else: unbound `u<n>` with a visible notice; the human resolves it with `nt bind`.

**Collision rule — PROPOSED.** With two same-brand members in one cwd, rule 4 never fires; the directory signal alone would turn a second session into a fake rollover of the first. Launches of the same brand into the same cwd are serialized until the earlier intent binds.

**Dormant grace.** A process exit followed by `--resume` or `--continue` in the same pane is a rollover, not a leave plus a join. A dormant member's messages stay held until the rebind or grace expiry. The reported `--continue` double firing (startup with a new id, resume with the source id) is read as one rebind, never as a new member plus a rebind; P1 confirms which file is live.

**Source switch (inbound).** On rebind, keep reading the old source for a short grace window, then close it. Dedupe by vendor message id so copied history is never projected twice. Write a `rollover` marker into the projection.

**Missing / decide.** Everything here waits on P1. Without a head link and without the hint hook, rules 3 and 4 carry the weight, and launching only through `nt launch` becomes mandatory. Codex needs its own answer: check whether the installed version offers a session-start hook.

**Exit gate.** For every P1 action the member tag survives, the projection has no duplicated history, and anchors minted before the rollover still resolve after it. A deliberate second same-brand session in the same cwd becomes a new or unbound member, never a rebind.

### Codex notes

*(reserved)*

## 12. Step 6 — Editor connector (G2)

Reading, marking and composing move into a real editor, and tmux copy-mode becomes optional. Size: S–M.

**Remote constraint.** Sessions live on the office machine and are reached over SSH, so a GUI editor on that host is not directly usable. Two paths:

- A terminal editor on the host, inside tmux (Neovim, Helix, micro): works over SSH unchanged.
- A local GUI editor (Sublime, Lite XL) on a synced copy of `members/` (e.g. Mutagen or SSHFS), with K running `ssh <host> nt relay`. inotify does not cross SSHFS, so reloads rely on polling.

Recommendation: start with the terminal editor and keep the GUI path for days at the host. Editor and path are OPEN.

**Builds.** A thin plugin: open projections with auto-reload; K relays the selection, passing file path, line range and text to `nt relay` (the heading lines give anchors directly); a member picker from `nt members --json`; a compose buffer with an explicit release command; an optional `outbox/` watcher for save-to-release.

**Rule.** The plugin holds no protocol logic. All envelope work stays in `nt`, so editors stay swappable.

**Missing / decide.** Reload behavior with large projections; whether the editor becomes the whole dashboard (switching and composing) or the composer only.

**Exit gate.** A full working session without tmux copy-mode.

### Codex notes

*(reserved)*

## 13. Step 7 — Console (G3)

The console is the unified surface from the original idea: member views, an input bar with application semantics, and a marking layer that doubles as the debugger for the automatic regime. It is the only large build in the plan. Size: L–XL.

**Two paths.**

| Path | What the console shows | Cost | When |
| --- | --- | --- | --- |
| A — PROPOSED first | Projections rendered from `events.jsonl`; raw agent TUIs stay in tmux behind it, one key away for permission prompts | A normal TUI application (e.g. Textual; ratatui if it proves hot) | Default |
| B | Embedded terminals: the console owns each agent's PTY and runs a VT emulator per pane (vt100 or alacritty\_terminal in Rust, pyte in Python) | Rebuilds a multiplexer | Only if A pinches |

**Builds (path A).** A member list with idle or busy state; a live projection view; an input bar with multi-line editing, an explicit send and the target shown before release; a bus timeline of joins, relays, acks, held and dead letters. Later, hops with `by: rule:*` are highlighted — the debugger role.

**Key gotcha.** A default terminal sends the same bytes for Shift+Enter and Enter. Telling them apart needs extended keys end to end: the local terminal (kitty keyboard protocol or CSI-u), SSH (transparent), tmux (`extended-keys on`) and the framework.

Verify that chain on the real terminal before fixing the keymap; fallback newline chords are Alt+Enter or Ctrl+J. Keymap OPEN.

**Cheap foil now (PROPOSED).** `display-popup` and `display-menu` already float over panes in G1, with no console code.

**Exit gate.** One week of daily use in which raw panes are needed only for permission prompts.

### Codex notes

*(reserved)*

## 14. Side organ — screen reading

An independent module lets an agent or a brick read a pane's rendered screen; nothing in the core depends on it.

- Inside tmux it is cheaper than first assumed: `tmux capture-pane -p -J -t <pane>` returns the rendered grid, because tmux is already the terminal emulator. pyte is needed only outside tmux; the hard part is interpreting the screen, not capturing it.
- Uses: sight of a non-agent TUI; a second opinion for the idle gate (a visible permission prompt); debugging.
- Interface: `nt screen <member|pane> [--ansi]` returns text. Agents reach it later through their own tools.

### Codex notes

*(reserved)*

## 15. Later — autonomous regime (not scheduled)

The trigger changes, the primitive does not: a named rule releases a hop instead of the human, recorded as `by: rule:<name>`.

**Preconditions.** P6 cleared for automated relay; verified ack, idle gate and `by` in production; the Step 7 timeline, or at least `nt status`, available as the debugger.

**Loop-breakers, all required before the first unattended hop.**

- A chain id and hop count in the header; past the hop limit, a human checkpoint.
- Cycle detection: A to B to A within one chain.
- A per-pair rate limit and a per-chain budget of turns and time.
- Echo guard: never auto-relay text that carries a relay header from the same chain.
- Kill switch: `nt pause` makes the deliverer hold everything not released `by: human`.

**Agent-originated addressing.** One narrow tool, such as a local MCP tool `relay(to, text)`, writes `by: agent:<member>`. Permitted pairs come from the wallet, and output is validated at the boundary. Agent text is still never parsed as an envelope.

**Main new risk.** Prompt injection carried from agent to agent with no human reading the payload.

### Codex notes

*(reserved)*

## 16. Testing and operations

Most of the suite runs without spending a token: fixtures from Step 0, a replay harness and a fake agent.

**Testing.**

- Adapters are pure functions, tested per brand and version against Step 0 captures.
- Replay harness: plays a fixture into a temporary birth directory with random chunk boundaries (mid-line, mid-UTF-8), parallel sessions and rollover sequences. Projections must be byte-identical across runs.
- Fake agent: a small program that enables bracketed paste, reads input, writes a vendor-shaped transcript, and switches between idle, busy and prompt on command. It exercises the deliverer, the idle gate and the verified ack.
- Crash tests: SIGKILL each brick at random points. Invariants: no lost event, no visible partial file, duplicates only where §10 allows.
- Drift check on every vendor upgrade: run a fresh capture through the adapters; any `drift` event blocks the upgrade until reviewed.

**Operations.**

- `nt up` / `nt down`: in development, a hidden tmux window with one pane per brick; in daily use, systemd user units with restart on failure.
- Heartbeats in `state/`; `nt status` flags stale bricks.
- Derived files are rebuildable: `nt reproject <m>` from `events.jsonl`, `nt reingest <m>` from transcripts with dedupe. Only the vendor transcripts and the bus are primary data.
- Playbook: a crashed brick restarts and resumes from its state; a wrong binding is fixed with `nt bind`; an adapter broken by a vendor update shows a drift banner, gets a fresh capture and a patch, then `nt reingest`.

### Codex notes

*(reserved)*

## 17. Risk register

Three risks matter most in G1: silent format drift (R1), injection into a busy prompt (R3) and agents writing into the bed (R5).

| # | Risk | Effect | Mitigation | Step |
| --- | --- | --- | --- | --- |
| R1 | Silent transcript format drift | Plausible but incomplete projections | Drift events and counters, fixtures per version, upgrade check | 2, 16 |
| R2 | Rollover misclassification; same-cwd collision | Split identity or wrong routing | Classification order, collision rule, hint hook, unbound fallback, verified ack | 5 |
| R3 | Injection into a busy TUI or an open permission prompt | A tool action approved by accident | Idle gate, header line, verified ack | 3 |
| R4 | Escape sequences break out of bracketed paste | Keystroke injection | Sanitizing | 3 |
| R5 | Agents write into the bed: forged releases, edited projections | Trust boundary bypassed | Bed outside writable roots, vendor sandboxes on, non-atomic writes rejected. Same Unix user means no real authentication; use a separate user or a container if it matters | 1, 4 |
| R6 | Echo loops | Token burn | Human gate in G1–G3; loop-breakers before autonomy | 15 |
| R7 | Vendor policy change | Claude path unusable | Rule 2.1, P6, brands isolated so the others keep working | 0 |
| R8 | Secrets cross vendors through a relay | Data leak, e.g. Claude to OpenAI | The human sees every payload; optional redaction filter in `nt`; bed mode 0700 | 3 |
| R9 | tmux restart or pane id churn | Stale bindings | Liveness, dormancy, pane check before every injection | 4 |
| R10 | Recipient cannot read `files/` | File deliveries stall on permission prompts | P4 finding, then a per-brand read grant or an in-workspace copy | 4 |

### Codex notes

*(reserved)*

## 18. Decisions and open questions

Thirteen proposals need an accept or a veto before the step that uses them; locked and settled items are listed for completeness.

**LOCKED.** 2.1 no non-interactive agent modes; 2.2 GEV exempt.

**SETTLED.** tmux over Zellij, behind a thin interface; transcripts, not the screen, as the projection source; one writer per file; temp-then-rename; six event kinds; the member tag as identity; agents never protocol participants; explicit release, no auto-send; the selection-relay as the core primitive; per-brick language over files; editor optional; console last.

**PROPOSED.**

| # | Proposal | Reason | Fallback if vetoed | § |
| --- | --- | --- | --- | --- |
| P-1 | Immutable bus; acks double as consumer state | Two consumers cannot share a move; audit log by construction | Per-consumer `processed/` folders | 5.3 |
| P-2 | Envelope refinements: member and source into join, `by`, `ack.status`, join as rebind | Six kinds cover held, dead, denied and late binding | Original header plus a seventh kind | 5.3 |
| P-3 | Normalized `events.jsonl` as the internal contract, anchors inside it | Drift absorbed once; one schema for every consumer | Adapters feed the projector; separate anchor sidecar | 5.4 |
| P-4 | GEV wrapper writes normalized events natively | No adapter, no injection | GEV gets an adapter like the others | 2.2 |
| P-5 | Registrar as sole membership author; launch intents; same-cwd collision rule | Deterministic binding; no fake rollovers | cwd heuristic, one member per cwd by convention | 8, 11 |
| P-6 | Optional session-start hint hook | Deterministic rebind on clear and resume | Heuristics only | 8, 11 |
| P-7 | Idle gate before every injection | Injected keys can answer an open permission prompt | None safe | 9 |
| P-8 | Header line on every injection | Provenance, match key, no leading command character | Bare text | 9 |
| P-9 | Bracketed paste with sanitizing | Multi-line integrity, no escape breakout | `send-keys -l` line by line | 9 |
| P-10 | Verified ack from the recipient's transcript | tmux success is not arrival | Ack on tmux success | 10 |
| P-11 | Large messages become file events | TUI paste limits | Manual choice | 10 |
| P-12 | Console path A first | Avoids terminal emulation | Path B | 13 |
| P-13 | tmux popups and menus as the G1 foil | The foil without console code | Plain panes | 9, 13 |

**OPEN.** CLI name (`nt` is a placeholder); bed location; member tag scheme; console keymap; K bare or K-with-note; anchor expansion syntax; elision expansion on relay; G2 editor and remote path; Gemini CLI and Antigravity brand profiles (after P2–P3); timeouts W, T and G; autonomy scope.

**Sources.**

- [I tried verifying all patterns of Claude Code's SessionStart hook](https://dev.classmethod.jp/en/articles/claude-code-session-start-hook-verification/) — DevelopersIO, 10 Mar 2026, Claude Code 2.1.72 on Windows.
- [anthropics/claude-code issue #44607](https://github.com/anthropics/claude-code/issues/44607) — interactive `--session-id` behavior, Claude Code 2.1.92.

### Codex notes

*(reserved)*
