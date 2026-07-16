---
scope: editors
mode: interrogation
output_path: raw.research/editors/report/raw.editors.<YYYY-MM-DD>.md
persist: ask
wiring:
  skill: ~/.claude/skills/refresh/SKILL.md
  purpose: >
    Sublime Text, Zed, and editor-space exploration.
    Question-driven — no sources roster. Each run starts from a direct question.
    Feature gaps route to coding tasks, not back to research.
---

# Scope: editors

Invoked as `/refresh editors [question]`.

No `sources_file` — this scope is question-driven. Standard `/refresh` steps 3–5
(source roster → fetch loop → briefing) are **replaced** by the interrogation procedure
below. Steps 1–2 and 7–8 (scope read, output/confirm) apply as usual.

**Editors in scope:** Sublime Text · Zed · any other solution on demand.
**Output:** one file per run covering all editors touched in the question.

## Phase 1 — Interrogation + Research

1. **Collect question.** Take from invocation argument or current session context.
   If absent, ask:
   *"What do you want to know about Sublime Text, Zed, or another editor solution?"*

2. **Classify the question:**
   - **Capability check** — "does editor X support feature Y?"
   - **Comparison** — "how does Sublime compare to Zed for workflow Z?"
   - **Workflow probe** — "how would I do action A in Zed?"

3. **Research.** Fetch from official docs via WebFetch:
   - Zed: `https://zed.dev/docs/`
   - Sublime Text: `https://www.sublimetext.com/docs/`
   Do not assume version states — verify. If a page is JS-rendered or WebFetch returns
   thin content, surface to outer session: dispatch @Epoch with the question and today's
   date; do not hallucinate on behalf of the docs.

4. **Synthesize in-session.** Tight briefing: capability status · version if relevant ·
   any caveats or workarounds. One section per editor covered.

5. **Confirm before writing.** `persist: ask` — single prompt:
   *"Write snapshot to report/? (yes / no)"*
   Write only if the answer is reference-dense enough to carry across sessions.
   Conversational answers → no write, session only.

## Phase 2 — Verdict routing

After synthesis:

**Capability EXISTS** → answer complete. Note as a session finding if useful.

**Capability DOES NOT EXIST (feature gap):**

Re-classify as a coding / feature task. Surface the verdict clearly:
> *"Feature gap — [X] does not exist in [editor]. Suggest routing as a coding task."*

Best destination (majkee decides, do not auto-create):
- `/home/hruzam/www/elements-factory/applications-in-common` — if it is a UI-layer or
  browser-based experiment fitting the hypothesis playground
- New dedicated project — if the scope is standalone and reusable beyond the playground

Surface the verdict and the lean; majkee routes.

## Process map (side quest — this README is the home)

This README is the process map. Expand it in place as the scope accumulates findings.
Open a new scope only when this single-README shape hurts (Foreman rule).

Accumulation hooks for future runs — add sections here as they fill:

```
## Sublime Text — verified capabilities
## Zed — verified capabilities
## Open feature gaps   ← staged list; majkee marks each: routed / dropped
```

Skill: `/refresh editors`
No card — Q&A output does not age predictably; snapshot on demand via `persist: ask`.
