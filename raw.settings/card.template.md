---
# card.template — the canonical RELATIVE-card shape · temple-owned · COPY this to start a new card.
# consumed by: /project-regular-self-report (Phase 2) for project card frontmatter shape.
# note: project cards adapt this template — they omit brand:/recheck:/verify_cmd: (knowledge-card fields).
# This file is a TEMPLATE, not a card: its name has no `raw.card.` prefix, so the freshness glob
# `raw.card.*.md` (the `harness-stale` checker) never picks it up. Rename to `raw.card.<name>.md` to make a real card.
card: card.<name>                       # the card id, e.g. card.claude-code
brand: <Vendor> — <Product>             # e.g. Anthropic — Claude Code (CLI)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: <YYYY-MM-DD>                  # last date this card was checked against reality
half_life: ~<N>-<M> weeks               # HUMAN prose — readable decay window (Gemini CLI ~1-2 wk; others ~weeks)
half_life_days: <int>                   # MACHINE field — max staleness window in days. Tooling reads THIS;
                                        #   it never parses the prose above. (= the max end of half_life, in days.)
recheck:                                # canonical sources to re-verify from, in trust order
  - https://<official-changelog>
  - https://<official-repo>
verify_cmd: <local truth check>         # where one exists, e.g. `claude --version`
# optional, card-specific (add only what applies):
# model_floor: <string>                 # CONFIRM current string via changelog; do NOT hardcode dated strings
# auth_survival: <note>
---

# <Card title>

## ⚠ VOLATILE — read first
- <the few facts most likely to be stale, or most load-bearing — the sunset clock, the breaking change>

## <body sections, as the card needs>
- Capability terms, not stack terms. Cite sources. Keep it scannable.

---

## Card discipline  *(delete this block in a real card — it is guidance, not content)*
- A RELATIVE card is **volatile, decaying, refreshed by the recalibration researcher.** Cards = mutable memory;
  the researcher = perception.
- **Freshness rule:** stale when `(today − verified) >= half_life_days`. Past that → mark low-confidence; do not
  emit from a stale card without a re-check (use `recheck:` / `verify_cmd:`).
- **Two freshness fields, on purpose:** `half_life:` is human prose (readable at a glance); **`half_life_days:` is
  the integer the freshness tooling reads** (`harness-stale`). Keep BOTH — the researcher writes both on every refresh.
- **Lineage (point, never copy):** the RELATIVE-card protocol is inherited from larva
  (`raw.larva.cards.structure-and-protocol.md` — **verbatim, another project; reference it, do not edit it**).
  This template is the temple's own clean expression of it.
