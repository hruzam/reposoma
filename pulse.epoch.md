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

- [ ] **Stale-card job — fixes in source, DEPLOY PENDING per host.** Office timer runs weekly (Mon 09:00; fired 11-23, manual start 20:23:59, both with the OLD script). ia-sync source now: 8b4d3ed move to zsh/scheduled (11-23) · trailing-slash fix (swept into majkee's 5ba9eb0, 11-24) · dc897cc unit-separator field delimiter (pipes in verify_cmd) · fa3071e strip ONE outer quote pair (closing ' of verify_cmd kept). All pushed. NOT verified on any host: majkee deployed on office + one more host on 11-23 from the 8b4d3ed state (home's deployed copy still lacked the slash fix on 11-25). To do per host (home, office, monitor): pull ia-sync → deploy.sh --dry-run → deploy → `grep -c AWK_TRIM ~/.config/zsh/scheduled/harness-check.zsh` (non-zero) → office: `systemctl --user cat harness.service | grep ExecStart` must name …/scheduled/… → start service, journal must show `…-<YYYY>-W<NN>.md` or "unchanged". Then delete old ~/.config/zsh/ai/harness-check.zsh on each host. Pending office mail zsh.stale-settings-cards-2026-11-23.md untracked on office. See [2026-11-25 harness fixes + handoffs].
- [ ] **First real mail render check:** confirm the next weekly mail renders `\|` inside backticks as `|` (sandbox only counted columns), and that the 4 previously truncated commands (agent-docs, arch, laravel, openrouter) show their closing quote.
- [ ] **Optional harness-check cleanups (not done):** recheck-link trim in the cards loop still strips every quote char; model-effort card's verify_cmd contains backticks → its mail cell renders broken (choose code-span delimiter by content); `half_life_days` not validated as a number; dead code (brand fallback in guides loop, display_link, guides awk never reads recheck:); jq fallback may return "null"; awk on office (mawk?) untested with the new trim().
- [ ] **Autonomous card-refresh loop — handoff DRAFT awaiting majkee's gavel:** ia-sync .dev/session/zsh-scheduler-00-epoch-autonomous-card-refresh/raw/HANDOFF.epoch.autonomous-card-refresh.2026-11-23.md (addressed to Atlas+Trajectory; six open questions §8; nothing built, nothing locked).
- [ ] **Chapter owner unassigned:** raw.guides/scheduler/res/harness-check.md (majkee named candidates Atlas+spawns / Trajectory / Cartan, not chosen).
- [ ] **Hand cleanup (majkee):** delete ~/.config/zsh/guides/ai.md on home (no source; stale/wrong); delete old ai/harness-check.zsh on all hosts after the new service has run once; archive old date-named stale mails if wanted.
- [x] **Role statement for the supervisor group filed:** ia-sync .dev/session/germline-A1-vi-agents/raw/007-researcher/EPOCH.role-and-inputs.2026-11-25.md (moved there from 006-supervisor on majkee's correction; commit `fad1c42` in ia-sync).
- [ ] **18 guides never tracked** — have verified: but no half_life_days:, so harness-check skips them (browser-egress, bus, cold-start-card, gemini-seats, guide-writing, harness-check, laravel-daily-epistemics, machine-home, machine-office, meeting, project-topology, regime-session, runbook, session-browser, status, temple-mail, tree-snapshot, tunnel). Needs majkee's half-life numbers (or a default). Also no verified: at all: gty addendum card; 9 guides without frontmatter.
- [ ] **Guide rows all render as "guide:GUIDE (GUIDE)"** — script derives name from filename (every file is GUIDE.md); fix = use parent dir name. Not done.
- [ ] **Deploy chain for the patch:** see the stale-job bullet above. Deployed `~/.config/zsh/guides/ai.md` has NO source (copied 2026-06-29, absent on office, old backup at `~/www/oldSync/bckp/dot.config@zsh/guides/ai.md`) and is largely stale/wrong: `gemini-base.zsh` missing, `g-astro`/`g-epoch`/`g-vega` aliases gone, alias is `harness-stale` not `aihs-stale`, `~/reposoma/.git/hooks/post-commit` missing, timer not on home, daily mail name, sample output from June. Decision: retire — majkee deletes by hand; keep the 0009-L5 lesson + doorbell smoke probe docs if wanted elsewhere.
- [ ] **Uncommitted from this session:** raw.settings cards claude-code/cursor-ide/codex-cli, pulse.epoch.md, raw.guides/scheduler/{GUIDE.md,res/}, ~/ia-sync/zsh/ai/harness-check.zsh. Nothing pushed.
- [ ] **claude-code card — header bumped 2026-11-23, PARTIAL.** Delta section covers v2.1.321–330 + settings hierarchy; **v2.1.294–320 still not itemised**, docs pages (MCP/skills/hooks) not re-fetched.
- [ ] **15 of 20 dated `raw.settings` cards past half-life** after 2026-11-23 refreshes of claude-code, cursor-ide, codex-cli (still stale: the rest; `nature`, `autonomous-orchestrator`, `claude-code`, `cursor-ide`, `codex-cli` are inside). Not refreshed. Per-card table: `_mail/toAll/inbox/epoch.stale-cards.2026-11-23.md`.
  Refresh needs majkee's pick of which cards, in what order.
- [ ] **Claude Code changelog v2.1.294–320 never itemised** (v2.1.321–330 done 2026-11-23). Page is 1.4M chars; use WebFetch offsets ≥200000 or github CHANGELOG.md.
- [ ] **Vendor-page checks outstanding (aggregator-only claims, rated M):** Fable 5.2 / Mythos 5.2 (9 Nov,
  `$8/$40` for Fable 5.2) → anthropic.com; Cursor 2026.11.05–06 → cursor.com/changelog; Google/Antigravity
  November news (none found) → geminicli.com/docs/changelogs + antigravity.google changelog.
- [ ] **Not covered in the 2026-11-23 edition:** OpenAI/Codex, OpenRouter, Laravel, Arch news,
  newsletters, open-model corner.
- [ ] **`worktree.bgIsolation`** — allowed values / default / min version NOT read (index says scope "Any
  file"). nablarva `.claude/settings.json` sets `"none"` (commit `6f5af9e`, pushed). Read
  `code.claude.com/docs/en/settings-reference#worktree-bgisolation` before anyone relies on it.
- [ ] **majkee: `_mail` README mismatch.** RESOLVED 2026-11-23 — mail IS git-tracked and syncs (README fixed); only the unread 11-09/11-16 mails remain the receiver's to archive.
- [ ] **majkee/harness-check owner: generator defects** — empty-name rows (`eagle`, `machine.office`,
  `reposoma`); addendum card lacks `verified:`; README "monthly" vs weekly Monday mails since 2026-09-07.
- [x] **settings.json vs settings.local.json answered + card section fixed** — reposoma `e0c0ccb`, pushed.
- [x] **nablarva `.claude/settings.json` created + pushed** — nablarva `6f5af9e`.
- [x] **Epoch Gazette 2026-11-23 filed** — `.majkee/journal/newspaper.2026-11-23.md`, reposoma `06f2976`, pushed.
- [x] **pulse.epoch.md created + pushed** — reposoma `0a0abf3`.
- [x] **Curated staleness mail committed + pushed** — `_mail/toAll/inbox/epoch.stale-cards.2026-11-23.md`, reposoma `2b13425`.

---

## [2026-11-25 harness fixes + handoffs]
- Source fixes in ia-sync (all pushed): `8b4d3ed` moved harness-check to zsh/scheduled (11-23); trailing-slash fix (swept into majkee's `5ba9eb0`, 11-24) — `mail-inbox-dir` had a trailing slash and the script appended `/`, giving a double slash; `dc897cc` unit-separator field delimiter — 5 live verify_cmd values contain `|`, which broke the pipe-delimited rows; `fa3071e` strip ONE outer quote pair — gsub stripped every quote char, so `grep -c '<item>'` lost its closing quote (4 live cards affected: agent-docs, arch, laravel, openrouter).
- Discovery: the first commit attempt found a CLEAN tree because majkee's `5ba9eb0` had already swept the fix and the handoff in. Lesson: check git log before assuming uncommitted.
- Handoff: ia-sync `.dev/session/zsh-scheduler-00-epoch-autonomous-card-refresh/raw/HANDOFF.epoch.autonomous-card-refresh.2026-11-23.md`. Role file: ia-sync `fad1c42` (`.dev/session/germline-A1-vi-agents/raw/007-researcher/EPOCH.role-and-inputs.2026-11-25.md`).
- Corrections to myself: (i) I relayed a Zenith claim of a half_life/half_life_days "key mismatch" without checking — false; (ii) I wrote "job not installed" after checking only home — it ran on office; (iii) I misread the mail inboxes as non-syncing — they sync via git, the job just doesn't commit; (iv) I bumped claude-code `verified:` after a PARTIAL read (gap v2.1.294–320 still open).
- Sources: Delta/Trajectory reports this session; ia-sync commits; fetched changelogs 2026-11-23.

## [2026-11-23 stale-job patch]
- (a) Cron check on host `home`: no timer installed; the script only writes the alert mail and spawns no research.
- (b) Design chosen: all hosts run the timer; mail keyed by ISO week (`zsh.stale-settings-cards-<YYYY-Www>.md`); deterministic body (no host/time); temp-file + `cmp` skip-if-unchanged; last writer wins; best-effort `git pull --ff-only` before scan; never commits. Brand fallback to card name for empty-name rows.
- (c) CORRECTION to myself: I (relaying a Zenith scan) claimed a `half_life` vs `half_life_days` key mismatch. That was FALSE: every card with `half_life:` already has `half_life_days:`. The real gap is the 18 untracked guides (see ledger).
- (d) I first patched the deployed `~/.config/zsh` copy, then learned zsh is deployed from `~/ia-sync/zsh` via deploy.sh. Delta ported the patch to source (source was byte-identical to the pre-patch backup). Backup at the session scratchpad `harness-check.zsh.bak`.
- (e) `zsh -n` OK and `--debug` run clean. Non-debug mode and systemd NOT run.
- Later same day: office check (read-only, via ssh) found the timer running with old script; design changed to single-writer (office), script moved to ia-sync `zsh/scheduled/` (Delta, uncommitted). My claim "mail doesn't sync" was a misread — it syncs via git; the job doesn't commit.
- Open: claude/houston.goal:13 mentions ai/harness-check.zsh (historical, left); office ~/reposoma has uncommitted _cold-start/.majkee changes — a pull there must not touch them.

## [2026-11-23 card-refresh pass]
- Refreshed from live changelogs: claude-code (partial — v2.1.321–330 itemised; v2.1.294–320 not), cursor-ide, codex-cli.
- Cron check on host `home`: no weekly staleness job installed (no crontab, no user timers, no harness.timer/service). Details in ledger.
- Remaining 15 stale cards need majkee's priority pick.

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
