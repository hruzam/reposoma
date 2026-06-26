# Build outcome — temple mail-transport + canon-doorbell (0008 Stage 1)

`status: BUILT + VERIFIED 2026-06-25 · builder: @Trajectory (Claude senior) · host: office · spec: transport-and-doorbell.spec.md`
`go-live gap: ONE non-sudo command (the post-commit hook install — see below). Everything else is live.`

## What was built (machine layer — NOT in canon, no `~/` paths in any repo)
- **P0** `~/.config/zsh/temple-project-map.zsh` — assoc-array map of all 6 registry projects → office repo-roots (`temple-project-root <name>`). All 6 present on office. The ONLY place physical paths live.
- **A** `~/.config/zsh/temple-mail.zsh` — `temple-mail <origin>:<agent> <scope> [body|-] [--from …]` → stages `<root>/_mail/<agent>/inbox/<sender>.<scope>.<date>.md` with `host:` frontmatter. Receiver owns; no sent-copy.
- **B** `~/.config/zsh/temple-doorbell.zsh` — `temple-doorbell-run`: derives canon version from `decisions/index.md` (max `LOCKED <date>` = `2026-06-25`); per project reads `<root>/.projection-stamp` (`projected-from: decisions@<date>`); stale (or no-stamp) → rings via A with a **pointer-only** body (signal + pass reference, never a diff). Skips reposoma (the canon source). New dated file per run.
- **Hook template** `~/.config/zsh/temple-doorbell.post-commit.hook` — guards on `temple/decisions/` changing, then invokes `temple-doorbell-run` in background. Zero logic in the hook (L7 hook≠brain).
- Machine-layer `~/.config/zsh/AGENTS.md` updated to register all four files + the install command.

## Verify-it-fires (guardrail 4) — both PASS
- **A:** test message → `piql.dev:houston` landed at the correct inbox path, right filename, no sent-copy. PASS.
- **B:** piql stamped current + vacuole no-stamp → fired → vacuole rung (1 dated file), piql NOT rung, reposoma NOT rung. Stale/fresh discriminator works. Test residue cleaned. PASS.

## The one go-live command (non-sudo — @majkee runs when ready; this is the "react on temple changes" switch)
```
cp ~/.config/zsh/temple-doorbell.post-commit.hook ~/reposoma/.git/hooks/post-commit && chmod +x ~/reposoma/.git/hooks/post-commit
```
Until installed: the doorbell runs on manual `temple-doorbell-run` only. After install: it fires automatically on any commit that touches `temple/decisions/`.

## Houston's adjudication of @Trajectory's flags
- **F1 — P0 kept separate from the existing `harness.machine-project-registry.json` (dev-switcher map): ACCEPTED.** Different schema, different consumer; "one map" means doorbell+recalibration share P0, not a merge with the dev-switcher. P0 stands separate.
- **F3 — all 5 non-reposoma projects stale on first real ring: ACCEPTED as correct bootstrap** (no-stamp = stale by design). First hook fire will ring all 5 once; expected.

## Remaining (Houston's follow-up, not the builder's)
- Wire the **read-side**: project saddle-boot reads its `_mail/<agent>/inbox/`.
- Update **0008 Stage-1 rollout** note (append-only) once the hook is installed and the read-side lands.
- **Recalibration script** (Vega's sector) folds onto P0 later — one map, one skeleton.
