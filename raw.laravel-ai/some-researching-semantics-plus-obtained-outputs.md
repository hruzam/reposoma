Quick transparency note first: the YouTube community-posts tab is JavaScript-rendered, so my fetch of that URL returned only the channel header — no individual posts, images, or links. The channel is **Laravel Daily by Povilas Korop**, and his community posts almost always announce/mirror his videos, blog tutorials, courses, and his "AI Coding Daily" newsletter — so I synthesized the last ~6 months (Dec 2025 → Jun 2026) from those primary sources instead. Here's what came out of it.

## 1a. AI-focused tips (Cursor / Claude Code / Codex)

**Laravel Boost is the foundation of his whole workflow.** His process for every new project: install Laravel Boost right away (it's now part of the `laravel new` installer), copy his custom guidelines into a `.ai/guidelines` folder (e.g. `php-laravel.md` and `filament.md`), then re-run `php artisan boost:install`, which merges those files into `CLAUDE.md` — and only then start prompting Claude Code. He keeps the guideline files in a separate local folder backed by a GitHub repo and even wrote a small bash script to automate copying them + running boost:install in each new project. This maps almost 1:1 onto your planned `ARCHITECTURE.md` + ADR idea for Freya — Boost's `.ai/guidelines` is exactly the "committed blueprint agents read instead of re-deriving structure."

**Why Boost matters:** it provides guidelines/skills that steer agents toward Laravel best practices, plus a documentation API combining a built-in MCP tool with a knowledge base of 17,000+ Laravel-specific entries with semantic search — and it instructs agents like Claude Code and Cursor to use that API for the latest framework features. A commenter tip from his course he endorsed: run `php artisan boost:update` whenever you install a new package, and run `php artisan boost:mcp` for agents that need the MCP registered manually.

**Guidelines should shrink over time.** Notable trend in his rule file changelog: in January 2026 he simplified and shortened the guidelines "as LLMs got better at generating good code by default" — i.e., only encode rules where models *actually* still fail. Concrete rules worth stealing (his file is public and updated continuously):

- No obvious code comments; **Pest tests are mandatory for new features**; and for libraries not covered by Boost's `search-docs`, automatically use the **Context7 MCP** without being asked.
- Before writing tests: check the schema with Boost's `database-schema` tool (defaults, nullables), and verify relationship names in the model instead of assuming `user_id` → `user()`.
- A practical agent gotcha: never chain multiple migration-creating commands with `&&` — they can get identical timestamps; run them one at a time.
- Filament v4 rules: always generate smoke tests for resources, use `Resource::getUrl()` over `route()`, and a do-not-use list of deprecated v3 methods (`->form()` → `->schema()`, `Placeholder::make()` → `TextEntry::make()->state()`, etc.) — directly relevant to your Filament migration plan.
- He runs Cursor/Claude Code in **auto-run mode** with file-deletion restricted, rather than approving every command.

**Tool positioning** (from his Nov 2025 course "Laravel Coding with AI Agents"): it's an AI-ecosystem overview of how he personally uses Cursor, Claude Code, and Codex CLI for Laravel projects — the general consensus he reflects: Cursor for interactive in-editor flow, CLI agents (Claude Code/Codex) for larger autonomous, multi-step feature work.

**Ecosystem development worth knowing:** Laravel launched skills.laravel.cloud in February 2026 — an open directory of reusable AI agent skills for Laravel/PHP, installable with one command and compatible with Claude Code, Cursor, Windsurf, Copilot.

## 1b. Pure Laravel tips from the last ~6 months of videos

Several are directly relevant to a web shop like Freya:

- **E-shop homepage speed** (two-part, May/Jun 2026): practical Eloquent optimizations on a mock gaming e-commerce homepage — killing N+1 queries, tightening data loading, caching with proper invalidation — followed by a video on perceived speed using Livewire components with deferred loading, including the trade-offs (extra requests, SEO).
- **Composer supply-chain security**: analysis of the serious "laravel-lang" package supply-chain attack, why it's more dangerous than typical vulnerabilities, and practical steps to reduce risk with Composer dependencies; he also rushed out a text-based course "Practical Laravel Security: Packages, Secrets, Supply-Chain Attacks" in late May.
- **Bulk data benchmarks**: inserting and upserting 1M rows from CSV into MySQL — comparing updateOrCreate, query-builder upsert, Eloquent upsert, insert-on-duplicate, and a PHP-driven split approach for speed, reliability, and memory (streaming to limit RAM). Useful for OpenCart → Laravel data migration.
- **Passkeys**: Laravel starter kits now ship passkeys by default via Fortify; the video covers enabling HTTPS and retrofitting passkeys into existing projects.
- **Releases he covered**: Laravel 13 main changes, Livewire 4 (released January 2026, with changes to component creation and dynamic behavior), the Laravel AI SDK (released February 2026 — image/audio/text generation, document chatbots), and NativePHP v3 for mobile apps.
- **Package discovery**: "don't ask ChatGPT" for the best packages — he rebuilt laraveldaily.com/packages as a curated hub and shows how to use AI to vet packages instead.

The single most useful link: his living guidelines article at `laraveldaily.com/post/my-cursor-rules-for-laravel` (free, last revised Jan 23, 2026).

## 2. Can Claude Code do "the same"? Yes — here's the build

Two separate capabilities you're asking about: (a) the Laravel AI workflow above, (b) the research task (reading JS-rendered pages like YouTube posts, following links, reading images). Plain `WebFetch` in Claude Code hits the same JS wall I did — that's what the browser MCP solves.

**Install** (native installer is the recommended path now; npm still fully supported):

```bash
curl -fsSL https://claude.ai/install.sh | bash
# or: npm install -g @anthropic-ai/claude-code
cd your-project && claude   # first launch opens browser auth
```

Requirements are minimal (macOS 13+, Ubuntu 20.04+, or Windows 10+ with WSL); you need a Pro/Max/Team/Enterprise plan or a Console API account — the free plan doesn't include Claude Code. Docs: https://code.claude.com/docs

**MCP stack for the Laravel + research workflow:**

```bash
# 1. Laravel Boost — the core (in your Laravel project)
composer require laravel/boost --dev
php artisan boost:install
```

The installer auto-detects your IDE/agents and generates `.mcp.json` plus guideline files (CLAUDE.md, AGENTS.md); Boost registers itself with Claude Code automatically — verify with `/mcp` inside a session. If needed manually: `claude mcp add -s local -t stdio laravel-boost php artisan boost:mcp`, and add `php artisan boost:update` to your Composer `post-update-cmd` scripts to keep guidelines current. The Boost MCP gives Claude direct access to your app — Artisan, Eloquent queries, routes, migrations, schema, plus tinker, log reading, and the docs API.

```bash
# 2. Context7 — accurate docs for non-Laravel packages (Povilas's rule)
claude mcp add -s user -t stdio context7 npx -y @upstash/context7-mcp

# 3. Playwright — the piece that does the YouTube-posts research
claude mcp add -s user -t stdio playwright npx -y @playwright/mcp@latest

# 4. GitHub (optional, for PR/issue workflows)
claude mcp add -s user -t http github https://api.githubcopilot.com/mcp/
```

With Playwright MCP, Claude Code can open `youtube.com/@LaravelDaily/posts` in a real browser, scroll to load posts, read text, take screenshots of post images (which it reads visually), and follow embedded links — exactly the task from part 1. Caveat: YouTube may show consent walls or throttle automation, so expect to occasionally click through manually in headed mode.

**Then mirror Povilas's setup:** put your Freya conventions (modular monolith boundaries, layer ownership rules from your cutting-agent manifests, Filament v4 rules, "Pest tests mandatory") into `.ai/guidelines/*.md` and re-run `boost:install` — that becomes your `CLAUDE.md`, and every Claude Code session starts already knowing your architecture. Your Cursor teammates benefit too, since Boost writes the equivalent Cursor rule files from the same source.

One warning from the field worth heeding: every MCP server and plugin eats context window — with many servers loaded, your effective working context can shrink dramatically before the first message — so disable everything not relevant to the current session. For Freya work: Boost + Context7 on, Playwright off; for research sessions, the reverse.