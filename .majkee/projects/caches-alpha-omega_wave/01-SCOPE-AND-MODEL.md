# Scope and model for observing live session state

Purpose: agree on what is being studied before choosing tools. Input: the running-session questions in this conversation. Output: a bounded target and a vocabulary that separates storage, behavior, and evidence.

## Main question

Can an observer obtain useful, attributable live session state that an agent cannot already obtain adequately from ordinary session records and application interfaces?

Useful means answering a declared question, such as which tool call is pending, which request is being assembled, or whether a result has arrived but has not been persisted. Finding a copy of a prompt is not enough on its own.

## Distinctions

| Term | Meaning in this investigation |
| --- | --- |
| Process memory | The virtual address space and allocations used by a program; some pages may not currently reside in physical RAM |
| Cache | Retained data or results intended for reuse |
| Buffer | Data held while being transferred or accumulated |
| Live state | Objects and execution status currently maintained by an application |
| Persistent record | Saved history, logs, databases, or files |
| Snapshot | A capture with a stated time interval, scope, and consistency limitation |
| Event trace | A sequence of observations collected while execution proceeds |
| Interpretation | A claim about what a byte range, object, or event means |

The target is a logical session, potentially spanning several processes. A PID is one participant, not automatically the whole session. Identify processes using PID plus process start information; PIDs can be reused.

## Established technical starting points

Linux exposes memory mappings and accounting through procfs. Process-memory reads and debuggers can access selected memory subject to system permissions. Raw reads need not be atomic. Runtime inspectors can provide more structure than raw bytes. Core dumps preserve selected process memory and status; dump filters can exclude mappings. See the primary references below.

There is no universal parser that turns arbitrary process memory into a CLI session. Identifying fields requires runtime knowledge, application knowledge, or explicit instrumentation. Debug information may help; its absence does not make every observation impossible.

For cloud-backed inference, local client memory and remote inference state are different subjects. This first study observes the client. Local model weights, GPU memory, and KV tensors would require a separate target and capture method.

## First bounded scope

Start with a fixture whose state transitions we control. Next, select one CLI by installed version, inspect its architecture, and declare the exact process set and question. Do not assume all named CLIs use the same runtime or storage layout.

Use an isolated test account or profile with synthetic messages and a temporary project. The observer reads selected targets and writes its own evidence. Debugger attachment may pause execution even if no application memory is intentionally modified.

## Primary reference register

These references establish available mechanisms, not verified behavior of a particular installed CLI.

- S1: [Linux procfs documentation](https://docs.kernel.org/filesystems/proc.html) — memory maps, accounting, and process interfaces.
- S2: [Linux process_vm_readv manual](https://man7.org/linux/man-pages/man2/process_vm_readv.2.html) — memory reads, access checks, partial transfers, and lack of atomicity.
- S3: [GDB core file generation](https://sourceware.org/gdb/current/onlinedocs/gdb.html/Core-File-Generation.html) — process snapshots and excluded mappings.
- S4: [Node.js heap snapshot guide](https://github.com/nodejs/learn/blob/main/pages/diagnostics/memory/using-heap-snapshot.md) — object inspection and snapshot comparison when the target uses Node.js.
- S5: [Node.js V8 API](https://nodejs.org/api/v8.html) — isolate-specific heap snapshots, blocking, and memory overhead.
- S6: [strace manual](https://man7.org/linux/man-pages/man1/strace.1.html) — system-call and signal observation.
- S7: [Linux memory management concepts](https://docs.kernel.org/admin-guide/mm/concepts.html) — page cache, anonymous memory, and reclaim.

Record the installed tool versions when beginning a run. Recheck the relevant reference before selecting version-dependent commands. Add CLI-specific source references when a target is selected.

## Completion condition

Write one sentence naming the target question, one selected process set, one baseline source, and one proposed extra observation. If any is still undefined, remain in scope discovery.

Next: [02 Hypotheses](02-HYPOTHESES.md). Return: [Index](00-INDEX.md).
