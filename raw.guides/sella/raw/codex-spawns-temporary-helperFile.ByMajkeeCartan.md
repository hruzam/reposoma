# CODEX SUBAGENTS

You request this inside the Codex conversation, not
  through a terminal command. For example:

  Spawn one native subagent for this bounded task.

  agent_type: default
  model: gpt-5.6-terra
  reasoning_effort: medium
  fork_turns: none

  Task: add to runbook tool this special help window similar as B (board). 
  - syntax press `H` or 2x`H` or some popular known one keyboard. Also want for this tool its own registry source, which can help me estabilish key map (I do not know) will load guide, its res/ + volatile part chapters, which will be checked according routine cold start card (researchers) -- this will provide calude CLI agent epoch or any codex build (has no name now, can we call him  ).
  Scope: read-only, [exact paths].
  Return: findings with evidence and any uncertainty.

  Remain the parent/controller. If the requested model
  cannot
  be selected, report that instead of silently
  substituting.

  For a stronger child, change only:

  model: gpt-6-astra
  reasoning_effort: high

  Three important distinctions:

  1. Model selects Luna/Terra/Sol/Astra; reasoning effort
     selects how much thinking that model uses.

  2. Your named agents already have settings: implementer
     = Terra/high, architect = Sol/xhigh, astrobley = Sol/
     high. Those role configurations take precedence; use
     default for the flexible examples above.

  3. Here, fork_turns: none permits the model override and
     gives the child only its task brief. Full-history
     forks inherit the parent’s model and effort.

---

A subagent can use skills too. The reliable approach is
  to name the required skill in the child’s task—not
  merely activate it in the parent.

  There are three separate steps:

  1. Available: the child can discover enabled skills in
     its environment. Skill configuration normally
     inherits from the parent unless the custom agent
     overrides it. Subagent configuration

     (https://learn.chatgpt.com/docs/agent-configuration/subagents)

  2. Selected: its task explicitly names a skill, or the
     task matches the skill’s description.

  3. Applied: the child reads the full SKILL.md, follows
     its required references, and uses that procedure.
     Catalog presence alone is not activation. Skill
     activation
     (https://learn.chatgpt.com/docs/build-skills)

  For example, you could tell the parent:

  Spawn one native default subagent:
  model: gpt-5.6-luna
  reasoning_effort: medium
  fork_turns: none

  Include these instructions in the CHILD'S task:
  Use the guide skill in consult mode.
  Read its full SKILL.md before doing the task.

  Task: Compare [exact STATUS path] with the applicable
  runbook
  and status guidance. Report inconsistencies with
  evidence.

  Read-only. Do not replace STATUS, become the head, or
  dispatch
  other agents. Report the skill path actually read.
  If the skill is unavailable, report that limitation.

  fork_turns: none means no inherited conversation
  history, not “no skills.” Give the child the needed
  task, paths, constraints, and skill names explicitly.

  Your custom agents can also require skills permanently.
  This already exists locally: codex/agents/
  harness_builder.toml:13 instructs that agent to use
  codex-harness for every task. That is a role instruction
  —not a separate skill-spawning mechanism.

  For our roster, the important boundary is:

  - Parent using Medusa: does not mean every child should
    use Medusa.

  - Implementation child: gets implementation procedures.
  - PAD-driving child using Polyp: gets Polyp’s restricted
    procedure, but does not automatically acquire STATUS
    ownership.

  Model, role, and skill are separate choices. A Luna
  child can read the same skill as an Astra child; correct
  application still needs verification. I haven’t run a
  child activation test here.
