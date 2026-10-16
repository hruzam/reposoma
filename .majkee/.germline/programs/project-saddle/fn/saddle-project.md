---
program: project-saddle
function: saddle-project
revision: 2026-10-16
stamp: a3ea5e32
---
# saddle-project

Inputs: explicit shortlist alias, task (`myShell-says:` or `task:`), task path/scope, actor and
authority (read-only if omitted). Read `project-entry`, `instruction-chain` and relevant named
`owner-state`. Output is a handoff to the current seat/operator; this function writes nothing.

1. Match the explicit alias exactly to the controller's shortlist. Verify the root is a directory
   and its mandatory AGENTS is readable. Resolve actual paths; if an alias/path changed meaning,
   escapes the declared project scope, or is missing, report it and hold. Do not search for a
   substitute root. If the task names no path, require an explicit project-wide/root scope.
2. Inspect the finite ancestor path to that root for applicable AGENTS, then read them and the
   mandatory project-root AGENTS in order. For each named task path, inspect each intervening
   directory's AGENTS through the task directory; a file uses its parent directory. Return the
   discovered chain, including absence of additional AGENTS where checked. Do not recursively
   scan unrelated subtrees. For a new path, use existing parents; unresolved traversal or boundary
   ownership holds the handoff rather than assuming missing instructions. Any later chosen path
   requires its own nested-chain check before use.
3. Follow the project's mandatory read order and named scope-specific references before preparing
   task handling. Honor existing ask-first/ownership gates on those reads; return the exact pending
   gate if one applies. Check current owner-state pointers required by this task. Do not follow
   arbitrary journal history or perform operations merely because an entry file mentions them.
4. Return `READY` only after required reads resolve: alias, verified absolute root, actual host,
   complete inspected AGENTS chain, required-read evidence, task words, scoped paths, authority,
   and next governing owner/read pointer. Missing/conflicting instructions or required state →
   `HELD` with exact path and missing decision/material; do not handle the blocked task.
5. Hand the task to the same seat under project instructions and user authority. READY is a
   checked context receipt, not task completion, write authorization, or permission to change
   session owners. Any journal fold is a separately requested continuity action.

Done when the caller has a checked project frame or a precise hold. No project file, registry,
journal, program, session, git index, or runtime surface changes during this function.
