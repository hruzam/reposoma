# Material inbox — disposable copies to knowledge

Put a batch of **copies** in `media/<batch-id>/` below this folder. Any image names
are fine: screenshots, photographed notes and other pictures can be mixed. Pick a
new batch ID; a date alone is not required. `media/` and `private/` are Git-ignored.

Then ask myShell:

```text
ctrl material-intake&process-batch :
batch: projects/material-inbox/media/<batch-id>;
priorities: <subjects you care about, or omit>;
consultant: auto
```

This invocation authorizes the entire named batch's processing and cleanup. Everything
in this designated image inbox must be a disposable copy: myShell may remove personal,
irrelevant, duplicate or extracted images and retain only images needed as evidence.
Your phone and originals elsewhere are outside the cleanup scope. Dropping files here
without an invocation starts nothing.

A narrower live request such as “review only,” “retain all” or “no deletion” overrides
that default. Review-only produces a report without writing notes or receipts.

The procedure produces thematic Markdown under `../<subject-slug>/`, separates
useful/unproven/rejected material, and links it from a receipt and technical item
index under `batches/<batch-id>/`. It keeps the complete input inventory and cleanup
log under `private/<batch-id>/`. Extracted material is backlog, not an active work queue.

Routine worker: Terra/medium, with Sol/medium as the ceiling. An optional Astrobley
or Oraculum consultant advises under its own current TOML contract. myShell retains
integration and deletion responsibility. `consultant: none` skips that slot.

For interruption/re-entry, invoke the same batch again and read its existing receipt.
The procedure resumes from checked evidence; it does not overwrite the old inventory
or assume agent instances survived.

Authoritative local procedure:
[material-intake controller](../../.germline/programs/material-intake/CONTROLLER.md).
This is manual prompt guidance, not a shell command or automatically installed skill.
