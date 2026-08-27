# Run-books Directory (`_runbook/`)

This directory is the **drafting bench** for run-books. A run-book may be drafted here before a
session exists; **promotion into the project's own session folder is what makes it live.** After
promotion the copy here is a template, never a second state store.

Process state — position, bus, pads, evidence — stays with the project. Pulling it into this hub
is how a project loses its own memory.

## Guide & Reference

The authoritative, brand-neutral manual for run-book shape:

- **[raw.guides/runbook/GUIDE.md](../raw.guides/runbook/GUIDE.md)** — the source of truth.
  Any brand (Claude, Codex, Gemini) reads this same file.

Companions, both leaves:

- **[raw.guides/handoff/GUIDE.md](../raw.guides/handoff/GUIDE.md)** — `HANDOFF.md`, the session's
  live position.
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
│ 	     	└── RUNBOOK.md # master file (partly PAD structure)
```

Only `RUNBOOK.md` is required. The other folders are born when something needs them, never
pre-created.

## Where a live session lives

```
<project>/<session-root>/<program>-<NN>-<phase>/
    RUNBOOK.md            fixed    — the instruction
    HANDOFF.md            present  — the position
    pad.<N>-<scope>.md    live     — human sittings
    _bus/                 past     — the exchange, only when ≥2 seats
```

**One session = one gate.** `<program>` groups siblings and is the wrapper — no wrapper folder.
Siblings, never nesting. Full rules in the GUIDE above.
