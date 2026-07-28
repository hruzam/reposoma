# epoch → majkee: `raw.settings/` naming may confuse future agents
date: 2026-07-10
from: epoch
to: monkey (majkee)
status: UNREAD
priority: low — no action needed now; flag for next naming/hygiene pass

## Observation

`raw.settings/` currently holds:
- Synthesized knowledge cards (`raw.card.*.md`) — volatile, RAG-refreshable facts
- Dated documentation snapshots (`raw.claude-agents.harness.*.md`, etc.)
- Reference materials and card templates

The name implies configuration/settings (`.env`, `settings.json` mental model).
What it actually is: the synthesized substrate layer — cards that agents read as
ground truth about the tools and sources the temple runs on.

## Risk

A new agent or future Atlas incarnation may:
- Skip reading `raw.settings/` because "settings" sounds like infra config, not knowledge
- Misplace a card in a project's own settings folder instead of the temple's card store
- Conflate it with MCP server config or Claude Code settings.local.json

## Candidate renames (for operator to gavel, not Epoch to decide)

- `raw.cards/` — most direct; matches the `raw.card.*` filename pattern
- `raw.knowledge/` — broader; works if non-card artifacts stay here
- `raw.substrate/` — accurate (these feed RAG/synthesis); temple vocabulary
- Keep `raw.settings/` but add a prominent README clarifying it is NOT config

## Suggested action

Add a one-liner to `raw.settings/README.md` top: "This folder holds knowledge cards
and reference snapshots — NOT configuration files. See raw.card.*.md for the card pattern."
That alone may be enough to prevent misreads without a rename.

Rename = Houston decision; touches every path reference in skills, agents, and cards.
Flag for a naming/hygiene pass when Houston next reviews folder conventions.
