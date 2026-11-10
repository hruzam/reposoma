# Evidence records and decision templates

Purpose: make each conclusion inspectable and resumable. Inputs: one experiment from 04. Outputs: a run record, preserved evidence, and an explicit decision.

## Proposed repository layout

Create this structure when experiments begin; it is not a claim that these run artifacts already exist.

```text
README.md
PROJECT_STATE.md
HYPOTHESES.md
DECISIONS.md
protocols/
fixture/
observer/
runs/<run-id>/manifest.json
runs/<run-id>/reference.jsonl
runs/<run-id>/observations.jsonl
runs/<run-id>/raw/
runs/<run-id>/analysis.md
```

Use JSONL for event-like records and ordinary files for larger captures. Start without a database. Put protocols, code, and concise decisions under version control. Large raw captures need a declared storage and retention policy; a checksum alone cannot reconstruct deleted evidence.

## Run record template

```markdown
# Run <id>

Hypothesis and experiment:
Target question and selected fields:
Protocol version:
Target executable, version, runtime evidence, and configuration:
OS and kernel:
Target process identities and parent/child relationships:
Baseline channels:
Observation channels and sampling policy:
Capture coverage and exclusions:
Fixture/task and unique marker references:
Warm/cold-cache policy:
UTC start/end and local timezone:
Monotonic clock source and units:
Clock relationship if more than one host:
Run condition and trial order:
Predeclared budgets and success criteria:
Raw artifact paths and SHA-256 hashes:
Measured correctness, coverage, timing, resources, and pauses:
Failures, gaps, and deviations:
Conclusion: supported / contradicted / inconclusive in tested conditions
Next action:
```

Use monotonic time for within-host elapsed time and UTC for human correlation. Do not directly subtract unrelated monotonic clocks from different hosts. Capture start and end bound an acquisition; they do not guarantee a simultaneous snapshot of every field.

## Observation envelope example

This is a proposed record shape with illustrative values, not observed output or an existing API.

```json
{
  "run_id": "example-run",
  "target": {"pid": 1234, "start_identity": "recorded-start-token"},
  "source": "fixture-adapter",
  "adapter_version": "0.1",
  "capture": {"clock": "host-monotonic", "start_ns": 100, "end_ns": 140},
  "kind": "tool_status",
  "status": "observed",
  "value": "waiting",
  "evidence_ref": "raw/capture-001",
  "limitations": []
}
```

For unavailable values, use an explicit status and reason. For inferred meaning, retain both the observation and the inference rule. Do not manufacture numeric confidence values without a calibration method.

## Source comparison template

| Field and checkpoint | Independent reference | Baseline result | Added observation | Timing uncertainty | Attribution and limitation |
| --- | --- | --- | --- | --- | --- |
| Selected field | Known fixture state or independently verified event | Available / missing / unknown | Exact result or explicit status | Interval or measured delay | Why the interpretation is justified |

Report field correctness and event coverage separately. Finding the same string repeatedly is not evidence of multiple target events.

## Decision record template

```markdown
# Decision <id and subject>

Question:
Evidence runs:
Observed facts:
Interpretations and assumptions:
Alternatives:
Decision: continue / narrow / reject / implement
Reason:
Scope and known limitations:
Evidence that would change the decision:
Next action and owner:
```

An inference may guide the next experiment; it must not silently become a measured fact.

## Raw capture handling

Process captures can include credentials and unrelated application data as well as synthetic markers. Keep collection limited to the declared test scope. Keep raw captures separate from the concise handoff; share derived test results by default. Retain enough evidence to audit the conclusion, with deletions and lost coverage recorded explicitly.

## Completion condition

Another reader can identify the exact question, target, protocol, evidence, observed limitations, and reason for the decision without reading the original chat.

Next: [07 Current state and handoff](07-CURRENT-STATE-AND-HANDOFF.md). Return: [Index](00-INDEX.md).
