---
card: reposoma
kind: project-regular-self-report · RELATIVE (monthly, refreshable via /project-regular-self-report reposoma)
host: both
status: live
stack: zsh · markdown · Claude Code agents/skills
verified: 2026-10-08
half_life_days: 30
beacon: — (this IS the temple / meta-repo)
repo: github.com/hruzam/reposoma (private, branch core)
---

# reposoma — project log

Skill: `/project-regular-self-report reposoma`
Authoritative sources: `pulse.claude.md` (Houston/Flight) · `pulse.atlas.md` (Atlas) ·
`temple/decisions/index.md` · `registry/index.md`
Note: reposoma has no `.dev/` harness — it IS the temple. Read its own pulse files and
decisions index in place of the standard harness read order.

<!-- newest run first — appended by /project-regular-self-report -->

## Refresh delta 2026-11-25

_PARTIAL: local read-only pass by @Epoch's sibling, host home. Verified: ledger, registry, directory layout, git/hook state, mail dirs, guides, cards, skills/agents dir listings. NOT verified: open items, phase, gate/blocker (judgment content), live runtime agent list (only ~/.claude/agents/*.md names listed), remote GitHub state (no network call). Card NOT bumped._

**Lead:** structure is stable since 2026-10-08 (same 12 locks, same registry) but the entry path in AGENTS.md has drifted from disk, and the git post-commit doorbell hook is absent on this host.

**Verified unchanged (H):**
- Repo/branch: `git branch -vv` -> `* core ... [origin/core]`; `git remote -v` -> `origin git@github.com:hruzam/reposoma.git`. Only branch locally and on origin (`git branch -a`). Matches card `repo:` line.
- Locks: `ls temple/decisions` -> 0001-0010, 0012, 0013 + index.md = 12 locks; no 0011 file; index.md still carries the "Gap note - 0011 reserved". Latest commit touching temple/decisions: 2026-09-03 (`git log -1 -- temple/decisions`). The 12-lock count and 0013 precedence stone stand. Still-open items O1/O2/O4 present in index.md.
- Registry: `registry/index.md` table lists reposoma, subai.devenv, reposoma.devenv, freya, freya.devenv, piql.dev, vacuole, nabla-lab, jar-kuba, pajdulium-web, pajdulium-studio, fantasyobchod, ham, applications-in-common = 14 rows (freya/freya.devenv "beacon pending"). Beacon files in registry/: applications-in-common, fantasyobchod, ham, jar-kuba, nabla-lab, pajdulium-studio, pajdulium-web, piql.dev, reposoma.devenv, subai.devenv, vacuole (+ README, index, _beacon.template, projects/).
- Layout: AGENTS.md (55 lines) and CLAUDE.md (1 line, `@AGENTS.md`) present; `.majkee/` (journal, projects, therapy, engine, helpers, SHM.md), `_cold-start/` (card 64, issues 10 incl. README -> 9 ISS cards, routines 5, archive), `raw.settings/`, `raw.research/` (30 entries), `raw.guides/` (41 entries), `_mail/` (agol astrobley atlas cartan delta-sql epoch flight houston monkey oraculum piql subai symmetry toAll trajectory vega + README.md). `raw.canon/` holds 12 canon files. 1156 tracked files, 437 commits; 25 commits on 2026-11-25, 8 on 11-23, 1 on 11-24 since the card's last run.
- Cards: `ls raw.settings/raw.card.*.md` = 21 (incl. this one). Template is `raw.settings/card.template.md`.
- Pulse files (mtime / newest dated entry): pulse.atlas.md 2026-11-22 (newest header `[2026-11-22 runbook-retire]`) | pulse.epoch.md modified 2026-11-25 | pulse.claude.md Jul 30 mtime, newest header `[2026-07-09 ...]` (still stale, ~4.5 months) | pulse.flight.md 2026-09-02 mtime | pulse.gemini.md 2026-06-22 | pulse.md 2026-09-02. `majkee.news.md` mtime Jul 30.

**Drift found:**
1. **Post-commit doorbell hook MISSING (H).** `ls ~/reposoma/.git/hooks` -> only `*.sample` files, no `post-commit`; `git config core.hooksPath` -> unset. `temple/tools/tools.md:15` still says "hook installed 2026-06-25 (live)" and decision 0009 describes the post-commit doorbell (`temple-doorbell-run`). On this host the doorbell cannot fire from commits. (Other machine not checked.)
2. **AGENTS.md saddle step 3 points at a path that does not exist (H).** "most recent `_mail/monkey/inbox/houston.monkey-not-forget-this.*.md`" -> no such file in inbox; all houston.monkey-not-forget-this.* files are in `_mail/monkey/archive/`, newest `houston.monkey-not-forget-this.2026-07-09.md`. `_mail/monkey/inbox` holds only 10 other-agent files (2026-06..08). The "you are here" memo has been frozen since 2026-07-09.
3. **`.host` says `office` on a home machine (H).** `cat ~/reposoma/.host` -> `office`; `echo $MACHINE_NAME` -> `home`. Card frontmatter `host: both` is defensible; the per-repo `.host` marker is not per-machine (git-tracked, shared).
4. **Scheduler guide rename (H).** `raw.guides/harness-check` does not exist; `raw.guides/scheduler/` (GUIDE.md + res/harness-check.md, res/verify-trigger.md) is the current home. This card cites neither, so nothing in it is wrong; but `pulse.epoch.md`, `pulse.atlas.md`, `raw.guides/sella/GUIDE.md`, `temple/decisions/0009...md`, `_mail/README.md` and `_mail/toAll/inbox/epoch.stale-cards.2026-11-23.md` still mention "harness-check" (not checked whether as the old guide path or the res/ file).
5. **Skills count in the 2026-10-08 block is outdated (H).** `ls ~/.claude/skills | wc -l` -> 40 dirs (card: 36); `SKILL.md` present in 39 of them. Added since: claude-creator, fetch-agent-docs, fetch-ollama-docs, fetch-qwen-docs (listed dirs). Previously listed ones still present, incl. chatbot-port, drop-brief, synced, track-run. `octo`, `gavel-ballot` still absent.
6. **Agent definitions (M):** `~/.claude/agents` = 34 `.md` files; includes `metaterminal.md` (not in the card roster), still-on-disk `hypatia.md`, `maxwell.md` (retired stubs), `capcom.md` (retired 2026-10-17 per runtime list, so now retired - card lists it as live). `ptyra-ac-journal` and `epoch` card: ptyra-ac-journal appears in the runtime agent list but has no file in ~/.claude/agents (likely project-scoped; not checked).
7. **Mail:** `_mail/toAll/inbox` has `epoch.stale-cards.2026-11-23.md` (stale_count: 18) plus weekly `zsh.stale-settings-cards-*` items 2026-09-07..11-02 (unread-by-name; not opened beyond header). `_cold-start/issues` now includes `ISS.jev-score-wire-consistency.2026-11-10.md` (new since card).

**Not checked:** open items / phase / gate (pulse.claude.md is stale so cannot confirm); contents of _mail inboxes; whether the doorbell is installed on office; origin remote state (no fetch).
## 2026-10-08

**Self-report refreshed by @Epoch (research seat), not by the temple master. Verified: ledger, agent roster, skills directory, git activity. NOT verified: open items, phase.**
**Phase:** active — continuous operation (no single phase).
**Stack:** zsh · markdown · Claude Code primitives (agents/skills/hooks) · Codex line (Cartan resident, Astrobley, Vega/Mirror relays) · _mail/ bus · registry/beacons · decision ledger · `_cold-start/` cards
**Status:** live
**Locked decisions:** 12 (0001–0010, 0012, 0013). 0011 is reserved for Oraculum's in-flight writer-partition draft (index.md gap note). 0013 = the precedence stone (2026-09-03). 0005 amended A1 2026-07-24 (peer seat Gemini → Codex/GPT). Source: temple/decisions/index.md.
**Recent activity (git status/log at session start, 2026-10-08):** `_cold-start/` cards for Nablarva X0/X1 (Codex head card), the Oraculum Bash-whitelist hook card, an open issue `ISS.guard-destructive-reads-dead-env-var.2026-10-08`, `pulse.atlas.md` modified.
**Agents in scope (global, live runtime list 2026-10-08):** houston · flight · atlas-auto · atlas-ui · eagle · zenith · zenith-zsh · epoch · janus · agol · oraculum · symmetry · vara · trajectory · delta · delta-sql · vector · assay · field · capcom · recorder · color · shannon · ferry · mirror · vega · astrobley (Codex line) · ptyra-ac-journal · advisor-{low,mid,advanced,high} · utility: claude · claude-code-guide · statusline-setup · zed-editor-expert. Retired: maxwell (2026-09-01), hypatia (→ oraculum). `atlas` is NOT a standalone agent (atlas-ui / atlas-auto).
**Skills in scope (global, 36 dirs under ~/.claude/skills; SKILL.md presence not checked):** agol-brief · buffering-creative-triad · buffering-cycle · chatbot-port · cmd-zen · cold-start-card · devenv-sync · drop-brief · first-person-voice · gavel-interpreter · gavel-loop · goal · guide · issue-card · learn-repomix · new-project · program-pulse · project-document · project-read · project-regular-self-report · pull · rc-launch · refresh · regime-arch · remote-read · remote-write · runbook · run-synthesis · session-resume · socratic-therapy · synced · take-pin · therapy · trace-refs · track-run · tree-snapshot. Gone since 07-15: octo, gavel-ballot (no such dir; successor unknown).
**Open items:** NOT re-verified. The 07-15 items (T1 twin read-side gavel bundle, Claviature design, track-back tooling) may be closed — `pulse.claude.md`'s newest entry is dated 2026-07-09, so the shared pulse itself looks stale. Check `pulse.atlas.md`, `pulse.flight.md` and the latest `_mail/monkey/inbox/houston.monkey-not-forget-this.*.md`.
**Gate/blocker:** unknown — see above.

## 2026-07-15

**Phase:** active — no single phase; continuous operation. T1 (twin read-side) gavel-ready
but blocked on majkee bundle sign-off.
**Stack:** zsh · markdown · Claude Code primitives (agents/skills/hooks) · _mail/ bus ·
registry/beacons · decision ledger (0001–0010 locked)
**Status:** live
**Open items:**
  · T1 twin read-side binding-spec — gavel bundle pending majkee (contract + tools.md:16 repoint + spec)
  · Claviature design session — needs Houston design + Janus pass
  · track-back tooling — @Delta post gavel, sandboxes line pending
**Locked decisions:** 10 total (0001–0010)
  · 0004 L4 — no ~/paths in canon/beacons; physical paths only in temple-project-map.zsh
  · 0008 — temple-project-map.zsh as the single P0 physical-path map
**Agents in scope (global):** houston · flight · atlas · atlas-auto · atlas-ui · eagle ·
  zenith · epoch · janus · agol · oraculum · symmetry · vara · trajectory · delta · vector ·
  capcom · recorder · color · maxwell · shannon · advisor-{low,mid,advanced,high}
**Skills in scope (global):** project-read · project-regular-self-report · refresh · pull · devenv-sync ·
  trace-refs · tree-snapshot · session-resume · program-pulse · octo · run-synthesis · therapy · goal ·
  agol-brief · gavel-ballot · regime-arch · buffering-cycle · buffering-creative-triad ·
  first-person-voice · learn-repomix
**Siblings:** all projects (meta-repo — the registry IS the sibling graph)
**Gate/blocker:** T1 gavel bundle — majkee's gate before dispatch

<!-- older runs appended below this line, newest first -->
