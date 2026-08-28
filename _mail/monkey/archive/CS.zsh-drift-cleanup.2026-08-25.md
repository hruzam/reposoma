CS · 2026-08-25 · zsh drift audit + @Metaterminal seat

commit : your hand-commit — 3 files staged in ia-sync, nothing pushed yet
task   : home zsh source-vs-deployed cleanup; @Metaterminal briefed to Atlas
context: session ran on HOME (verified by mechanism, not by docs — the zsh headers
         all say "office" no matter where you are, and misled the first hour).
         deploy.sh rsyncs without --delete and backs up without retention, so
         ~/.config/zsh is an ACCRETION not a projection: 120 source / 155 deployed /
         37 orphans. 29 quarantined to /tmp/zsh-prune-2026-08-25 (moved, not rm'd).
         Home now 5 orphans. Office has never been audited.
         Also found: machines are MANJARO, not Arch — docs say Arch everywhere.
resume : claude --agent oraculum (in ~/ia-sync) — on OFFICE. Home side is finished.

FIRST STEP (deterministic re-entry): `zsh ~/ia-sync/zsh/blessings/zsh-orphans.zsh`
- runs on either host, report-only, no delete path at any flag
- office has never been run — expect a larger orphan set than home's 37
- KILL bucket is safe to quarantine; UNKNOWN needs a trace before any verdict

Pending (in order):
1. commit + push the 3 ia-sync files from HOME before switching — otherwise this
   work strands on the wrong machine
2. run the reporter on office, quarantine its KILL bucket
3. Atlas builds @Metaterminal from the brief (below) — born in nablarva per flag L6
4. temple mail: ai/base.zsh prints on source, violating its own contract, in a file
   gated by decision 0009 — needs a decision, not a patch
5. decide Arch→Manjaro correction scope (AGENTS.md:3 is one line; zsh/archx/ naming
   is a bigger question)
6. deploy.sh copy_file() backup retention — deliberately deferred, see journal

State pointers: ia-sync/journal.host-cleanup.md (HOME 2026-08-25 entry carries the
full finding) · ia-sync/AGENTS.md §"Which host am I on?" (new) ·
reposoma/_mail/atlas/inbox/oraculum.metaterminal-seat.2026-08-25.md (the build brief) ·
ia-sync/zsh/blessings/zsh-orphans.zsh (the tool) · /tmp/zsh-prune-2026-08-25 (quarantine,
purge only after a fresh shell comes up clean).

Session advice: I built a whole mail-based Claude↔Codex protocol before checking whether
the mail rail carried any traffic. It didn't — `_mail/kelvin/` had never existed. The
empty inbox was the answer and I filed it as a docs defect instead. Check demand before
building transport. Corollary that did work: verify host by mechanism (php74/valet/nginx/
tailscale node ID), never by documentation — three doc surfaces claimed "office" while
standing on home.

Cleanup: /tmp/zsh-prune-2026-08-25 holds 31 files, reversible until purged. 3 substrate.*
files still in the live tree (KILL bucket, not yet moved). 2 UNKNOWN orphans need tracing:
config_backup_docker.zsh, guides/ai.md. One stale secrets file parked at
archive/secrets.zsh.stale-2026-07-31. termbrana on OFFICE has an uncommitted +153 README
diff — do NOT let a tidy session `git checkout` it away.
