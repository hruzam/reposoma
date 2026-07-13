---
scope: nature
sources_file: raw.research/nature/draft/sources.jsonl
output_path: raw.research/nature/report/raw.nature.<YYYY-MM-DD>.md
card: raw.settings/raw.card.nature.md
output_mode: report
persist: canonical
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Comprehensive biological research on mycorrhizal networks and mycelium.
    Goal: functional depth, not a surface survey. Required coverage —
    network architecture and structural properties (including extreme scale
    examples); cross-species exchange mechanisms: what is transported, in
    which direction, under what conditions; chemical and electrical signaling
    pathways; symbiotic dependency structure (who depends on whom and how);
    saprotrophic and decomposition roles; reproduction lifecycle (fruiting
    body formation, spore dispersal, germination); persistence and age scales.
    Output is synthesis-ready substrate — not a textbook chapter, not a FAQ.
    Emphasis on mechanisms and structural properties over taxonomy.
  related_scopes: []
---

# Scope: nature

Deep research on mycorrhizal networks and mycelium biology.
Invoked as `/refresh nature`.

Persist: canonical — report output committed.
Output: `raw.research/nature/report/`
Card: `raw.settings/raw.card.nature.md`
Sources: `raw.research/nature/draft/sources.jsonl`
