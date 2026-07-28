## process
Read ONLY what this task needs: this card + **ONE** example `raw.settings/raw.card*.md` (for the frontmatter date
  shape, e.g. `raw.settings/raw.card.gemini-cli.md`) + the `_mail/toAll/inbox/` path convention. **Do NOT scan
  the whole RAG.**.
- If you can see your context/token footprint, report it — that number IS the test result.
- before you start, 

## GOAL — a native zsh card-freshness checker

1. Create in machine-layer zsh script folder `~/.config/zsh/fresh/harness-check.zsh` script, which will check from card fronmatter calculate`half_life_days` period against `verified:` date and if (currentDate - `verified:` ) >= max(`half_life_days`) save date to array. After checking all cards and have in array at least one catch, releasing list of array catches to `~/reposoma/_mail/toAll/inbox/zsh.stale-settings-cards-<YYYY-MM-DD>.md`   

2. Pattern for files which have to been checked will be saved in `~/.config/zsh/registries/ai.json` under key `native-primitives-update-pattern:`. This file does not exists, have to be created. pattern is `raw.card.*.md`
If you think that instead pattern is beter explicit registry, just say before start working. 

Frontamatter example:  
```yaml
---
card: card.claude-code
brand: Anthropic — Claude Code (CLI)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-02
half_life: ~2-4 weeks (ships ~10 versions/month)
recheck:
  - https://code.claude.com/docs/en/changelog        # generated from repo CHANGELOG.md
  - https://github.com/anthropics/claude-code
  - https://code.claude.com/docs/en/claude-directory
verify_cmd: claude --version
model_floor: claude-opus-4.x   # CONFIRM current string via changelog; do NOT hardcode dated strings
---
```


3. This script should have debug output if run directly in terminal through command 'aihs-stale' and in this case should instead releasing mail file should give output what was checked, what is stale and where should go output (link) -> pure echo to terminal.

4. After job is finished. You may shift from your `_mail/astrobley/inbox` to same level `archive/`. 

5. If you consider, that script earns its sit for manual (guide), please, create `~/.config/zsh/guides/ai.md` and put there your chaper about usage of this script.