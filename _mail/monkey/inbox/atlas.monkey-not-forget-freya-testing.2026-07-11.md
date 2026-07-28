# atlas → monkey — freya test checklist (not-forget style)

`date: 2026-07-11 · majkee replies Sunday · machine layer sits UNCOMMITTED awaiting your ia-sync`

## Shell layer — open a NEW terminal first (reload)

1. `ai-help` · `temple-help` · `devenv-help` — all three print, zero "command not found"
2. `type fr-sync bo-sync` — resolve as aliases → engine functions
3. **Gemini live run** (dual-sourced gemini-processor.sh is syntax-verified both shells,
   but needs ONE real execution): quick `agy-astro` prompt OR a bluebottle blob —
   proves the subprocess chain end-to-end
4. `bo-status` / `bo-sync` on fantasyobchod — regression check after the keyboard rework

## freya transport — first live run

5. `fr-status` → `fr-sync`. **FIRST RUN EXPECTATION:** the CLAUDE.md backup-diff will
   show the graveyard-section deletion — that one is OURS (annotated in
   `.dev/rescue/claude-header-team.md`), not the team's. Don't chase it.
6. `fr-deploy` same machine — deploy-guard passes silently. Want to see it fire?
   Switch branch in freya.devenv and try deploy: it must stop and show both states.
7. `git status` in the freya APP repo — must stay clean (nothing team-visible leaked)

## Claude layer — freya CWD, fresh session

8. `/freya-context` loads · `@voyager` spawns (saddle wants `.dev/flag.md` — exists post-P1)
9. Ask any agent about the graveyard rules WITHOUT opening files — proves
   CLAUDE.local.md auto-load carries the army half
10. **The `.ai/` experiment when you're ready:** marker guideline
    (`.ai/guidelines/99-temple-test.md`) → `php artisan boost:update` → check the
    regenerated CLAUDE.md contains your marker · did `freya-context` skill SURVIVE
    the managed-dir regen? (I want that data point — it's the live test of the
    unique-name survival claim) · `.zed/settings.json` intact or restore from
    `.dev/rescue/`

## Decisions parked on you

11. **ia-sync pass** — rounds 2–4 delta in one run; the file list is in
    `pulse.atlas.md [2026-07-11]` Round-4 entry. Fresh-read rule applies (your own).
12. **`_gai_model` / `_gai_graceful_fail` ghosts** — never implemented, never called;
    tagged inline in `gemini-agents-help()`. Delete the two help lines, or stub them.
    Two-minute call.

`atlas-out · see you Sunday`
