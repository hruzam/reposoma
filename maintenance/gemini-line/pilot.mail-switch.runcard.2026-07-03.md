# RUN CARD — Gemini Coder Pilot: `mail-switch.zsh`
# Operator-driven, by hand. Protocol: ledger → diff → apply → test → iterate. Ceiling: 4 turns.
#
# ── PILOT VERDICT (2026-07-03): GREEN at turn 2/4 ─────────────────────────────
# Turn 1: 88s — complete correct code; infra note: hunk header miscount (fixed forever
#         via git apply --recount); one genuine bug: `fpath` = reserved zsh special var.
# Turn 2: 5.6s — surgical rename, TUI fully working (arrows, space, cross-receiver batch
#         archive, backloop, quit). First-pass apply: yes. Iterations to green: 1.
# ──────────────────────────────────────────────────────────────────────────────
#
# STATUS REWIRED 2026-07-07 (Oraculum): PARKED. Sandbox verified intact at
# _mail/toAll/gemini-line/pilot-mailswitch.parked/ (ledger + script + turn diffs + .git).
# Ext-1 APPLIED (warn path verified; positive path pending). Ext-2 APPLIED via ext-2b
# re-anchor turn (turn-ext2b.diff on disk) — functional verification PENDING.
# Remaining: Ext-2 VERIFY → Ext-1 positive path → Step 6 (deploy + acceptance ride).
# Resume path + fallbacks: handoff.gemini-pilot.parked.2026-07-03.md (rewired copy).

## Step 0 — persona generalization — DONE
## Step 1 — sandbox — DONE (fixture state at parking: drifted by manual play — re-seed
##          _mail/<r>/inbox|archive/ fixtures before judging extension behavior)
## Steps 2–5 — DONE, verdict above.

## Step 6 — deploy (run LAST, after extensions pass)

```zsh
cp /tmp/pilot-mailswitch/mail-switch.zsh ~/.config/zsh/ai/mail-switch.zsh
chmod +x ~/.config/zsh/ai/mail-switch.zsh
cd ~/reposoma && zsh ~/.config/zsh/ai/mail-switch.zsh   # the real acceptance ride
```

## Step 7 — EXTENSION 1 (brownfield): the archive queue

Purpose: Bash-less agents (Write-only seats) cannot run any command — they close the loop
by APPENDING one line `receiver/filename` to `_mail/.archive-queue`. mail-switch drains it.

```zsh
cd /tmp/pilot-mailswitch
printf '%s\n' 'atlas/a2.md' 'houston/nope.md' > _mail/.archive-queue   # 1 valid, 1 missing
time ~/.config/zsh/ai/astrobley.sh --patch "$L" 'EXTENSION to the existing mail-switch.zsh (current state = all your previous diffs applied). Add an archive-queue drain feature:
- Queue file: <mail-root>/_mail/.archive-queue — plain text, one entry per line, format receiver/filename. Written (appended) by agents that cannot execute commands.
- On start of ANY mode and on every backloop refresh: if .archive-queue exists and is non-empty, move each listed file from _mail/<receiver>/inbox/ to _mail/<receiver>/archive/ (mkdir -p; if a listed file is missing, print a warning and continue). Then truncate the queue file. In TUI, show a one-line note: "drained N queued (M skipped)".
- New headless mode --drain: only performs the drain, prints the same summary, exit 0 (also exit 0 when queue empty or absent).
- Reminder: fpath/path are reserved zsh variable names — avoid.
Return ONLY the unified diff against the current file.' > turn-ext1.diff

git apply --recount --check turn-ext1.diff && git apply --recount turn-ext1.diff && echo APPLY-OK
zsh -n mail-switch.zsh && echo SYNTAX-OK
zsh mail-switch.zsh --drain          # expect: a2.md moved, warning for houston/nope.md,
                                     # queue truncated to 0 lines
ls _mail/atlas/archive/              # expect: a1.md a2.md
```

Ext-1 scorecard: apply [x] · drain behavior [x warn path · positive path PENDING] · wall: ___s · iterations: __

## Step 8 — EXTENSION 2 (brownfield): reversible mechanism (restore)

Design lock (Oraculum lean, operator-approved pending): TAB toggles INBOX ↔ ARCHIVE view;
in ARCHIVE view the "a" action RESTORES marked files. No undo stack, no new concepts.

*(2026-07-07 note: first ext-2 diff failed to apply — context drift; the ext-2b re-anchor
turn with full-file ground truth RAN + APPLIED before parking. Code is in the parked script:
TAB toggle, ARCHIVE view, --restore, view-aware hints. Do NOT re-fire the prompt below unless
verification fails — see the rewired handoff for the verify sequence + fallback prompt.)*

```zsh
cd /tmp/pilot-mailswitch
time ~/.config/zsh/ai/astrobley.sh --patch "$L" 'EXTENSION 2 to the existing mail-switch.zsh (current state = all previous diffs applied). Add a reversible/restore mechanism:
- TUI: TAB key toggles between INBOX view (current behavior, scans _mail/*/inbox/) and ARCHIVE view (scans _mail/*/archive/, same tree rendering, same checkbox marking). In ARCHIVE view the "a" key RESTORES all marked files: mv each back to its own _mail/<receiver>/inbox/ (mkdir -p if missing). Backloop refresh stays in the current view. Status line shows the active view name (INBOX / ARCHIVE) and the action hint changes accordingly (Archive marked / Restore marked).
- Headless: --restore <receiver>/<filename> — mv from _mail/<receiver>/archive/ to _mail/<receiver>/inbox/ (mkdir -p inbox), exit 0 on success, exit 1 + message if file missing.
- Never delete anything. Queue drain (if present) runs only in INBOX view refreshes.
- Reminder: fpath/path are reserved zsh variable names — avoid.
Return ONLY the unified diff against the current file.' > turn-ext2.diff

git apply --recount --check turn-ext2.diff && git apply --recount turn-ext2.diff && echo APPLY-OK
zsh -n mail-switch.zsh && echo SYNTAX-OK
zsh mail-switch.zsh --restore atlas/a1.md && ls _mail/atlas/inbox/   # expect: a1.md back
zsh mail-switch.zsh    # TAB → ARCHIVE view shows a2.md; mark it, "a" → restored;
                       # TAB back → INBOX view shows it; "q"
```

Ext-2 scorecard: apply [x via ext-2b re-anchor] · restore behavior [ ] · TAB toggle [ ] · wall: ___s · iterations: 1 (context-drift re-anchor)

## Step 4 pattern — iteration on any extension failure (unchanged)

```zsh
FB="Turn N feedback. FAILURE: $(zsh -n mail-switch.zsh 2>&1). Relevant region:
$(sed -n '<start>,<end>p' mail-switch.zsh)
Current file state = your last diff applied. Return a corrected unified diff."
time ~/.config/zsh/ai/astrobley.sh --patch "$L" "$FB" > turnN.diff
```
Diff won't apply even with --recount → request full-file rewrite diff.
503 → re-fire: `~/.config/zsh/ai/astrobley.sh --patch "$L"` (no message; ledger holds the turn).
TUI crash with clean syntax → `zsh -x ./mail-switch.zsh 2>tui-trace.log; echo "exit=$?"` and
send trace tail as feedback.

## Post-green bookkeeping (one gaveled batch, after Step 6)
- file-map entries: ai/README.md + zsh AGENTS.md · ia-sync commit
- doc line for Bash-less seats ("after processing mail, append receiver/filename to
  _mail/.archive-queue") — belongs in `_mail/README.md` = mail canon → operator gavel
  *(still open, checked 2026-07-07)*
- PROTOCOL PATCHES (permanent, from this pilot): git apply --recount mandatory · zsh
  reserved-vars reminder line in coding-task prompts · xtrace probe as standard TUI debug
- Ledger `pilot-mailswitch.parked/ledger.json` → keep; first real specimen of the protocol.
