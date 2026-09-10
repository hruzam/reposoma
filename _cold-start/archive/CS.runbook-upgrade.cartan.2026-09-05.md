---
kind: cold-start-card
date: 2026-09-05
brand: codex
seat: cartan-csharp
project: reposoma
root: ~/ia-sync
commit: fbd9f5e (main)
task: Resume the existing runbook-upgrade cSharp head after the operator's PC restart
resume: codex resume -C ~/ia-sync 01a06cfd-b74e-7430-b041-992a9d9cea3c
model: astra
dedicated: cartan-csharp
recommend: Resume this exact session; if unavailable, a fresh Cartan reads the same live STATUS and preserves all gates
runbook: ~/ia-sync/.dev/session/runbook-upgrade/RUNBOOK.md
pointers:
  - ~/ia-sync/AGENTS.md
  - ~/ia-sync/SYNC_DISCIPLINE.md
  - ~/ia-sync/pulse.md
  - ~/ia-sync/.dev/session/runbook-upgrade/STATUS.md
  - ~/ia-sync/.dev/session/runbook-upgrade/_bus/18.cartan-csharp.verdict.md
  - ~/ia-sync/.dev/session/runbook-upgrade/_bus/19.cartan-csharp.point.md
  - ~/reposoma/raw.guides/runbook/res/csharp-head-protocol.md
  - ~/reposoma/raw.guides/runbook/res/fanout-turns.md
session_id: 01a06cfd-b74e-7430-b041-992a9d9cea3c
rollout: ~/.codex/sessions/2026/09/04/rollout-2026-09-04T17-16-02-01a06cfd-b74e-7430-b041-992a9d9cea3c.jsonl
observed_model: gpt-6-astra
observed_effort: xhigh
cli_version: 0.153.2
host: office · hruzam-120922
active_goal: none
authority_may_write: Head-owned session controls; other bodies of work remain delegated under RUNBOOK
authority_gated: Follow current STATUS and the exact POINT; this card grants no Git, deploy or worker-wake authority
---

## Read first

This is a transfer pointer, not another doing-state. Read the applicable AGENTS chain, then
the live RUNBOOK and STATUS above. STATUS owns the recovery probe, approval state, next action
and holds. Read the cited VERDICT/POINT as directed there; do not replay an old cycle.

The existing head is Cartan in cSharp posture, not an Octopus plan-and-park restart. Atlas UI
and harness-builder are one existing seat, `atlas-ui`. Majkee carries absolute POINT paths;
do not spawn a replacement builder or message existing seats directly.

## Observed frame and limits

The context capture's session ID matches CODEX_THREAD_ID and an existing local rollout path.
The installed CLI's `resume --help` accepts an exact session ID and `-C`; the resume command
above was syntax-checked against that help, not executed. Avoid `--last`: other Cartan sessions
also work in this repository. Local CLI/session files are host-local, not cross-host transport.

The captured active model is gpt-6-astra/xhigh; RUNBOOK's original Sol tuple is historical
declaration, not proof of the current carriage. Do not rewrite the fixed launcher to mask it.
The registered umbrella project is reposoma; ia-sync has no key in the inspected temple map.
The actual working root and resume target are explicitly ~/ia-sync; no registry edit is earned.

## First tool shot

```sh
hostname -s
git -C ~/ia-sync status --short
git -C ~/ia-sync rev-parse HEAD origin/main
git -C ~/ia-sync diff --cached --name-only
sed -n '1,150p' ~/ia-sync/.dev/session/runbook-upgrade/STATUS.md
```

Reconcile results with STATUS before any action. A reboot does not require staging, stashing,
resetting or committing unrelated work. The approval is durable in the cited POINT; history
and any later receipts still decide whether its operation already ran.

## prompt-0

###### prompt

```text
Resume Cartan-csharp for ~/ia-sync/.dev/session/runbook-upgrade.
Read RUNBOOK.md and STATUS.md from that bed and run STATUS's read-only recovery probe.
Preserve the existing gate, ownership and approval boundaries. Do not restart planning,
repeat completed cycles, implement delegated source, push, deploy, or wake another agent.
After reconciling disk, follow STATUS.next and give me the one required relay or decision.
```

## Gates and lifecycle

This card is office-local and uncommitted. The live bed also has uncommitted control files;
another host cannot reconstruct this pause from Git alone. No commit, push, deployment or
session wake was performed to create this card. The next reader archives this card only
after successful consumption, under the vault lifecycle; never archive another seat's card.
