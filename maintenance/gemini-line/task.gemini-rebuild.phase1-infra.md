# TASK — Phase 1 Track A: Infrastructure (Trajectory)
# Gemini Rebuild — Shell Infrastructure

**Executor:** @Trajectory + @Delta  
**Status:** SUPERSEDED — completed via fix-pass 2026-07-03. DO NOT EXECUTE: this spec predates the hang addendum; the CLI-fallback and `{ext}` patterns here were patched by `task.gemini-rebuild.fix-pass.2026-07-03.md`. See `report.gemini-fix-pass.2026-07-03.md` + `report.gemini-t2-livefire.2026-07-03.md` for final state.  
**Input:** `reposoma/_mail/toAll/inbox/handoff.gemini-rebuild.md` (Epoch Phase 0 output)  
**Parallel with:** Track B (agent scripts) — coordinate on nothing except reading the same handoff file

---

## Pre-flight: read the handoff

Open `reposoma/_mail/toAll/inbox/handoff.gemini-rebuild.md` first. Extract:
- `## Q5 — Scripting` → **SCRIPTING VERDICT** block: extension + shebang for `processor.{ext}` and per-agent scripts
- `## Q2 — Policy Engine` → whether any `.toml` step is needed
- `## Q3 — Agent injection` → confirm MD format still correct for `~/.gemini/agents/`

All decisions below marked `[SPEC]` are governed by the handoff. Do not assume.

---

## Scope

Working directory: `~/.config/zsh/ai/`

---

## Step 1 — Create `processor.{ext}` [SPEC: extension from handoff Q5]

New file. Shebang: [SPEC]. Common functions used by both `keyboard.zsh` and per-agent scripts.

Functions to implement (migrated from `bluebottle.zsh` + `gemini-agents.zsh`, generalized):

```
_gai_api_key()       — resolves GOOGLE_API_KEY → GEMINI_API_KEY → error + exit 1
_gai_model()         — resolves $1 (explicit) → GEMINI_MODEL env var → $2 (default fallback)
_gai_payload()       — builds JSON body: model=$1, temperature=$2, user_content=$3
                        system_instruction optional: $4 (if non-empty, inject as systemInstruction)
_gai_rest_call()     — curl POST to REST endpoint; args: json_payload; returns raw JSON or exits 1
                        endpoint: https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent
                        auth: x-goog-api-key header (verify against handoff Q7)
_gai_extract()       — jq extract: .candidates[0].content.parts[0].text (verify path against handoff Q7)
_gai_graceful_fail() — wrapper: on non-zero exit from REST call, output "[CROSS-CHECK UNAVAILABLE: $1]" + exit 0
_gai_strip_noise()   — strips 4 known CLI noise lines via grep -v:
                        "^Both GOOGLE_API_KEY", "^Warning:", "^\[STARTUP\]", "/tmp.*permission denied"
```

No aliases. No interactive logic. Pure functions. Guard: if sourced in non-bash/sh environment, silently skip.

---

## Step 2 — Create `keyboard.zsh`

New file. Replaces both `gemini-base.zsh` (aliases) and the function/wrapper layer of `gemini-agents.zsh`.

**Structure:**

```zsh
#!/usr/bin/env zsh
# keyboard.zsh — interactive shell only: aliases + sourcing + wrappers
# Do NOT call this from bare bash or agent scripts — use processor.{ext} directly

[[ -n "$ZSH_VERSION" ]] || return 1   # guard: zsh only

# ── source dependencies ──────────────────────────────────────────────────────
[[ -f ~/.config/zsh/ai/processor.{ext} ]] && source ~/.config/zsh/ai/processor.{ext}
[[ -f ~/.config/zsh/ai/bluebottle.{ext} ]] && source ~/.config/zsh/ai/bluebottle.{ext}  # if Track B uses sourceable scripts
[[ -f ~/.config/zsh/ai/vega.{ext} ]]       && source ~/.config/zsh/ai/vega.{ext}
[[ -f ~/.config/zsh/ai/orby.{ext} ]]       && source ~/.config/zsh/ai/orby.{ext}
[[ -f ~/.config/zsh/ai/astrobley.{ext} ]]  && source ~/.config/zsh/ai/astrobley.{ext}
```

**Aliases to migrate from `gemini-base.zsh`:**

PARTITION 1 — General CLI:
- `g`, `g-ver`, `g-help`, `agy-ver`, `agy-help`

PARTITION 2 — Safety/YOLO:
- `g-yolo`, `g-skip`, `agy-yolo`, `agy-skip`

PARTITION 3 — Kebab shims (update targets to new script names):
- `gemini-bluebottle`, `g-bluebottle` → call `bluebottle.{ext}`
- `gemini-vega`, `g-vega` → call `vega.{ext}`
- `gemini-orby`, `g-orby` → call `orby.{ext}`
- `gemini-astrobley`, `g-astro` → call `astrobley.{ext}`
- `g-astro-yolo` → call `astrobley.{ext} --yolo` (or equivalent)

PARTITION 4 — agy wrappers (migrate from `gemini-agents.zsh`):
- `agy-vega()`, `agy-orby()`, `agy-astro()`, `agy-astro-yolo()`
- `agy-astrobley` shim

PARTITION 5 — Epoch-Gemini function (stays as function, no dedicated script):
- `epoch()` — `GEMINI_MODEL=gemini-2.5-flash gemini "@epoch $@"` (or `-p` if Q1 recommends)

PARTITION 6 — Hygiene:
- `gemini-fresh()`, `agy-fresh()` (from `gemini-agents.zsh`)

PARTITION 7 — Help:
- `gemini-agents-help()` updated to reflect new layout

---

## Step 3 — Update `base.zsh`

File: `~/.config/zsh/ai/base.zsh`

Changes:
- Remove PARTITION 1 source line: `[[ -f ... ]] && source .../gemini-base.zsh`
- Remove PARTITION 4 source line: `[[ -f ... ]] && source .../gemini-agents.zsh`
- Add single line: `[[ -f ~/.config/zsh/ai/keyboard.zsh ]] && source ~/.config/zsh/ai/keyboard.zsh`
- Update partition numbering comment to keep it clean (no orphaned PARTITION labels)

Do NOT touch: `aihs-stale` alias (PARTITION 2), temple transport family (PARTITION 3).

---

## Step 4 — Kill old files

Only after Steps 1–3 are written and verified to source correctly:

```bash
rm ~/.config/zsh/ai/gemini-agents.zsh
rm ~/.config/zsh/ai/gemini-base.zsh
rm ~/.config/zsh/ai/bluebottle.zsh
```

Verify kill list against the plan before deleting. Temple files (`temple-*.zsh`, `temple-*.hook`) are **UNTOUCHED** — scope boundary.

---

## Step 5 — Create `~/.config/zsh/ai/README.md`

Dev standard for the `ai/` namespace. Keep concise — pointer-first, not a manual.

Sections:
1. **File map** — one line per file: role, who uses it, sourced by what
2. **Dev rules** — 4 rules:
   - Temple family (`temple-*.zsh`) is untouched; never modify without temple gate
   - No per-agent logic in `keyboard.zsh`; no aliases in processor or agent scripts
   - New agent seat: create `~/.gemini/agents/<name>.md` + `<name>.{ext}` + add shims to `keyboard.zsh` + update `AGENTS.md`
   - Check `guides/guide-for-builder.md` before adding anything new here
3. **Lighthouse pointer** — one line: `See ~/.config/zsh/AGENTS.md for the live file map`
4. **Guide pointers** — `~/.config/zsh/guides/guide-for-builder.md` (building here) and `guide-for-user.md` (invoking agents)

---

## Step 6 — Create `~/.config/zsh/guides/guide-for-builder.md`

Guide for adding a new Gemini agent seat to this namespace. Extendable — future builder appends.

Structure:
1. **How to add a new agent seat** (step-by-step):
   - Create `~/.gemini/agents/<name>.md` (frontmatter: name, model, temperature)
   - Create `~/.config/zsh/ai/<name>.{ext}` (two-mode: no-arg=UI, arg=headless)
   - Source it in `keyboard.zsh` + add kebab shims
   - Update `~/.config/zsh/AGENTS.md` file map + help table
   - Update `ai/README.md` file map
   - Run stress test: `bash ~/.config/zsh/ai/<name>.{ext} "test"` → verify headless exit 0
2. **Don't forget checklist** (grep-able `## CHECKLIST` heading):
   - `[ ] ~/.gemini/agents/<name>.md created`
   - `[ ] <name>.{ext} created and executable`
   - `[ ] keyboard.zsh: source + shims added`
   - `[ ] AGENTS.md updated`
   - `[ ] ai/README.md file map updated`
   - `[ ] ia-sync: run sync.sh after all changes`
3. **Pointer to user guide**: `~/.config/zsh/guides/guide-for-user.md`

---

## Step 7 — Create `~/.config/zsh/guides/guide-for-user.md`

Guide for invoking Gemini agents from the shell. Extendable.

Structure:
1. **Quick reference table** — alias → seat → model → use case
2. **UI session** (interactive): `g-vega`, `g-orby`, `g-astro`, `g-bluebottle` (no arg)
3. **Headless one-shot**: `g-vega "question"`, `g-bluebottle "blob"`, etc. (with arg)
4. **Bluebottle raw mode** (research pass, no persona): `g-bluebottle --raw "question"`
5. **Hygiene**: `gemini-fresh` (token-clean new session), `/compress` every ~20-30 turns, bug #8609 mitigation
6. **Pointer to builder guide**: `~/.config/zsh/guides/guide-for-builder.md`

---

## Step 8 — Update `~/.config/zsh/AGENTS.md`

Update the file map section:
- Mark killed: `gemini-agents.zsh` (killed → split into keyboard.zsh + per-agent scripts)
- Mark killed: `gemini-base.zsh` (killed → keyboard.zsh)
- Mark killed: `bluebottle.zsh` (killed → bluebottle.{ext})
- Add: `keyboard.zsh` — interactive aliases + wrappers
- Add: `processor.{ext}` — common API functions
- Add: `bluebottle.{ext}`, `vega.{ext}`, `orby.{ext}`, `astrobley.{ext}` — per-agent launchers

---

## Sign-off criteria

- [ ] `source ~/.config/zsh/ai/keyboard.zsh` in clean zsh subshell: no errors
- [ ] `type gemini-bluebottle` → resolves
- [ ] `type gemini-agents-help` → resolves, output reflects new layout
- [ ] Old files confirmed absent: `ls ~/.config/zsh/ai/gemini-agents.zsh` → No such file
- [ ] README.md, guide-for-builder.md, guide-for-user.md created
- [ ] AGENTS.md updated

Report to: `reposoma/_mail/toAll/inbox/task.gemini-rebuild.phase2-finalize.md` sign-off section (add "Track A: DONE — [date]")
