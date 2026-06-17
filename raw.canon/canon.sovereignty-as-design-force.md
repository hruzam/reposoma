---
status: promoted
promoted_by: "burning the shared/ layer 2026-06-08 — concrete need-event"
validated_by:
  - "a vendor CLI sunset (gemini-cli, 2026-06-18) — vendor lock-in confirmed real"
  - "shared/ registries and schemes were never native to any tool — burned 2026-06-08"
expresses_as:
  - "sovereignty_ratio = portable-text / (portable + vendor-locked-config)"
  - "vendor configuration (.claude/, .cursor/, .gemini/, ~/.agents/) are adapters, not the source of truth"
  - "every decision should increase sovereignty_ratio"
  - "share between tools only through open standards (SKILL.md, AGENTS.md), never a custom abstraction"
commonized_from: "freya.devstudio/canon/canon.sovereignty-as-design-force.md (2026-06-17)"
---

# Sovereignty as a design force

Agent-facing contracts (CLAUDE.md, flag.md, pulse.md, canon, guides) live in portable
Markdown owned by the project, not by a vendor. Vendor-specific configuration is an adapter,
not the source of truth.

## Expression

No `shared/` abstraction layer — no cross-tool registries, schemes, or custom classes. Every
tool gets its primitives in its native format. Tools share only through open standards the
vendors themselves understand (SKILL.md, AGENTS.md).

A custom cross-tool abstraction was burned once (2026-06-08) as a concrete need-event. Do not
rebuild it: when it breaks, the vendor lock-in it hid breaks with it.
