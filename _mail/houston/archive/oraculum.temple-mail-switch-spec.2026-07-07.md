---
from: reposoma:oraculum
to: reposoma:houston
scope: temple-mail-switch-spec
date: 2026-07-07
host: office
---

# TASK — `temple-mail-switch`: central interactive mail picker (craft-layer)
**Gavel state:** operator go (majkee, session 2026-07-07 — "process all of it"). No gate crossed:
craft-layer tool, 0010-adjacent (read-side must bind to the inbox *interface* per R-b).
**Executor:** @Trajectory (dispatched same session by @Oraculum)
**For the board:** gemini-line row is separate; this is temple transport. Board it under
workflow/transport, not gemini.

## Governing insight
The "central registry of mail destinations" majkee asked for **already exists as two layers that
must not be duplicated**: `temple-project-map.zsh` (P0 — the only home of physical paths, 0004 L4)
enumerates projects; `<root>/_mail/*/` enumerates each project's seats. Seat-name collisions
across projects are already solved by `<origin>:<agent>` addressing. The only missing piece is the
interactive front-end. **Derive at runtime; register nothing.**

## Build
`~/.config/zsh/ai/temple-mail-switch.zsh` — zsh, same conventions as `temple-mail.zsh` /
`temple-mail-inbox.zsh` (source-able, function-based, sources P0 map if absent).

### Interface
```
temple-mail-switch [--project <origin>]
```
- Candidate lines: `origin:agent` — built by iterating `TEMPLE_PROJECT_MAP` keys, resolving roots
  **only** via `temple-project-root` (skip roots that fail resolution — other-host projects),
  listing `<root>/_mail/*/` dirs (include `toAll` as `origin:toAll`).
- `--project <origin>` → restrict to that project's seats. Default: all P0 projects.
- Picker: `fzf` with `--preview` = the newest file in `<root>/_mail/<agent>/inbox/`
  (`head -40`; frontmatter makes it self-describing). Unread-first ordering **if and only if**
  `temple-mail-inbox.zsh` exposes a read-state convention — READ that script first and reuse its
  interface/convention; do NOT invent a second read-state or a second read-path (0010 R-b).
- Selection → print the `origin:agent` address to stdout, nothing else. Composable by design:
  `temple-mail $(temple-mail-switch) <scope> <body>`.
- ESC/empty selection → exit 1, no output.
- No fzf on host → degrade to a numbered `select` menu (no preview), same output contract.

### Invariants (hard)
1. No physical path anywhere except via `temple-project-root` (0004 L4).
2. Read-side goes through the `temple-mail-inbox` interface/conventions where they exist (0010 R-b).
3. Read-only tool: never writes mail, never touches read-state, never mkdirs.

### Out of scope
Cross-machine anything (P0 map is per-host by design) · DB/mail-fold projection (workflow-spine
step 2 owns that) · changes to `temple-mail.zsh` write path · new read-state mechanics.

### Acceptance
- `temple-mail-switch --project reposoma` lists reposoma seats incl. toAll; preview shows newest
  item head on cursor line.
- Full run (no filter) lists seats from ≥2 projects, addresses correctly namespaced.
- Output of a selection is exactly `<origin>:<agent>` (round-trips into `temple-mail`).
- ESC exits clean (code 1, empty stdout). Missing-fzf degrade path works.
- One file-map row added to `~/.config/zsh/ai/README.md`. Nothing else edited.
