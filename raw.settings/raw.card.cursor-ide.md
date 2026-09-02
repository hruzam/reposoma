---
card: card.cursor-ide
brand: Cursor (IDE; runs Claude / GPT / Grok / etc. models)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~2-3 weeks (feature-drop cadence still fast; numbered "Cursor 3.x" releases gave way to named drops — watch for a version-scheme change)
half_life_days: 21
recheck:
  - https://www.cursor.com/changelog
  - https://releasebot.io/updates/cursor
  - https://forum.cursor.com        # feature reality vs docs
---

# Cursor IDE — native build surface

## Refresh delta 2026-09-02
- **Cursor Router launched (Jul 22)**: intelligent model routing — Intelligence / Balance / Cost modes; admin controls across desktop/web/iOS/CLI/SDK. [cursor.com/changelog, 2026-07-22, H]
- **Auto pricing de-flattened (Aug 24)**: flat Auto rate ($1.25 in/$6 out per M) retired — Auto now bills at the routed model's list price, +$0.25/M surcharge on 3rd-party models for Teams/Enterprise. Legacy Enterprise Auto keeps the old flat rate until 2026-09-07. [cellcog.ai / cursor.com/docs/models-and-pricing, 2026-08-24, M — vendor blog + docs page, not primary changelog entry]
- **MAX mode narrowed**: now legacy-request-plan-only, billed API rate +20%; current usage-based plans pick context size directly instead of toggling MAX. Supersedes the prior "Individual = no surcharge" reading. [cursor.com/docs/models-and-pricing, 2026-08 snapshot, M]
- **Origin Code Hosting (Aug 17, beta)**: Cursor-hosted repos, PRs, code browsing; bidirectional GitHub sync; Vercel/Depot/Buildkite CI integration. Rolling to all paid plans except opted-out enterprise orgs. [cursor.com/changelog, 2026-08-17, H]
- **Cloud Agent Builds (Aug 13)**: pre-configured dev environments, ~3x faster start (10x faster internal boot); resilient fallback to last good build. [cursor.com/changelog, 2026-08-13, H]
- **Cloud Agent harness expansion (Aug 19)**: event subscriptions (watch PRs/Slack threads/scheduled tasks), custom modes pinning skills, subagents each in their own VM, `/goal` for long-lived objectives, mid-work steering without interrupting the agent. [cursor.com/changelog, 2026-08-19, H]
- **Cloud Agents no longer need a repo (Aug 27)**: prompt-from-scratch, save to an Origin repo later; browser preview + Vercel publish. [cursor.com/changelog, 2026-08-27, H]
- **Models refreshed**: Grok 4.6 (Aug 12, long-horizon agentic + visual work) joins Grok 4.5, Composer 2.5; Router spans GPT-5.5, Claude Opus 5, Grok 4.5, Claude Fable 5.1. [cursor.com/blog/grok-4-6, forum.cursor.com, 2026-08-12, M]
- **.cursorrules further deprecated**: not read in Agent mode at all now; AGENTS.md covers all three surfaces (chat/composer/agent) but stays frontmatter-free (always-applies, no glob/activation modes) — `.mdc` remains the only path to scoped activation. [thepromptshelf.dev practitioner guide, 2026 snapshot, M — not an official changelog page]
- **iPad support (Jul 29)**: full layout rebuild, split-screen chat, PR review, Apple Pencil markup — extends the existing iOS mobile-agent surface. [cursor.com/changelog, 2026-07-29, H]
- **CLI (Aug 26)**: self-hosted workers now support live-desktop viewing; `--computer-use --share-desktop` shares the agent's managed desktop instead of a separate session. [cursor.com/docs/cli/changelog, 2026-08-26, M]
- **Unverifiable**: no changelog entries found between 2026-08-27 and 2026-09-02 (report window ends there); no evidence of a numbered "Cursor 4" release — version numbering appears to have shifted to named feature drops. Flag as watch item, not confirmed retirement of the scheme.

## Config homes
- Project rules: `<repo>/.cursor/rules/*.mdc`
- Global MCP:    `~/.cursor/mcp.json`   ; project MCP: `<repo>/.cursor/mcp.json`
- Cross-tool contract: `<repo>/AGENTS.md` — now the recommended fallback across chat/composer/agent modes (no glob/activation control, always applies).
- Legacy single file `.cursorrules` — **not read in Agent mode**; avoid entirely for new work.
- **Customize page**: consolidated view for plugins, skills, MCPs, subagents; marketplace leaderboard for popular integrations.

## Native primitives
1. **Rule** (`.mdc` = markdown + YAML frontmatter) — FOUR activation modes:
   - `alwaysApply: true`   → every request (keep < ~200 words; it's a token tax).
   - `globs: src/**`       → auto-attaches when matching files are touched.
   - `description: "..."`  → agent pulls it in when relevant (Agent-Requested).
   - no frontmatter        → manual `@rule-name`.
   - ← glob/description modes are the NATIVE scope-leash for an over-reaching agent.
2. **Cloud / Subagents** — spawn in isolated VMs; now bootable **without a connected repo** (Aug 27) and via reusable **Builds** environments (Aug 13, ~3x faster start). Configured via `.cursor/environment.json`.
3. **Agent Skills** — `SKILL.md` (open standard); can now be **pinned as persistent custom modes** (Aug 19).
4. **Cursor Router** (Jul 22) — routes requests across models by Intelligence / Balance / Cost mode; admin controls org-wide.
5. **Origin Code Hosting** (Aug 17, beta) — Cursor-hosted repos/PRs/browsing, bidirectional GitHub sync, Vercel/Depot/Buildkite CI.
6. **Cursor Hooks** — lifecycle interception, incl. cloud-agent hook events (prompts, responses, thinking).
7. **Background / Cloud Agents + BugBot** — async long-running work; GitHub triggers, Slack emoji-reactions, `/automate` for plain-language automations. Agents now support **event subscriptions** and `/goal` long-lived objectives (Aug 19).

## CROSS-ECOSYSTEM (key)
- Cursor can LOAD skills/agents placed under `~/.claude/{skills,agents}` → your shared Claude skills corpus is consumed by Cursor directly.
- **Team MCPs:** admins configure MCP servers once, distribute across cloud agents, IDE, and CLI; team marketplaces support org groups alongside SCIM directory groups.
- **Origin** bidirectionally syncs with GitHub — treat it as a second source-of-truth surface, not a replacement (verify project policy before relying on Origin as primary host).

## Surfaces
- Tab (autocomplete) · Cmd+K (inline edit) · Chat · Composer/Agent (reads files, edits, runs terminal, loops).
- **Cloud Agents** — `/in-cloud`, now startable with no repo (Aug 27); Builds-backed envs (Aug 13).
- **Side Chats:** parallel agent conversations via `/side`, `/btw`, or the plus button; each is a full agent session, durable across the main thread.
- **iPad (Jul 29):** full layout rebuild, split-screen chat, PR review, Apple Pencil markup — extends the existing iOS agent-launch/voice/Remote-Control surface.

## Context window — session hygiene (see card.session-hygiene for full analysis)
- Effective available window = **< 50% of advertised** (system prompt + codebase index + history + auto-included files; Cursor does not publish breakdown).
- By the 50th tool call, conversation history alone can exceed 150K tokens — re-sent every turn.
- Mode switch (Cmd+. / Ctrl+.) = **fresh context window** (confirmed). Continuity lost; cost resets.
- **Pricing restructured (Aug 24):** flat Auto rate retired — Auto bills at routed model's list price, +$0.25/M on 3rd-party models for Teams/Enterprise. **MAX mode is now legacy-plan-only** (API rate +20%); current usage-based plans pick context size directly instead. Re-verify whichever plan this project is on before quoting a per-request cost.

## CAVEAT / watch
- Binding a specific `.mdc` to ONE custom mode is weak — `alwaysApply` rules apply across modes.
- Local models (Ollama/LM Studio) possible but materially weaker on multi-file Composer work; cloud is the real path.
- Context mechanics are NOT fully documented publicly. Numbers above are practitioner-measured — treat as approximate.
- Forum activity (2026) shows recurring complaints: code-reversion bugs (Agent Review / Cloud Sync / Format-on-Save conflicts), background agents losing connection mid-task, and users reporting slow bug-fix turnaround — treat stability claims in marketing copy skeptically.
- Version-numbering scheme (Cursor 3.x) has not produced a new numbered release since v3.11 (Jul 10) as of this pass — features now ship as named drops (Router, Origin, Builds). Confirm at next refresh whether numbering resumes.

## Recommendation for LARVA (freya/fo studio)
Author the FO/freya rule-set as scoped `.mdc` (globs per layer) + a lean AGENTS.md (now the cross-mode fallback, still frontmatter-free). For the existing frontend → a "know-your-code" indexing pass (@Codebase) before agent edits. Reuse the shared `~/.claude/skills` corpus rather than duplicating. For long agentic tasks: prefer `/in-cloud` with a Builds-backed environment over long Composer sessions to avoid context accumulation. Side Chats remain the preferred pattern for parallel investigation threads. Before quoting cost to the team, re-check which plan (legacy vs current usage-based) governs MAX-mode / Auto pricing — the Aug 24 change is material.

local verify: n/a (not installed on office)
