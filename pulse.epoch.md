---
title: pulse.epoch — Epoch status log
owner: epoch (single writer)
created: 2026-11-23
---

# pulse.epoch — Epoch status log (Epoch writes · everyone reads)

Newest on top. Single-writer: Epoch owns this file. Same shape as `pulse.atlas.md`:
an OPEN LEDGER (the only zone a re-incarnated Epoch MUST read) pointing down to dated entries.
Canon: `raw.canon/canon.mail-protocol.md` (single-writer-per-file · ask-first · everyone reads all).

**Re-entry:** read this ledger → recalibrate to today's date → treat every version, model string,
price and path below as STALE until re-fetched. Nothing here is a source; it is a pointer list.

---

## OPEN LEDGER — the living square

- [ ] **claude-code card (`raw.settings/raw.card.claude-code.md`) — partly re-verified.** Settings
  hierarchy section done 2026-11-23 (reposoma `e0c0ccb`). Header `verified:` still 2026-10-08 (half-life
  14 d) — rest of card unverified. MCP-scope line (~L98) was reconciled with L37 internally, MCP docs
  NOT re-fetched. → `[2026-11-23 settings-desk]`.
- [ ] **18 of 20 dated `raw.settings` cards past half-life** (only `nature` + `autonomous-orchestrator`
  inside). Not refreshed. Per-card table: `_mail/toAll/inbox/epoch.stale-cards.2026-11-23.md`.
  Refresh needs majkee's pick of which cards, in what order.
- [ ] **Claude Code changelog v2.1.294–325 never itemised** (read only v2.1.326–330; newest seen v2.1.330,
  20 Nov). Re-read from `code.claude.com/docs/en/changelog` with offsets, or github CHANGELOG.md.
- [ ] **Vendor-page checks outstanding (aggregator-only claims, rated M):** Fable 5.2 / Mythos 5.2 (9 Nov,
  `$8/$40` for Fable 5.2) → anthropic.com; Cursor 2026.11.05–06 → cursor.com/changelog; Google/Antigravity
  November news (none found) → geminicli.com/docs/changelogs + antigravity.google changelog.
- [ ] **Not covered in the 2026-11-23 edition:** OpenAI/Codex, OpenRouter, Laravel, Arch news,
  newsletters, open-model corner.
- [ ] **`worktree.bgIsolation`** — allowed values / default / min version NOT read (index says scope "Any
  file"). nablarva `.claude/settings.json` sets `"none"` (commit `6f5af9e`, pushed). Read
  `code.claude.com/docs/en/settings-reference#worktree-bgisolation` before anyone relies on it.
- [ ] **majkee: `_mail` README mismatch.** README says `_mail` is gitignored except README/.gitignore, but
  `git check-ignore` shows `_mail/toAll/inbox/` files are NOT ignored (checked 2026-11-23). Decide: fix the
  README line or add the ignore rule. Also: 2026-11-09 and 2026-11-16 automated stale mails still unread in
  `inbox/` (move to `archive/` is the receiver's act).
- [ ] **majkee/harness-check owner: generator defects** — empty-name rows (`eagle`, `machine.office`,
  `reposoma`); addendum card lacks `verified:`; README "monthly" vs weekly Monday mails since 2026-09-07.
- [x] **settings.json vs settings.local.json answered + card section fixed** — reposoma `e0c0ccb`, pushed.
- [x] **nablarva `.claude/settings.json` created + pushed** — nablarva `6f5af9e`.
- [x] **Epoch Gazette 2026-11-23 filed** — `.majkee/journal/newspaper.2026-11-23.md`, reposoma `06f2976`, pushed.
- [x] **pulse.epoch.md created + pushed** — reposoma `0a0abf3`.
- [x] **Curated staleness mail committed + pushed** — `_mail/toAll/inbox/epoch.stale-cards.2026-11-23.md`, reposoma `2b13425`.

---

## [2026-11-23 settings-desk] — settings question, card fix, gap newspaper, staleness mail

**Request (majkee, interactive, session in `~/unikuklatrix/nablarva`):** difference between
`.claude/settings.json` and `.claude/settings.local.json` beyond gitignore; check `raw.settings` + Anthropic
docs; then create/commit/push the project settings file; update the card; write the newspaper and the
staleness mail ("blessings in updates").

**Delivered:** see ledger `[x]` lines. All git/push done by @Delta (Epoch has no Bash). Pushes were gated:
Delta pushed only when the new commit was the sole one ahead of upstream.

**Facts worth keeping (re-verify before use):** precedence managed → `--settings` → local → shared → user;
lists merge, scalars override; local file at repo root since v2.1.211; shared-file `allow` waits for trust,
untracked local `allow` doesn't; local `allow` doesn't outrank project/managed `ask`. Source:
`code.claude.com/docs/en/settings`, fetched 2026-11-23 (H).

**Corrections to myself:** I first said "19 of 21" stale cards; recomputed from headers = **18 of 20 dated**.
Delta's card-commit message carried a `Co-Authored-By` trailer I did not request (harness default) — left
as is; amending would need a force-push, not done.

**Paths:** the user's `~/reposma` = `~/reposoma`; `_mail/to-all` = `_mail/toAll` (camelCase, `inbox/` +
`archive/`).
