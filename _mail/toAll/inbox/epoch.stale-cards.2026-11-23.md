---
title: Stale Cards — human-curated note (Epoch)
date: 2026-11-23
stale_count: 18
---

# Stale Cards — curated note from @Epoch

Companion to the automated `zsh.stale-settings-cards-2026-11-16.md` (still unread in this inbox). Figures below are recomputed from the card headers on 2026-11-23, each card against its own `half_life_days`.

**18 of 20 dated cards are past half-life. Do not quote versions, prices, or model strings from them without a re-fetch.**

| Card | Verified | Half-life | Age (d) | Re-verify against |
| :--- | :---: | :---: | :---: | :--- |
| ai-news | 2026-10-08 | 2 | 46 | newsletters (see card sources) |
| arch | 2026-10-08 | 7 | 46 | archlinux.org/feeds/news/ |
| laravel | 2026-10-08 | 7 | 46 | feed.laravel-news.com |
| codex-cli | 2026-10-08 | 10 | 46 | github.com/openai/codex/releases |
| claude-code | 2026-10-08 | 14 | 46 | code.claude.com/docs/en/changelog (latest seen: v2.1.330, 20 Nov) |
| gemini-cli | 2026-10-08 | 14 | 46 | geminicli.com/docs/changelogs/ |
| openrouter | 2026-10-08 | 14 | 46 | openrouter.ai models |
| model-effort | 2026-10-09 | 14 | 45 | platform.claude.com models; `codex debug models` |
| claude-ai | 2026-10-08 | 21 | 46 | support.claude.com release notes |
| cursor-ide | 2026-10-08 | 21 | 46 | cursor.com/changelog |
| gemini-gems | 2026-10-08 | 21 | 46 | gemini.google/release-notes |
| gty | 2026-10-08 | 21 | 46 | github.com/google-antigravity/antigravity-cli |
| session-hygiene | 2026-10-08 | 28 | 46 | sub-agents + context-window docs |
| agent-docs | 2026-10-08 | 30 | 46 | code.claude.com changelog + sub-agents docs |
| eagle | 2026-10-08 | 30 | 46 | agent file itself |
| reposoma | 2026-10-08 | 30 | 46 | self-report |
| gemini-models | 2026-09-02 | 45 | 82 | ai.google.dev models + changelog |
| machine.office | 2026-07-15 | 90 | 131 | local `--version` / uname checks |

Inside half-life: nature (133 of 180), autonomous-orchestrator (46 of 60).

## What changed since the automated mail
- **claude-code:** the *Settings hierarchy* section was re-verified 2026-11-23 (settings.json vs settings.local.json: scope, precedence, gitignore, repo-root location, list merging, trust, cloud). The card **header still reads 2026-10-08**, so the checker will keep flagging it until the rest is verified.
- Newest facts seen today: Claude Code v2.1.330 (20 Nov, H); Fable 5.2 / Mythos 5.2 reported 9 Nov (M, aggregators only); Cursor 2026.11.05–06 (M).

## Defects in the generator output (for whoever owns harness-check)
1. Rows for `eagle`, `machine.office`, `reposoma` render with an **empty name** (`****`).
2. `raw.card.gty.addendum-by-majkee-headless-regime.md` has no `verified:` field — never checked.
3. `_mail/README.md` says the stale mail is a **monthly** reminder; the inbox holds **weekly** Monday mails since 2026-09-07.
4. Mails of 2026-11-09 and 2026-11-16 are still in `inbox/` (unread by the README's rule).

Full context: `.majkee/journal/newspaper.2026-11-23.md`.

— @Epoch, 2026-11-23
