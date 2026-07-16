# TASK — Phase 2+3: Finalize + Stress Test + Sync (Trajectory)
# Gemini Rebuild — Close Out

**Executor:** @Trajectory  
**Status:** BLOCKED — wait for both Track A and Track B sign-offs below  
**Input:** `handoff.gemini-rebuild.md` + Track A + Track B completed work

---

## Gate: confirm both tracks done

```
Track A sign-off: [x] DONE — 2026-07-03
Track B sign-off: [x] DONE — 2026-07-03 (fix-pass @Trajectory; P1–P6 applied; all headless tests exit 0)
```

Tracks fill this in. Trajectory checks both before starting.

---

## Phase 2 — Finalize (4 file updates)

### 2.1 — `reposoma/.claude/agents/gemini-cross-check.md` line 33

Current:
```bash
RESULT=$(zsh ~/.config/zsh/ai/bluebottle.zsh "$TMPFILE")
```

Change to (using extension from handoff `## CONSOLIDATED SCRIPTING VERDICT`):
```bash
RESULT=$(bash ~/.config/zsh/ai/bluebottle.{ext} "$TMPFILE")
```

If the spec addendum says `.zsh` extension, use `zsh` as executor. If `.sh`, use `bash`. Match exactly.

Verify: the output prefix `## @BlueBottle cross-check` is still returned — grep test.

---

### 2.2 — `~/.claude/agents/epoch.md` — add Gemini buffering runbook

Add a new section `## Gemini cross-check runbook` after the existing `## Subagent` section.

Content:
```markdown
## Gemini cross-check runbook

When to spawn `gemini-cross-check`:
- Research synthesis needs a second-model perspective
- Conflicting sources or "does my lean hold?" verification
- NOT for routine card updates or single-source findings

Headless invocation (from handoff Q1 findings):
- [paste the Q1 recommendation here from handoff.gemini-rebuild.md]

Model in use: gemini-2.5-flash (fast synthesis tier) via REST API primary, CLI fallback.

Graceful-fail behavior: if gemini-cross-check returns `[CROSS-CHECK UNAVAILABLE: ...]`, continue
without synthesis — do NOT block or retry. Note the failure in your output.

bluebottle.{ext} path: `~/.config/zsh/ai/bluebottle.{ext}` (updated from bluebottle.zsh)
```

---

### 2.3 — `raw.settings/raw.card.gemini-cli.md` — add stability section

Add a new section `## CLI stability matrix` near the end of the card (before any closing notes).

Content shape:
```markdown
## CLI stability matrix

Based on: operator reports (2026-06-27), Epoch research (2026-07-03), GitHub issues.

| Use case | Safe? | Notes |
|---|---|---|
| Interactive UI session (short) | ✓ | < 20 turns, manual /compress |
| Interactive UI session (long) | ⚠ | Bug #8609: crash past ~50 turns |
| Headless one-shot (CLI -p) | ✓ | Stable if short input |
| Headless one-shot (REST API) | ✓✓ | Preferred — no TTY, no noise |
| Automated loop / agentic | ⚠ | Token bloat, 503 cascade risk |
| Gemini 2.5-flash | ✓ | Recommended for CLI automation |
| Gemini 2.5-pro | ✓ | Recommended for thinking/advisor |
| Gemini 3.x (any) | ✗ | CLI instability reported 2026-06-27; agentic-first, timeout/silent-fallback risk |

Community reports (2026-06-27): Model line 3 CLI sessions stall, fail silently, token-bloat.
Recommendation: stay on 2.5 line for all CLI agent use until 3.x CLI stability confirmed.
```

Fill actual content from handoff `## Q4 — Failure cascade` + `## Q6 — Model stability` findings. Update the `verified:` date to 2026-07-03.

---

### 2.4 — `raw.settings/raw.card.gemini-models.md` — add CLI stability column

In the existing model matrix table, add a `CLI stable?` column:

| Grade | Gemini 3.x | Gemini 2.5 | CLI stable? |
|---|---|---|---|
| Pro | gemini-3.1-pro-preview | gemini-2.5-pro | 2.5: ✓ / 3.x: ✗ |
| Flash | gemini-3.5-flash (GA) | gemini-2.5-flash | 2.5: ✓ / 3.x: ✗ |
| Flash-Lite | gemini-3.1-flash-lite | gemini-2.5-flash-lite | 2.5: ✓ / 3.x: unknown |

Add a note below the table from handoff Q6 findings (current as of 2026-07-03). Update `verified:` date.

---

## Phase 3 — Stress Test

Run from bare bash (not zsh, not sourced session):

```bash
# Headless tests
bash ~/.config/zsh/ai/bluebottle.{ext} "Summarize: REST API is reliable for headless use"
bash ~/.config/zsh/ai/bluebottle.{ext} --raw "What is gemini-2.5-flash?"
bash ~/.config/zsh/ai/vega.{ext} "What is the trade-off between pro and flash models?"
bash ~/.config/zsh/ai/orby.{ext} "What does the gemini CLI -p flag do?"
bash ~/.config/zsh/ai/astrobley.{ext} "Write a hello world bash function"

# Sourcing test
zsh -c 'source ~/.config/zsh/ai/keyboard.zsh && type gemini-agents-help && gemini-agents-help'

# Cross-check path test (spawn gemini-cross-check with test blob)
echo "Test blob for cross-check" > /tmp/test-crosscheck.md
bash ~/.config/zsh/ai/bluebottle.{ext} /tmp/test-crosscheck.md
rm /tmp/test-crosscheck.md
```

All must exit 0. Bluebottle headless must output `## @BlueBottle cross-check` header. Keyboard source must resolve `gemini-agents-help`.

---

## Phase 3 — ia-sync

After ALL tests pass:

```bash
cd ~/ia-sync
git pull --rebase origin main        # per SYNC_DISCIPLINE.md — always first
bash sync.sh                         # live → repo (rsync --delete: killed files removed, new files added)
git add -A
git commit -m "sync: gemini rebuild cleanup $(date +%Y-%m-%d)"
git push
```

Verify: `ls ~/ia-sync/zsh/ai/` — killed files absent, new files present.

---

## Final sign-off

- [x] 2.1 gemini-cross-check.md path updated + verified (bluebottle.sh, bash executor, 2026-07-03)
- [x] 2.2 epoch.md Gemini runbook section added (operator override: REST-only, @agent forbidden, 2026-07-03)
- [x] 2.3 raw.card.gemini-cli.md stability matrix added, verified: 2026-07-03 (3.5-flash REST=✓ per fix-pass; @agent=✗)
- [x] 2.4 raw.card.gemini-models.md stability column added, verified: 2026-07-03
- [x] All headless script tests exit 0 (verified in fix-pass track B 2026-07-03)
- [x] Keyboard source test clean (zsh -c 'source keyboard.zsh && type gemini-agents-help' → function, 2026-07-03)
- [x] Cross-check end-to-end test passes (bluebottle.sh "$TMPFILE" → ## @BlueBottle cross-check header, 2026-07-03)
- [x] ia-sync committed and pushed (commit bc337d4, 2026-07-03)

**When all checked: write to `pulse.atlas.md` → add entry: "Gemini rebuild COMPLETE — [date]" with summary of what changed.**
