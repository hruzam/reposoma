---
title: Codex subagent call — the exact-agent_type promptbook
chapter-of: sella
scope: sella
audience: agent + operator + builder
machine: both
verified: 2026-09-04
half_life_days: 90
recheck: "WEATHER (Sella L8): the volatile facts are the OpenAI/Codex subagent-config docs (URL below), the exact spawn-tool name, and how a custom agent_type is resolved. Re-verify against the dated live source before trusting a pinned claim; refresh the file + re-stamp verified, never hand-patch a version."
verify_cmd: "open https://learn.chatgpt.com/docs/agent-configuration/subagents  # Cartan-provided; dated live source is authority per L8"
source: "Cartan (Codex co-architect) recommendations — raw/majkee-extend-guide-subchapter-codex-promptbook.2026-09-04.md"
---

# Codex subagent call — the exact-`agent_type` promptbook

_A subchapter of Sella. Where the relay contract owns TRANSPORT (quote-safety, exit codes,
verbatim/foreground — `~/.config/zsh/guides/codex-relay.contract.md`) and `codex-builder-user`
owns Codex CLI mechanics, THIS chapter owns the INVOCATION PROMPTBOOK: how to phrase a spawn
order on the Codex line so the controller **delegates to a named custom agent** instead of
role-playing it._

> ⛅ **WEATHER — check from time to time.** This chapter leans on OpenAI/Codex subagent-config
> docs (`https://learn.chatgpt.com/docs/agent-configuration/subagents`, Cartan-provided) and on
> vendor spawn-tool semantics — all volatile. Per Sella **L8 (the compiler is a moving target)**
> the dated live source wins over any pinned claim here. `/guide` will prepend a stale-card banner
> once the half-life (90d) passes; when it does, re-synthesize from the live doc — do not
> hand-patch. Sella never claims frozen authority over facts it does not track.

## The load-bearing catch (read this first)

**A prose simulation of the named agent is NOT acceptable.** The controller must call the
subagent-spawning tool with `agent_type: <exact-name>`. If that exact agent type cannot be
spawned, **stop and report FAIL** — never silently fall back to the default agent, and never
complete the task in-controller as if you were the agent.

Sella framing:
- **L1 (right contract, right layer)** — "delegate, don't role-play" is an IDENTITY declaration,
  so it belongs in the ORDER the controller receives, stated imperatively, not buried in prose.
- **L4 (exit/output contract)** — every pattern below closes with an explicit PASS/FAIL shape and
  a required report. A spawn that cannot name its agent_type is a FAIL, not a soft continue.
- **L9 (anchors, not full reads)** — the controller coordinates, waits, and synthesizes from the
  spawned agent's report; it does not re-do the work to "understand" it.

Per OpenAI docs, custom agents are selected by their configured **name**. The templates below are
promptbook-ready — fill the `<PLACEHOLDERS>` and paste.

---

## Strict single-subagent execution

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

---

## Astrobley implementation

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

---

## Implement, then independently verify

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

Report both canonical task paths and both agents' results.

---

## Read-only researcher

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

---

## Parallel independent review

Spawn these agents in parallel because their scopes are independent:

- `architect`: inspect <ARCHITECTURE QUESTION>, read-only
- `challenger`: challenge <PROPOSED DECISION>, read-only
- `researcher`: verify <EXTERNAL OR VERSIONED FACT>, read-only

Do not let agents edit files or duplicate one another's scope. Wait for all three.
Report each canonical task path and result separately, then synthesize agreements,
disagreements, and the recommended next action. Do not implement.

---

## UI verification (spawn actually happened)

For UI verification, look for:

Started `/root/<task-name>`
Completed `/root/<task-name>`

Expand the spawn event when possible and check that it says:

agent_type: astrobley   # (or the exact name you ordered)

The most important catch for your promptbook: a prose simulation of the named agent is not
acceptable. You must call the subagent spawning tool with `agent_type: <exact-name>`. If
unavailable, stop and report FAIL.

---

## Cross-references (point, never copy)

- `~/.config/zsh/guides/codex-relay.contract.md` — relay TRANSPORT (quote-safety, exit codes,
  verbatim/foreground). This chapter is the ORDER shape; the contract is the wire.
- `~/ia-sync/HANDSHAKE.md` §"Seat transfers" — astrobley is the Codex line's senior implementer
  (crossed vendor 2026-09-01); vega = blind relay, mirror = adversarial.
- Claude-side cognates: the "spawn a real agent, don't simulate" discipline mirrors @assay
  (fresh-context verifier, PASS/FAIL, does not fix) and the relay seats' verbatim contracts.

---

_Subchapter forged 2026-09-04 from Cartan's recommendations · weather-flagged (L8) · source in
`raw/majkee-extend-guide-subchapter-codex-promptbook.2026-09-04.md`._
