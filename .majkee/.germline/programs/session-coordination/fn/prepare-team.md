---
program: session-coordination
function: prepare-team
revision: 2026-10-23
stamp: 17ac0a51
---
# prepare-team

Inputs: current coordinator/continuation context, selected sessions, intended support,
current owner/source pointers, requested role slots, caller-supplied native bindings,
delegation authority and allowed effects.
No persistent file writes unless a separate receipt destination/write scope is authorized.

1. Distinguish adopting the procedure from resuming an explicitly authorized frame.
   Take session selection from the current assignment or that continuation, not an
   example or another coordinator's historical card. Resolve each selected session
   through its current applicable instructions and owner state. Confirm the support
   task and owning head without taking its position or pen.
2. Declare its team slots using the controller's role meanings and supplied bindings.
   Use separate session-bound members; do not silently reuse another session's thinker
   or adviser as the same retained instance. A deliberately shared exception is explicit.
3. Discover existing instances before creating any. Verify native handle, coordinator
   binding, assigned session, role contract, capability and last checked source state.
   Reuse only compatible instances bound to this coordinator/session/role or covered by
   an explicitly authorized transfer/continuation. Addressability alone is insufficient.
   If creation is unauthorized, return the unbound slot rather than spawn.
4. Brief each requested member with its session boundary, one preparation question,
   named source slice, authority ceiling and expected compact return. Avoid inheriting
   unrelated parent history. Member output is evidence for coordinator checking.
5. Activate/read only requested slots, respecting current active-turn capacity. Other
   team slots may remain planned or idle. Do not report unread material consumed.
6. Verify readiness claims against cited owner/artifact passages. Return per session:
   coordinator/session/role bindings and handles, sources/revisions consumed, scoped
   prepared/qualified/held result, planned slots, gaps and exact next read pointer. A fully requested team is
   prepared only when all requested preparation reads/checks are accounted for.

Hold an affected binding for ambiguous owner/session, missing required evidence,
incompatible role or denied capability. Preparation is not project acceptance,
head launch, delivery permission or proof of survival after a new root.
