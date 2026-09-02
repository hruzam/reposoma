# session-hygiene — substrate
_Fetched: 2026-08-01 | Mode: snapshot | Sources: 4/6 fetched this pass (2 carried)_

## claude-code
**Sub-agents docs** (code.claude.com/docs/en/sub-agents) — Core isolation model unchanged: each subagent runs in its own context window with its own system prompt/tools/permissions and returns only a summary; use to keep exploration/logs out of the main conversation. New adjacent concepts now documented: **background agents** (`/docs/en/agent-view`, many parallel independent sessions) and **agent teams** (`/docs/en/agent-teams`, sessions that communicate). Cost-control framing: route tasks to faster/cheaper models like Haiku. NOTE: this page covers CUSTOM subagent creation — it does NOT publish the built-in Explore/Plan model defaults, so the card's "Explore inherits capped Opus, changed v2.1.198" footnote was NOT re-confirmed this pass. Re-verify against release notes / context-window docs.
**Context window** (code.claude.com/docs/en/context-window) — not re-fetched this pass; carried from 2026-07-02. Referenced from the sub-agents page as the isolation-savings walkthrough.
**Remote Control** (code.claude.com/docs/en/remote-control) — carried fresh from the 2026-08-01 companion fetch (see `harness/reports/2026-08-01-remote-control-tmux-ssh-persistence.md`). No re-fetch needed.

## cursor
**Changelog** (cursor.com/changelog) — Recent entries (Jul 10–29 2026) are mobile (iPad/iPhone inbox, PR review), Cursor Start pricing (India), Slack, side chats, project picker. **No context-window / mode-switch / token-accounting changes in the last ~2 months.** New: **Cursor Router** does per-request classification by task type & complexity (model routing, NOT a context-mechanics change). ⇒ Card's Cursor findings (<50% effective window, mode-switch reset, 80%-vs-12%) stand unchanged; all still practitioner-measured, not Cursor-official.

## gemini-cli
**Subagents docs** (geminicli.com/docs/core/subagents) — **STATUS CHANGE: no longer marked PREVIEW; presented as a standard feature** (no experimental flag). Independent context window; interactions run in a separate context loop (token savings in main history). Recursion guard CONFIRMED verbatim: "subagents cannot call other subagents" — even with the `*` tool wildcard. Config: `.gemini/agents/*.md` or settings.json overrides; `@subagent_name` explicit delegation. No breaking API changes documented.
**Bug #8609** (github.com/google-gemini/gemini-cli/issues/8609) — **STATE CHANGE: now CLOSED** (was open 2026-07-02). Priority p2. Bug: long session → auto model downsize → context overflow → `/compress` requests `maxOutputTokens` > 65,536 → session unrecoverable. Exact fix release/date NOT stated on the issue. Treat as resolved; re-test before relying on long unattended sessions.

## Run metadata
- Fetched this pass: `cc-subagents`, `gemini-subagents`, `gemini-bug-8609`, `cursor-changelog`
- Carried (not re-fetched): `cc-context-window`, `cc-remote-control` (fresh from 2026-08-01 companion)
- Deltas vs 2026-07-02 card: Gemini subagents PREVIEW→standard · bug #8609 open→CLOSED · Cursor no context-mechanics change (+Cursor Router noted)
- Not re-confirmed: built-in Explore/Plan model defaults (v2.1.198 footnote) — not on the custom-subagents page
- One-off study metrics (CheesecakeLabs / MindStudio / InfoQ / MorphLLM) not in roster; carried unchanged
