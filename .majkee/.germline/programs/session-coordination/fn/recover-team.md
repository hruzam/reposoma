---
program: session-coordination
function: recover-team
revision: 2026-10-23
stamp: 16bf5d46
---
# recover-team

Inputs: current coordinator/continuation context, selected session/team, last known
receipt and handles if any, current task, current owner/source pointers and authority
for native discovery/replacement.

1. Resolve current instructions, owner state and changed source identities. A dated
   receipt supplies pointers, not current project position or a child-tree restore key.
   Session selection comes from the current assignment or an explicitly authorized
   continuation; adopting the procedure does not adopt another coordinator's frame.
2. Inspect native availability. For each needed member, verify its actual binding,
   including coordinator/session/role and any explicit transfer/continuation authority;
   refresh a bounded changed-source slice. Native addressability alone does not prove
   that binding. Do not label a same-name new incarnation as the old instance.
3. Reuse available compatible members. For missing members, create a replacement only
   with authority, using the supplied role binding and current sources. Reconstruct
   the relevant task/evidence/dependency context; do not claim restored private memory.
   Unneeded slots remain idle or planned; do not recreate all roles automatically.
4. Return which members were reused, replaced, held or left planned; evidence of current
   sources and unresolved questions; and the next safe selected event. Check any old
   reply against source revisions before integrating it.
5. Return the dated recovery receipt in the reply. Persist it only when the caller
   supplies an authorized destination and write scope, using a compatible native writer.
   Preserve other writers and project doing-state. Missing native capability returns
   a reconnection requirement; this procedure cannot manufacture handles, persistence
   or a transport route.

Recovery concerns the support team's bindings. It neither restarts nor closes the
owning project session. A deliberate support-team detach stops its future dispatch;
closing a CLI/project session or deleting evidence requires separate authority.
