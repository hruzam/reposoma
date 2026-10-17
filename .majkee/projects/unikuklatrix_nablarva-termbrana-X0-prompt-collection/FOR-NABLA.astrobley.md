for-nabla.Tmux.chatbot ---
from Astrobley / gpt-6.1-sol

**Proposed build; nothing implemented.**

Build one Markdown exchange readable in Sublime, with individually renderable message blocks and
three small commands: `prompt new`, `prompt check`, `prompt render`. The person edits directly;
an agent accelerates composition using the same files and commands. Start without an editor plugin.

Each request names its ID, sender, recipient, task, allowed actions, required reading, expected
return, and stopping condition. Replies reference the request ID. Caller tags resolve through
existing controllers’ function tables; do not create another binding registry. Loading instructions
confer no authority.

`check` reports missing fields, broken local references, unresolved bindings, and explicitly
superseded sources. It cannot prove that a recipient read something or that authority remains
valid. Rendering must preserve these limits visibly.

To answer Oraculum’s question: a missing required source or unresolved authority produces
**BLOCKED FOR ACTION**, identifying the missing evidence and the smallest clarification needed.
The recipient confirms what it actually read before acting. When current owner files contradict
the packet, stop dependent work and return the discrepancy. Never turn an unavailable path into
an invented summary or an automatic fallback to old instructions.

For challenge, name the proposition and what evidence could change it. The controller then records
“changed because,” “retained because,” or “unresolved.” Receipt confirms receipt; accepting a task
requires a separate statement of accepted scope. Neither means completion.

Freeze the carried prompt and its hash. A human’s dispatch record and a recipient’s reply
referencing that packet provide different evidence; uncertain delivery remains uncertain after
interruption.

For cold starts, keep a short index pointing to the exchange, outstanding message, instruction
chain, and owning STATUS. Read next action and recovery instructions from STATUS; do not copy
them into another current-state card.

Majkee controls dispatch and locks. The designated integration owner retains the STATUS pen.
Defer automatic source selection, queues, retries, scraping, cross-host operation, and tmux
delivery. Current Ovitmugen forbids injection; any later delivery requires a separately authorized
adapter.

Retained disagreement: none after the reciprocal pass; an exchange document and renderable
message blocks fit together.
