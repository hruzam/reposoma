CS · 2026-07-28 · CLAUDE.local.md backup via sync-deploy

commit : 9254561 (core) — freya.devenv, work STAGED not committed
task   : make CLAUDE.local.md survive disk loss — commit it as W3 backup
context: it was copied into freya.devenv/claude/ every sync but git-excluded
         → never pushed → no remote backup. Fix: removed the $DEVENV_REPO
         exclude-guard in sync.sh (deploy.sh's $APP_DIR guard STAYS — keeps
         private rules out of public freya repo). SYNC_DISCIPLINE.md flipped,
         global devenv-sync SKILL.md updated. 3 files staged in freya.devenv:
         sync.sh, SYNC_DISCIPLINE.md, claude/CLAUDE.local.md.
resume : cd freya.devenv → git pull --rebase → commit → push (my move pending)
