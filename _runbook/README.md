# Run-books Directory (`_runbook/`)

This directory is the storage location for all project-specific run-books in the workspace.

## Guide & Reference
The authoritative manual for how run-books are structured and maintained in this workspace is stored in:
- **[GEMINI.md](../GEMINI.md)** (Root Workspace Rulebook)
- **[raw.guides/runbook/GUIDE.md](../raw.guides/runbook/GUIDE.md)** (Mirrored Guide)

## Run-book Storage Principle
Run-books are stored according to the following generic shape principle:

```tree
├── <project-name>  # e.g., ia-sync                 
│ 	 └── <slug>
│ 	     	├── raw   # raw: idea substrate ~brief  ~brainstorming
│ 	     	├── res   # resources: extending chapters
│ 	     	├── _<{package}, something to process first}>
│ 	     	├── scr   # scripts
│ 	     	└── RUNBOOK.md # master file (partly PAD structure)
```

Refer to the main guide links above for details on the `RUNBOOK.md` structure, journal guidelines, and cold-start cards.
