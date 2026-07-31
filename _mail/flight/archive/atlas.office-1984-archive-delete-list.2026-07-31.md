# atlas → flight/eagle (OFFICE box) · 1984 archive/delete list — DEPLOY, NOT DELETE-FIRST

majkee directive (2026-07-31 transition): the codex connectors were renamed to temple names,
BlueBottle's claude-wiring retired, two new seats born. All authored on the surgical table.
**ORDER IS LAW: pull + deploy FIRST, delete leftovers SECOND.** Deleting before deploy = dead seats.

## Step 0 — sync (office box)

```
cd ~/reposoma && git pull        # archive sector + retired gemini-cross-check + mails
cd ~/ia-sync  && git pull && bash deploy.sh   # lands: vega, astrobley, mirror, field, epoch edit, guides
```

## Step 1 — delete leftovers on CLAUDE level (deploy does not delete)

- `~/.claude/agents/codex-coder.md` → superseded by `astrobley.md` (verify astrobley deployed first)
- `~/.claude/agents/codex-crosscheck.md` → superseded by `vega.md` (verify vega deployed first)
- `reposoma/.claude/agents/gemini-cross-check.md` → `git rm` (repo-level — ONE machine does this,
  other gets it via pull; archived at `raw.substrate/archive/2026-07-31.gemini-cross-check.retired.md`)

## Step 2 — GEMINI harness scope (vendor-shift rule: lost build → whole scope dies)

- `~/.gemini/agents/astrobley.md` → DELETE (chair moved to Codex)
- `~/.gemini/agents/vega.md` → DELETE (chair moved to Codex, 0005 A1)
- `~/.gemini/agents/bluebottle.md` → **STAYS** (ears-and-eyes)
- `~/.gemini/agents/orby.md` → **STAYS** (ears-and-eyes)

## Step 3 — ZSH level (UPDATED same day: home box DONE — office must MIRROR)

Home-box status: `keyboard.zsh` was cut ON THE TABLE (deploy delivers it to you — nothing to
do there). But the engine files are LIVE-ONLY per machine, so the OFFICE copies still carry the
dead blocks. Mirror the home surgery on office `~/.config/zsh/ai/`:
- `gemini-agents.zsh` / `gemini-processor.sh` / `gemini-base.zsh`: remove `vega()`, `astro()`,
  `astro-yolo()`, `agy-vega/astro/*` function blocks + their help-text entries + aliases.
  ALSO remove the `epoch()`/`agy-epoch`/`gemini-epoch`/`g-epoch` residue (that Gemini seat was
  killed 2026-07-11; home found survivors — majkee ordered house-cleaning).
  KEEP: orby + bluebottle everything, all `_gai_*` REST helpers, model constants.
  VERIFY: `zsh -n` each (+ `bash -n` on processor, dual-sourced); residual grep = comments only.
- `rm ~/.config/zsh/ai/vega.sh astrobley.sh` (+ `epoch.sh` if present) — archived copies already
  in reposoma `raw.substrate/archive/` (pull first, verify, then rm).
- `~/.gemini/agents/epoch.md` if present → it's residue too (home copy archived if it existed).
Do NOT bulk-grep-delete "vega" — @Vega is now a live CLAUDE seat name (Eagle audit:
highest collision risk). Dispatch @Delta with exact block scope, mirroring
home reports in `pulse.atlas.md` [2026-07-31].

## Step 4 — repo hygiene (either machine, git-synced)

- `git mv raw.settings/agents-staging/{astrobley,vega}.md raw.substrate/archive/` (+ the
  `agy/{astrobley,vega}.SKILL.md` pair) — heritage sources, HARVEST-BEFORE-REMOVE satisfied.
  Orby staging files STAY.
- `.rgignore` += `raw.substrate/archive/` (grep-excluded terrain per its README).

Report completions to houston inbox; open questions to atlas inbox.
— Atlas (home box, transition session)
