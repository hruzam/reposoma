# Phases and working sessions

Purpose: organize sequential learning, experiments, and conditional implementation. Inputs: 01 and 02. Output: a phase decision and one concrete next action.

This is an effort outline, not a calendar booking or background automation. Work in sessions of roughly 45–90 minutes, adjusted for findings. Estimated sessions describe effort, not a promised completion date.

## Phase plan

| Phase | Estimated sessions | Work | Required output | Gate |
| --- | --- | --- | --- | --- |
| P0 Define the question | 1 | Explain memory versus cache; choose a target field and acceptable observation delay | Scope sentence and hypothesis card | The question has an observable answer |
| P1 Establish controlled truth | 1–2 | Build a small local fixture; create a separate ledger; measure record-only behavior | Fixture protocol and baseline run | The fixture and timestamps can be checked independently |
| P2 Observe one real CLI | 1–2 | Inventory version, process tree, records, interfaces; capture selected state | Channel comparison with attributable evidence | At least one justified extra observation, or a recorded decision to use existing interfaces |
| P3 Verify time and cost | 1–2 | Repeat trials; compare event coverage, latency, pauses, and resources | H2–H4 results | A useful observation survives correctness and cost checks |
| P4 Implement a minimal observer | 1–3 | Build only the selected adapter, collector, and evidence writer | One working vertical slice | A repeated scenario produces correct records end to end |
| P5 Evaluate and broaden | 1–2 | Test downstream value, then a second target if justified | H5/H6 decision and deployment choice | Continue, narrow, or close the investigation |

The rough total is 4–7 working sessions for research through P3, or 6–12 including conditional implementation and evaluation. These estimates depend on what passes the gates.

## How we work within each session

1. Start by reading 07 and the previous decision.
2. Spend the first few minutes clarifying the relevant concept.
3. Choose one uncertainty and its pass/fail observation.
4. Carry out only the experiment needed to reduce that uncertainty.
5. Inspect the actual evidence together.
6. End with a short decision, open uncertainty, and next action in 07.

Wave prepares explanations, protocols, scripts when that phase is reached, and evidence analysis. Majkee supplies the local-device context and performs steps that require his machine unless a suitable connection is already established. No observer is assumed to have access to the Arch host from this chat.

## Branches after P2

- Existing records or a supported API answer the question: implement a reader for those interfaces if useful. The investigation has succeeded without memory decoding.
- Memory adds a useful field: continue with the smallest target-specific decoder.
- A source modification exposes the field more cleanly: compare instrumentation cost with debugger extraction cost.
- Only raw fragments appear: narrow the claim and decide whether further reverse engineering is worth the effort.
- Permissions or runtime packaging block inspection: record an access limitation; do not call the hypothesis disproved.

## When to make a dedicated project

Create a repository when P1 produces a runnable fixture or when multiple people or agents need to share experiment state. Broaden it into a maintained observer project after useful added state, reliable interpretation, and acceptable cost are demonstrated.

Do not purchase a separate observing device before deciding which collection must occur on the target host. A remote receiver can store events, but moving the receiver does not itself grant access to another machine's process memory.

## Completion condition

The current phase has its required output and a written gate decision. If a gate fails, return to scope, choose a simpler interface, or close the branch. Advancing is not automatic.

Next: [04 Experiments](04-EXPERIMENTS.md). During runs: [06 Evidence and decisions](06-EVIDENCE-AND-DECISIONS.md).
