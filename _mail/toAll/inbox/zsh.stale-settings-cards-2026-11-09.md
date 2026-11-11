---
title: Stale Settings Cards Alert
date: 2026-11-09
stale_count: 20
---

# Stale Settings Cards Alert

The following settings/knowledge cards are past their freshness threshold (half-life) and require manual re-verification.

| Brand / Card | Last Verified | Threshold (Days) | Elapsed (Days) | Verification Command & Recheck Links |
| :--- | :---: | :---: | :---: | :--- |
| **Research — Claude Code agent harness (scope: agent-docs)**<br>(card.agent-docs) | 2026-10-08 | 30 | **32** | `curl -s https://code.claude.com/docs/en/changelog `<br>[[link]( grep -c 'v2\.|~/reposoma/raw.research/agent-docs/draft/sources.jsonl)] [[link](https://code.claude.com/docs/en/changelog)]  |
| **Research — AI/LLM news watch (scope: ai-news)**<br>(card.refresh.ai-news) | 2026-10-08 | 2 | **32** | `cat ~/reposoma/raw.research/ai-news/draft/sources.jsonl `<br>[[link]( wc -l|~/reposoma/raw.research/ai-news/draft/sources.jsonl)] [[link](https://www.interconnects.ai/recommendations)] [[link](https://magazine.sebastianraschka.com/recommendations)] [[link](https://newsletter.ruder.io/recommendations)]  |
| **Research — Arch Linux workstation health (scope: arch)**<br>(card.arch) | 2026-10-08 | 7 | **32** | `curl -s https://archlinux.org/feeds/news/ `<br>[[link]( grep -c '<item>|~/reposoma/raw.research/arch/draft/sources.jsonl)] [[link](https://archlinux.org/feeds/news/)] [[link](https://security.archlinux.org/advisory)]  |
| **Anthropic — claude.ai (chat + Projects)**<br>(card.claude-ai) | 2026-10-08 | 21 | **32** | <br>[[link](https://support.claude.com/en/articles/12138966-release-notes)] [[link](https://www.anthropic.com/news)] [[link](https://releasebot.io/updates/anthropic/claude)]  |
| **Anthropic — Claude Code (CLI)**<br>(card.claude-code) | 2026-10-08 | 14 | **32** | `claude --version`<br>[[link](https://code.claude.com/docs/en/changelog)] [[link](https://github.com/anthropics/claude-code)] [[link](https://code.claude.com/docs/en/claude-directory)]  |
| **OpenAI — Codex CLI**<br>(card.codex-cli) | 2026-10-08 | 10 | **32** | `codex --version`<br>[[link](https://learn.chatgpt.com/codex/changelog)] [[link](https://learn.chatgpt.com/codex/developer-commands)] [[link](https://github.com/openai/codex/releases)] [[link](https://developers.openai.com/codex/config-reference)]  |
| **Cursor (IDE; runs Claude / GPT / Grok / etc. models)**<br>(card.cursor-ide) | 2026-10-08 | 21 | **32** | <br>[[link](https://www.cursor.com/changelog)] [[link](https://releasebot.io/updates/cursor)] [[link](https://forum.cursor.com)]  |
| ****<br>(eagle) | 2026-10-08 | 30 | **32** | <br> |
| **Google — Gemini CLI**<br>(card.gemini-cli) | 2026-10-08 | 14 | **32** | `gemini --version`<br>[[link](https://geminicli.com/docs/changelogs/)] [[link](https://github.com/google-gemini/gemini-cli/releases)] [[link](https://google-gemini.github.io/gemini-cli/ROADMAP.html)] [[link](https://antigravity.google/docs/gcli-migration)]  |
| **Google — Gemini app (Gems / chat)**<br>(card.gemini-gems) | 2026-10-08 | 21 | **32** | <br>[[link](https://gemini.google/release-notes/)] [[link](https://releasebot.io/updates/google/gemini)] [[link](https://blog.google/products/gemini/)]  |
| **Google — Gemini Models & CLI Model Config**<br>(card.gemini-models) | 2026-09-02 | 45 | **68** | `gemini --version`<br>[[link](https://ai.google.dev/gemini-api/docs/models)] [[link](https://ai.google.dev/gemini-api/docs/changelog)] [[link](https://geminicli.com/docs/reference/configuration/)] [[link](https://google-gemini.github.io/gemini-cli/docs/get-started/configuration.html)]  |
| **Antigravity — agy CLI (gty)**<br>(card.gty) | 2026-10-08 | 21 | **32** | `agy --version`<br>[[link](https://github.com/google-antigravity/antigravity-cli)] [[link](https://antigravitylab.net/en/articles/)]  |
| **Research — Laravel / PHP ecosystem (scope: laravel)**<br>(card.laravel) | 2026-10-08 | 7 | **32** | `curl -s https://feed.laravel-news.com `<br>[[link]( grep -c '<item>|~/reposoma/raw.research/laravel/draft/sources.jsonl)] [[link](https://feed.laravel-news.com)] [[link](https://github.com/laravel/mcp/releases)] [[link](https://github.com/laravel/boost/releases)]  |
| ****<br>(machine.office) | 2026-07-15 | 90 | **117** | <br> |
| **Anthropic — Claude · OpenAI — Codex (cross-vendor)**<br>(card.model-effort) | 2026-10-09 | 14 | **31** | ``codex debug models` (zero quota) · `claude --version``<br>[[link](https://developers.openai.com/api/docs/models)] [[link](https://learn.chatgpt.com/docs/models)] [[link](https://platform.claude.com/docs/en/models/overview)] [[link](https://code.claude.com/docs/en/model-config)] [[link](https://platform.claude.com/docs/en/build-with-claude/effort)]  |
| **Research — OpenRouter model catalog (scope: openrouter)**<br>(card.openrouter) | 2026-10-08 | 14 | **32** | `curl -s https://openrouter.ai/docs/models `<br>[[link]( grep -c 'api/v1/models|~/reposoma/raw.research/openrouter/draft/sources.jsonl)] [[link](https://openrouter.ai/blog)]  |
| ****<br>(reposoma) | 2026-10-08 | 30 | **32** | <br> |
| **Cross-tool — Claude Code CLI · Cursor IDE · Gemini CLI (session hygiene + token distro)**<br>(card.session-hygiene) | 2026-10-08 | 28 | **32** | <br>[[link](https://code.claude.com/docs/en/sub-agents)] [[link](https://code.claude.com/docs/en/context-window)] [[link](https://geminicli.com/docs/core/subagents/)] [[link](https://github.com/google-gemini/gemini-cli/issues/8609)] [[link](https://cursor.com/changelog)]  |
| **guide:GUIDE**<br>(GUIDE) | 2026-10-07 | 30 | **33** | <br> |
| **guide:GUIDE**<br>(GUIDE) | 2026-09-01 | 42 | **69** | `ls ~/reposoma/raw.guides/sella/ && ls ~/reposoma/raw.guides/sella/src ~/reposoma/raw.guides/sella/raw`<br> |

---
*This is an automated notification generated by the native zsh card-freshness checker on po 9. listopadu 2026, 09:00:43 CET.* To run manually and check details directly in terminal, execute: `harness-stale`.
