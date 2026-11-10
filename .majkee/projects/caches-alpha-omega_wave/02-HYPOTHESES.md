# Hypotheses and decision criteria

Purpose: make the research falsifiable. Input: the bounded question from 01. Output: a selected hypothesis, measurable endpoints, and an outcome that can change the design.

The criteria below are proposed pilot criteria, not measured performance or universal requirements. Freeze them before the run being evaluated. Record any later change with its reason.

## Hypothesis register

| ID | Hypothesis | Test | Evidence against it or reason to stop |
| --- | --- | --- | --- |
| H1 | Live inspection exposes a task-relevant state field earlier or more completely than the declared baseline | E1 then E2: compare the same named fields across capture channels | Every required field is already adequately available from the baseline in the tested conditions |
| H2 | A target-specific decoder can recover selected state with attributable meaning | E2: compare extracted values and relationships with controlled checkpoints | Only unlabelled strings are recoverable, or field errors exceed the chosen tolerance |
| H3 | Selected state changes can be observed as a sufficiently accurate timeline | E3: compare events and samples with the fixture ledger | Important transitions are missed, misordered, or cannot be timed within the required tolerance |
| H4 | The observer can operate within a practical resource and disruption budget | E4: compare baseline, lightweight observation, and intrusive capture separately | Latency, memory, storage, or pauses exceed the agreed budget |
| H5 | The adapter boundary supports a second implementation without rewriting the collector | E5: add a second runtime or CLI version | Application assumptions are embedded throughout the collector and cannot be isolated economically |
| H6 | The collected state improves a declared downstream decision | E6: compare baseline-only decisions with baseline-plus-observer decisions | Extra data adds cost without correcting relevant decisions or reducing uncertainty |

H1–H4 concern the first target. H5 concerns engineering portability. H6 concerns practical value. Success at byte extraction does not establish success at useful agent context.

## Initial fields to investigate

Select at most three for the first CLI experiment:

- Pending tool-call identifier and operation.
- Execution status at a controlled checkpoint.
- Result received but not yet represented in the declared persistent record.

These are candidate questions. No particular CLI is assumed to retain or expose them. If the chosen application never has the proposed intermediate state, replace that field before measurement.

## Proposed pilot criteria

- Correctness: every emitted exact field in the small controlled pilot matches its independent reference. Unknown or unsupported fields remain explicit rather than becoming guessed values.
- Added value: at least one preselected field is available at a useful checkpoint where the baseline is inadequate. A later transcript containing the same field can still leave a useful timing advantage, if that advantage was required in advance.
- Coverage: report recovered fields divided by fields known to be present at checkpoints that the capture actually covers. Report missing events separately from wrong values.
- Runtime mode: start with provisional ceilings of 10 percent added median task duration and 10 percent added peak target-plus-observer resident memory relative to the baseline. Report absolute values too. These budgets can be revised before a new comparison.
- Intrusive diagnostics: label heap/core capture as a separate mode; report pauses and peak memory even when that mode cannot meet continuous-observation budgets.
- Repetition: three repetitions per condition establish feasibility only. If promising, perform at least ten per condition and report individual results, spread, and failures. This remains exploratory evidence, not a general statistical guarantee.

## Outcome vocabulary

Use supported in tested conditions, contradicted in tested conditions, or inconclusive. Record the target version and capture scope with the outcome.

Inconclusive examples: permission failure, parser unsupported, capture window missed, reference unavailable. None establishes that the application contains no relevant state.

## Completion condition

Select H1 and one field for the first real CLI pilot, with the baseline and useful observation window declared. Add other hypotheses only as the work reaches their phase.

Next: [03 Phases and working sessions](03-PHASES-AND-SESSIONS.md). Return: [Index](00-INDEX.md).
