# Sella-v.0.1 — shared request meaning, asymmetric runtime bindings

for-nabla.Tmux.chatbot ---
Prepared by myShell with Astrobley and Oraculum · 2026-10-17 · office
Personal design proposal requested by Majkee. `v.0.1` versions this briefing, not the Sella guide.

## The recommendation

Build a small workbench for composing, checking, rendering, and preparing folds of prompt
exchanges. Keep the request readable in Sublime and usable by hand. Give deterministic code the
structured parts; let the integrating agent interpret evidence and operate through the actual
runtime's supported mechanisms. Preserve differences instead of inventing one universal CLI.

This collection specifies a direction and a proposed pilot. It implements no parser, adapter,
command, automatic writer, or delivery system, and it changes no program/controller/Sella source.

## Three authors, three perspectives

| Read | Perspective | Main contribution |
|---|---|---|
| [brief.astrobley.sella-v.0.1.md](brief.astrobley.sella-v.0.1.md) | Programmer · GPT-6.1-Sol | Explicit source packet, derived representation, parsing/loading, adapter outcomes, fold recovery limits. |
| [brief.oraculum.sella-v.0.1.md](brief.oraculum.sella-v.0.1.md) | Project designer · GPT-6-Astra | Commitments, acceptable substitutions, operation-specific failures, meaningful pilot. |
| [brief.myshell.sella-v.0.1.md](brief.myshell.sella-v.0.1.md) | Agent using the device | The inspect/compose/render/return/fold interface I would actually use. |
| [History and attachment refinement](note.myshell.history-and-attachments.sella-v.0.1.md) | myShell with Astrobley | Pending reasons, own JSONL history, stable workspace, optional RUNBOOK bed and replaceable tmux endpoint. |
| [EXCHANGE.md](EXCHANGE.md) | Shared critique | First-view summaries, reciprocal questions, integration record. |
| [evidence.sella-v.0.1.json](evidence.sella-v.0.1.json) | Evidence index | Source identities, official documentation links, observed versus proposed claims, artifact hashes. |

The advisers first read the shared context, then each read the other's first proposal in the
exchange. Their final briefs remain attributed. myShell alone wrote the durable files.

## The animal's parts

```text
Majkee in Sublime / agent-assisted composition
                |
       readable request document
                |
     parse -> resolve -> load -> check
                |
      neutral task + checked context
                |
        runtime-specific plan
          /       |        \
      native   manual   unsupported/unqualified
          \       |        /
       attributable return or diagnostic
                |
     integration owner's disposition
                |
        exact proposed fold
                |
 existing authorized owner applies under current rules
```

Every branch is observable. A rendered request is not dispatched; a dispatched request is not
accepted; an accepted task is not complete. A matching return format does not establish the same
context, controls, independence, or quality across runtimes.

Two binding types must stay distinct:

- **Procedure binding:** which existing controller/function defines this operation?
- **Role/runtime binding:** which real collaborator and native/manual route can meet the request?

The parser reads the declared header and preserves the body as text. It does not discover
instructions inside quoted examples or turn task prose into shell code. Agent-assisted rewriting
produces a new reviewable draft version. The derived machine representation is never a second
editable source of intent.

## What is neutral, and what must vary?

| Shared meaning | Runtime-dependent realization |
|---|---|
| Request identity, actual task, scope and expected return | Native agent/tool identity, invocation mechanism and return channel |
| A consultation advises one integration owner | New child, existing child, another interactive session, or explicit human carrying |
| Required context separation and evidence access | What context is inherited, which files/tools are available, what is observable |
| Allowed work and named authority reference | Actual approval/sandbox controls; a declared limit does not create enforcement |
| Attribution, uncertainty, and disposition | Native response shape normalized without concealing material losses |
| Exact fold proposal and intended destination | Existing function owner and writer/concurrency mechanism |

A manual alternative may preserve a consultation's purpose while failing a required automation,
context, or tool constraint. Propose that alternative visibly. A mandatory requirement that cannot
be met remains unmet until Majkee explicitly relaxes it; do not quietly rewrite the request.

## Current vendor evidence, with limits

These are narrow documentation facts checked on 2026-10-17. They do not qualify an installed
cross-runtime adapter, assert account access, or promise identical behavior.

| Runtime | Documentation fact relevant to this design | Local qualification in this sitting |
|---|---|---|
| Codex | Custom agent definitions use TOML. Child permission controls come from the parent; a custom agent file cannot replace that policy. | Existing Astrobley and Oraculum follow-up consultations were actually used. No external Codex adapter was implemented. |
| Claude Code | Custom subagents use YAML frontmatter plus Markdown. Permission-mode behavior has parent-mode conditions. | Source wrapper inspected; no Claude invocation or permission probe performed. |
| Gemini CLI | Custom subagents are documented with YAML/Markdown definitions and their own configuration surface. | Documentation only; no Gemini executable, account, configuration, or delegation was tested. |
| Other CLI | No common capability is assumed from the name “CLI.” | Unqualified until its actual interaction and return mechanism are inspected. |

Sources: [Codex subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents),
[Claude Code subagents](https://code.claude.com/docs/en/sub-agents),
[Gemini CLI subagents](https://geminicli.com/docs/core/subagents/).
Exact flags, model pins, native key schemas, and billing/account assumptions are outside this proposal.

## Folding automation: the first boundary

In this candidate, automate preparation: exact proposed text, attribution, evidence, destination
scope, request identity, and disposition. The existing authorized journal function owner applies
the append and returns its receipt. Preparation does not authorize its own application.

Missing evidence is handled per operation. A procedure may permit a partial uncertain report
about unavailable subject evidence. Missing the governing procedure or mandatory authorization
cannot be repaired by inventing a fallback. A diagnostic report can still explain a blocked action.

Automatic application comes later if a credible writer boundary and recoverable update exist.
A tool lock alone does not control an unrelated Sublime save. A successful side log does not prove
the intended journal content survived. Project STATUS continues to own current project position.

## Sella inputs and the disagreement kept visible

The existing [Sella GUIDE](/home/hruzam/reposoma/raw.guides/sella/GUIDE.md) labels itself draft
and separates primitive construction from session governance. Its laws encourage small native
primitives, explicit contracts, bounded loading, and dated behavior evidence. They inform this
proposal; this file does not extend their authority or replace them with a language specification.

Its older application/glossary passages still call pulse the doing-state. Current Nablarva L9′
and the session guides instead make pulse a router and STATUS the owner of current position.
That observed mismatch is preserved here rather than silently inherited or repaired. Historical
vendor tables likewise do not establish today's native capabilities.

The local program tables' matching stamps provide a checked marker. Byte digests separately
identify content; neither alone proves that an agent read, understood, or followed the source.
A future loader replacing manual agent checks would require a deliberate change to the current
instructions. This briefing makes no such change.

## Proposed first experiment

Use one low-consequence consultation and then repeat it through a materially different binding.
Freeze the actual question, necessary evidence, and mandatory semantics first. Include a challenge
that can cause a revision and a fresh-reader interruption.

Observe whether each route preserves scope and attribution, exposes missing requirements, permits
a reasoned disposition, and lets the fresh reader recover the open request from the small exchange
and owner-state pointers. Include two negative cases: an allowed partial report with missing owner
evidence, and a mandatory capability that the selected route cannot supply. Neither may produce a
dependent unauthorized write or a fabricated equivalent result.

Compare recovery effort with the old journal workflow. This is a proposed acceptance method; it
has not been executed. Results would earn a dated finding, not a claim of universal runtime parity.

## Open choices for Majkee and Nabla

- Which obligations are mandatory for each task class: context separation, evidence access,
  tools, exact model, human dispatch, or automation?
- Which substitutions are acceptable, and who may explicitly approve them?
- Does structured preparation measurably reduce composing and recovery work before automatic writing?
- Which later writer or delivery boundary is justified by observed failures?

For the chatbot: discuss these choices from the three briefs. Preserve the distinction between
the proposed device, the existing local manual programs, and actual vendor features. Request the
smallest missing source passage rather than assuming access to a local path.
