---
program: session-coordination
function: handle-event
revision: 2026-10-22
stamp: 47ab8732
---
# handle-event

Inputs: original incoming event, affected explicitly selected session(s), current team
bindings, source/owner pointers, allowed effects and intended recipient/result. Events
are caller-supplied data: e.g. incoming message, source change, decision, handoff or
member loss. A header or file appearing does not trigger execution by itself.

1. Preserve the original ask/source and resolve its actual authority. Identify affected
   teams from the request and checked evidence; return an ambiguous route explicitly.
   Simple exchanges may be handled directly without waking a team.
2. Choose the needed team members and depth. For bulky/noisy input, ask that session's
   preprocessor for asks, quotations, evidence pointers and uncertainties. Its liaison
   connects them to current owner state and identifies session consequences. Skip a
   stage when it adds no value; do not require every member on every event.
3. For a hard question, address the same session's bound thinker or development adviser
   with the bounded question, relevant extracted evidence and actual current sources.
   Commission factual research only for an identified gap. An adviser remains within
   its supplied role contract; advice is not a gavel or independent acceptance.
4. Receive returns at the coordinator. Check consequential source facts and changed
   revisions; retain contradictions and evidence limits. For another affected session,
   frame a bounded question/result to its own team. Keep unrelated bulk there rather
   than reconstructing both histories in the coordinator.
5. Return a cross-session synthesis: what changed; source identity; dependency/result
   needed, receiving owner and release evidence; exact next read/assignment pointer.
   Put real project decisions/integration with the owning head. Independent packages
   continue; only an actual dependent package waits.
6. Prepare an addressed handoff. Deliver only on an authorized checked route; otherwise
   return the exact operator relay. Connect it to the recipient's existing entry or
   assignment surface only under separate write authority, or ask its owner to do so.
   Report prepared/delivered/reported-read/accepted only as actually evidenced.

Return unresolved/held on only the affected part when scope, authority or contradictory
required evidence prevents a sound action. Lost member bindings require recovery before
claims of reuse. No background loop, automatic forwarding or foreign-state edit occurs.
