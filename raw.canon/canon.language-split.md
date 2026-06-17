---
status: promoted
promoted_by: "rewriting Cursor rules into Czech 2026-06-08, then governed by principal overwrites"
validated_by:
  - "a mixed-language human team × an English-comfortable principal — real need"
refined_by:
  - "2026-06-09 — challenger: mixed-language does not degrade comprehension, but output-language drifts in low-human-salience turns. Fix: mandatory output-language stanza."
  - "2026-06-09 — principal (governing): all persisted artifacts in English; non-English narrowed to a team-facing live surface."
  - "2026-06-11 — principal (governing): the live exception splits by audience. Principal ↔ any AI = English only. Non-English in live conversation is scoped to the human team ↔ their IDE agents."
expresses_as:
  - "everything written to disk is English — agent bodies, skills, hooks, rules, .md, plans, reports, memory, commit messages, PR descriptions"
  - "the principal ↔ any AI is English, live included"
  - "a human team ↔ their IDE agents may use their own language — ephemeral, non-persisted only"
  - "any persisted rule carries an explicit output-language stanza (drift guard for low-human-salience turns)"
commonized_from: "freya.devstudio/canon/canon.language-split.md (2026-06-17)"
---

# Language split

**English is the language of everything written to disk.** Every persisted artifact — agent
bodies, skills, hooks, rules, `.md` files, plans, reports, session memory, commit messages,
PR descriptions — is authored and maintained in English.

**Live, non-persisted conversation splits by audience:**

- **Principal ↔ any AI** (CLI, IDE, chat agents) — **English**, always. No exception.
- **A human team ↔ their IDE agents** — may use the team's own language. This is the one
  place a non-English live channel is permitted, and only while it stays ephemeral. The
  moment something is saved, it is English.

## Rule when in doubt

> Written to disk → **English**.
> Live turn between the principal and any AI → **English**.
> Live turn between a human team member and their IDE agent → mirror the human.

A project may carry one external exception (e.g. client-mandated comment language in the
product code); that is governed by the client's rule, not this one.

## Output-language stanza — mandatory for persisted output

Comprehension is language-agnostic for frontier models; persisted-output language is not. In
low-human-salience turns (commit messages, doc comments, autonomous multi-file edits,
agent→agent handoff) there is no human prompt to anchor language, so a model can drift a
team's spoken language into a committed artifact.

Therefore any persisted rule (agent body, IDE rule) MUST carry an explicit stanza:

> All generated output that is saved — code, file content, commit messages, PR descriptions —
> is written in English, regardless of the language of this conversation. (A project may
> declare one external exception for product-code comments.)
