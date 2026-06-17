---
status: promoted
promoted_by: "architectural decision while building devstudio 2026-06-08"
validated_by:
  - "piql.dev — forge→product pattern, never product→forge"
  - "freya.devenv master_prompt.md §4 — unambiguous historical precedent"
expresses_as:
  - "forge/ → product/ — one-way flow (e.g. devstudio/ → app/)"
  - "agents stage (git add), do not commit — the human holds the commit gate"
  - "never write directly into the product tree from a forge context"
commonized_from: "freya.devstudio/canon/canon.one-direction.md (2026-06-17)"
---

# One direction

```
forge/ → product/
```

A forge (a devstudio, a planning/research workspace) produces configurations, research,
rules, plans. Application/product code flows through the product repository plus the human
review gate. Never the reverse.

## Why

Bidirectional flow creates cyclic dependencies and loses the audit trail. The human holds
the commit gate — a safety firewall, not bureaucracy. Agents know more about the product
than they need to; the gate is the firewall between knowing and writing.
