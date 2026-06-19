---
card: card.claude-ai
brand: Anthropic — claude.ai (chat + Projects)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-02
half_life: ~weeks
half_life_days: 30
recheck:
  - https://support.claude.com
  - https://www.anthropic.com/news
surface_type: chat (NO filesystem; standing instructions + retrieved knowledge)
---

# claude.ai — chat & Projects (the architect / authoring surface)

## What it is (and isn't)
- A reasoning + authoring surface. NO disk write, NO agent/skill/hook files. It PRODUCES
  artifacts (config, prompts, plans) as text for transcription.
- Best-fit LARVA roles: architect (@Houston), agent-builder (authoring brain), recalibration researcher.

## The two configuration levers
1. **Project** — a workspace with:
   - **Custom instructions** (standing prompt baked into every chat in the project)
     ← this is where a researcher's / builder's "system prompt" lives.
   - **Project knowledge** (files/text, retrieved via search during chats) ← feed the RELATIVE cards here.
2. **Style** — customizes writing/tone separately from instructions.

## Toggles that matter
- Web search / Deep research (live grounding — powers "recalibrate vs training data").
- Code Execution & File Creation (produces downloadable artifacts).
- Memory / search-past-chats.

## The date fact (load-bearing for researchers)
- The interface INJECTS the current date; the model does NOT know it from weights. "Today is <date>"
  in a prompt works because the harness supplies it. Keep that line in researcher prompts.

## Limits
- NO autonomous scheduling. Standing instructions shape behavior WHEN invoked; the chat does not
  wake itself on a date. (Recurring radar → CLI/automation layer.)
- Project-knowledge edits do not disrupt a running thread; freshness for an in-flight thread isn't
  guaranteed → for a running thread, paste new context rather than rely on re-index.

## Recommendation for LARVA
Host the **agent-builder** and the **recalibration researcher** here as Projects with standing
instructions. Feed the RELATIVE cards as project knowledge so they reason against current reality.
