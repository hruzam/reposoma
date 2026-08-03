---
scope: session-hygiene
sources_file: raw.research/session-hygiene/draft/sources.jsonl
output_path: raw.research/session-hygiene/report/raw.session-hygiene.<YYYY-MM-DD>.md
output_mode: snapshot
window_days: 0            # snapshot ignores the recency window; kept for schema completeness
persist: ephemeral
# card: INTENTIONALLY OMITTED — see "Why no card: field" below.
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Re-fetch the doc/issue sources behind raw.settings/raw.card.session-hygiene.md so a
    researcher can re-synthesize the card from fresh substrate. Docs snapshot, not a news feed.
---

# Scope: session-hygiene

Backing research place for `raw.settings/raw.card.session-hygiene.md` (token-distro + context
isolation across Claude Code CLI · Cursor IDE · Gemini CLI, plus remote-session restore).

`/refresh session-hygiene` fetches the sources in `draft/sources.jsonl` in **snapshot mode**
(full doc content, no recency filter — these are living docs/issues, not dated news), synthesizes
in-session grouped by domain, and writes a dated substrate file to `report/`. That substrate is
the **synthesis input** for a manual card re-write.

## Why no `card:` field (important)

The `/refresh` skill's card-update step (7-B) prepends a **briefing-style run-block**
(`Lead / Convergence / Quiet / Feed flags / Manual-check`) above a `<!-- older runs -->` marker.
That shape fits accumulating feed cards like `ai-news`. It does **not** fit `session-hygiene`,
which is a **structured synthesis card** — sectioned per-tool findings, comparison tables, canon
mapping, no run-block log. Wiring `card:` here would make `/refresh` write a mismatched block into
a card it can't correctly edit.

**So the loop is deliberately two-step:**
1. `/refresh session-hygiene` → writes fresh substrate to `report/` (never touches `raw.settings/`).
2. @Epoch (or operator) reads that substrate and **re-synthesizes the card by hand**, bumping its
   `verified:` date and `half_life_days` per the freshness rule in `raw.settings/README.md`.

This mirrors how the card was originally created (one-shot @Epoch synthesis, 2026-07-02) and keeps
the structured card safe from format-mismatched auto-edits.

## Roster scope + a provenance caveat

`sources.jsonl` carries the **doc/issue sources** that are standing, re-fetchable signals (the
card's `recheck:` set + the remote-control companion doc).

The card also carries **quantified metrics from one-off studies** — CheesecakeLabs plan-mode
savings (20–35%), MindStudio 7× multi-agent multiplier, InfoQ/MorphLLM Cursor 80%-vs-12% figure.
Those were single studies, **not standing feeds**, so they are **not** in the roster (and their
exact URLs are not fabricated here). A refresh re-verifies the doc-based facts; regenerating those
specific numbers requires locating fresh studies by hand.

Skill: `/refresh session-hygiene`
Card (manual re-synthesis target): `raw.settings/raw.card.session-hygiene.md`
Companion report: `raw.research/harness/reports/2026-08-01-remote-control-tmux-ssh-persistence.md`
