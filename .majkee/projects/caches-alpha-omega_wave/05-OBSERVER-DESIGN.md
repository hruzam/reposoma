# Conditional design for a minimal observer

Purpose: define the component boundaries if experiments justify implementation. Inputs: a useful field, a validated extraction method, and resource measurements. Output: a small software observer with an explicit contract.

Status: proposed architecture. No collector, decoder, or device integration has been implemented by this package.

## Data flow

The target exposes records, an inspection interface, or selected memory. An adapter collects evidence. A decoder produces attributable observations. A writer preserves those observations and their evidence references. A reader or agent queries the resulting files.

Keep original captures separate from decoded observations. A decoder revision should be able to reinterpret retained evidence without rewriting the original capture.

## Components

| Component | Responsibility | Boundary |
| --- | --- | --- |
| Target resolver | Identify the chosen session's process set and start identities | No machine-wide memory scan by default |
| Source adapter | Read the selected interface and report collection coverage | No unsupported assumptions about other CLIs |
| Decoder | Interpret target-specific structures and report unknowns | No guessed field values |
| Evidence writer | Write captures, observations, and checksums | Does not modify the target's session files |
| Reader | Filter observations for the user or agent | Distinguishes observed, inferred, stale, and unavailable |

Start with a command-line process writing local files. A daemon, UI, database, streaming server, or remote device must answer a demonstrated requirement before being added.

## Adapter order

1. Existing structured session records or a supported application interface.
2. Explicit instrumentation when source and maintenance costs permit it.
3. Runtime inspector or debugger with object/type awareness.
4. Selected raw memory reads when the earlier methods cannot answer the question.

These are alternatives to evaluate, not wrappers that all must be stacked. A useful runtime snapshot may be an offline diagnostic mode rather than the continuous observer's main collection mechanism.

## Observation contract

Each observation needs a run ID, target process identity, source adapter and version, capture start/end, observation kind, value status, evidence reference, and any decoder limitation.

Use exact statuses such as observed, inferred, unavailable, and unsupported. Unknown is not an empty string or a false value. Memory addresses and object identifiers are implementation-local references, not portable session identity.

If a source has no stable event sequence, the observer may number its own observations; label those numbers as observer order, not target event order.

## Failure behavior

- Permission denied: report inaccessible; preserve the run as failed collection.
- Target exits: finish the run and stop collecting that identity.
- Partial or non-atomic read: report coverage and consistency limitations.
- Unknown schema or version: stop that decoder rather than silently mislabel fields.
- Collection falls behind: report gaps or dropped observations; keep bounded queues.
- Storage limit reached: stop or apply the declared retention policy; never report a truncated capture as complete.

Debugger attachment can pause execution. Runtime snapshots can block and consume substantial extra memory. Record those effects as part of the method, not as unexplained target latency. See S2–S5 in 01.

## Deployment progression

Stage A: same-host, manually invoked collection on the test machine.

Stage B: same-host sidecar process for selected sessions, with explicit start and stop.

Stage C: optional remote receiver for event storage and analysis. A small target-side collector remains necessary for local process access unless the target exposes an adequate remote interface.

Container or VM deployments introduce a new boundary: the collector must reach the relevant process namespace or guest. A receiver outside that boundary does not automatically observe its memory. Android and iOS require platform-specific evaluation before promising equivalent access.

## Completion condition

One selected field travels from the declared target through the adapter and decoder into an evidence-linked record. E2–E4 pass again on the implementation, including target exit and unsupported-version behavior.

Next: [06 Evidence and decisions](06-EVIDENCE-AND-DECISIONS.md). Return: [Index](00-INDEX.md).
