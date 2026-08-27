# Run-books Directory (`_runbook/`)

This directory is the **drafting bench** for run-books. A RUNBOOK may be drafted here before a
session exists; **promotion into the project's own session folder is what makes it live.** After
promotion the copy here is a template, never a second state store.

Process state — position, bus, pads, evidence — stays with the project. Pulling it into this hub
is how a project loses its own memory.

## Guide & Reference

The authoritative, brand-neutral manuals — each file shape has its own GUIDE, all leaves:

- **[raw.guides/runbook/GUIDE.md](../raw.guides/runbook/GUIDE.md)** — `RUNBOOK.md`, the session
  launcher + the session rule. The source of truth for this bench.
- **[raw.guides/status/GUIDE.md](../raw.guides/status/GUIDE.md)** — `STATUS.md`, the session's
  bounded recovery snapshot (sole doing-state per gate).
- **[raw.guides/bus/GUIDE.md](../raw.guides/bus/GUIDE.md)** — `_bus/`, the multi-seat
  POINT · RETURN · VERDICT exchange.
- **[raw.guides/PAD/GUIDE.md](../raw.guides/PAD/GUIDE.md)** — operator step-pads.

`../GEMINI.md` is **not** a rulebook — it is Proxima's local address card and points here.

## Storage principle — the bench

```tree
├── <project-name>
│ 	 └── <slug>
│ 	     	├── raw   # raw: idea substrate ~brief ~brainstorming
│ 	     	├── res   # resources: extending chapters
│ 	     	├── _<{package}, something to process first}>
│ 	     	├── scr   # scripts
│ 	     	└── RUNBOOK.md # master file
```

Only `RUNBOOK.md` is required. The other folders are born when something needs them, never
pre-created.

## Where a live session lives

```
<project>/<session-root>/<program>-<NN>-<phase>/
    RUNBOOK.md            fixed    — the instruction
    STATUS.md             present  — the position (sole doing-state for the gate)
    dock.md               scratch  — uncanonical handwriting, prunable (flag L9)
    pad.<N>-<scope>.md    live     — human sittings
    _bus/                 past     — the exchange, only when ≥2 seats
```

**One session = one gate.** `<program>` groups siblings and is the wrapper — no wrapper folder.
Siblings, never nesting. The project's `pulse.md` is a bounded router (slug · gate · STATUS
path); two files are allowed, two authorities are not. Full rules in the GUIDEs above.
