# 05 — Way of thinking

Nabla.Tmux handoff · 5 of 5 · method, not content

Components change; the questions at each junction don't. Run these questions whenever you add a component or a contract, whenever a failure surprises you, and before you automate anything a human approves today.

## The four questions

1. **What is this called outside our project?**
   Strip our vocabulary and name the plain pattern, e.g. "async request–reply over a spool", "mail delivery agent", "state machine". The conventional name makes decades of prior work searchable, for us and for agents.

2. **What is already solved?**
   Find the established practice and the documented failure modes for that pattern. Borrow other people's scars instead of earning your own.

3. **What is still open, and who has hit it?**
   Look for the complaints, not the answers. Where do practitioners still struggle, across user experience, developer experience and operations? What workarounds exist, and who wrote about them?

4. **What is genuinely ours?**
   Find the parts with no established answer. Spend invention here and only here.

Then decide. Proposals carry their reasons; the owner bends or vetoes. Record the decision, and the alternative that was rejected, in the relevant file.

## One research request for any scope

```
SCOPE:   <component, contract, or decision>
CONTEXT: <two lines: what we are building, and the constraint that matters>

1. CONVENTIONAL NAME: Which established patterns or terms describe this? Give 2–3.
2. SOLVED: For each, the standard practice, known failure modes and typical defaults. With sources.
3. OPEN EDGES: What do practitioners still complain about or work around?
   Split by users · developers · operations. Who hit it, and what did they do?
4. OFF-MAP: Which parts of our case have no established answer, and why not?

OUTPUT: (a) requirements to adopt · (b) risks to test · (c) questions only we can answer
```

Hand it to a research agent or run it yourself. Bend SCOPE and CONTEXT; keep the four sections.

## Worked example: the message layer (this handoff)

| Question | Answer |
|---|---|
| 1 · Name | async request–reply; message broker; mail transfer (submission, queue, delivery, bounce); Maildir spool |
| 2 · Solved | immediate accept/reject; temporary vs permanent failures (SMTP 4xx/5xx); `sysexits.h`; idempotency keys; at-most-once vs at-least-once delivery; timeouts and dead-letter queues; atomic rename; per-resource locks; bracketed paste |
| 3 · Open | how LLM agents read delivery notices; how TUIs handle input that arrives mid-turn; telling "stuck" from "thinking"; provider outages surfacing late |
| 4 · Ours | trust tiers from measured model behavior; a human content gate that promotes classes to auto-delivery on evidence; identity exposure between models (factionalism) |

Result: question 2 became requirements R1–R11 in 01, and question 3 became the "must test" lists in 02 and 03.

## Standing lenses (from decisions so far)

- Mechanism, policy and observation live in separate layers.
- Each dangerous effect has exactly one write path.
- Pull at the moment of asking; take history from events, not snapshots.
- Who *can* exist (definitions) is a different question from who *does* exist (liveness).
- Use verbs, not magic words: control goes through commands, not reserved text.
- Project names are for humans; conventional names are for code.
- Model behavior is measured, not designed: define the structure, test it, tier models by the results.
- When something belongs to another layer, park it instead of folding it in (e.g. event monitoring).
