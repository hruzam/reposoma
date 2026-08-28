CS · 2026-08-27 · machine-layer staleness pair — normalizer retirement + deploy accretion

commit : ia-sync f8d780e (pushed) · reposoma 2ffd4a4 (pushed) + full guide set UNCOMMITTED
         on home awaiting majkee's sweep
task   : two threads left deliberately in the air — retire normalizer.py on home, and fix
         deploy.sh so staleness stops accreting
context: home's login evals `python3 normalizer.py` (config.zsh:19-27) to hydrate PROJECT_*
         paths from harness.machine-project-registry.json — office dropped this long ago for
         inline exports. Separately, deploy.sh has two accretion defects: copy_file() writes
         a dated .bak even when content is byte-identical (proof: AGENTS.md.bak-2026-08-27
         == its current file), and every rsync leg runs without --delete across FOUR trees
         (zsh/ · codex/agents/ · codex/skills→~/.agents/skills · gemini/). Result measured
         2026-08-25: deployed tree = accretion, not projection; 37 orphans on home.
resume : claude --agent oraculum (in ~/ia-sync) — host home. Verify: echo $MACHINE_NAME → home

FIRST STEP: decide which thread, they are independent —
- deploy fix → it is CYCLE 2 of the tree-bus trial. Do NOT do it standalone: promote
  ~/reposoma/_runbook/ia-sync/codex-tree-bus/RUNBOOK.md to
  ~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/ (two-step via nablarva.devenv
  transport — .dev/ is gitignored), run cycle 1 first (substrate.* quarantine + 2 UNKNOWN
  traces), then cycle 2 carries the deploy change behind its --dry-run gate.
  Fix = back up only when content differs (NOT keep-last-N), in copy_file() itself so every
  target benefits. deploy.sh breaks config delivery to BOTH machines if wrong.
- normalizer → its own small session, order is LAW: (1) author inline PROJECT_* exports
  office-style into ~/ia-sync/zsh/config.home.zsh on the surgical table, (2) dry-run deploy,
  (3) deploy + fresh shell, (4) verify project switcher resolves every path (fo/im/psd/ltp),
  (5) ONLY THEN quarantine normalizer.py + harness.machine-project-registry.json (move to
  /tmp, never rm). Migrate-then-retire or the switcher loses all paths — ia-sync/AGENTS.md
  documents the dependency; both files are pinned in zsh-orphans.zsh KEEP_GLOBS — unpin
  after retirement.

Pending (wider, in order): majkee's commit sweep of the guide set · L9′ append in nablarva
flag (paste-ready text in session 2026-08-27) · detector parameterisation (zsh-orphans.zsh →
source/deployed as arguments, 4 tree pairs; keep-sets ONLY for audited trees — do not
fabricate policy for ~/.claude or ~/.gemini) · Codex-Desktop-on-office question · 53 ingested
transcripts + ~48 squatter skills decisions.

State pointers: ia-sync/journal.host-cleanup.md (HOME 2026-08-25 = drift mechanism · HOME
2026-08-27 = vendor migration) · _runbook/ia-sync/codex-tree-bus/RUNBOOK.md (trial + stop
rule + ledger) · CS.codex-migration.2026-08-27.md (sibling card, incident detail) ·
raw.guides/{runbook,status,bus}/GUIDE.md (the new convention — read runbook GUIDE before
opening any session folder) · ia-sync/AGENTS.md §"Which host am I on?".

Session advice: verify-after-claim caught silent failures twice today (Delta's edit pass
reported a sweep but not its two failed edits; an earlier count was an ls artifact). The bus
GUIDE now encodes it: bare claims are never evidence, including another agent's. Run the rg
sweep after every delegated edit batch. Second: the deploy fix was deferred TWICE as
wrong-moment — that was correct both times; it now has a proper harness (trial cycle 2, dry-run
gate). Do not let a tidy instinct pull it forward out of its harness again.

Cleanup: three /tmp quarantines survive until reboot (zsh-prune-2026-08-25 · codex-agent-
mirrors-2026-08-27 · codex-repair-2026-08-27, 71 files total, majkee says reboot is far).
The 8 damaged skills in codex-repair are the only set worth relocating before purge — 7 have
clean ~/.claude/skills/ counterparts for deliberate re-authoring into ia-sync/codex/skills/.
