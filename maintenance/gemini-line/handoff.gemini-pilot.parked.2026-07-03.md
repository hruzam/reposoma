# HANDOFF — PARKED: Gemini rebuild + coder pilot (Oraculum session, 2026-07-03)
# Resuming seat: read this + the runcard (pilot.mail-switch.runcard.2026-07-03.md). That is all.
# REWIRED 2026-07-07 (Oraculum, post temple-reshape): state below re-verified against disk.
# FORENSIC PASS 2026-07-07 (Oraculum + @Delta, operator lost 3 days of track): NO post-parking
# work exists anywhere — zero mtime deltas in ~/.config/zsh and ia-sync between 07-03 11:32
# (parking) and 07-07 (reshape work, unrelated). The parked copy below IS the frontier. The
# remembered astrobley "cure" = the 07-03 REST-only rebuild itself (P1: no CLI in headless
# paths — Class C hang amputated); deployed and ia-sync copies byte-identical, synced in d14b77a.

## ✓ RESCUE DONE — sandbox parked and verified intact (2026-07-07)
`pilot-mailswitch.parked/` holds ledger.json (5 turns: build → fpath fix → ext-1 → ext-2 →
ext-2b re-anchor), mail-switch.zsh (both extensions integrated), all 5 turn diffs,
tui-trace.log, and the sandbox's own `.git` (1 commit: fixture). Live /tmp copy confirmed
GONE (reboot) — this parked copy is the sole surviving state. On resume:
```zsh
cp -r ~/reposoma/_mail/toAll/gemini-line/pilot-mailswitch.parked /tmp/pilot-mailswitch
export L=/tmp/pilot-mailswitch/ledger.json
```
⚠ **Gitignore shadow gotcha:** `_mail/.gitignore` ignores `*` — glob/ls-style agent tools may
report this subtree as EMPTY. It is not. Read files directly; trust `cat`, not listings.
⚠ **Durability flag (operator):** same shadow means `git add -A` never committed the
gemini-line files unless force-added. If this parked line must survive the machine:
`git add -f _mail/toAll/gemini-line/ && git commit`. Verify: `git log --oneline -- _mail/toAll/gemini-line/`.

## You are here (re-verified 2026-07-07, forensic-confirmed)
- **Gemini rebuild: COMPLETE, deployed, tested, synced.** `~/.config/zsh/ai/` REST-only
  headless, all live-fire green (7–25s), cross-check 6s. ia-sync `bc337d4` + `d14b77a`
  pushed; deployed astrobley.sh == ia-sync copy (MD5-verified). Operator field report
  07-07: coder runs normally in practice — harness (gemini CLI) was the only problem, cured.
- **Coder pilot mail-switch.zsh: GREEN at turn 2/4** (88s + 5.6s; 1 iteration — `fpath`
  reserved-var bug). TUI works: arrows, space, cross-receiver batch archive, backloop.
- **Ext-1 (archive queue): applied**, warn path verified live; **positive path PENDING**
  (fixture had drifted — operator's manual TUI play consumed a2.md; not a defect).
- **Ext-2b: RAN + APPLIED before parking:** `turn-ext2b.diff` on disk (new-file diff, as
  demanded); parked `mail-switch.zsh` contains drain + TAB INBOX/ARCHIVE toggle + `--restore`
  + view-aware hints. **Functional verification NOT yet done** — resume = verify, not regenerate.
- **NOT deployed:** no `mail-switch.zsh` in `~/.config/zsh/ai/`; no bookkeeping references
  anywhere in config (grep-verified 07-07) — Step 6 + bookkeeping fully ahead. Correct.

## Topology note — the reshape changed the neighborhood, not this tool
`temple-mail.zsh` (send) + `temple-mail-inbox.zsh` (list-only read side) are now deployed in
`~/.config/zsh/ai/` — decision 0008 Stage-1 primitives; the AGENTS.md saddle references
`temple-mail-inbox <origin>:<seat>`. **mail-switch is the operator TUI flush + archive-queue
drain — complementary, NOT superseded.** Boundary: decision 0010 locked cross-machine mail as
append-only events; mail-switch's `mv`-based inbox↔archive transitions are **local-single-host
only** — never extend it cross-machine.

## Next actions, in order (~15 min operator terminal time to close)

### 1. Ext-2 verification (code already applied — verify, don't regenerate)
```zsh
cd /tmp/pilot-mailswitch
zsh -n mail-switch.zsh && echo SYNTAX-OK
zsh mail-switch.zsh --restore atlas/a1.md && ls _mail/atlas/inbox/
zsh mail-switch.zsh    # TAB → ARCHIVE view, mark, "a" restore, TAB back, "q"
```
Fixtures may have drifted (manual play + prior gates) — re-seed `_mail/<r>/inbox|archive/`
files as needed before judging behavior. Score the runcard Ext-2 boxes on results.

**Fallback only if verification FAILS** — re-fire the re-anchor turn (ground-truth prompt):
```zsh
FB="Your EXTENSION 2 diff did not apply cleanly — here is the CURRENT COMPLETE file on disk (ground truth):
$(cat mail-switch.zsh)
END OF CURRENT FILE. Re-emit EXTENSION 2 against exactly this content: TAB toggles INBOX/ARCHIVE view; in ARCHIVE view 'a' RESTORES marked files to their receiver's inbox (mkdir -p); headless --restore <receiver>/<filename> (exit 0 / exit 1 + message); status line shows active view + action hint; never delete anything; queue-drain runs only in INBOX-view refreshes; fpath/path are reserved zsh names.
FORMAT: a NEW-FILE unified diff (--- /dev/null, +++ b/mail-switch.zsh) containing the FULL updated script. Return ONLY the diff."
time ~/.config/zsh/ai/astrobley.sh --patch "$L" "$FB" > turn-ext2c.diff
rm mail-switch.zsh
git apply --recount --check turn-ext2c.diff && git apply --recount turn-ext2c.diff && echo APPLY-OK
```

### 2. Ext-1 positive-path close (30s)
```zsh
cd /tmp/pilot-mailswitch
echo m5 > _mail/atlas/inbox/a5.md
printf '%s\n' 'atlas/a5.md' > _mail/.archive-queue
zsh mail-switch.zsh --drain               # expect: drained 1 queued (0 skipped)
ls _mail/atlas/archive/ | grep a5         # expect: a5.md
cat _mail/.archive-queue | wc -l          # expect: 0
```

### 3. Deploy + acceptance ride (runcard Step 6)
```zsh
cp /tmp/pilot-mailswitch/mail-switch.zsh ~/.config/zsh/ai/mail-switch.zsh
chmod +x ~/.config/zsh/ai/mail-switch.zsh
cd ~/reposoma && zsh ~/.config/zsh/ai/mail-switch.zsh   # first honest flush of real backlog
```

### 4. Post-green bookkeeping (one gaveled batch — runcard tail)
file maps (ai/README.md, zsh AGENTS.md) · ia-sync commit · protocol patches into
guide-for-user.md driver docs (see lessons below)

## Protocol lessons locked this session (fold into driver docs at bookkeeping)
1. `git apply --recount` ALWAYS — never trust LLM hunk arithmetic
2. Reserved-zsh-vars reminder line (`fpath`/`path`) in every zsh coding prompt
3. TUI debug = xtrace probe: `zsh -x ./script 2>trace.log; echo $?` — trace, don't guess
4. Brownfield turns carry the CURRENT file content — ground truth beats ledger memory
5. Manual play between scripted gates mutates fixtures — acceptance ride comes AFTER gates
6. *(added 2026-07-07)* Gitignore-shadowed trees look empty to listing tools — verify by
   direct read before declaring artifacts lost
7. *(added 2026-07-07)* When track is lost, the filesystem is the handoff: mtime sweep +
   clean-repo checks reconstruct days of history in minutes — and beat remembered state

## Open gavels / parked tickets (operator) — status re-checked 2026-07-07
- **STILL OPEN** — `_mail/README.md`: add Bash-less-seat queue protocol line ("after processing
  mail, append `receiver/filename` to `_mail/.archive-queue`") (mail canon → gavel). Checked
  07-07: line absent.
- **STILL OPEN** — reposoma `AGENTS.md`: ImportProcessor escape for bare `@Trajectory / @Delta`
  mentions. ⚠ line ref was 24, now stale — the loop line is **line 37**, and the 2026-07-07
  Flight-saddle bullet added more unescaped mentions (~lines 11–18). Anchor by content, not line.
  (pulse.atlas WP-D: deliberately untouched per standing instruction.)
- **DONE (confirm at gavel batch)** — @Atlas ticket, `gemini-cross-check.md` no-narration
  contract: rebuilt agent now carries "Return @BlueBottle's output verbatim — no editorializing"
  + graceful-fail passthrough. Covered.
- **DONE** — staging retirement: `~/reposoma/ai_scripts` absent, verified 07-07.
- **DONE** — run-shape skills line (side thread): `run-task` + `run-synthesis` delivered by
  Atlas; mis-filed request mail re-filed to `_mail/atlas/archive/`. Awaiting skill gavel only.
- **PHP pilot — the real "colleague vs agy" verdict — next session after mail-switch closes.**
  Protocol proven; needs: repo path + file + task sentence from operator.

## Artifact map (all in _mail/toAll/gemini-line/ — presence verified 2026-07-07)
- `pilot.mail-switch.runcard.2026-07-03.md` — THE working doc, verdict header current
- `handoff.gemini-rebuild.md` + `handoff.gemini-rebuild.addendum-hang.2026-07-03.md` — specs
- `triage.gemini-hang.2026-07-03.md` · `report.gemini-fix-pass.2026-07-03.md` ·
  `report.gemini-t2-livefire.2026-07-03.md` — evidence chain
- `draft.gemini-coder.patch-protocol.2026-07-03.md` — gaveled concept
- `task.gemini-coder.build.2026-07-03.md` — build spec (executed)
- phase0/1/2 task files — phase1 stamped SUPERSEDED, do not execute
- `pilot-mailswitch.parked/` — the sandbox, frozen 2026-07-03 11:32 (ledger.json = first
  protocol specimen; 5 turns; KEEP)
- deployed layer: `~/.config/zsh/ai/` (via ia-sync, clean @ `d14b77a`)
