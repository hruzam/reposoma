---
status: promoted   # gaveled by majkee 2026-06-19 (need-event: stabilize the bus before the context-economy codification returns)
captured_by: "design conversation 2026-06-19 — the per-author pulse bus + inbox/archive emerged from the two-writer collision analysis (Vega's bus proposal vs the 'two crews must not overwrite' constraint); majkee requested canonization before the context-economy codification returns"
expresses_as:
  - "the filesystem IS the state machine — no databases, no tracking tables, no vendor hooks"
  - "status log per stack, ONE writer per file: pulse.<brand>.md — everyone reads all, no one writes another's"
  - "deep proposals/arguments → _mail/<receiver>/{inbox,archive}/ ; fast status → the pulse bus (not _mail)"
  - "presence in inbox/ = unread; processed → `mv` to archive/ — the move IS the state transition"
  - "_mail/toAll/{inbox,archive}/ for broadcasts addressed to everyone"
  - "ask-first: do not auto-read inbox or RAG on boot — ask before reading on a quick run (token economy)"
  - "filename: <sender>.<topic>.<YYYY-MM-DD>.md ; carry host: provenance where it matters"
  - "collision-safety invariant: single-writer-per-file — the conserved property the whole bus rests on"
---

# Mail & status bus

A file-native message bus between collaborators (architects, crews, the principal). It rests on one
conserved property — **single-writer-per-file** — built from the cheapest UNIX primitives.

## Two surfaces, one rule
- **Status / "what I just did"** → the **pulse bus**: one log per stack, `pulse.<brand>.md`
  (`pulse.claude.md`, `pulse.gemini.md`, …). Each owner writes ONLY their own; everyone reads all.
- **Deep proposals / architectural arguments** → `_mail/<receiver>/{inbox,archive}/`.

## Inbox / archive — the filesystem as state machine
- Presence in `inbox/` **is** the unread state. No tracking table.
- When a memo is read and fully processed, the final action is `mv inbox/<memo>.md archive/`. The move
  **is** the state transition — crash-proof (a died task leaves the file in inbox; the next instance
  resumes it) and headless-safe (an invocation just reads whatever is in its inbox).
- `_mail/toAll/{inbox,archive}/` carries broadcasts addressed to everyone (e.g. "card expired").

## Why single-writer-per-file (the load-bearing invariant)
N writers on one file = last-writer-wins **clobber** — the same failure `canon.reflection-channels`
governs with a single synthesizer. The bus removes the hazard at the root: every write target has
exactly one owner. A shared file (e.g. an orientation `pulse.md`) is read-mostly; status that changes
goes in a per-author log. Cross-party notes go in *your own* log (they read it) or `_mail/` — **never by
writing another party's file.**

## Token economy (ask-first)
The bus never forces a read. On boot, do **not** auto-drain the inbox or eager-scan the RAG — ask first
("inbox/toAll has items — read now, or a quick run?"). Recalibration broadcasts arrive *to*
`_mail/toAll/inbox/` from a **native machine-layer script, never a vendor hook**.

> Siblings: `canon.pulse-heartbeat` (the now-file read first) · `canon.reflection-channels` (the
> clobber / single-synthesizer governor) · `canon.one-direction` (the human holds the gate) ·
> `canon.context-economy` (ask-first is also the starvation valve, not just thrift).
