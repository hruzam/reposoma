# Context for Nabla

Snapshot: 2026-10-17 · office · myShell. Source IDs resolve in `sources.json`.
This is an explanatory personal collection, outside the owning project sessions.

## 1. Why so many files and names?

The practical problem is continuity. A person moves between AI sessions, machines, tools, and
projects; a fresh model cannot safely infer what the previous model finished or was allowed to do.
The environment therefore gives different kinds of information different homes. A decision should
survive a session; a current next action should change as the session advances; an operator's day
notes should remain readable without becoming a competing project plan.

The main repositories have distinct jobs:

| Place | Job in this collection |
|---|---|
| `~/reposoma/` | Shared doctrine and guides; `.majkee/` is Majkee's personal working corner. |
| `~/ia-sync/` | Authored machine configuration, runtime wrappers, and session tools; deployment copies these outward. |
| `~/unikuklatrix/nablarva/` | Experimental project and its toolbox, session gates, locks, and evidence. |

The personal seat here is **myShell**. It may collect, compare, and explain project evidence.
That personal role does not acquire the project's STATUS pen or architectural authority.
Majkee remains the person who gives the gavel: an explicit decision that settles a lock or gate.
[M01, N01, N02]

## 2. Three kinds of “programmatic” structure

### A. Manual programs and functions

The local vault is `.majkee/.germline/programs/`. Each program has a `CONTROLLER.md` containing
shared rules and a table of functions. Each selected function lives in a separate file. The table
binds its function name, path, and expected stamp; a mismatch stops that procedure instead of
inviting a guessed replacement. A stamp is a checked marker in this manual procedure, not runtime
enforcement or a cryptographic proof of the entire document.

The prompt convention is:

```text
ctrl <program>&<function> : <task>
```

For example, `ctrl journal-continuity&list-pending : review the past week` tells the current
assistant which procedure to read and apply. It does not execute a parser or shell command.
The ampersand separates prompt names; pasting this notation into a shell would change its meaning.
[M02–M05]

| Existing local program | Functions | Boundary |
|---|---|---|
| `journal-continuity` | `fold-entry`, `list-pending`, `audit-beds`, `carry-unfinished` | Reports first; authorized writes stay inside the caller's journal scope. |
| `project-saddle` | `saddle-project` | Read-only preparation of a named project's instruction chain and scoped handoff. |

“Fold” means recording authorized material in its intended home. “Saddle” means getting oriented
under the actual project instructions. Neither word grants extra capability. An audit does not
tick completion boxes; a date change does not carry unfinished work into a new day automatically.
[M03–M06]

This local trial resembles the broader guide/controller/function direction, but resemblance does
not establish that every GUIDE should be converted. The stored guide-model package is historical
proposal material. Its own claim that nothing was written “from this thread” is about that thread,
not a present-day deployment inventory. [P01]

### B. Session lifecycle and authority

Session files govern a bounded piece of work. Their roles are deliberately different:

| File or surface | Question it answers |
|---|---|
| `flag.md` | What has Majkee settled, and which decisions remain pending? |
| `pulse.md` | Which sessions are active, what gate does each have, and where is its STATUS? |
| `RUNBOOK.md` | What fixed outcome, participants, constraints, and closing gate define this session? |
| `STATUS.md` | What is currently verified, possibly interrupted, held, and next? |
| `_bus/` | What did one named seat ask, return, or decide in a durable exchange? |
| Personal journal | What should Majkee remember and where should he resume reading? |

The governing rule is one session, one gate. A materially changed gate calls for a numbered sibling
session. RUNBOOK remains the fixed launcher; the declared owner updates STATUS. STATUS includes a
checkpoint, `in_flight`, a read-only recovery probe, holds, and one `next` / `expected` pair.
The probe should distinguish an action that never started from a partial action after interruption.
[R01, R02, N02]

An exchange may use POINT → RETURN → VERDICT: a bounded request, the recipient's evidence, then
the integrating head's judgment. Acknowledging receipt is a separate act from authorizing the next
task. These are process contracts carried by people and assistants; merely having files does not
enforce compliance. [J01, X03]

### C. Executable session tools

`~/ia-sync/zsh/session/` contains actual tools. `base.zsh` wires engines; `keyboard.zsh` exposes
aliases; Python provides the browser and tmux operations. Authored source belongs in ia-sync;
`~/.config/zsh/session/` is the deployment destination. [T01–T06]

The `rb-open` browser discovers `.dev/session/` beds and shows STATUS, bus files, RUNBOOK, other
files, and raw evidence. It extracts `next` and `in_flight` for display. Its indicators are file/
field heuristics, not semantic verdicts that a gate passed. An optional bridge displays Ovitmugen
information; the browser can work without tmux. Presence records are advisory attachments.
[T02, T03]

That gives a useful reading order: **manual procedure chooses the bounded task; project files
define its authority and position; executable tools help the operator see and navigate it.**
This sentence is myShell's synthesis of the inspected layers, not a newly gaveled architecture.

## 3. The journal sequence: intention, challenge, narrower future work

The selected October 16 journal passages preserve an evolving human relay. Their packet names
identify exchanges; line numbers inside older packets are historical locators and sometimes no
longer match the edited file. The user-requested read was approximately lines 87–500, then
1091–end, plus narrowly followed owner evidence. [J01]

The initial MASTER PLAN leaned toward finishing planning with Cartan and an analysis adviser,
obtaining Atlas's critique, then using a separately opened Medusa execution gate. That later gate
could assign one bounded Astrobley body at a time, verify each fold, and obtain closing review.
It was a proposed sequence rather than permission to turn the current audit into implementation.

The challenges narrowed what could responsibly happen:

- Do not assume that “fold programs and functions” has already answered whether the source needs
  that split.
- Freeze an observable criterion and an identified source corpus before measuring it.
- Name the executor, synthesis writer, witness, and receipt destinations.
- Keep one integration owner; an analysis adviser does not gain an independent durable pen.

The four candidate labels did not themselves identify a usable four-subject source corpus.
The A2 finding preserved that gap. The later journal records Majkee's direction to stop treating
the unbound labels as the next live work and prepare a future guide-dogfood substrate instead.
“Dogfood” here means trying a guide on a bounded real task to discover whether its instructions
work, rather than treating the guide as already validated. [J01, G01–G03]

The saved **future Germline-04 substrate** has two important corrections:

1. Only turn one's source is fixed in the proposal: `raw.guides/sella/GUIDE.md`. Its immutable
   identity and audit bounds must be frozen when G04 is opened. A later receipt may propose one
   next source; selecting it needs another explicit cycle decision.
2. The worker and Oraculum adviser return analysis in chat. Cartan checks the evidence and alone
   writes the working synthesis. A later authorized Atlas exchange gives Cartan POINT/VERDICT
   and Atlas RETURN ownership.

Sella is the primitive-building foundation to examine. Proposed work may recommend adjustments;
it does not edit Sella, compose programs, or launch implementation. A Fable/Astra reconciliation
is conditional on a concrete cited conflict, with an evidence-only return. [G03]

**The unresolved seam:** current G03 STATUS still asks Majkee to approve, correct, or exclude A2
source mappings. The future G04 substrate explicitly leaves that G03 edge separate. The journal's
new direction and the unchanged STATUS are both visible; this briefing does not close G03 F1 or
declare G04 open. The substrate exists, but neither its existence nor the rehearsal is a launcher.
[G01–G03]

**Names describe different postures:** cSharp is a head/navigation protocol; Medusa is a later
working-head posture for an existing execution RUNBOOK. In the inspected G03 proposal, Oraculum is
an analysis-only Codex adviser. In historical X0/X1 records, `oraculum` also names the Claude main
head that owns STATUS. Those are different runtime arrangements; do not transfer authority between
them just because their names match. Atlas critiques or builds within its named scope; Field and
Assay were discussed as synthesis and verification options, not activated by this briefing.
[J01, G02, X03, X04]

## 4. Ovitmugen: implemented workspace, proposed basement

Ovitmugen displays agent tabs and a fixed application, usually the runbook browser. Its current
implementation uses two tmux servers: the default server holds agent windows; the `ovitmugen`
server holds the frame that views them. The frame normally shows switchable agents on the left
and the browser on the right. Closing the viewer must not terminate an agent. [O01, T05, T06]

Existing commands include `ov-up`, `ov-ls`, `ov-tab`, `ov-console`, and `ov-down`. Busy-tab checks
refuse unsafe closure. Every tmux call identifies its server, because the browser may itself be
inside the frame and inherited tmux context can be misleading. The implementation's explicit
rule forbids `send-keys` and `paste-buffer` into panes. It manages views, not prompt delivery.
[T04–T06]

The earlier console session closed GO. The next session, `ovitmugen-01-basement`, proposes a
layered extension:

```text
UI: frame keys, console, browser integration
control: narrow workspace operations
pipes: live JSON report, action events, remembered bed files
map: host → bed → tabs → process
adapter: tmux now; a future Zellij adapter remains possible
```

The proposed `ovitmugen.map/v1`, `events.jsonl`, `beds/<bed>.json`, and remembered last bed would
let other tools inspect and restore workspace structure. State would live at the machine-local
`~/.local/state/ovitmugen/`; it would not travel through Git. The old `ov-ls --json` consumer
shape is to remain compatible. The map supplies process observations, not authoritative agent
identity or message acceptance. [O02, O03]

**Observed limit:** the current basement STATUS says nothing of 01 is built. The source file's
latest recorded change is the baseline fix at `b435af5` on October 2. A future acceptance walk
requires restored tabs/root, faster switching, layout/preset operations, added map/state outputs,
and checks on both hosts. Old baseline selftests do not satisfy that new gate. No such tests or
live walk were rerun while preparing this briefing. [O01, O02, T05]

## 5. Termbrana and the wider communication project

Termbrana aims to make meaningful terminal events easier to find: prompts, answers, tool runs,
approvals, errors, and bookmarks. Its intended review view and retained observations would support
navigation and replay. It is Zellij-first and read-only by default. [B01]

The implemented artifact is an M0 probe harness. The M0 contract was frozen on September 2 after
operator probes and an independent check, recorded in ADR-0002. The pinned contract is historical
project evidence, not a fresh measurement of installed versions on this host. The README still
describes `termbrana-core`, semantic review UI, persistence, and replay as unimplemented. [B01, B02]

A critical observation boundary is already explicit: Zellij plugins receive host-rendered text
or ANSI-bearing render reports, not original raw PTY bytes. Derived observations cannot recover
erased intermediate terminal history. Planned replay means replaying retained observations;
it does not mean re-executing commands or reconstructing an original byte-perfect terminal.
[B01, B02]

Termbrana now lives at `nablarva/toolbox/termbrana/` in the unified repository. Earlier records
mention a standalone repository and devenv pair; flag L12 supersedes that topology. Its technical
ADRs do not own project structural locks. [N01, N02, B01]

The wider organ names help keep responsibilities understandable:

| Organ | Intended responsibility | Evidence status here |
|---|---|---|
| Ovitmugen | Workspace views and structure | Existing baseline; basement extension planned. |
| Termbrana | Terminal observation, navigation, retained replay | M0 probe; product features planned. |
| termpanum | Observation lab | Described in the working wrapper. |
| stridulatrix | Communication broker and CLI | Described separately; key implementation choices remain open. |
| stridularium | Human-facing phone app | Named component; thin lens over host-resident sessions. |

The project ladder is same-host agent communication, then cross-host communication, then the
human-facing phone layer. Settled constraints include append-only journal truth, participant
cursor projections, explicit visibility, and adapter-owned PTY delivery; tmux does not become
the protocol. PTY is an impulse layer under L14, while the file plane is the spine. A workspace
manager or a working tunnel does not by itself establish that the whole broker exists.
[N01, N02, N05]

## 6. X0 closed; X1 carries the architecture work

X0 was a bounded forge-and-coordination trial, not a release of the whole application.
It tested a re-forged **Houston** grounding architect and the carrier/tunnel/bus discipline
used to coordinate the work. Houston's purpose is architecture coherence within a selected card;
it does not inherit the operator's gavel or the lifecycle owner's STATUS pen. [N02, X01–X03]

At closure on October 7, Majkee gave GO on Houston and KEEP on that discipline. The historical
closing receipt records a classified real audit, verification, recovery costs, and open follow-up.
Its cost account explicitly names the human carrier as a serialization point and reports stale
requests and bookkeeping defects. KEEP preserves the evaluated arrangement; it does not promise
automatic communication or a universally validated coordination system. [X03]

The closed bed was pruned to a README. The whole earlier bed remains available in Git at
preservation commit `d1c4b1e`; the historical STATUS and closing receipt were read directly from
that commit for this briefing. The historical STATUS has its own stale-looking residual fields,
so the explicit closed checkpoint, final receipt, and live stub establish the closure. [X01–X03]

**X1** is the active continuation. Its gate is the first real whole-project architecture document,
with Houston operating from canonical homes, promotion/migration completed, and a classified audit.
The current STATUS records substantial preparatory progress and reports office installation
checks passed; it still lists coexistence/home migration and the Houston sitting among open work.
`docs/ARCHITECTURE.md` remains a pre-architecture pointer. [N03, X04–X06]

Houston's homes also evolved after X0. The current X1 record points to global germline material
and thin runtime wrappers authored through ia-sync, with a project addendum in Nablarva. The old
X0 package remains frozen history. This briefing checked source pointers and owner records; it
did not repeat installation, permission, or runtime-loading tests. [N01, X05]

## 7. Disagreements and questions worth keeping visible

| Seam | What the evidence supports | What remains unresolved |
|---|---|---|
| **Personal relay draft vs Ovitmugen** | The personal `03_OVITMUGEN_CONTRACTS.md` proposes a pane injection door. Current code, wrapper, and basement rules forbid Ovitmugen input injection. | Reconcile the proposal with project locks or assign delivery to a separately authorized organ. The draft is not the current implementation contract. |
| **G03 vs future G04** | The newer substrate preserves the corpus gap and proposes one-source guide trials. G03 STATUS retains its mapping decision. | The owner must resolve that G03 edge independently; no silent closure follows from this report. |
| **X1 gate vs architecture pointer** | X1 asks for a real architecture document; the current document still defers its body to unresolved language/V1-cut decisions. | Determine which prerequisites govern the intended sitting. The briefing does not settle the timing. |
| **X1 original wording vs later homes** | The RUNBOOK now explicitly annotates its old no-ia-sync restriction as superseded for Houston by Majkee's October 10 gavel. | Follow the newer named owner evidence; do not present the old restriction as an unqualified live prohibition. |
| **Observed source vs deployed behavior** | Source and recorded receipts describe implementation and old tests. | Fresh deployment/runtime behavior needs its own evidence; no live check was run here. |

Evidence: `P02`, `T05`, `N02`, `N05`, `O02`, `G01–G03`, `X04–X06`.

The two untracked X1 cycle-14 bus files observed during collection were not read or classified.
They may contain newer exchange evidence; their existence alone is not an accepted outcome.
The source manifest records the working-tree context, including the journal and G03 drafts.
HEAD hashes therefore do not stand in for the exact bytes of those files. [sources.json]

## 8. How to use this with Majkee

Start with the layer map and ask whether it matches the intended project direction. For a design
discussion, the useful question is where workspace observations end and communication authority
begins. For program design, test whether separating a controller and functions actually reduces
the reader's work without hiding dependencies or expanding authority.

Treat `said`, `inferred`, and `locked` separately, as L16 requires. Here, direct source descriptions
are attributed by ID; this briefing's connections are myShell interpretation. Reading a historical
packet, finding a RUNBOOK, or acknowledging a reply does not activate the task described inside it.

The collection preserves the uncertainty needed for an honest discussion. It creates no new
session, changes no project state, and makes no architecture or canonical decision.

## 9. Additional counsel: a smaller prompt-composition device

Majkee separately commissioned a practical Astrobley view and a philosophical Oraculum view.
They read this contextual briefing, then read each other's first view through one controller-owned
exchange. Their proposals and the resulting corrections are in [EXCHANGE.md](EXCHANGE.md);
the short attributable returns are [FOR-NABLA.astrobley.md](FOR-NABLA.astrobley.md) and
[FOR-NABLA.oraculum.md](FOR-NABLA.oraculum.md).

The common proposal is a readable Markdown exchange in Sublime with individually renderable
packets. Optional `new`, `check`, and `render` commands would help Majkee or an agent compose the
same material. Existing controller tables supply function bindings. A checker can expose missing
fields or paths, while a recipient must still report what it read and whether the allowed task
is clear. The proposed tool does not exist as a result of this consultation.

Their reciprocal challenge sharpened two boundaries: keep an exact rendered version separate from
the carrier's dispatch report and the recipient's accepted scope; keep next actions and recovery
probes in the project STATUS rather than copying them into a new card. Challenge earns its place
when the controller records a change, a reasoned retention, or an unresolved decision. Both
advisers defer message transport and any expansion of Ovitmugen's responsibilities.

This synthesis is myShell's reading of two design returns. It is not evidence that the interface,
checks, recovery behavior, or proposed commands have been built or validated.
