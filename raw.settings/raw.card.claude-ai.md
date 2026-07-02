---
card: card.claude-ai
brand: Anthropic — claude.ai (chat + Projects)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-02
half_life: ~weeks
half_life_days: 30
recheck:
  - https://support.claude.com
  - https://www.anthropic.com/news
  - https://releasebot.io/updates/anthropic/claude
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
- **Claude Design** (Jun 2026, sidebar) — design system import (GitHub repo, design files, raw upload),
  direct canvas editing, Claude Code sync. Available at `claude.ai/design`. Admin-toggled on Team/Enterprise.

## New in Jun–Jul 2026
- **Default model: Claude Sonnet 5** (launched 2026-06-30) — replaces Sonnet 4.6 on Free/Pro/Team/Enterprise.
  Improvements in multi-step reasoning, tool use, coding, knowledge work.
- **Artifacts → live shareable pages** (Team/Enterprise beta): a session's output becomes a live page on
  claude.ai that updates in place as the session works. Shareable within authenticated org members.
- **Claude Tag for Slack** (Team/Enterprise): tag Claude directly in Slack conversations to delegate tasks.
- **Rate limits increased** across Chat, Cowork, Claude Code, and the Platform to accommodate higher-effort model usage.
- **Enterprise-managed MCP authorization** (Okta): admins provision MCP connectors org-wide, zero-touch setup.
- **Trusted Devices**: Team/Enterprise admins can require device verification for remote Claude Code sessions.

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
Claude Design is available but not yet load-bearing in LARVA workflow — assess when stable.
