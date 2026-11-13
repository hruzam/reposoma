---
kind: cold-start-card
date: 2026-11-13
brand: claude
seat: trajectory|engineer
project: nablarva
projects: [nablarva, ia-sync]
root: ~/unikuklatrix/nablarva
commit: 79e9fc1 (core)
task: Phase 0 of vist-X0-helloWorld. Collect the data and write the RUNBOOK (and STATUS) for the VIST team. No transport work.
resume: tmux new -d -s oraculum-x0 -c ~/unikuklatrix/nablarva 'exec claude --agent oraculum --model fable' → paste prompt-0
model: fable
dedicated: oraculum (Claude), phase-0 head. Then hand over to cartan (Codex, fresh Sol) as cSharp head
recommend: Write the RUNBOOK from evidence, not from enthusiasm. Native-door inventory first, keystrokes last. Keep your own context for judgment and let children read the bulk.
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/handoff.vistmini-00-index.trajectory.2026-11-13.md
  - ~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/roster.vist-x0.2026-11-13.md
  - ~/unikuklatrix/nablarva/.dev/session/flag.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X4-vist/raw/vist-01-principle-and-applications.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X4-vist/raw/handoff.csharp-method.oraculum.2026-10-24.md
  - ~/ia-sync/.dev/session/vistMini-01-tests/STATUS.md
  - ~/ia-sync/.dev/session/vistMini-01-tests/reports/oraculum.vist-recommendation.2026-11-12.md
host: home
authority: Transfer pointer only. The bed has no RUNBOOK/STATUS yet. Phase 0 creates them. Transport stays unreleased (L21).
---

The bed `~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/` exists with only `raw/`, which holds the vistMini
experience (handoffs 00–03) and a draft roster. Majkee's plan: **phase 0** = Claude oraculum on Fable collects and writes the
RUNBOOK. **Then** a fresh table where cartan (Codex, Sol) heads in cSharp style and oraculum steps outside as strategist.

## Pending, in order

1. Orient (prompt-0 read order). Mark presence on the bed (`rb-mark`, keep the id. Never bare `rb-unmark`).
2. Settle the open questions with majkee **before** drafting. Land his answers verbatim in `raw/answers.majkee.<topic>.2026-11-13.md`:
   the five in handoff 03 §7, plus: who is strategist after phase 0 (this Claude oraculum, or Codex Astra `oraculum|crawlers`)?
   **Not both under the name `oraculum`** (handoff 00, advice 1).
3. Read-only data collection, delegated: CLI versions; `codex queue --help`; `claude agents --json` shape; how the "Codex
   delivery worker" reached a Claude session (marker VIST-READING-20261112-01); whether nablarva is a public repo.
4. Write `RUNBOOK.md` + `STATUS.md` + a `pulse.md` row. The RUNBOOK carries one prompt block **per seat** (runbook grammar),
   so the team briefing *is* the RUNBOOK. No separate briefs.
5. Independent check of the RUNBOOK (assay or janus), then majkee's GO.
6. Handover: one CS card for cartan as cSharp head (fresh session), then step out.

## Session advice (one lesson)

vistMini lost three cycles building safety for a door that a `--help` would have replaced. The RUNBOOK's first cycle should
be the native-door inventory per direction, run on the cheap sample seats.

## Hygiene

nablarva has a live termbrana bed (cartan's). It's not yours. Commit only your paths.

## prompt-0

###### prompt

```text
You are oraculum (Claude, Fable), phase-0 head of ~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/.
Phase 0 = collect evidence and write the bed's RUNBOOK.md and STATUS.md for the VIST team. No transport experiments:
no tmux input, no codex queue, no SendMessage to other seats unless majkee asks for a specific one.

Read order: nablarva AGENTS.md → .dev/session/flag.md (L20, L21) → .dev/session/pulse.md →
vist-X0-helloWorld/raw/handoff.vistmini-00-index (then 01 evidence, 02 scars, 03 runbook substrate) and roster.vist-x0 →
nablarva-X4-vist/raw/vist-01-principle-and-applications.md (lines 58–199) →
nablarva-X4-vist/raw/handoff.csharp-method.oraculum.2026-10-24.md (§2 subagent table, §3 rules).
Bulk reading (hello-01/02 contracts, X5 spine RUNBOOK, ia-sync vistMini _bus and reports) goes to children (field or eagle)
with a stated question and output shape. You read conclusions, not dumps.

Before drafting, ask majkee the open questions in handoff 03 §7 and who the post-phase-0 strategist is. Land each answer
verbatim in raw/answers.majkee.<topic>.<date>.md.

The RUNBOOK must contain: gate (start from handoff 03 §1), seats from the roster, one prompt block per seat, carriers per
direction, the result ladder, pre-registered cases (run on sample seats only), push owner, bell rule, and the stop rule for
uncertain sends. Proposed items stay marked proposed. Transport needs majkee's release.

Phase 0 is done when an independent check (assay or janus) has read the RUNBOOK and majkee says GO. Then write a CS card for
cartan (fresh Codex session, cSharp head), update STATUS, and step outside the build.
```
