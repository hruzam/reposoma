# @Larasor — Context & Source Registry
**Version:** 2026-06-09
**Role:** Attachable knowledge card — upload to the Gem as a knowledge file
**Mirrors:** `larasor_system_prompt.md` (Gem instructions) · `~/.gemini/agents/larasor.md` (CLI)

---

## SOURCE REGISTRY

### scope{1} — Laracasts / Jeffrey Way
| Surface | URL |
|---------|-----|
| YouTube | https://www.youtube.com/@laracasts |
| Site | https://laracasts.com |
| Key series | Laravel from Scratch · PHP for Beginners · What's New in Laravel |
| X/Twitter | @jeffrey_way |

### scope{2} — Laravel Daily / Povilas Korop
| Surface | URL |
|---------|-----|
| YouTube | https://www.youtube.com/@LaravelDaily |
| Shorts | https://www.youtube.com/@LaravelDaily/shorts |
| Site | https://laraveldaily.com |
| GitHub org ★ PRIMARY | https://github.com/LaravelDaily |
| X/Twitter | @LaravelDaily · @PovilasKorop |

**GitHub note:** Personal profile `povilaskorop` has only ~2 public repos.
Course repos and project code live under the **LaravelDaily org** — search there.
Search strategy: `github.com/LaravelDaily` + filter by recently updated.
For course-specific repos: search `site:github.com/LaravelDaily <course-topic>`.

### scope{3} — Laravel News
| Surface | URL |
|---------|-----|
| Site | https://laravel-news.com |
| X/Twitter | @LaravelNews |

### scope{4} — AI × Laravel (tools side)
**What to search for — general:**
- "Laravel Cursor IDE workflow"
- "Laravel Claude Code agent"
- "Laravel GitHub Copilot setup"
- "AI-assisted Laravel development 2025/2026"

**GitHub search queries — Claude Code patterns:**
```
filename:CLAUDE.md laravel
path:.claude/ filename:*.md
filename:settings.json "PreToolUse" laravel
```

**GitHub search queries — Cursor IDE patterns (from research-buffer):**
```
filename:00-base.mdc OR filename:AGENTS.md "globs"
path:.cursor/rules/ filename:*.mdc "alwaysApply"
filename:AGENTS.md laravel "cursor"
```

**GitHub search queries — MCP + hooks:**
```
filename:mcp.json "mcpServers" "read"
filename:hooks.json "afterFileEdit" OR "stop"
filename:mcp.json php "database" "read-only"
```

**Repo evaluation checklist (apply to `rn gh` results):**
```
☑ production repo (not a demo/tutorial)
☑ last commit ≤ 3 months
☑ PHP / Laravel stack
☑ multi-agent or AI-integration pattern present
```

### scope{5} — AI × Laravel (building side)
| Package / pattern | URL |
|-------------------|-----|
| Prism PHP (LLM abstraction) | https://github.com/echolabsdev/prism |
| openai-php/laravel | https://github.com/openai-php/laravel |
| pgvector + Laravel | search "pgvector laravel" on GitHub / Packagist |
| RAG in Laravel | search "laravel rag vector search" |
| Laravel Pulse + AI monitoring | https://laravel.com/docs/pulse |

### scope{community} — Trusted Voices
| Person / team | Surface | Focus area |
|---------------|---------|-----------|
| Spatie | spatie.be · github.com/spatie | Packages, best practices, open-source Laravel |
| Taylor Otwell | @taylorotwell · laravel.com/blog | Framework direction, new releases |
| Nuno Maduro | @nunomaduro · github.com/nunomaduro | Pest, Collision, Laravel tooling |
| Aaron Francis | aaronfrancis.com · screencasts | Eloquent, MySQL performance, tips |
| Jack Ellis | usefathom.com/blog | Indie Laravel, privacy-focused analytics patterns |

---

## SHORTHAND MAP (quick reference)

```
ola                 →  what's new digest (all scopes)
scope{1}            →  Laracasts / Jeffrey Way
scope{2}            →  Laravel Daily + Povilas GitHub
scope{3}            →  laravel-news.com
scope{4}            →  AI tools × Laravel
scope{5}            →  AI features in Laravel
scope{community}    →  trusted voices
scope{1,2,3}        →  multi-scope (any combination)
rn digest           →  full cross-scope synthesis
rn tips             →  shorts + quick wins only
rn gh               →  GitHub repos focus
rn ai               →  scope{4} + scope{5} combined
```

---

## SCOPE HEADER PATTERN

Put the scope on the **first line** of your message before the question body:

```
scope{2,5}
What new repos did Povilas push this month that touch AI features?
```

or

```
ola
```
(standalone = full digest)

---

## LARVA REGISTRY NOTE

This researcher is **read-only / community radar**. It does not modify project files.
Findings feed back to the team manually (copy → Larva session memory or project notes).
For scheduled / automated runs → see `researcher.recalibration.standing-prompt.md` hibernation notes.
