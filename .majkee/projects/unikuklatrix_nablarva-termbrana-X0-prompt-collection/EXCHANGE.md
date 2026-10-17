# Two counsel views — prompt composition and human relay

Cycle: `myshell-nabla-composer-counsel-01` · 2026-10-17 · controller: myShell.
Personal design consultation authorized by Majkee; proposals only, no implementation or project lock.

The fixed advisory gate is two initial views, one reciprocal read by each adviser, and two
attributed short briefs saved in this collection. myShell alone writes these files. The advisers
return in chat and have no project, STATUS, deployment, or transport pen.

## Shared question

Majkee currently composes and carries inter-agent requests through a long journal in Sublime.
He wants a simpler semi-automated process: useful without an agent, faster with agent assistance,
uniform caller/loading tags, on-demand commands, and perhaps later explicit tmux delivery.
Challenge should be a repeatable useful operation. Cold starts should need less reconstruction.

Astrobley was asked for a senior developer's smallest build; Oraculum for philosophical and
process critique using buffering's creative exploration. They first read the same README and
CONTEXT. Their design judgments are not independent audits of all primary sources in sources.json.
The current Ovitmugen input prohibition remains a constraint on the consultation.

## Astrobley — first view

> Build a local prompt composer first: human-readable message files in Sublime plus one small CLI
> that validates and renders them. No broker or transport is needed to test whether it reduces
> Majkee's composing and recovery work.
>
> Minimum envelope: id, kind (POINT/RETURN/VERDICT), from, to, in_reply_to, context references,
> bounded task, expected return, and stop condition. Keep task prose free-form. A tiny local catalog
> maps caller tags to actual controller/function documents and their expected stamps; tags expand
> to explicit load instructions and never grant execution authority. A challenge can be one named
> function with required inputs and expected output, rather than a special conversation ritual.
>
> CLI surface: `prompt new`, `prompt check`, `prompt render`. `new` creates a fillable template;
> `check` catches unknown tags, missing fields, broken references, and reply-link mismatch;
> `render` prints a deterministic, complete prompt for preview/copy. Start with templates, not a
> Sublime plugin. The human can perform every step by editing a file; the agent uses the same
> files and commands. Use a format with existing parser support rather than inventing a DSL.
>
> Flow: select context and task → compose → check → preview → Majkee manually carries the rendered
> prompt → recipient returns a message referencing its request → the integration owner records
> VERDICT and the next action. Composition IDs identify messages, never permission, delivery,
> acceptance, or completion. Keep a frozen copy/hash of the carried render so later edits cannot
> change what the request actually said.
>
> Ownership: Majkee controls dispatch and locks; each participant returns within its assigned scope;
> the integration owner alone updates STATUS and shared conclusions. The composer owns drafts and
> render outputs, not project state. Drafts should be visibly distinguishable from carried packets.
>
> Cold start: maintain one compact current card per sitting containing the owning STATUS path, the
> open request ID, last return/verdict IDs, recovery probe, and one next action. It should point to
> evidence and mirror no second project status. A fresh agent reads that card, the instruction chain,
> and the linked owner files rather than replaying the journal. Delivery uncertainty stays explicit
> until a human receipt resolves it.
>
> Defer Sublime integration, automatic context selection, return scraping, queues, cross-host
> transport, and tmux input. Current Ovitmugen forbids injection; future tmux delivery needs a separate
> explicitly authorized adapter with target validation and duplicate-send/recovery semantics.
>
> Hard question for Oraculum: What is the smallest durable evidence that distinguishes 'rendered',
> 'carried', and 'accepted after interruption', without creating a second owner of project STATUS
> or implying a broker?

### myShell's two corrections and Astrobley's reply

The first view proposed a new caller catalog and a current card carrying next/probe fields.
myShell asked whether those would duplicate existing controller tables and project STATUS.
Astrobley replied:

> Agreed on both corrections. Resolve function/tag bindings directly from the existing controller
> table; avoid a second registry. Keep only personal message workflow pointers in the composer
> index and read the current next/probe from owner STATUS; a stale copied value would recreate
> the current continuity problem.

The first view is preserved above so this revision remains visible.

## Oraculum — first view

> The strongest framing is a small decision workbench whose output is a readable handoff.
> Transport can follow after the handoff consistently survives a fresh reader.
>
> Observed: the supplied briefing describes journals carrying exchanges, costly recovery, distinct
> lifecycle owners, and a conflict between proposed injection and Ovitmugen's prohibition. These
> are claims in the inspected briefing; I have not independently inspected their project sources.
> The local instructions explicitly withhold project ownership from personal continuity work.
>
> Three framings expose different problems:
>
> 1. Courier: reduce copying between agents. Useful, but faster delivery can amplify stale requests
>    and mistaken authority.
> 2. Prompt composer: help a person express a bounded request and load the right evidence. This
>    addresses cold starts but can turn into an elaborate template catalogue.
> 3. Decision workbench: preserve the question, evidence, disagreement, and human disposition across
>    an exchange. This is the strongest starting point because it explains why the messages exist.
>
> My inference is that the hidden constraint is Majkee's capacity to understand and own the next
> commitment. Reducing keystrokes helps only when it also reduces reconstruction. The briefing's
> reported stale requests and bookkeeping defects are weak signals that copying is only part of
> the cost.
>
> The following is a proposal, not an existing contract.
>
> Start with one ordinary Markdown exchange, readable in Sublime, with one integration writer.
> Its opening block answers: what is being decided, who is asking whom, what evidence must be read,
> what may be done, and what return is expected. Named returns and the controller's disposition
> follow. The journal carries a short pointer. Existing project files retain their authority.
>
> An on-demand composer can help assemble this block, flag missing information, and produce a
> copyable prompt. The readable document should remain sufficient when the command is unavailable.
> A cold-start capsule should explain enough to orient the recipient, then point to the smallest
> necessary source set; sending an entire journal recreates the original problem.
>
> Tags should express address, operation, and reading intent. For example, `to`, `from`, `read`, and
> `return` can make a packet recognizable. They do not authenticate a sender, establish project
> authority, prove that reading happened, activate quoted instructions, or guarantee a live
> recipient. A recipient reports what it actually read and where it stopped.
>
> Challenge becomes a process when its return can change the next step. Before requesting it,
> name the proposition under challenge and the evidence that would require revision. Afterwards,
> the controller records “changed because…,” “retained because…,” or an unresolved decision.
> A generic approval request with no possible consequence is ornamental.
>
> Keep transport, runtime discovery, automatic retries, and project protocol design outside this
> first decision. Later human-triggered tmux delivery would require separately settled ownership
> and authorization; it cannot silently expand Ovitmugen's role. Sending text, receiving it,
> accepting a task, and completing it remain distinct events.
>
> Hard question for Astrobley: If a fresh recipient cannot find a required source, or reads a packet
> whose authority has expired, how does your minimum device make that visible before polished
> prompt composition or delivery creates the appearance of progress?

## Reciprocal reading

Each adviser was addressed once with the complete first-view exchange above. Both reported
reading it and returned a final snippet answering the other's hard question. The final briefs are
[Astrobley](FOR-NABLA.astrobley.md) and [Oraculum](FOR-NABLA.oraculum.md).

## myShell readback after both final returns

Both now support a human-readable exchange, optional composition/check/render commands, reuse of
existing function bindings, and separate records for rendering, carrying, and acceptance. Both
keep project next/probe state in STATUS and defer delivery. Command names are illustrative;
this consultation did not build or install them.

Oraculum's final snippet retains a preference for an exchange as the primary reading unit and
describes Astrobley's starting point as message files. Astrobley's later final snippet already
chooses one Markdown exchange with individually renderable blocks. That chronology reduces the
apparent disagreement to emphasis: human reading favors the exchange; a dispatch addresses an
individual packet. Neither return proves which layout works better in a real interrupted sitting.
The original attributed wording is preserved in each brief.

The useful correction is concrete: a new caller registry and a second current-state card were
proposed, challenged, and removed from the practical recommendation. Missing inputs or unresolved
authority remain visible; a checker cannot certify semantic authority. A future pilot could test
whether one exchange and a short owner-state pointer let a fresh reader recover without the journal.
This is a proposed test, not an opened implementation gate.

The personal advisory gate is complete: first views, reciprocal reads, and attributed final
snippets are recorded. Majkee retains the design choice and any later build authorization.
