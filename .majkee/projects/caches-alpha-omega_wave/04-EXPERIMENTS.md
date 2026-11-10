# Controlled experiments for session observation

Purpose: provide runnable experiment designs without pretending the collection code already exists. Inputs: a selected hypothesis, an isolated test workspace, and the run record in 06. Output: evidence that supports, contradicts, or leaves the claim unresolved.

## Shared test setup

Use fresh, unique markers for each run and field. Keep an independent reference ledger outside the observed process. Inspect only the declared target process set; finding a marker in the observer's own buffers is not a target-memory discovery.

A local fixture should implement a known sequence: accept input, retain a structured field, begin a tool-like operation, receive its result, persist a record, release selected objects, and exit. Include controlled waits at checkpoints. The fixture ledger and observer output must be distinct evidence channels.

Cloud-model responses need not be deterministic. In a real CLI experiment, make the local tool behavior deterministic where possible and timestamp the actual transitions instead of assuming the model followed an exact script.

## E0 Prove the measuring setup

- Start the fixture and record its process identity and child processes.
- Hold it at a declared checkpoint with a known active field.
- Check that the reference ledger reports the expected state and that the baseline record can be read independently.
- Confirm which snapshot regions or runtime objects the capture method includes.
- Verify the observer stops when that process exits and does not follow a reused PID.

Completion: the team can distinguish a wrong decoder from a fixture or targeting failure.

## E1 Compare records and live state on the fixture

Run the controlled sequence with the baseline only, then under observation. Capture before a field is created, while it is active, and after it is persisted. Compare what each channel can establish at each checkpoint.

Use one marker that is never supplied to the target as a negative control. Use a marker definitely held in a reachable fixture object at a checkpoint as a positive control. A marker previously supplied and subsequently released is not a valid proof of complete erasure; remnants may remain.

Measure the time between the fixture event and its first observation in each channel. For sampled data, give the resulting interval of uncertainty, not an invented exact transition time.

Completion: a table of field, checkpoint, baseline availability, live availability, correctness, and timing uncertainty.

## E2 Transfer the question to one CLI

Record the installed version, runtime evidence, process tree, selected profile, and session sources. Choose one reproducible task with a controlled local tool pause. Observe before the tool begins, while it waits, after its result arrives, and after persistence when that boundary can actually be identified.

Compare record-only, supported application/runtime inspection, and raw memory inspection only where needed. Source inspection or explicit instrumentation may be required to identify the field.

Classify each finding as raw string, runtime object, or application field with verified relationships. A prompt string without object attribution does not count as recovered conversation state.

Completion: an H1/H2 result for one target version, including exactly what added state was found.

## E3 Measure timeline coverage

Generate a known sequence of start, wait, complete, and persist events with unique sequence numbers in the fixture. Include both long-lived and shorter-than-sampling-interval states. Compare observed ordering and missed transitions with the ledger.

Test quiescent snapshots separately from captures taken while the process changes. Repeated snapshots need not form an execution trace. Missing an intermediate state must not become a false claim that it never occurred.

Completion: event coverage, ordering errors, detection delays, and declared consistency limitations.

## E4 Measure observer effects

Compare baseline-only runs, lightweight continuous collection, and intrusive snapshots as separate conditions. Balance or randomize condition order and keep the workload and warm/cold-cache policy consistent. Record environmental differences rather than silently pooling them.

Measure task wall duration, target-plus-observer CPU consumption, peak resident memory, output bytes, and observed pauses. Record method limitations, especially transient peaks missed by sampling. Report failed and interrupted trials.

Completion: measured cost against the predeclared budgets. If the reference ledger itself adds overhead, that common baseline is explicit.

## E5 Test the adapter boundary

Select a second target or version. Reuse the collection envelope, evidence writer, and evaluation procedure. Change the target-specific adapter. Record any collector changes required and whether they reveal a faulty abstraction.

Completion: a portability decision with costs, not a claim of universal CLI support.

## E6 Test practical value

Choose a concrete question such as whether a tool is waiting, has completed, or failed. Evaluate an ordinary reader and the observer using the same independent reference. If an agent interprets the results, give both conditions equivalent instructions and count incorrect confident answers as well as correct ones.

Completion: a comparison of decision correctness, time, and cost. If the extra channel does not improve the chosen task, reject that use case even if extraction works.

Next: [05 Observer design](05-OBSERVER-DESIGN.md). Record every run using [06](06-EVIDENCE-AND-DECISIONS.md).
