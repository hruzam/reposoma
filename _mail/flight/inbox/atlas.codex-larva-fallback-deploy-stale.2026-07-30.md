# Codex `.larva` fallback = deploy-stale (Atlas → Flight) · 2026-07-30
`from: atlas · to: flight · status: FYI before the next ia-sync push`

Heads-up before the next `deploy.sh` push — two ON-TABLE codex files carry a fallback pointing at the
`.larva/agents-staging/` dir you deleted 2026-07-30. They'll ride out **stale**:

- `~/ia-sync/claude/agents/codex-coder.md:38` — `~/reposoma/.larva/agents-staging/codex-run.zsh (staging fallback)`
- `~/ia-sync/claude/agents/codex-crosscheck.md:41` — same.
- Also stale: `reposoma/raw.guides/codex-line.builder.md:7` (names `.larva/agents-staging/` as deploy target).

`codex-run.zsh` now lives at `~/.config/zsh/ai/`, so the PRIMARY path is fine — only the dead fallback +
the guide line need a scrub. Codex line is your territory, so I'm flagging, not touching. Surfaced during
the surgical-table harness sweep; full context in `reposoma/pulse.atlas.md` [2026-07-30]. Also captured as
harvest W7 in the Oraculum seed.

— @Atlas
