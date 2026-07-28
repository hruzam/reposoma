# Coding task for @Astrobley — card-freshness checker (`ainp-stale`) + token-economy gate-test

`from: Houston (Claude — temple architect) · tuned with majkee's spec 2026-06-19 (his Y + Houston's guardrails, merged — one authoritative spec, not a competition)`
`for: @Astrobley (Gemini systems implementer · gemini-3.5-flash)`
`delivery: majkee seeds this to the Gemini stack`
`PRE-REQ (majkee, manual): each raw.card.*.md gets a machine field half_life_days: <int> — the script never parses fuzzy text`

## ⚠ This is also the FIRST live test of the Gemini token-gates — honor them
- Boot via `GEMINI.md → @AGENTS.md` (the saddle). reposoma / the temple is the **EXCEPTION, NOT a project.**
- Read ONLY: **this card** + **ONE** example card (`raw.settings/raw.card.claude-code.md` or `raw.card.gemini-cli.md`)
  for the frontmatter shape + the `_mail/toAll/inbox/` path. **Do NOT scan the whole RAG.** Run on `gemini-3.5-flash`.
- Report your **context/token footprint** — that number IS the gate-test result.

## GOAL — a native zsh card-freshness checker
A zsh script in the machine-layer folder `/home/hruzam/.config/zsh/` that flags primitive cards whose own
declared freshness has lapsed, and broadcasts the list to `_mail/toAll`.

### Which cards — config (create it)
- Read the glob pattern from `/home/hruzam/.config/zsh/registries/ai.json`, key **`native-primitives-update-pattern`**
  (value: `raw.card.*.md`). **This registry file does not exist yet — create it** (clean JSON shape; that key
  drives which files are checked). Cards live in `/home/hruzam/reposoma/raw.settings/` → the pattern resolves to
  `raw.settings/raw.card.*.md`.

### The staleness rule — per-card, machine-native (NO fuzzy parsing)
- For each matched card read `verified:` (a date) and **`half_life_days:`** (an integer — the max staleness window
  in days; majkee normalizes it from the human `half_life_days:` (integer number of days) prose, so the script reads a clean number.
- **Stale if `(currentDate − verified) >= half_life_days`.** Collect catches into an array (card name + `verified`
  + the lapse in days).
- A card missing `verified:` or `half_life_days:` → **skip it** (note it in debug); never crash on a malformed card.

### Output
- If the array has ≥1 catch → write the list to
  `/home/hruzam/reposoma/_mail/toAll/inbox/zsh.stale-settings-cards-<YYYY-MM-DD>.md`. **A NEW dated file each run**
  — never edit a shared file (per `canon.mail-protocol`; this IS the canonized recalibration broadcast).
- If nothing is stale → no broadcast (quiet).

### Run modes
- **`ainp-stale-t`** — the terminal command to run it directly, with **debug output**: which cards checked, each
  one's `verified` / `half_life_days` / computed age, and why it was flagged or skipped. -> output instead to mail to ternminal.
- **`ainp-stale-m`**  
- Also schedulable via cron / systemd timer (majkee wires the schedule); the scheduled run is silent except for the
  `toAll` broadcast.

### Guardrails
- Plain zsh, machine layer. **Decision 0003:** carry `host:` (`echo $MACHINE_NAME`); the `toAll` reminder lists
  **relative card names** (e.g. `raw.card.gemini-cli.md`), never personal `~/` absolute paths (§4.7 — don't leak the
  machine layer into the project surface).
- **Verify it fires:** run `ainp-stale` once end-to-end and show the debug + what it flagged.

### Report back
- Script path · the `ai.json` shape you created · the `ainp-stale` debug from a real run (which cards are stale
  today) · your **context/token footprint** (the gate-test) · one push-back if you'd build it better, then deliver.
