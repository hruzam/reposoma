---
program: office-lab
revision: 2026-11-14
state: DRAFT; prepared, not activated
scope: personal myShell trial; uncanonical; no deploy
author: myShell-office (Codex)
authority: journal/2026-11-14.md section 1; operator clarification in current session
---
# Office laboratory controller

This is a manual procedure for myShell-office to coordinate two independent
Oraculum research seats, Claude and Codex, for `/home/hruzam/nabla-lab`.
myShell also keeps the process receipts. The operator starts the CLI sessions;
this controller needs direct access to their three tmux windows. No daemon,
new global role, automatic launch, timer or deployed transport is installed.

The authoring request and first-output gate are in
`/home/hruzam/reposoma/.majkee/journal/2026-11-14.md` section 1; the transfer
pointer is `/home/hruzam/reposoma/_cold-start/card/CS.myshell-office-lab.2026-11-14.md`.
Majkee's current clarification: “You do not have run cli sessions only need
direct access to three tmux windows under one tmux session.”

## Authority and ownership

- Majkee selects the question, releases live actions and gavels canon. No live
  sends before GO. A release names the action and recipient(s); silence supplies
  neither acceptance nor authority for another action. Explicitly released paired
  delivery may cover both recipients; an uncertain first delivery stops the pair.
- myShell owns briefs, binding/attempt receipts, comparison and process notes in
  an explicitly assigned evidence home. This file is procedure, not live STATUS.
  Before work starts, resolve exact artifact paths and their instructions. No lab
  session pen, pulse update or new STATUS is acquired through this personal seat.
- Each researcher owns only its exact assigned RETURN file. No edits to the
  other RETURN, shared brief, comparison, canon or another seat's files. No
  commit, push, deploy, implementation, external relay or researcher-to-researcher
  communication. Helpers require an explicit bounded grant in the assignment.
- myShell is the assigned controller plus keeper, not an independent outside
  witness. Its own authorship is a declared review conflict. A non-author checks
  acceptance claims when independent review is required; myShell cannot certify
  its own draft as independently verified or replace the lab's named Janus gate.

## Verified office frame — observation, 2026-11-14

Host `hruzam-120922`, `MACHINE_NAME=office`; personal checkout branch `core`,
HEAD `b7120fb`, clean before this draft. Lab root is `/home/hruzam/nabla-lab` in
both source and deployed project registries. Its HEAD was `07c62dc`; an existing
untracked `session/jev-coordination-01-two-rails/` belongs to other work.

Applicable lab chain: no `/AGENTS.md`, `/home/AGENTS.md` or
`/home/hruzam/AGENTS.md`; root `nabla-lab/AGENTS.md` exists. Root saddle reads
completed: beacon, pulse, AGENTS and PROJECT. Project-saddle controller token
`0d7f2a36`, function `saddle-project` token `a3ea5e32`. No active historical draft
was selected. Pulse is dated August; its old queue is not this assignment.
Any later output directory still needs its own nested AGENTS check.

Codex `0.169.0`, Claude Code `2.1.323`, tmux `3.7c` are installed. The Codex
Oraculum main profile and both vendors' global Oraculum loaders/germline files
exist; fresh-session loading and effective permissions remain untested.
Lab Oraculum addendum token `4c894176` and `guides/codex-lab.md` were read.
Main identity follows the operator's actual launch, never a window label.

### Three-window bed and operator viewers

Created after Majkee's clarification; all three panes were verified as `zsh`:

| Window in `nabla-lab` | Pane at observation | Working directory | Dedicated grouped viewer |
|---|---|---|---|
| controller | `%1` | `/home/hruzam/reposoma/.majkee` | `view-lab-controller` |
| claude | `%2` | `/home/hruzam/nabla-lab` | `view-lab-claude` |
| codex | `%3` | `/home/hruzam/nabla-lab` | `view-lab-codex` |

The group `nabla-lab` has three shared windows. Each viewer has its own selected
window; verified selection matches its name. `traj-office` was left untouched.
Pane IDs are observations: re-resolve before use. No agent CLI was launched,
resumed or messaged. A shell pane must never receive an agent pointer.

Run one command in each separate `tso` SSH terminal on office:

```sh
tmux attach -t view-lab-controller
tmux attach -t view-lab-claude
tmux attach -t view-lab-codex
```

Use writable attachment for the requested interaction. Default bindings:
`Ctrl-b [` enters copy/scroll mode, `q` leaves it, `Ctrl-b d` detaches.
Grouped views share window contents and edits; independent selection is not
research isolation. Operator terminal interaction/scrolling has not been witnessed.

## Doors and qualification before use

1. Read windows without typing: inventory sessions/windows/panes and their current
   processes, then inspect only the assigned pane's screen. Once the operator
   launches a seat, bind its actual session/thread UUID, vendor, root process,
   cwd and pane. Names alone prove none of these. One agent per window, one pane
   per agent; use `exec` at operator launch to avoid returning to a live shell.
2. Codex candidate: `codex queue --thread <exact-uuid> --message <pointer>`.
   Installed help and current official reference establish syntax. The home
   trial supports tested exchanges, not office consumption. Do not add
   `--resume`: CLI lifecycle remains with the operator. A successful exit or
   queued acknowledgement is carrier acceptance, not reading or completion.
3. Claude candidate: one tmux pointer paste followed by a separately checked
   submit. Before either act, verify actual foreground/root identity, a known
   idle composer, no existing draft and no trust/approval dialog. Activity
   timestamps alone do not establish idleness. If uncertain, hold.
4. Qualify each selected door on office with a separately released harmless nonce
   task and its exact RETURN destination. Record expected versus observed
   identity, carrier result, consumption and evidence. No research dispatch is
   implied by a qualification release. Never script a trust/security response.
5. Preserve every attempt ID and outcome. On uncertain send, stop and reconcile
   the screen, queue/available receipt and RETURN before any further action;
   never retry it or switch carriers to evade uncertainty. After definite
   pre-send refusal, a labelled manual fallback remains available under the
   applicable release and fresh look-first checks. One attempt; no retry loop.

Do not use headless `claude -p --resume`, `codex exec resume`, TABLE, or a second
writer on a TUI session for this assignment. Headless syntax exists; exclusivity,
recovery and office behavior were not qualified. Claude SendMessage was seen once
in the home trial and is not an established office cross-session route.

## File contract and blindness

HANDSHAKE's POINT is a notice with no reply owed; the trial calls a task POINT
and expects RETURN. Do not silently merge these meanings. Every packet states
whether it is notice-only or a task, the exact owed RETURN, ownership, stop
condition and done evidence. An acknowledgement mode alone does not define work.

Use a unique message ID, sender, recipient, absolute brief path, exact output
path and source revision/hash. Bells contain only an ASCII pointer, for example:

```text
[lab p01] from myshell -> read /absolute/assigned/brief.md ; ack: per file
```

Keep the substantive research brief byte-identical for both researchers; freeze
its hash before delivery. Recipient and output-path wrappers differ. Do not
include myShell's preferred answer, the other seat's response, or claims of
novelty. A RETURN contains the question/brief hash, sources actually read,
reasoning and mathematics, findings, uncertainty, tests and changed-file list.

Before dispatch, select a common position-free source corpus. Exclude the other
RETURN and any shared process comparison from both briefs and reads. Researchers
must report accidental exposure; the affected leg then loses its blind label.
Instructional fences are not filesystem isolation. Both CLI sessions and grouped
viewers can access shared material; do not claim enforced secrecy. Use actual
separate restricted contexts if a stronger isolation guarantee is required.

Wait for both complete RETURNs on disk before exposing either to the other
researcher. Freeze hashes and check decisive citations. Compare agreement,
disagreement, assumptions and evidence in myShell's assigned synthesis. A later
position-aware challenge is a separate released action, labelled as such.
Timeout or a missing leg yields partial evidence, never fabricated triangulation.

### Proposed common research brief — unsent

Investigate linguistic and caching methods used during interactive AI sessions,
their mathematical descriptions, and concrete programmatic projections.
Clarify interpretations and assumptions before selecting a method. Distinguish
linguistic/context organization, retrieval or summaries, and provider prompt/KV
caching where relevant. Determine which distinctions matter rather than assuming
these mechanisms are equivalent or that a particular architecture is desired.

Map established methods and prior art using dated primary sources. Define objects,
state transitions, objectives and constraints; label proofs, models, conjectures
and empirical claims separately. Derive useful bounds or counterexamples where
supported. Describe feasible algorithms, data structures, measurements and small
falsifiable experiments, including failure modes and tradeoffs. Apply the lab's
reinvention, theatre and technical-wall gates. Offer alternatives and unresolved
questions. Do not implement, promote an artifact or reopen historical lab tasks.

Exact common corpus, output paths, size/time budget and current source cutoff
must be fixed in the assignment before release. They are not invented here.

## Keeper sweep and recovery

At each completed exchange or Majkee's call, check tasks without RETURN,
unrecorded operator decisions, uncertain sends, unattributed manual intervention,
unpublished work and ownership conflicts. Record decision words plus the question
and receipt pointer. Do not commit or push to repair a finding without authority.

For a context reading at or below 35%, record observer, time and actual available
measurement, then prepare an authorized continuity pointer. Unknown context is
unknown, not a guessed percentage. No scheduled watcher follows from this rule.
On transfer: preserve exact paths/handles and uncertainty, obtain successor
read-back, then explicit activation. A remembered role name restores no session.

## Configuration investigation — no changes

Tailnet inventory reported office, home (`100.110.27.60`) and monitor
(`100.80.107.66`) online; SSH hostname probes succeeded for both Linux peers.
Both Android peers were reported offline; their SSH/configuration access was not
tested. Presence is not proof of equivalent capabilities.

Candidate local reference is office lab `.claude/settings.local.json`: JSON with
only `permissions`, 23 allow entries and 3 deny entries, 882 bytes, SHA256
`3483c8cfb0b54ba54e1bd88bcdcc21450ffe996186aa865f9aa8545cb512dbc7`.
It controls local Claude tool permissions; it does not configure Codex or create
transport authority. The file is absent at the same path on home and monitor;
their lab checkouts were present and clean. No credentials or rule values were
copied, and no settings were changed. Confirm this is the intended reference
and inspect any proposed rule change before extending permissions to another host.

## Evidence and preparation checks

Local sources read: journal `raw.2026-11-13.md` sections 1.3–1.4;
`/home/hruzam/ia-sync/HANDSHAKE.md`; local `tmux-bed/README.md`,
`journal-continuity/CONTROLLER.md` and `session-coordination/CONTROLLER.md`.
No session-coordination function was invoked and no retained team was created.

The following cited sources were absent on office but read through SSH on home:

- `/home/hruzam/ia-sync/.dev/records/vist/2026-11-14/CLOSE.md` and its adjacent
  `vistMini-01-tests/reports/trial-report.vistmini-01.md`.
- `/home/hruzam/ia-sync/.dev/session/helper-utils-00-tmux/raw/handoff.senior-advice.trajectory.2026-11-14.md`.
- `/home/hruzam/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/plan.runbook-and-team.cartan-trajectory.2026-11-14.md`
  and `decision.majkee.fallback-poke.2026-11-14.md` beside it.

The closure pins accepted experimental report `3584a02`, review16 and a narrowed
operator GO. Ordinary messages were supported in each direction on home; crash,
expiry, misaddress and other carried cases remained unrun/unqualified. These
files are attributed historical evidence, not a fresh office witness or adoption
of the unreleased VIST prototype. This controller does not implement VIST or
alter Nablarva L20/L21.

Scar intake source:
`/home/hruzam/ia-sync/.dev/observations/germline.scars.g06.flight.2026-10-22.md`.
Concrete uses: S1 checked home before calling cited files lost; S2 records the
authoring/gate receipt path; S3 checked actual quoted wording; S4 separates
report/relay evidence from office behavior; S5 declares the combined-role review
conflict; S6 qualifies doors before research dispatch; S7 labels proposals and
limits. S8's October host assumptions were not carried forward as current fact.

Current product syntax checked against installed help and official
[queue reference](https://learn.chatgpt.com/docs/developer-commands?surface=cli#codex-queue)
and [non-interactive mode](https://learn.chatgpt.com/docs/non-interactive-mode).
Documentation establishes supported interfaces; live behavior remains unexercised.

Preparation is complete when this draft and the office read-back are presented.
The next runtime edge is operator CLI launch, actual seat binding and an explicit
GO for the named first qualification action. No current research RETURN is owed.
