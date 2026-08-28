CS · 2026-08-27 · Codex Desktop migration incident + tree-bus trial opened

commit : uncommitted — 3 files across 2 repos (see Cleanup). Prior work IS pushed:
         ia-sync 390ab90 · reposoma 5cd3c2a
task   : audited the Codex handshake before a two-seat trial; found a vendor migration
         nobody had seen; quarantined the damage; trial designed but not started
context: Codex Desktop (the ChatGPT app, NOT the npm CLI) ran an "external agent
         migration" 2026-08-26 23:01:54 from its onboarding checklist. In one 8ms burst
         it mirrored 32 Claude agents into ~/.codex/agents/, ~56 skills into
         ~/.agents/skills/, translated the SessionStart hook, imported settings.json
         into config.toml — and INGESTED 53 Claude session transcripts (8.3MB, 421KB of
         majkee's own typed text) into ~/.codex/sessions/2026/08/26/. Its converter is
         buggy: a blind claude→Codex rewrite on file BODIES turned ~/.claude/houston.goal
         into ~/.Codex/houston.goal. The mirrored files were corrupt on arrival.
         No journal entry, no stamp, no diff, no visible sign. Found two days later by
         accident. Earlier same session: home's zsh tree went 37 orphans → 5.
resume : claude --agent oraculum (in ~/ia-sync) — host home

FIRST STEP: `grep -n external-agent-import-sync-enabled ~/.codex/config.toml`
- still `true` → the switch is ARMED. Flip to `false`. majkee parked this pending
  closure of a live Codex CLI session (PID 554293, his own — its argv contains his
  typed question about the desktop app, which is what caused the whole thing).
- already `false` → done; move to the transcript decision.

Pending (in order):
1. Flip the flag. `memories_1.sqlite` has stage1_outputs(raw_memory, rollout_summary)
   and a jobs table, BOTH EMPTY — a second-stage distillation of those 53 transcripts is
   wired and has not run. Flip before it does.
2. Decide the 53 transcripts at ~/.codex/sessions/2026/08/26/ — keep or quarantine.
3. Decide ~48 squatter skills in ~/.agents/skills/ (undamaged, unmanaged, no source).
4. Fix codex/AGENTS.md — its "do not mirror the Claude persona roster" tells CARTAN not
   to do something the CLI does regardless. Needs a line naming the config flag.
5. OFFICE: does Codex Desktop run there? If yes it has its own migration, its own 8
   damaged skills, its own transcript ingest — of sessions including piql. NOTHING
   propagates: the mirrors were never in git. Office needs its own pass, from office.
6. Start the tree-bus trial: write _bus/01.oraculum.point.md.

State pointers: ia-sync/journal.host-cleanup.md (HOME 2026-08-27 = the full incident;
HOME 2026-08-25 = the zsh drift finding) · _runbook/ia-sync/codex-tree-bus/RUNBOOK.md
(trial + pre-registered stop rule + audit ledger) · _runbook/termbrana/m0-close/RUNBOOK.md
(prompt-0 filled, office-only) · ia-sync/AGENTS.md §"Which host am I on?" ·
ia-sync/zsh/blessings/zsh-orphans.zsh (the reporter).

Session advice: audit the VENDOR surface, not just your own. Every drift discipline here
points at ia-sync → machine. Nobody had ever compared vendor-deployed state (~/.codex,
~/.agents/skills) against source, and that is exactly where 8.3MB moved unseen. The fix
is small: zsh-orphans.zsh already does source-vs-deployed bucketing but hardcodes
~/.config/zsh — parameterise both sides and point it at codex/ → ~/.codex/.
Second lesson, mine: I built a whole mail-based Claude↔Codex protocol before checking
whether the mail rail carried traffic (_mail/kelvin/ had never existed). Deleted it.
Check demand before building transport.
Third, procedural: I spawned a FRESH Trajectory instead of continuing the one that hit a
gate, and it correctly flagged that it had been handed a brief asserting an agreement it
could not verify. Continue agents with SendMessage; do not re-spawn and assert history.

Cleanup: three quarantines in /tmp — zsh-prune-2026-08-25 (31 files),
codex-agent-mirrors-2026-08-27 (32), codex-repair-2026-08-27 (8 damaged skills).
All MOVES, reversible until /tmp clears; majkee says reboot is far. The 8 skills are the
ones worth keeping — 7 have clean counterparts in ~/.claude/skills/ and could be authored
into ia-sync/codex/skills/ deliberately, which is the visible version of what the
migration did badly.
Uncommitted: ia-sync/journal.host-cleanup.md · reposoma/_runbook/termbrana/m0-close/
RUNBOOK.md · reposoma/_runbook/ia-sync/codex-tree-bus/RUNBOOK.md
