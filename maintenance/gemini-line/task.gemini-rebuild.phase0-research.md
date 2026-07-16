# TASK — Phase 0: RE/SEARCH (Epoch)
# Gemini Rebuild — Research Gate

**Executor:** @Epoch  
**Status:** OPEN — starts immediately  
**Output:** write findings to `reposoma/_mail/toAll/inbox/handoff.gemini-rebuild.md`  
**Gates:** Phase 1 Track A + Track B both wait for this file before starting

---

## Context

The Gemini shell layer (`~/.config/zsh/ai/`) is being rebuilt. Before any code is written, we need ground-truth findings on 7 open questions. Your output becomes the spec addendum that governs all build decisions — scripting format, model choices, injection patterns, policy engine migration.

**Do not assume. Do not recall from training. Fetch live.** Calibrate to today's date (2026-07-03) before starting.

---

## Research questions

Answer each with: **findings** (what you found) + **recommendation** (what to do, one clear call).

### Q1 — Headless invocation patterns

What is the correct way to invoke a Gemini agent headlessly (one-shot, no interactive loop)?

- `-p "..."` flag: exact behavior, does it bypass the agentic loop?
- `@name "task"` selector: confirmed to enter interactive/agentic loop — document why and when to avoid
- `--raw` mode: exact behavior, does it suppress the system prompt / persona from `~/.gemini/agents/<name>.md`?
- What is the difference between `-p` and `@name` in terms of system prompt handling?
- What is the correct headless one-shot invocation for: (a) with agent persona, (b) without persona (raw research pass)?

Sources: `github.com/google-gemini/gemini-cli` (issues + docs), `geminicli.com/docs`, Stack Overflow practical reports.

### Q2 — Policy Engine (replaces `--allowed-tools`)

`--allowed-tools` CLI arg and `tools.allowed` in `settings.json` are deprecated (removal at v1.0). The Policy Engine is the replacement.

- What does `geminicli.com/docs/core/policy-engine/` document?
- What is the `.toml` structure for tool/permission rules?
- Does the Policy Engine affect how `~/.gemini/agents/*.md` agent definitions are loaded or what tools they can access?
- Do per-agent scripts need to set any Policy Engine flag or config?
- Is there a per-agent `.toml` alongside the `.md`, or is it global?

### Q3 — Agent injection: MD vs JSON

- Are `~/.gemini/agents/<name>.md` files still the correct format for agent definitions in v0.49.0+?
- Is there a JSON alternative (`settings.json` `agents:` key or similar)?
- Any changes to agent frontmatter fields (model, temperature, etc.) since v0.49.0?
- Does the `model:` frontmatter field in the `.md` file take effect, or must model be set via `GEMINI_MODEL` env var? (Current scripts double-lock both — is this necessary?)

### Q4 — "Massive" failure cascade

Map the full failure mechanism:
- **503 pattern**: rate-limit trigger vs server overload; is it per-key, per-model, or per-region? Any retry-after headers?
- **Token bloat**: what causes CLI to over-read? Known `/tmp` scan behavior — is this documented? Context accumulation per turn?
- **Crash bug #8609**: anatomy — what exactly triggers the auto-switch to smaller context model, when does context exceed cap, why does `/compress` also fail (requesting ~100K output tokens)?
- Any mitigations beyond `/compress` manually every ~20–30 turns?
- Is this bug fixed in v0.49.0 or still open?

### Q5 — Scripting portability

We need scripts that work in BOTH:
1. Interactive zsh sessions (sourced via `.zshrc` → `ai/base.zsh` → `keyboard.zsh`)
2. Bare bash invocations from Claude Code's Bash tool (no `.zshrc`, no `.zshenv` sourced)

- What is the recommended shebang and extension for scripts that must be callable from bare bash AND sourceable in zsh?
- POSIX sh (`#!/bin/sh`) vs bash (`#!/usr/bin/env bash`) vs zsh (`#!/usr/bin/env zsh`) — trade-offs for this use case?
- Can a `.sh` file with `#!/usr/bin/env bash` be sourced cleanly by zsh? Any gotchas?
- Is there a standard community pattern for "shared shell function library" callable from multiple runtimes?

**Specific decision needed:** What extension and shebang for:
- `processor.{ext}` — shared function library (sourced by keyboard.zsh, also called by agent scripts)
- Per-agent scripts (`bluebottle.{ext}`, etc.) — called from Claude Code Bash tool AND from keyboard aliases

### Q6 — Current model stability (2026-07-03)

- Gemini 2.5-pro and 2.5-flash: current CLI stability status? Known issues?
- Gemini 3.x (3.1-pro-preview, 3.5-flash GA): what changed since last week? The operator reported "line 3 was terrible last week" — stuck sessions, failures, token bloat. Has this improved or is 3.x still inadvisable for CLI agent use?
- For automated/headless use specifically: which model is safest? For thinking/advisor use (interactive)? For implementer/coder use?
- Check community reports (GitHub issues, Reddit r/Gemini, HN) for any stability reports from 2026-06-27 to 2026-07-03.

### Q7 — REST API current state

Current `bluebottle.zsh` uses:
```
POST https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent
Header: x-goog-api-key: $GOOGLE_API_KEY
Response path: .candidates[0].content.parts[0].text
```

- Is this endpoint still correct for 2026-07-03? Any v1 migration?
- Is `x-goog-api-key` header still the correct auth format? (Some docs use `Authorization: Bearer`)
- Is the response path `.candidates[0].content.parts[0].text` still accurate?
- Any rate limits per model for this REST endpoint vs CLI?
- Can system instructions be passed in the REST body (to inject agent persona without `~/.gemini/agents/` file)?

---

## Output format

Write to: `reposoma/_mail/toAll/inbox/handoff.gemini-rebuild.md`

Structure:
```
# Handoff: Gemini Rebuild Spec Addendum
# Epoch RE/SEARCH output — 2026-07-03

## Q1 — Headless invocation
findings: ...
recommendation: ...

## Q2 — Policy Engine
...

## Q3 — Agent injection
...

## Q4 — Failure cascade
...

## Q5 — Scripting
...

## Q6 — Model stability
...

## Q7 — REST API
...

## CONSOLIDATED SCRIPTING VERDICT
Extension: ...
Shebang for processor: ...
Shebang for per-agent scripts: ...
Sourcing pattern: ...

## MODEL ASSIGNMENTS
Vega (thinking/advisor): ...
Orby (researcher): ...
Bluebottle (synthesizer): ...
Astrobley (implementer): ... [with rationale — pro depth vs flash stability]
Epoch-Gemini (recalibrator): ...
```

Cite source + date + confidence for each finding. Flag anything you cannot verify with `[UNVERIFIED — training-recall only]`.
