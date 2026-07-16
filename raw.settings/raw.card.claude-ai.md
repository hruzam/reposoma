---
card: card.claude-ai
brand: Anthropic — claude.ai (chat + Projects)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-07-16
half_life: ~weeks
half_life_days: 21
recheck:
  - https://support.claude.com/en/articles/12138966-release-notes
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

## New in Jun–Jul 2026 (verified 2026-07-16)
- **Default model: Claude Sonnet 5** (launched 2026-06-30) — replaces Sonnet 4.6 on Free/Pro/Team/Enterprise.
  Improvements in multi-step reasoning, tool use, coding, knowledge work. Fable 5 and Mythos 5 also restored
  July 1 after brief suspension; Mythos 5 limited to vetted partners only.
- **Claude Code Artifacts** (Jun 18, expanded to Pro/Max July 2026): a coding session's output becomes a
  self-contained HTML page published to a private URL on claude.ai, updating in place as the session works.
  Page cap: 16 MB. Public sharing off by default on Team/Enterprise (Owner must enable external sharing).
  Free/Pro/Max can generate embed code for published artifacts.
- **Claude Cowork** expanded to web and mobile (Jul 7, rolling out starting with Max): sessions save remotely
  with scheduled task capability. Chat and Cowork consolidated into one home interface.
- **Reflect** (Jul 9, beta — Free/Pro/Max, requires memory enabled): Settings > Reflect shows monthly usage recap,
  topics, activity patterns, work observations; break reminders and quiet-hours settings added.
- **Microsoft 365 write tools** (Jul 7): with connector enabled, Claude drafts/sends email, manages calendar
  events, creates/updates files in OneDrive and SharePoint.
- **Claude for Government Desktop** (Jul 7, public beta): FedRAMP High authorized; includes Claude Code
  and Claude Cowork.
- **HIPAA self-serve** (Jul 14): Enterprise and API organizations with BAA can now self-configure HIPAA settings.
- **Claude Science** (Jun 30): research workbench integrating tools and packages scientists use; auditable
  artifacts. Separate surface from standard Projects.
- **Claude for Teachers** (Jul 14): verified US K-12 educators get free premium access, teaching skills,
  curriculum connections across all 50 states.
- **Claude Tag for Slack** (Jun 23, Team/Enterprise): tag Claude directly in Slack to delegate tasks.
- **Enterprise-managed MCP authorization** (Okta): admins provision MCP connectors org-wide, zero-touch setup.
- **Trusted Devices** (Jun 25, Team/Enterprise): admins can require device verification for remote Claude Code sessions.

## Model tier (2026-07-16)
Claude Mythos 5 (vetted partners only) > Fable 5 > Opus 4.8 > **Sonnet 5** (default) > Sonnet 4.6 (legacy) > Haiku 4.5.

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
Claude Code Artifacts are now usable on Pro/Max for publishing session outputs as live pages.
