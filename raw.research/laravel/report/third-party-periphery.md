# Laravel Third-Party Periphery
_Extendable research doc — add chapters as new tools/integrations are assessed_
_Last updated: 2026-07-10 | Scope: Boost, MCP, SDK, Gemini CLI, Cursor, Antigravity, Zed, agentive harness safety_

---

## Chapter 1 — Laravel Boost

### What it is

`laravel/boost` is a first-party Laravel package (`--dev`) that accelerates AI-assisted
development by wiring up an MCP server, AI guidelines, and agent skills into your project.
It ships a `boost:install` Artisan command and a `boost:update` command for ongoing
maintenance.

- Packagist: `laravel/boost`
- Docs (live): https://laravel.com/docs/13.x/boost
- Plugin listing: https://claude.com/plugins/laravel-boost
- Source: https://github.com/laravel/boost

### What `boost:install` actually touches — verified against source + official docs

| File / Directory | Action | Safe for hand-mades? |
|---|---|---|
| `.mcp.json` (project root) | **Written / regenerated** | ❌ Overwritten on re-install and update (see issue #325) |
| `CLAUDE.md` (project root) | **Written / regenerated** | ❌ Overwritten — meant to be gitignored |
| `AGENTS.md` (project root) | **Written / regenerated** | ❌ Same — Codex-facing guideline |
| `junie/` (project root) | **Written / regenerated** | ❌ Junie-facing guideline dir |
| `.claude/skills/` | **Installed / updated** | ⚠️ Managed by boost — custom skills survive only under unique names or via override pattern |
| `boost.json` | **Written** | ⚠️ Boost config file — gitignore recommended |
| `.ai/guidelines/` | **Source** (user-owned) | ✅ User custom overrides here are respected; naming-match pattern in docs |
| `.ai/skills/` | **Source** (user-owned) | ✅ Custom skills here survive — auto-included by boost:update |

### The key answer: `.claude/agents/` — does boost:install touch it?

**No. `boost:install` does NOT write to `.claude/agents/`.**

The `ClaudeCode.php` agent class (the configuration class for Claude Code integration)
defines three paths:

```
guidelinesPath()  → "CLAUDE.md"
mcpConfigPath()   → ".mcp.json"
skillsPath()      → ".claude/skills"
```

`agents/` is absent. Claude Code agent definition files in `.claude/agents/` (your hand-made
subagent `.md` files — global or project-scoped) are **fully outside boost's write surface**.

CONFIDENCE: H — verified against source + official docs 2026-07-10
SOURCE: https://github.com/laravel/boost/blob/main/src/Install/Agents/ClaudeCode.php

### `boost:update` behavior (the quieter risk)

The `boost:update` command regenerates whatever boost already installed. Official docs say:

> "Feel free to add the generated MCP configuration file (.mcp.json), guideline files
> (CLAUDE.md, AGENTS.md, junie/), and the boost.json configuration file to your
> application's .gitignore, as these files are automatically regenerated when running
> boost:install and boost:update."

This confirms: **these files are intentionally ephemeral.** Do not hand-edit them. Any
customization should go into `.ai/guidelines/` (for guideline overrides) or `.ai/skills/`
(for skill overrides).

Known issue: `boost:update` was overwriting `.mcp.json` including user docker/WSL
customizations. Reported as issue #325, addressed in PR #334. Status: closed, but
regeneration behavior is by design — customise via boost's override mechanism, not by
editing the output file directly.

SOURCE: https://github.com/laravel/boost/issues/325

### `boost:update` via Composer post-update-cmd

The official docs suggest adding this to `composer.json`:

```json
{
  "scripts": {
    "post-update-cmd": [
      "@php artisan boost:update --ansi"
    ]
  }
}
```

**Risk:** Every `composer update` silently regenerates `CLAUDE.md`, `.mcp.json`, and
`.claude/skills/`. If you hand-edit any of those, your edits are gone after the next
package update. Use the `.ai/` override system instead.

### Skills: `.claude/skills/` vs `.claude/agents/`

Boost manages `.claude/skills/` — a directory for on-demand Agent Skills (lightweight
markdown knowledge modules, not Claude Code subagent definitions). These are NOT the same
as `.claude/agents/` (Claude Code subagent `.md` files). The two directories serve
different purposes and have different owners:

| Path | Owner | Purpose |
|---|---|---|
| `.claude/agents/` | **You** | Claude Code subagent definitions — NOT touched by boost |
| `.claude/skills/` | **boost** | On-demand knowledge modules — managed by boost |

### Full agent class inventory in boost (2026-07-10)

Source confirms these agent classes exist in `src/Install/Agents/`:
`Agent` (base), `Amp`, `Antigravity`, `ClaudeCode`, `Codex`, `Copilot`, `Cursor`,
`Factory`, `Junie`, `Kiro`, `OpenCode`, `Pi`, `Zed`

Notable: **no `GeminiCli` class** — Gemini CLI is handled differently (see Chapter 6).

Path inventory for agents confirmed via raw source (2026-07-10):

| Agent class | guidelinesPath() | mcpConfigPath() | skillsPath() |
|---|---|---|---|
| `ClaudeCode` | `CLAUDE.md` | `.mcp.json` | `.claude/skills` |
| `Cursor` | `AGENTS.md` | `.cursor/mcp.json` | `.cursor/skills` |
| `Antigravity` | `AGENTS.md` | _(none — no MCP support)_ | `.agents/skills` |
| `Zed` | `AGENTS.md` | `.zed/settings.json` | `.agents/skills` |

Key observations:
- `Antigravity` implements no `SupportsMcp` contract — no MCP config file is written for it
- Both `Antigravity` and `Zed` share `.agents/skills` as the skills output path (not `.claude/skills` or `.cursor/skills`)
- All three non-Claude agents use `AGENTS.md` as their guidelines file

CONFIDENCE: H — verified from raw GitHub source 2026-07-10
SOURCE: https://raw.githubusercontent.com/laravel/boost/main/src/Install/Agents/Antigravity.php
SOURCE: https://raw.githubusercontent.com/laravel/boost/main/src/Install/Agents/Zed.php

---

## Chapter 2 — laravel-altitude (Third-Party Boost-Powered Agents)

### What it is

`laravel-altitude` (by mischasigtermans) is a third-party package that uses Laravel Boost's
extension API to publish Claude Code agent `.md` files into `.claude/agents/`.

- Source: https://github.com/mischasigtermans/laravel-altitude
- Tagline: "Claude Code agents for the TALL stack, powered by Laravel Boost"

### What altitude:sync does to `.claude/agents/`

**altitude DOES write to `.claude/agents/`.** This is the real danger vector for
hand-made agents.

Agents installed (always): `architect`, `database`, `docs`, `security`

Agents installed conditionally (based on `composer.json` packages detected):
`livewire`, `flux`, `filament`, `pest`, `realtime`, and others

### The overwrite risk — confirmed from docs

> "Altitude agents use common names like `architect`, `database`, and `livewire`. If you
> have custom agents with the same names, they will be overwritten on boost updates."

`altitude:sync --force` updates ALL agents to latest versions. Without `--force`, only
new agents are added (existing files are not overwritten). **The `--force` flag is the
dangerous path.**

### When does `altitude:sync --force` run automatically?

Altitude hooks into boost's update lifecycle. If both are installed and `boost:update` is
in `post-update-cmd`, a `composer update` chain can trigger altitude sync with `--force`,
silently overwriting matching agent files.

### Mitigations

1. **Use unique names** for your custom agents — avoid colliding with: `architect`,
   `database`, `docs`, `security`, `livewire`, `flux`, `filament`, `pest`, `realtime`
2. **Set `ALTITUDE_AUTO_SYNC=false`** in `.env` to disable automatic sync on updates
3. **Omit `--force`** if running `altitude:sync` manually — without it, existing files
   are not overwritten
4. **Use altitude's override pattern** — same as boost's: create matching-named files
   in `.ai/` to pin your versions

CONFIDENCE: H — from official altitude docs 2026-07-10
SOURCE: https://github.com/mischasigtermans/laravel-altitude

---

## Chapter 3 — Laravel MCP (laravel/mcp)

### What it is

`laravel/mcp` is the first-party Laravel package for **building** MCP servers inside a
Laravel application — distinct from boost's MCP tool integration. Where boost *consumes*
an MCP server to give AI agents access to your app, `laravel/mcp` lets you *build* your
own MCP server as a Laravel application.

- Source: https://github.com/laravel/mcp
- Docs: https://laravel.com/docs/13.x/mcp
- Packagist: https://packagist.org/packages/laravel/mcp
  - As of ~2026-06-25: version 0.8.2, 22M+ installs, 120 dependents
- Official overview: https://laravel.com/ai/mcp

### Install surface

```bash
composer require laravel/mcp
```

Does NOT touch `.claude/agents/`, `.mcp.json`, or any Claude Code harness files.
It is a framework-level package for exposing Tools, Resources, and Prompts to MCP clients.
Has no opinion on your editor/agent setup.

### Three exposed primitives

- **Tools** — callable functions the agent can invoke (query orders, create invoice, etc.)
- **Resources** — readable data by URI (e.g., `orders://reports/monthly`)
- **Prompts** — reusable conversation templates the client can invoke

Auth: OAuth 2.1 + Sanctum out of the box. Testing: MCP Inspector + unit test helpers.

CONFIDENCE: H — official Laravel docs + Packagist 2026-07-10
SOURCE: https://laravel.com/docs/13.x/mcp

---

## Chapter 4 — Laravel Claude / Anthropic SDK Packages

### The landscape (as of 2026-07-10)

Multiple competing packages exist. None are official Anthropic releases for PHP.

| Package | Packagist | Notes |
|---|---|---|
| `claude-php/claude-php-sdk-laravel` | https://packagist.org/packages/claude-php/claude-php-sdk-laravel | Wraps the claude-php SDK. Latest v1.1.1 (2026-02-17). PHP 8.2+, Laravel 11/12. |
| `mozex/anthropic-laravel` | https://packagist.org/packages/mozex/anthropic-laravel | Independent Laravel wrapper |
| `moe-mizrak/laravel-claude` | https://github.com/moe-mizrak/laravel-claude | Laravel package for Claude API |
| `helgesverre/claude-code-sdk` | https://packagist.org/packages/helgesverre/claude-code-sdk | Claude Code SDK wrapper for PHP |
| `artisan-build/claudecode` | https://github.com/artisan-build/claudecode | Internal toolkit, closed-contribution. Executes AI coding tasks from Laravel. Does NOT write to `.claude/agents/`. Requires Claude CLI + ANTHROPIC_API_KEY. |

### Harness impact of SDK packages

None of the above packages write to `.claude/agents/` or to any Claude Code config path.
They are API wrappers / service providers. Their install surface is:
- `config/` (published config file via `vendor:publish`)
- `.env` (API key required)
- No write to `.claude/`, `.mcp.json`, `CLAUDE.md`

CONFIDENCE: M — Packagist + GitHub repos verified 2026-07-10, some packages have thin docs

---

## Chapter 5 — Composer as Silent Trigger

### The full risk chain

```
composer update
  → post-update-cmd: php artisan boost:update
      → regenerates: CLAUDE.md, .mcp.json, .claude/skills/
      → if cursor installed: regenerates AGENTS.md, .cursor/mcp.json, .cursor/skills/
      → if altitude installed: altitude:sync [possibly --force]
          → overwrites matching .claude/agents/*.md
```

### What is guaranteed safe from the whole Composer chain

| Path | Status |
|---|---|
| `.claude/agents/` | ✅ SAFE — unless altitude is installed AND auto-sync is on |
| `~/.claude/agents/` (global) | ✅ SAFE — Composer and these packages operate at project scope only |
| `.cursor/rules/` | ✅ SAFE — boost does not touch Cursor's rules directory |
| `.cursorrules` | ✅ SAFE — boost does not touch legacy cursor rules file |
| `.gemini/settings.json` | ⚠️ PARTIAL — written by `gemini mcp add` (Gemini-CLI-side), not by boost directly; but boost may re-register on update |
| `GEMINI.md` | ✅ SAFE — user-created only; no tool writes it automatically |
| `.ai/guidelines/` | ✅ SAFE — user override source, respected |
| `.ai/skills/` | ✅ SAFE — user custom skills source, respected |
| `.claude/skills/` | ❌ MANAGED by boost — do not hand-edit |
| `.cursor/skills/` | ❌ MANAGED by boost — do not hand-edit |
| `CLAUDE.md` | ❌ REGENERATED — do not hand-edit; use `.ai/guidelines/` |
| `AGENTS.md` | ❌ REGENERATED by boost (Cursor path) — do not hand-edit |
| `.mcp.json` | ❌ REGENERATED — do not hand-edit; known issue #325 history |
| `.cursor/mcp.json` | ❌ REGENERATED — same regeneration risk as `.mcp.json` |

### Recommended safe-harbor pattern for hand-mades

```
Your custom agents           → .claude/agents/<unique-name>.md   (never collide with altitude names)
Your custom guidelines       → .ai/guidelines/<name>.blade.php   (boost picks these up)
Your custom skills           → .ai/skills/<name>/SKILL.md        (boost picks these up)
MCP customization (Claude)   → do NOT edit .mcp.json; use boost's API
MCP customization (Cursor)   → do NOT edit .cursor/mcp.json; use boost's API
Cursor rules                 → .cursor/rules/*.mdc               (boost-free zone — safe)
Gemini CLI context           → GEMINI.md in project root         (boost-free zone — safe)
Gemini CLI MCP config        → .gemini/settings.json             (written by gemini mcp add; guard manually)
env guard (if altitude)      → ALTITUDE_AUTO_SYNC=false
```

---

## Chapter 6 — Gemini CLI + Laravel Boost

### Gemini CLI's native config surface

Gemini CLI uses a layered config system. Files it reads/writes natively (no boost involvement):

| File | Scope | Written by |
|---|---|---|
| `~/.gemini/settings.json` | Global (all projects) | Gemini CLI itself / user |
| `~/.gemini/GEMINI.md` | Global context | User — never auto-generated |
| `.gemini/settings.json` | Project-level | `gemini mcp add -s project ...` or user |
| `GEMINI.md` | Project context | User — never auto-generated |

`GEMINI.md` is the Gemini CLI equivalent of `CLAUDE.md` — a context/instruction file.
**No tool auto-generates it.** It is user-authored. The CLI finds and concatenates all
GEMINI.md files from global → project root → subdirectories.

CONFIDENCE: H — official Gemini CLI docs 2026-07-10
SOURCE: https://google-gemini.github.io/gemini-cli/docs/cli/gemini-md.html
SOURCE: https://google-gemini.github.io/gemini-cli/docs/get-started/configuration.html

### Gemini CLI inside Laravel Boost — the no-agent-class situation

**Key finding: there is no `GeminiCli.php` agent class in boost's source tree.**

The full agent class inventory (verified 2026-07-10) includes: `Amp`, `Antigravity`,
`ClaudeCode`, `Codex`, `Copilot`, `Cursor`, `Junie`, `Kiro`, `OpenCode`, `Pi`, `Zed` —
but NOT a Gemini CLI class.

This means boost does **not** manage Gemini CLI as a first-class integration.
The official docs' instruction for Gemini CLI is:

```bash
gemini mcp add -s project -t stdio laravel-boost php artisan boost:mcp
```

This is a **Gemini CLI command**, not a boost command. It writes the MCP server entry into
the project-level `.gemini/settings.json`. Boost itself does not write this file.

CONFIDENCE: H — confirmed from boost source directory listing + official docs 2026-07-10

### Known issues: Gemini CLI + Boost

**Issue #51** (early, open): PHP errors from `artisan boost:mcp` producing non-JSON output
that Gemini CLI cannot parse — likely a config/model-class issue on specific setups.
STATUS: open at time of research.
SOURCE: https://github.com/laravel/boost/issues/51

**Issue #123** (closed, Aug 2025): Feature request for formal Gemini CLI support. Closed
with no description — may have been resolved informally (via the `gemini mcp add` manual
path documented in official docs) or deferred.
SOURCE: https://github.com/laravel/boost/issues/123

**Issue #431** (closed): `.gemini/settings.json` was NOT being auto-created during
`boost:install`, even when Gemini CLI was detected. Users had to manually create it with:
```json
{
  "mcpServers": {
    "laravel-boost": { "command": "php", "args": ["artisan", "boost:mcp"] }
  }
}
```
Issue closed — resolution unclear from page content. Given no GeminiCli.php class exists,
the manual path remains the canonical approach.
SOURCE: https://github.com/laravel/boost/issues/431

### Guidelines for Gemini CLI — what boost does vs. doesn't

| File | Boost writes? | Risk |
|---|---|---|
| `.gemini/settings.json` | No (gemini mcp add writes it) | ⚠️ Manual — not under boost lifecycle |
| `GEMINI.md` | No — user-created | ✅ Safe from boost entirely |
| `~/.gemini/settings.json` | No | ✅ Safe |
| `~/.gemini/GEMINI.md` | No | ✅ Safe |

**The Gemini CLI MCP config (`.gemini/settings.json`) is outside boost's regeneration
cycle.** Once you've run `gemini mcp add`, it won't be touched by `boost:update`.
The risk is: if you manually register it and then modify it, you're on your own — no
override mechanism equivalent to boost's `.ai/` pattern exists for this file.

### Gemini CLI + altitude

Altitude writes to `.claude/agents/` only — it has no integration with Gemini CLI's
agent/context system. Gemini CLI's `.gemini/` directory is untouched by altitude.

---

## Chapter 7 — Cursor IDE + Laravel Boost

### Cursor's native config surface

| File / Directory | Purpose | Written by |
|---|---|---|
| `.cursor/mcp.json` | MCP server config | Cursor + **boost** |
| `.cursor/rules/*.mdc` | Cursor rules (project AI instructions) | User / Cursor |
| `.cursorrules` | Legacy rules file (pre-rules dir) | User |
| `.cursor/skills/` | Agent skills (boost) | **boost** |
| `AGENTS.md` | Guidelines (boost writes for Cursor) | **boost** |

### What boost's `Cursor.php` agent class writes — verified from source

```
guidelinesPath()  → "AGENTS.md"
mcpConfigPath()   → ".cursor/mcp.json"
skillsPath()      → ".cursor/skills"
projectDetect()   → checks for ".cursor" directory
```

CONFIDENCE: H — verified from `Cursor.php` source 2026-07-10
SOURCE: https://github.com/laravel/boost/blob/main/src/Install/Agents/Cursor.php

Critical difference from Claude Code: **Cursor's guidelines file is `AGENTS.md`**, not
`CLAUDE.md`. If you install boost with BOTH Claude Code and Cursor selected, you get:
- `CLAUDE.md` (for Claude Code) — regenerated by boost
- `AGENTS.md` (for Cursor) — regenerated by boost

Both are ephemeral. Both should be gitignored. Both should not be hand-edited.

### What boost does NOT touch for Cursor

| Path | Status |
|---|---|
| `.cursor/rules/` | ✅ NOT touched by boost |
| `.cursor/rules/*.mdc` | ✅ NOT touched by boost |
| `.cursorrules` | ✅ NOT touched by boost (legacy file) |

**Cursor rules (`.cursor/rules/`) are the safe zone for hand-crafted Cursor instructions.**
This is the Cursor-native equivalent of what `.claude/agents/` is for Claude Code.
Boost has zero awareness of this directory.

### Cursor MCP config risk

`.cursor/mcp.json` is written and regenerated by boost. Same risk as `.mcp.json`:
- Do not hand-edit `.cursor/mcp.json`
- Customizations will be overwritten by `boost:update`
- No documented override mechanism for MCP config (unlike guidelines / skills)

CONFIDENCE: H — from Cursor.php source + issue #325 pattern 2026-07-10

### Cursor + altitude

Altitude writes to `.claude/agents/` only. It does not write to `.cursor/rules/` or any
Cursor-specific path. If you use altitude with a Cursor-primary workflow, your Cursor rules
are safe — but your `.claude/agents/` are still at risk from altitude's sync mechanism.

### Cursor skills: `.cursor/skills/` vs `.cursor/rules/`

Same distinction as with Claude Code:

| Path | Owner | Purpose |
|---|---|---|
| `.cursor/rules/` | **You** | Cursor project AI rules — NOT touched by boost |
| `.cursor/skills/` | **boost** | On-demand Agent Skills knowledge modules |

---

## Chapter 8 — Cross-tool write surface comparison

_Summary table: what each tool touches across the agent ecosystem_

| File / Dir | boost | altitude | laravel/mcp | SDK packages | gemini mcp add | Cursor (IDE) |
|---|---|---|---|---|---|---|
| `.claude/agents/` | ✅ safe | ❌ writes | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `.claude/skills/` | ❌ managed | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `CLAUDE.md` | ❌ regenerated | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `.mcp.json` | ❌ regenerated | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `AGENTS.md` | ❌ regenerated | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `.cursor/mcp.json` | ❌ regenerated | ✅ safe | ✅ safe | ✅ safe | ✅ safe | writes |
| `.cursor/rules/` | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe | writes |
| `.cursor/skills/` | ❌ managed | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `.agents/skills/` | ❌ managed (Antigravity/Zed) | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `.zed/settings.json` | ❌ regenerated | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `.gemini/settings.json` | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ❌ writes | ✅ safe |
| `GEMINI.md` | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `~/.claude/agents/` | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe | ✅ safe |
| `~/.gemini/settings.json` | ✅ safe | ✅ safe | ✅ safe | ✅ safe | `-s user` only | ✅ safe |

Legend: ❌ writes/managed = will overwrite on update | ✅ safe = confirmed not touched

---

## Epoch signal — related questions flagged for future research

- [ ] **`laravel-altitude` version matrix** — which agent names does each version install?
      Track for namespace collision risk as the package evolves.
- [ ] **`php-mcp/laravel`** (community MCP package by opgginc) — scope, install surface,
      harness impact. SOURCE candidate: https://github.com/php-mcp/laravel
- [ ] **`intercept` middleware** (laravel-news Jul 8) — prompt injection guardrail for
      Laravel AI SDK. Worth understanding if it wraps Boost or sits independent.
      SOURCE: https://laravel-news.com/intercept-middleware-guardrails-for-laravel-ai-agents
- [ ] **`square1/laravel-mpp`** — Machine Payments Protocol, 402 for AI agent API access.
      Novel pattern; relevance depends on whether you expose Laravel APIs to external agents.
      SOURCE: https://laravel-news.com/laravel-mpp-charge-ai-agents-for-api-access-with-402-payment-required
- [ ] **boost:install `--silent` flag behavior** — issue #526 confirms it exists; full flag
      documentation not in official docs. What does it skip?
- [ ] **PR #334 resolution detail** — what exactly was fixed in boost:update's .mcp.json
      overwrite behavior? Is custom .mcp.json now preserved, or is regeneration still the path?
- [ ] **Gemini CLI `gemini mcp add` merge behavior** — does it merge into existing
      `.gemini/settings.json` or overwrite? Not documented in official config docs.
- [ ] **Cursor rules supply-chain security** — security sources flagged `.cursor/rules/*.mdc`
      as a prompt-injection vector. Relevant if third-party packages ever start writing there.

---

_Sections to refresh: boost version tracking, altitude name registry, gemini mcp add merge behavior, PR #334 resolution, Amp.php + Kiro.php + Pi.php + OpenCode.php paths (not yet fetched)_
