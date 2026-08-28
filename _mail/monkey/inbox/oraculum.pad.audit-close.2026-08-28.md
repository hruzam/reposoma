# pad.1-audit-close — close out the 2026-08-28 audit/cleanup session (what is on YOU)

> Operator bring-up/close surface. Sequential — one step, report back, next step.
> Driver: the driver (any seat helping, or solo). Everything below is reversible or gated;
> nothing you can do here is stupid or broken-forever — STEP 0 makes that true.
> Sitting length: ~15 min without step 2's edit branch, ~25 with it.

Project path used in all commands:
/home/hruzam/ia-sync

Precondition: you are on HOME (hruzam) with tailnet up (`ssh office` reachable).

---

### STEP 0 — state check (non-destructive, proves the session's end-state still holds)

```bash
echo $MACHINE_NAME; hostname -s; git -C /home/hruzam/ia-sync status --short; ls -d /tmp/*2026-08-28* /tmp/*2026-08-2[57]*
```

Expected: `home` + `hruzam`; ~6 modified/untracked files (AGENTS.md · codex/AGENTS.md ·
zsh/config.home.zsh · zsh/blessings/zsh-orphans.zsh · journal.host-cleanup.md ·
_mail/kelvin/inbox/oraculum.substrate-audit.forward-houston.2026-08-28.md); quarantine dirs
listed (normalizer-retired, codex-transcripts, codex-squatter-skills, plus the 08-25/08-27 sets).

- matches → proceed
- git status shows MORE than those files, or a quarantine dir is missing → STOP, flag Oraculum
  (something moved since the session; do not commit blind)

>MAJKEE report 0
```zsh

```

---

### STEP 1 — office Codex Desktop kill-switch (gaveled; sandbox blocked the agent, your hand needed)

```bash
ssh office 'cp ~/.codex/config.toml /tmp/config.toml.pre-flag-add-2026-08-28'
ssh office 'printf "\n[desktop]\nexternal-agent-import-sync-enabled = false\n" >> ~/.codex/config.toml'
ssh office 'tail -3 ~/.codex/config.toml'
```

Expected tail:
```
[desktop]
external-agent-import-sync-enabled = false
```

- shows exactly that → office exposure CLOSED; also retype/prune the matching HANDS line
- any error, or the key already present with `true` → STOP, paste output, flag Oraculum

>MAJKEE report 1
```zsh

```

---

### STEP 2 — LRV decision (only you hold ground truth; `~/www/larva` does not exist on disc)

First look at what is registered:

```bash
grep -n "LRV" /home/hruzam/ia-sync/zsh/config.home.zsh
```

Then pick ONE branch:

- **2a — you know the real path**: edit the `PROJECT_LRV_PATH` line in
  `/home/hruzam/ia-sync/zsh/config.home.zsh` to the correct absolute path, then:
  ```bash
  cd /home/hruzam/ia-sync && bash deploy.sh --dry-run
  cd /home/hruzam/ia-sync && bash deploy.sh
  zsh -ic 'echo $PROJECT_LRV_PATH; ls -d $PROJECT_LRV_PATH'
  ```
  `ls -d` resolves → proceed. Errors → STOP, flag Oraculum.
- **2b — the project is dead on home**: delete the LRV line(s) shown by the grep, run the same
  three commands; `echo` prints empty → proceed.
- **2c — undecided**: skip. LRV stays verbatim-broken (harmless — it was broken under the old
  normalizer too). Note "parked" in your report so the ledger stays honest.

>MAJKEE report 2
```zsh

```

---

### STEP 3 — verdict on the 20 HOLD skills (my lean: Codex-stock, KEEP permanently)

If you accept the lean, record it in one line so no future tidy session re-litigates:

```bash
echo "- 2026-08-28 verdict (majkee): 20 HOLD entries in ~/.agents/skills are Codex-stock (babysit, canvas, create-*, review*, sdk, shell, statusline, ...) — KEEP permanently, not drift." >> /home/hruzam/ia-sync/journal.host-cleanup.md
```

- ran it → proceed
- you want them quarantined instead → do NOT run; flag Oraculum for a fresh classified pass

>MAJKEE report 3
```zsh

```

---

### STEP 4 — commit sweep (AFTER steps 2–3, so their edits ride the same commit)

```bash
git -C /home/hruzam/ia-sync add -A
git -C /home/hruzam/ia-sync commit -m "audit 2026-08-28: multi-pair drift detector, normalizer retired (home), PSD case fix, Manjaro + Codex-flag docs, journal + kelvin mail"
git -C /home/hruzam/ia-sync push
```

Expected: one commit, ~6–8 files, push clean.

- clean → the session's work is landed; office picks it up on next pull
- push rejected / conflict → STOP, paste output, flag Oraculum (do not force)

>MAJKEE report 4
```zsh

```

---

### STEP 5 — mail + HANDS hygiene (closes the loop that opened this session)

```bash
mv /home/hruzam/reposoma/_mail/monkey/inbox/CS.zsh-drift-cleanup.2026-08-25.md /home/hruzam/reposoma/_mail/monkey/inbox/CS.codex-migration.2026-08-27.md /home/hruzam/reposoma/_mail/monkey/inbox/CS.machine-staleness.2026-08-27.md /home/hruzam/reposoma/_mail/monkey/archive/
```

Then open `/home/hruzam/reposoma/_mail/monkey/HANDS.md` and friction-prune (retype only what
is still true). Candidates now satisfied or superseded: "Codex incident closes" (46 transcripts
+ 28 skills quarantined this session; only the HOLD verdict remained — step 3), "office Codex
Desktop exposure closes" (if step 1 ran), "home switcher LRV resolves" (if step 2a/2b ran),
"audit session lands in git" (if step 4 ran). When this PAD is fully processed, archive it too:

```bash
mv /home/hruzam/reposoma/_mail/monkey/inbox/oraculum.pad.audit-close.2026-08-28.md /home/hruzam/reposoma/_mail/monkey/archive/
```

>MAJKEE report 5
```zsh

```

---

## verdicts

| step | closes | SUPPORTED when | REFUTED/BLOCKED when |
|---|---|---|---|
| 1 | office migration exposure | tail shows flag=false | ssh error / flag already true |
| 2 | LRV path | ls -d resolves (2a) or line gone (2b) | deploy error |
| 3 | HOLD-skills question | journal line appended | you want quarantine instead |
| 4 | session lands in git | push clean | conflict/reject |
| 5 | inbox + HANDS honest | cards archived, HANDS retyped | — |

## parked (not yours today — do not chase)

- 12 native rollouts left in `~/.codex/sessions/2026/08/26/`; one mtime anomaly
  (filename 17-14-28, mtime 2026-08-27T03:03:57) awaits an eyeball — any future session.
- Office UNKNOWN-14 trace (guides/*, jacquard artifacts) — Kelvin's seat, briefed via
  `_mail/kelvin/inbox/oraculum.substrate-audit.forward-houston.2026-08-28.md`.
- deploy.sh accretion fix — stays in tree-bus trial cycle 2 (already on HANDS).
- /tmp quarantines (5 sets) — purge only after office flag is in and a few days of clean
  shells on both hosts; reboot is the natural deadline.
