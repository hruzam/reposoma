---
kind: cold-start-card
date: 2026-10-03
brand: claude
seat: atlas-ui
project: ia-sync
projects: [ia-sync, reposoma]
root: ~/ia-sync
commit: 2a8bc2a (main) · reposoma d4d0097 (core)
task: Close germline-00-home (two fresh-session receipts), then write the invariance architecture chapter; sweep the ptyra-release debt.
resume: cd ~/ia-sync && claude --agent atlas-ui
model: opus
dedicated: atlas-ui (Flight MANNED or Houston for the invariance pilot RUNBOOK — subject ≠ author)
recommend: Read germline-00-home/STATUS.md first and do ONLY its next; the architecture chapter is the one real piece of thinking — give it a fresh window, not the tail of another fork.
runbook: ~/ia-sync/.dev/session/germline-00-home/RUNBOOK.md
pointers:
  - ~/ia-sync/.dev/session/germline-00-home/STATUS.md
  - ~/ia-sync/.dev/session/invariance-autonomy/raw/master-brief.2026-09-23.md
  - ~/reposoma/.germline/README.md
  - ~/reposoma/.majkee/journal/2026-09-25.md
  - ~/reposoma/pulse.atlas.md
---

# Atlas — germline tails (parked 2026-10-03 while the Protocol-1 BUS fork runs)

## Pending, in order
1. **germline-00-home — gate.** STATUS owns the position; its `next:` is majkee's prompt-2
   (fresh Claude `/chatbot-port buffering-cycle` → no · `--check`; fresh Codex `$chatbot-port …`
   same). Paste receipts → atlas-ui records them in `checkpoint:`, closes the gate, prunes per
   RUNBOOK GUIDE, removes the `pulse.md` router line. No competing next here.
2. **invariance — `res/architecture.md`** (agreed 2026-09-25, not written; `res/` does not exist
   yet). Content: target tree · three cases (global-only · global+addendum · local-only) ·
   addendum-adds-never-overrides · render direction · entry adapters · **performance numbers the
   pilot must hit** (tokens-to-orientation · files-per-identity · brand-blind fraction + twin
   convergence · re-render cost · one verification per vendor per host). Subject = Atlas
   (gaveled); RUNBOOK author = Flight/Houston, not Atlas.
3. **Debts:** `git rm ~/reposoma/.claude/agents/ptyra-ac-journal.md` (still on disk; release
   edits are committed) · home box `ln -s ~/reposoma/.germline ~/.germline` + `git pull` ·
   tell the ovitmugen seat its brick went live 2026-09-25 · Claude.ai rendering
   `raw.claude-ai.agents/ptyra.C-journal.md` still names the retired hand (re-flatten on next
   Ptyra update, noted in her README).

## State pointers
- Ledger: `pulse.atlas.md` top entry (GERMLINE-00-HOME) · majkee's day square `.majkee/journal/2026-09-25.md` §4–5.
- Rulings deferred to the pilot session: Houston↔Cartan collision · `scope:` word · Codex
  `buffering` ≈ Claude `buffering-cycle` near-miss · `atlas-auto` as wrapper-variant.
- Parked, own session: `.germline` discovery index / connector bus · ptyra migration into `.germline/agents/`.

## One lesson
Whole-table `deploy.sh` ships every seat's committed work — ask before deploying when other
heads are mid-arc (the per-scope deploy belongs to `publish-gate`, not to a session hack).
