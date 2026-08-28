---
kind: cold-start-card
date: 2026-08-28
brand: claude
seat: atlas-ui
project: reposoma
projects: [reposoma, ia-sync]
root: ~/reposoma
task: Build Phase-2 of the cold-start vault — legacy migration, cs-palette, temple-cs-manage
resume: claude --agent atlas-ui (or flight for the regime-session build)
model: sonnet
dedicated: flight (regime-session coordinator) + delta/vector krakens; atlas-ui for primitive surfaces
recommend: migration FIRST — the archived legacy corpus is the palette's test data; bless before any ia-sync
pointers:
  - ~/reposoma/raw.guides/cold-start-card/GUIDE.md
  - ~/reposoma/raw.guides/cold-start-card/res/STATUS.md
  - ~/reposoma/raw.guides/regime-session/GUIDE.md
  - ~/ia-sync/zsh/ai/mail-palette.py
  - ~/ia-sync/zsh/ai/temple-mail-manage.zsh
---

The vault's first citizen: its own next step. This card is also the Claude-side write
smoke test (Codex smoke pending — majkee runs it).

## Pending, in order

1. **Legacy migration (@Delta, operator releases):** `git mv` the 23 `CS.*` cards from
   `~/reposoma/_mail/monkey/inbox/` → `~/reposoma/_cold-start/archive/`. They were
   gitignored-volatile — `git add` them during the move so the archive is tracked.
   No frontmatter backfill (legacy = test corpus).
2. **`cs-palette`** (`~/ia-sync/zsh/ai/`, clone mail-palette pattern): D1 left column =
   `card/` + `routines/` newest-first · D2 right-top = raw frontmatter verbatim ·
   D3 right-bottom = first `###### prompt` fenced block + `runbook:` line, else `—`.
   Keybinds hand off, never edit: Enter prints `resume:` · `e` opens card in $EDITOR ·
   `r` opens runbook. Parses ONLY the shared frontmatter contract (guide = schema of record).
3. **`temple-cs-manage`** (`~/ia-sync/zsh/ai/`, mirror temple-mail-manage grammar):
   moves `card/` ↔ `archive/` ↔ `routines/`, both directions, no frontmatter rewriting.
4. **Blessing card gates ia-sync:** `~/.config/zsh/blessings/cold-start.{json,md}` —
   checks: palette lists migrated corpus · D2 renders · D3 reveals prompt-0 + runbook
   line (test on THIS card) · Enter prints resume · manage moves both ways · `zsh -n`
   green. No deploy/sync until all pass or operator-waived.

## Laws that bind the build

- Regime-session protocol (`raw.guides/regime-session/GUIDE.md`): kraken execution via
  `_drop`; blessing before sync.
- Scope-build laws (`guide-for-builder.md §Architecture rules`, table-side): aliases +
  comments only in keyboard file · bodies in scope engine · `_<scope>_help` mandatory ·
  scope README updated.
- New consumers add themselves to GUIDE.md `## Wired surfaces`.

## prompt-0

###### prompt

```text
You are building Phase-2 of the cold-start vault (session glue system).
Read first, in order:
- ~/reposoma/raw.guides/cold-start-card/GUIDE.md   (the law: vault, schema, prompt grammar)
- ~/reposoma/raw.guides/cold-start-card/res/STATUS.md   (why each decision was made)
- ~/reposoma/raw.guides/regime-session/GUIDE.md    (build protocol: _drop, blessing card)
Then execute the "Pending, in order" list from this card:
migration -> cs-palette -> temple-cs-manage -> blessing card.
Reference implementations: ~/ia-sync/zsh/ai/mail-palette.py and temple-mail-manage.zsh.
All zsh builds land on the surgical table (~/ia-sync/zsh/ai/), never live ~/.config/zsh.
GATED: no ia-sync deploy until the blessing card is all-pass or operator-waived.
```

## Session advice

The D3 reveal must be tested against THIS card — if the palette cannot show the block
above without opening the file, the brick fails its own birth certificate.
