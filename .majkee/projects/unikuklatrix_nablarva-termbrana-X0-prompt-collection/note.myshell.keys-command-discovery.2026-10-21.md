# Keyboard and command discovery — research for the Houston sitting

`status: working reading notes; UNCANONICAL; final research handoff is linked below.`
`prepared by: myShell / Cartan, 2026-10-21; requested by Majkee during architecture G3.`

**Final research and Oraculum handoff:** [Houston sitting brief](/home/hruzam/unikuklatrix/nablarva/.dev/session/nablarva-X3-architecture-sitting/raw/brief.keys-command-discovery.2026-10-21.md).
Majkee authorized folding the larger conclusion directly into the sitting raw/.
These personal notes retain the reading context; use that brief for the completed synthesis.

## What Majkee wants

Majkee currently has to learn different keys for each terminal, Termbrana, Ovitmugen/tmux
and editor view. He wants a whole-animal key/command view, generic patterns where possible,
HELP.md, and fast access beyond walking a deep menu tree. Linux, terminal, tmux and Sublime
facilities should be supported rather than accidentally shadowed. Command-palette-style
search is a candidate, alongside direct fast commands or bindings.

He previously discussed this with Ovitmugen's builder, but an electricity outage interrupted
the session. He deliberately did not restart that thread while the main architecture was
still unsettled. Keep this design open, but put it early on Houston's sitting agenda.

This request does not choose a/b/c for the existing G3 document-relocation question. The PAD
therefore stays at G3 with its answer unconfirmed while the requested research runs.

## Research boundary

- Inventory the existing claviature/key-help/palette mechanisms and the live Ovitmugen
  dependencies, using the actual local sources.
- Check current official host documentation for terminal key encodings, tmux dispatch and
  editor command/keymap contexts. Separate source facts from proposed architecture.
- Ask native Oraculum for a bounded critique of the resulting options and trade-offs.
- Return an evidence-backed discussion note for Majkee/Houston. No existing code, keymap,
  product contract, RUNBOOK, STATUS, deployed config or lock is changed by this research.

## Existing tension to resolve

The claviature spec says “derive, don't register”: shell commands are discovered from
actual definitions and grouped by registered families. Existing KEYS CODE normalizes TUI
meanings; it is not a registry of all active bindings. HELP.md is the curated prose layer.
A readable catalogue generated from owner maps may fit these rules; a separately maintained
list or a new authoritative action contract needs explicit consideration rather than
silently being declared equivalent.

The completed findings and Oraculum critique are folded into the linked sitting brief.


## Hypotheses added by Majkee — PC gamer patterns and ergonomics

Majkee asks that the research include familiar PC-gaming controls and ergonomic best
practices. These are candidate influences to investigate, not a choice of WASD or another
keymap. Familiarity, physical comfort, accessibility, consistency and native compatibility
may point in different directions.

Questions for the evidence review:

- Do familiar spatial controls reduce relearning in navigation-only views, and for whom?
- Can consistent action meanings and context-specific bindings reduce confusion better
  than enforcing identical chords through every host?
- What happens to text entry, alternate layouts, AltGr/IME use and one-handed operation?
- Do fewer simultaneous modifiers, shorter command paths or a searchable palette reduce
  effort/errors in actual work, and how do they affect accidental activation?
- Can visible hints and remapping support learning and direct access together?
- Which claims come from gaming/accessibility/HCI evidence, and which still need a local
  comparison in Majkee's terminal, tmux and Laravel/Sublime workflow?

No ergonomic benefit or universal gamer familiarity is presumed. Research will preserve
source scope and distinguish measured performance from preference or design analogy.


## Local findings — code and documents inspected

Read-only local source audit by Explorer, with the load-bearing source paths inspected by
myShell. No interactive UI, generator or product test was run for this research.

| mechanism | what exists | what it does not yet establish |
|---|---|---|
| [Global claviature](../../../../ia-sync/zsh/guides/claviature.global.spec.md) and [keys engine](../../../../ia-sync/zsh/ai/keys.zsh) | Derive current shell alias/function names, grouped by known families; unknown names remain visible. | No catalogue of physical bindings or focused-application contexts. The current family map lacks rb/ov/tn groups. |
| [command-palette wiring](../../../../ia-sync/zsh/ai/keyboard.zsh) and [ZLE adapter](../../../../ia-sync/zsh/ai/command-palette.zsh) | command-palette, Alt-k, palette-help and palette-refresh exist in source. Selection can be inserted into the shell buffer without executing it. | No whole-animal semantic action identities, context availability or shortcut display is established by that command-name map. Current live wiring/keypress behavior was not tested. |
| [Palette source registry](../../../../ia-sync/zsh/registries/palette.json) | Explicit source-folder selection for the generator. | session and termbrana are outside its current scopes. This is a real discovery-coverage gap; changing registry coverage is separate work with its existing owner. |
| [Palette freshness](../../../../ia-sync/zsh/ai/command-palette.zsh) | Plain command invocation can regenerate for newer zsh files. | The Alt-k adapter bypasses that call; registry/generator changes and deletions are not covered by the zsh-file timestamp rule. These are source findings, not demonstrated live failures. |
| [Runbook HELP](../../../../ia-sync/zsh/session/help/keys/HELP.md) | Named HELP.md scopes are discovered; local and cross-scope search exists in the reader. | The key legend explicitly says it is transcribed from dispatch code. No automatic whole-animal HELP.md maintenance was found. |
| [Accepted KEYS CODE](../../../../unikuklatrix/nablarva/PROJECT-DESIGN.md#keys-code) | Common TUI meanings, reserved tmux prefixes, local ownership and known deviations. | A rule in prose does not prove every running view conforms. The unfinished Ovitmugen basement plan already includes key normalization work. |

The key distinction is between an **action** (open, search, remove), a **command** that
implements it in a particular tool, a **binding** that invokes it in one context, and the
**help/search projection** used to discover it. A command palette can index names without
knowing that two bindings mean the same thing or collide in one host context.

The existing global palette therefore is useful prior work, rather than proof that the
whole requirement has been met. cs-palette is a different tool for cold-start cards; its
similar name does not identify the global command selector.

One candidate is an owner-derived catalogue: local command/binding sources retain their
truth, while a generated index feeds HELP.md and searchable command discovery. A second
candidate would introduce authoritative shared action metadata with per-host bindings.
The latter needs a deliberate owner/contract decision; it cannot be smuggled in by calling
all metadata merely generated. Neither candidate is selected by this note.


## Operator correction — palette belongs to the toolbox body

> BUT from now | here palette should part of body (maybe another window|pane but must be conected to used toolbox in that time).

Said: Majkee, during this research. Treat this as the current placement/relationship
requirement: command discovery is part of the toolbox being used. A separate pane or
window may present it, but the toolbox/context it serves must remain explicit. The
existing global shell palette is implementation prior art, not the chosen product layout.
The research must cover context-aware action availability and what happens if focus or
target context changes while the palette is open. A common command mechanism may still
be reused; the UI must not become an unconnected global launcher. No concrete pane,
transport, daemon or shortcut is selected by this correction.
