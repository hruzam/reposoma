---
session : myshell-tunnel-it-dev (Codex · provisional support report for G03 Cartan)
---

# Tunnel IT/dev support — provisional report

2026-10-26 · Europe/Prague · requested by Majkee. Prepared for
Cartan(cSharp.germline-03); delivery/consumption is not established by this file.

The core operating shape is supported by the documentation, dated field records and
current source inspection. Source/deployed copies checked on office match. This is
not a fresh runtime qualification: no tunnel verb, model turn or selftest was run.

## Team and scope

This myShell owns this new, bounded support team and integrates its findings:

| Role | Native member | Work returned |
|---|---|---|
| Context liaison | `/root/tunnel_it_context` · researcher | GUIDE, chapters, HANDSHAKE, tunnel-session evidence; correction addendum |
| Historical-input preprocessor | `/root/tunnel_it_history` · researcher | October 7 journal slices and corrections; correction addendum |
| Development adviser | `/root/tunnel_it_dev` · Astrobley | Current shim/helper source, deployment comparison, operational risks |

All three were assigned read-only work and returned. They remain support bindings,
not project heads, G09 workers or restored historical agents. Oraculum is not
instantiated for this team. Historical beds below are evidence sources, not newly
attached execution sessions. No global agent, program or transport was created.

Coordination check: `session-coordination/CONTROLLER.md` stamp `ee8ecbd1`;
selected `prepare-team` expected/observed `17ac0a51`. Journal fold check:
controller `96a5974b`; `fold-entry` expected/observed `9456ec9a`.

## Operating distinctions worth keeping

1. **Three different things:** a stored tunnel thread is the conversation target;
   the interactive CLI/TUI is a client of a thread; a native subagent is a delegated
   role/context. A label or thread ID does not make these interchangeable.
2. **Address and authority:** the shim requires an explicit state path. One shared
   vault provides its per-vault turn lock; another vault addressing the same thread
   does not share that protection. Enable/dispatch authority comes from the actual
   assignment and operator grant, not a discovered file or successful health check.
3. **Release and locks:** avoid overlapping TUI/tunnel clients. A writer-lock file
   may remain after its holder exits. The current `tn-check` helper inspects holders;
   `tn-back` waits for a holder to release, then resumes/checks. Never delete
   Codex-owned writer locks as recovery.
4. **Evidence:** `ask` reconciles the returned turn text with read-back. This does
   not verify factual correctness or work acceptance. Preserve the actual result
   and receiving owner's disposition in the task's declared evidence surfaces.
5. **Settings:** saved intent, a server-reported runtime snapshot and effective
   settings on a later turn are distinct. Source forwards explicit turn overrides;
   historical field evidence says removing an override need not reset a previously
   applied thread setting. Current-version behavior has not been probed here.

Evidence homes: `/home/hruzam/ia-sync/HANDSHAKE.md` §TABLE and its Cartan amendment;
`/home/hruzam/reposoma/raw.guides/tunnel/GUIDE.md` and
`res/{user-run,settings,multi-seat,preamble}.md`; current
`/home/hruzam/ia-sync/zsh/ai/tunnel-codex.{zsh,py}` and
`/home/hruzam/ia-sync/zsh/session/tunnel.zsh`.

## Preamble placement — the important historical correction

The portable source currently exists at
`/home/hruzam/ia-sync/germline/tunnel/tunnel.preamble.md`; its deployed copy is
`/home/hruzam/.germline/tunnel/tunnel.preamble.md`. Both have SHA-256
`f84e51ebe25022802319595e5f8cc3f48d362310af4a77a30e54e68067832ca3`.
The provenance line says generalized for all tunnel beds on 2026-10-17; the first
line still names Nablarva X1. That heading is a wording/provenance residue, not
evidence that the shared file is absent or necessarily invalid.

The shim reads only the path actually named by a vault's `preamble` field and
prepends its current contents before send/ask/steer. File existence and matching
deployment do not establish any particular vault's configured attachment or the
model's compliance. We deliberately did not inspect live vault contents.

The GUIDE chapter's October 8 placement discussion and "first live turn unobserved"
statement are dated records, not a current absence finding. The two reader members
initially overextended those records; their addenda corrected this after myShell
checked the newer source/live files. Those initial conclusions are superseded here.

## Current-source caveats for a later operating task

These are source-backed risks and effects, not newly reproduced runtime incidents:

- **Failure may follow submission.** In Python `cmd_send` / `cmd_ask`, birth/resume
  and turn execution/reconciliation occur before the normal `save_state` call.
  An exception before that save can leave the vault's thread/turn identifiers
  null or stale despite remote work. An unknown outcome is not permission to resend
  or create another thread. Reconcile by an already established address/receipt
  under the owning session's authority. If that address is missing, record the
  uncertainty rather than invent a safe retry. In `ask`, the exact-text mismatch
  check occurs after saving state; not every error has the same persistence outcome.
  See `tunnel-codex.py` functions `_birth_or_resume`, `cmd_send`, `cmd_ask`, `main`.
- **Existing-vault open has effects.** Fresh open preflights without a task turn;
  fresh bind records a named thread without resuming it. Reopening an existing
  born vault, including changing preamble/overrides, can save changes and contact
  `thread/resume`. "Only local declaration" is not true of every open operation.
  See `cmd_open`, especially the existing-state path after the fresh-open return.
- **Close needs quiescence.** The shell close branch removes the state and its
  shim lock without checking a live holder. Do not close during activity or assume
  close is safe merely because it is local. This shim lock is distinct from the
  Codex-owned writer locks, which must not be removed by this support procedure.
- **Read is a remote read operation.** Python `cmd_read` starts app-server and
  fetches full thread JSON. It is not equivalent to a local health inspection.
  Recovery instructions must respect the project's permitted operation and privacy
  boundary; no read operation was executed by this support team.

Source/live SHA-256 matches checked on office:

| File pair | SHA-256 |
|---|---|
| `ia-sync/zsh/ai/tunnel-codex.py` ↔ `~/.config/zsh/ai/tunnel-codex.py` | `8ca70c3044a9756265b42bc94d4a58b1d2c512ecd6b2e25becbd781ca2259052` |
| `ia-sync/zsh/ai/tunnel-codex.zsh` ↔ `~/.config/zsh/ai/tunnel-codex.zsh` | `ae7803d804b54fd59145550807286a030d9efc6c2f13c6a0e17584dffe768f4e` |
| `ia-sync/zsh/session/tunnel.zsh` ↔ `~/.config/zsh/session/tunnel.zsh` | `50408135d2d97173505c75598addd652bc1085d745b75e794f976e28e0b6e075` |

The adviser also reported matching selftest copies; selftests were inspected as
text only. No result here proves compatibility with the current daemon/server.

## What to take from the October 7 journal and session records

Read `/home/hruzam/reposoma/.majkee/journal/2026-10-07.md` §1.1.4 and its October 8
correction block (around lines 150–169), plus "another trajectory note about tunnel"
(around lines 639–681). The filename does not date every later embedded correction.

- Preserve the explicit vault-address discipline, yielded carrier/seat ownership,
  refusal reporting and reconciliation before retries.
- Do not reuse the printed thread IDs, bed paths or old rebind recipes. The journal
  itself marks its proposed `/clear` successor unusable. Do not generalize that
  case into "all zero-turn threads are unusable": later fork evidence is distinct.
- `tn-check`/`tn-back` are implemented helpers, not merely historical suggestions.
  READY describes the helper's checked conditions; it grants no dispatch authority.
- The blanket statement that nobody can answer approvals behind the tunnel is too
  broad: the dated feedback F14 records two Guardian approvals under `auto_review`
  and distinguishes reviewer `user`. This is historical evidence, not a fresh
  current-version approval or rejection test.
- Later feedback F18/F19/F20 records overrides, compact and fork work. Current shim
  source includes compact/fork verbs; an earlier "proposal/unbuilt" line cannot
  establish their current absence. Neither source presence nor those historical
  records authorize using them in a running experiment.

Checked tunnel-session source map:

- `/home/hruzam/ia-sync/.dev/session/reversal-tunel-00-leader/` — historical spelling
  `tunel`; myShell checked its RUNBOOK/STATUS entry blocks. The September 3 STATUS
  is still an instrument-preparation record, not evidence that a reverse-direction
  instrument was completed or adopted. No reverse Claude launch is implied.
- `/home/hruzam/ia-sync/.dev/session/tunnel-upgrade-01-parametrization/` — RUNBOOK,
  STATUS and named support/closure records read selectively.
- `/home/hruzam/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/hotrun.headless.2026-10-03.md`
  — documented bind/runtime/memory checks and explicitly unrun cases.
- `/home/hruzam/ia-sync/.dev/session/tunnel-03-feedback-upgrade/raw/field-feedback.nablarva-X0.trajectory.2026-10-07.md`
  — read the updated F1/F13–F20 records, not only the older header. They distinguish
  implemented corrections, historical observations and pending proposals.

The latter two beds have no current RUNBOOK/STATUS at their roots. That is an
inventory observation, not proof of no work or a reason to restart them.

## Receiving Cartan / remaining limits

This report is provisional IT/dev context for G03. It does not assess G03's frozen
candidate set, settle its controller/function criteria, release an Atlas cycle or
live trial, repair a guide/shim, change the preamble, or activate a tunnel. G03's
current RUNBOOK/STATUS and Majkee retain their existing authority. G09's worker
handles, budget and release are separate and were not operated by this team.

Before an eventual authorized trial, its owner needs the actual selected thread,
vault, carrier, allowed operations and evidence/recovery route. Recheck the relevant
bytes/runtime facts then. This report supplies neither a live binding nor a generic
ready-to-paste activation recipe. In particular, unknown submission must remain
unknown until reconciled; a file or failed local command cannot close that question.

Not performed: live tunnel/model calls, selftests, current-version platform probe,
raw rollout/database/auth inspection, historical transcript replay, source/guide
repairs, deployment, commit or push. Only this report and its day-square pointer
were written by myShell. Any delivery to Cartan remains through Majkee or a later
explicitly authorized route.
