Exactly. The **testing laboratory is the place where the hacker method belongs**.

It should be separated from the production path:

```text
laboratory                           production
──────────                           ──────────
observe everything permitted        observe only proven signals
run invasive tracing                minimal runtime instrumentation
compare competing extractors        one selected extraction pipeline
retain experimental features        stable normalized events
infer hypotheses                    enforce conservative rules
```

The laboratory’s job is not to clean live communication reliably. Its job is to **discover how each CLI actually behaves**, then turn discoveries into narrow, tested production rules.

## Laboratory loop

```text
controlled scenario
      ↓
capture all observable layers
      ↓
correlate events by time and process
      ↓
form a hypothesis
      ↓
repeat with changed conditions
      ↓
promote proven rule into adapter
```

For example:

```text
Hypothesis:
Reading SKILL.md means a skill was activated.

Experiment A:
Start CLI without invoking the skill.

Experiment B:
Invoke it explicitly.

Experiment C:
Ask a task that should select it implicitly.

Experiment D:
List available skills but do not use one.
```

The result may reveal:

```text
SKILL.md read during startup       → discovery only
SKILL.md read after prompt         → probable activation
native Skill event + file read     → confirmed activation
bundled script launched afterward  → skill execution phase
```

That is much stronger than reasoning from one captured session.

## What the laboratory should capture

One experiment should produce a synchronized bundle:

```text
experiment/
├── manifest.toml
├── prompt.txt
├── environment.json
├── versions.json
├── pty.raw
├── terminal-events.ndjson
├── native-events.ndjson
├── processes.ndjson
├── files.ndjson
├── syscalls/
├── expected.md
├── observations.md
└── conclusion.md
```

`manifest.toml` identifies:

* CLI and version;
* adapter version;
* repository fixture;
* terminal dimensions;
* enabled skills;
* MCP configuration;
* experiment question;
* expected observable behavior.

This makes the experiment repeatable after a CLI update.

## Two distinct laboratory modes

### Behaviour mapping

Discover what signals exist:

* skill discovery and activation;
* tool invocation;
* subprocess creation;
* file loading;
* prompt boundaries;
* final-answer boundaries;
* errors and interruptions;
* compaction or context resets.

### Extractor evaluation

Feed the same captures through different pipelines:

```text
hard filters only
terminal-state reconstruction
stateful driller
statistical scorer
experimental semantic classifier
```

Then compare them against a human-approved clean output.

The original capture remains immutable, so every new driller version can be evaluated against the same evidence.

## Promotion rule

A laboratory discovery should enter production only when it has:

1. a repeatable fixture;
2. a precise observable signal;
3. a known failure case;
4. a conservative fallback;
5. a regression test.

For example:

```text
Experimental finding:
The last terminal row is usually a status bar.
```

That is not sufficient.

A promotable rule might be:

```text
In Codex version family X, while a turn is active, a fixed-width row
at the bottom of the alternate screen is repeatedly replaced and disappears
before the final prompt. Mark it as UI status, but preserve it as unknown
if it contains an error pattern.
```

That is constrained, testable, and reversible.

## Architectural place

I would name the development subsystem something like:

```text
nabLarva laboratory
├── probe       — captures signals
├── fixtures    — repeatable scenarios
├── replay      — reruns extractors over captures
├── compare     — calculates differences and metrics
└── promote     — exports proven adapter rules
```

The production adapter consumes only the promoted results:

```text
laboratory evidence
      ↓
versioned profile + tested transforms
      ↓
agent adapter
      ↓
clean nabLarva event
```

So yes: your original statement was not proposing that every live session should run under `strace` and experimental tensor processing. You were proposing **empirical reconnaissance before fixing the architecture**.

That is the right move. It also answers the earlier concern about over-engineering: we do not decide in advance whether the final solution is five hard filters or a sophisticated driller. The laboratory generates the evidence that decides.
