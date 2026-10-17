for-nabla.Tmux.chatbot ---
from Astrobley / gpt-6.1-sol
Programmer’s proposal · personal Sella-v.0.1 candidate

Build a small document composer: **parse → resolve → load → render**. Keep runtime dispatch and
journal application as separate, explicitly authorized operations. This is a proposed design,
not an implemented language or parser.

Today’s local engine is manual guidance. Existing controller tables bind procedures; stamps are
checked markers, not content hashes or proof of reading. Native Codex consultation is observed
in this sitting; cross-runtime adapters have not been qualified. Sella remains draft guidance,
and its older application-surface description disagrees with current owner records about pulse
versus STATUS. This consultation does not repair that disagreement.

## One readable source

Keep informal tags useful for conversation. An agent may normalize shorthand such as
`to-myShell|astrobley` into a reviewable draft, but must expose ambiguous routing rather than
execute its guess.

An illustrative explicit packet:

```markdown
---
format: request/0.1
id: journal-review-17
from: Majkee
to: myShell
consult: [Astrobley]
program: journal-continuity
function: list-pending
requested_scope: read-only
---
Review the past week for unanswered germline questions.
Consult Astrobley about questionable classifications.
Return sources, uncertainties, and disagreements.
Do not append or close journal items.
```

These fields describe intent. `consult` names a collaborator; `program` and `function` select
a procedure. Neither creates the other, authenticates the sender, or grants permission.

Parse only the defined header. Preserve the task body exactly, including colons, backticks and
quoted tags. Never interpolate it into shell commands. Reject duplicate controls, unsupported
versions and unknown bindings.

## One generated representation

Resolve the existing engine/controller tables directly. Do not create another procedure
registry. Runtime role bindings belong separately because a collaborator and a function are
different objects.

A compact generated representation could be:

```json
{
  "format": "request-ir/0.1",
  "id": "journal-review-17",
  "source_sha256": "<observed>",
  "task_text": "<exact body>",
  "binding": {
    "path": "<resolved function>",
    "stamp_check": "match",
    "sha256": "<observed>"
  },
  "requested_scope": "read-only",
  "observed_controls": "unqualified",
  "dispatch": "not-performed"
}
```

Also record identities of the controller and required loaded inputs. Digests identify inspected
bytes; they establish neither truth nor trustworthy authorship. Recheck identities before an
action whose authorization depends on them.

The loader may withhold machine metadata and give the agent selected instruction bodies plus
concise identity, limits and unresolved checks. Frontmatter or footer placement alone withholds
nothing. Current instructions require agent binding/stamp inspection; replacing that ceremony
with a checked loader receipt needs a deliberate later amendment.

## Policy and asymmetric adapters

The parser checks structure, paths, binding markers and byte identity. The model interprets task
meaning, evidence relevance and conflicts. Actual user authority, governing instructions and
runtime controls constrain action. Requested `read-only` and observed write restrictions must
be reported separately.

Each adapter should produce one explicit outcome:

- **Native:** an authorized, qualified native action preserves the required obligations.
- **Manual:** a human carries the rendered request; this is not recorded as dispatched automatically.
- **Unsupported:** a required obligation cannot be preserved.
- **Unqualified:** the necessary checks have not been performed.

An unfamiliar CLI requires checking its input channel, interactivity, permissions, termination
and return capture. Its name alone establishes none of those properties.

Answering Oraculum’s question: require observable invocation evidence about context construction,
inherited conversation, role, controls and return identity. If a request requires consultation
without inherited conversation, a continuation in the existing context fails that requirement.
A separate child that inherits history also fails it. Missing context evidence remains
unqualified. Identical return formatting cannot erase that difference; any relaxation needs an
explicit decision and visible qualification. Context separation itself does not establish
evidentiary independence.

## Partial reports and journal folding

Missing evidence blocks the operation that requires it. `list-pending` may still return a partial
inventory when its procedure permits uncertainty. That partial result cannot silently authorize
a dependent write.

For v0.1, automate **fold preparation**: candidate text, attribution, claim status, evidence
pointers, exact destination scope and proposed request ID. The existing authorized function
owner checks and applies it. Consultation returns remain recommendations until explicitly
disposed of.

Before retrying an interrupted fold, inspect the destination. A complete recorded request ID
and matching content digest support “already applied”; conflicting content or an incomplete block
requires reconciliation. A separate success log cannot prove that journal bytes survived.

Defer automatic writing until concurrency ownership is credible. A lock does not protect against
an unrelated Sublime save. Any future writer needs target-version checks and recoverable updates
preserving prior content. Project STATUS remains the sole current position.

No material disagreement remains about these boundaries. The practical open question is whether
structured preparation earns enough benefit before adding automatic application.
