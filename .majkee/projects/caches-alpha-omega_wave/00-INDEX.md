# Cache and live session observation research workflow

Prepared for majkee by Wave on 30 October 2026. Version 0.1. Status: research design; experiments have not started.

The question is what information a running machine already holds, how it changes, and whether an agent can obtain useful context from it. The first bounded investigation concerns live CLI session state on Arch or Manjaro Linux. It compares existing records with observations of process memory before committing to an observer implementation or dedicated hardware.

The working decision is to build a small experimental substrate first. A negative result is useful: if transcripts and application interfaces already expose the required state, memory extraction adds no justified component.

## Reading and execution order

| Step | Document | Purpose | Completion result |
| --- | --- | --- | --- |
| 1 | [01 Scope and model](01-SCOPE-AND-MODEL.md) | Agree on the question and vocabulary | One target question and declared boundaries |
| 2 | [02 Hypotheses](02-HYPOTHESES.md) | Turn curiosity into falsifiable claims | Selected hypothesis and success criteria |
| 3 | [03 Phases and working sessions](03-PHASES-AND-SESSIONS.md) | Organize work without premature implementation | Current phase and next gate |
| 4 | [04 Experiments](04-EXPERIMENTS.md) | Run controlled comparisons | Repeatable observations and measurements |
| 5 | [05 Observer design](05-OBSERVER-DESIGN.md) | Describe the smallest justified observer | Implementable component contract |
| 6 | [06 Evidence and decisions](06-EVIDENCE-AND-DECISIONS.md) | Preserve evidence separately from interpretation | Inspectable run record and decision |
| 7 | [07 Current state and handoff](07-CURRENT-STATE-AND-HANDOFF.md) | Resume work without reconstructing the conversation | Updated next action and handoff |

Each document includes its purpose, inputs, actions, and completion condition. Read 01–03 before choosing an experiment. Use 06 while running any experiment. Treat 05 as a conditional design, not an instruction to build immediately. Keep 07 current between sessions.

## Research loop

1. Name one unknown.
2. State an observation that would support or contradict the hypothesis.
3. Choose the least intrusive interface capable of making that observation.
4. Record a baseline, a controlled intervention, and the result.
5. Separate observed bytes or events from inferred application meaning.
6. Decide: continue, narrow, reject, or implement.

A measurement establishes only what its coverage permits. Missing data can mean absent, inaccessible, excluded by capture, unsupported by the parser, or missed between samples.

## Initial boundaries

- Main platform: Arch or Manjaro Linux with KDE Plasma.
- First subject: an isolated local fixture, followed by one installed CLI and its required child processes.
- Baseline: session records, logs, terminal output, and available application interfaces.
- Added observation: selected process state, initially by an existing debugger or runtime inspector.
- Output: attributable observations and a timeline, not a claim to reconstruct unrecorded model reasoning.
- Hardware: the first observer runs as software on the same host. A separate device is an optional later deployment.

Windows, macOS, Android, iOS, Docker, Kubernetes, and local inference remain on the learning map. Add them after a useful question and a repeatable method exist.

## Wider learning track

Keep the original tutorial sequence alongside the experiments: memory and persistence; Linux kernel caches; files and desktop state; services and networking; containers and virtual machines; live CLI and inference state; other operating systems; agent reuse experiments. A session can begin with the relevant lesson and then test one claim from it. Passing the first CLI experiment does not establish conclusions about every cache layer.

## Navigation and portability

The Markdown files use relative links. Keep them together in one directory; the companion ZIP preserves that layout. Future run folders and code are proposed in 06 and are not included as completed implementations.
