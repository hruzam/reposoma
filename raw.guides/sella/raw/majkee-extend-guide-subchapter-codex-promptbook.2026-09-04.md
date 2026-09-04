# cratan recommendations

>about adding subchapter here: THIS slug + res/ and add to GUIDE subchapter list.

---


According to OpenAI Docs (https://learn.chatgpt.com/docs/agent-configuration/subagents), custom
  agents are selected by their configured name. Here are promptbook-ready versions.

  ### Strict single-subagent execution

  Subagent execution requirement:

  You MUST delegate this task by calling the subagent spawning tool with:

  agent_type: <AGENT_NAME>

  Do not role-play the agent or execute the task yourself. The controller may inspect,
  coordinate, wait, and summarize, but must not modify files.

  Give the spawned agent ownership of:
  <FILES OR RESPONSIBILITY>

  Task:
  <TASK>

  Acceptance criteria:
  <EXPECTED RESULT>

  If the exact agent type cannot be spawned, stop and report FAIL; do not silently use
  the default agent or complete the task yourself.

  Wait for the agent to finish, then report:
  1. PASS or FAIL
  2. canonical spawned task path
  3. exact agent type used
  4. files changed
  5. verification evidence
  6. remaining blockers

  ### Astrobley implementation

  Run this task through the exact installed custom agent type `astrobley`.

  The controller is not permitted to implement or edit files. It must call the subagent
  spawning tool with `agent_type: astrobley`. A prose simulation of Astrobley is not
  acceptable.

  Astrobley owns:
  <FILES OR MODULE>

  Task:
  <TASK>

  Required verification:
  <COMMANDS OR OBSERVED BEHAVIOR>

  Do not commit, push, deploy, or modify unrelated files.

  If Astrobley cannot be spawned or cannot complete the task, stop and report the blocker.
  After completion, provide the canonical task path, changed files, and verification output.

  ### Implement, then independently verify

  Use two sequential custom agents:

  1. Spawn `implementer` to make the scoped change.
  2. After it finishes, spawn `verifier` with fresh context to inspect the resulting diff
     and test the acceptance criteria.

  The controller owns coordination and synthesis but must not edit files.

  Implementer ownership:
  <FILES>

  Task:
  <TASK>

  Acceptance criteria:
  <CRITERIA>

  The verifier must not fix anything. It must return PASS or FAIL with concrete evidence.
  If verification fails, stop and report the findings unless I explicitly authorize another
  implementation pass.

  Report both canonical task paths and both agents’ results.

  ### Read-only researcher

  Do not investigate this directly. Spawn exactly one custom agent using
  `agent_type: researcher`.

  The researcher is read-only. It must distinguish:
  - observed local facts
  - facts from authoritative sources
  - inferences
  - unresolved uncertainty

  Research question:
  <QUESTION>

  No files may be modified. Wait for completion and return the canonical task path,
  sources, findings, and confidence.

  ### Parallel independent review

  Spawn these agents in parallel because their scopes are independent:

  - `architect`: inspect <ARCHITECTURE QUESTION>, read-only
  - `challenger`: challenge <PROPOSED DECISION>, read-only
  - `researcher`: verify <EXTERNAL OR VERSIONED FACT>, read-only

  Do not let agents edit files or duplicate one another’s scope. Wait for all three.
  Report each canonical task path and result separately, then synthesize agreements,
  disagreements, and the recommended next action. Do not implement.

  For UI verification, look for:

  Started `/root/<task-name>`
  Completed `/root/<task-name>`

  Expand the spawn event when possible and check that it says:

  agent_type: astrobley

  The most important catch for your promptbook is:

  A prose simulation of the named agent is not acceptable. You must call the subagent
  spawning tool with `agent_type: <exact-name>`. If unavailable, stop and report FAIL.