---
kind: cold-start-card
date: 2026-09-16
brand: claude
seat: atlas-ui
project: reposoma
root: ~/reposoma
commit: 38dcb62 (core) — GUIDE v3; scribe chapter + this refresh land in the following commit
task: Ptyra 3-regime + journal hand + meeting GUIDE (now v3, evidence-driven); NEXT = run scenario 06 + 02 A/B with the scribe, then fold results into res/
resume: claude --agent atlas-ui
model: sonnet
dedicated: atlas-ui (fold scenario results into res/); Cartan for the Codex journal fold (cross-runtime)
recommend: Runs happen on Majkee's devices, not in the builder session — re-enter a fresh atlas-ui only to FOLD returned results. Graduation anchors to OBJECTIVE outcome, never the debrief.
pointers:
  - ~/reposoma/pulse.atlas.md
  - ~/reposoma/raw.guides/meeting/GUIDE.md
  - ~/reposoma/raw.guides/meeting/res/scribe.md
  - ~/reposoma/raw.guides/meeting/raw/epoch.brand-strengths-for-performance.2026-09-16.md
  - ~/reposoma/.majkee/journal/2026-09-16.md
  - ~/reposoma/raw.guides/sella/raw/codex-spawns-temporary-helperFile.ByMajkeeCartan.md
---

# CS · ptyra + meeting playground (2026-09-16)

Session closed clean, no live gate/STATUS bed — this card carries its own next-action queue.

## Done today (Claude-side)
- **Ptyra** → single source of truth `raw.vendor-neutral-agents/ptyra/`; duplicates removed.
- **JOURNAL regime (C)** added; Claude.ai Ptyra-AC split into dispatcher + A/B/C files.
- **`@ptyra-ac-journal`** (Haiku) — CLI journal hand (`fold` / `pending`); `.majkee/jornal`→`journal`.
- **`.majkee/`** now a tracked personal harness (SHM) with README + day journal.
- **Meeting** graduated flat file → GUIDE bed `raw.guides/meeting/` (served by `/guide meeting`);
  vacuole stocked with scenarios 01–07 + recipe template.
- **Meeting GUIDE v3** — @Epoch performance research + @mirror cross-vendor **REVISE** →
  cost gate (convene on consequence × vendor-divergence, NOT verifiability); assigned
  Devil's-Advocate role (rule 7 — load-bearing over soft dissent); debrief demoted to color
  (graduate on objective outcome); scenario 02 → A/B; +scenario 07 (role-by-strength).
- **Scribe** — scenario 01 unblocked (device ready); `res/scribe.md` briefing gives the scribe a
  meeting event vocabulary; it now rides every run as a silent non-participant.

## Pending (order matters) — refreshed post-v3, scribe ready
1. **Run scenario 06 (ground-truth) + scribe** — the clean first run (validates the scribe log
   vs debriefs, gives a real correctness signal). Scribe loads `res/scribe.md`, non-participant,
   on the longest-session vendor (ChatGPT for now). Bring back: scribe log + each voice's committed
   position + the verified answer.
2. **Run scenario 02 A/B** — soft "untested?" vs assigned Devil's-Advocate (rule 7); TWO runs.
   Bring back: CHALLENGE / CONCEDE / CORRECTION counts per condition.
3. **Overlays that ride any run:** 03 chair-blind (Voice-1/Voice-2 labels), 05 context-parity
   (log each voice's pack). **Paired/later:** 04 side-swap, 07 role-by-strength.
4. **Fold returned results** → `res/` chapters (objective outcome graduates them, not feelings).
5. **Codex journal fold** — ephemeral `default` subagent pointed at
   `~/reposoma/raw.vendor-neutral-agents/ptyra/skill.journal.md` (read it in full, follow it),
   fold into `.majkee/journal/<day>.md` append-only. No persistent Codex agent. See the Cartan
   pointer + the untracked `_cold-start/card/CS.codex-identity-first.2026-09-16.md`.

## One lesson
Codex identity ≠ Claude identity: Claude side = persistent named subagent; Codex side = ephemeral
in-conversation spawn (name the skill in the child's task). And on meetings: a two-vendor meeting
earns its cost only on consequence × vendor-divergence — reserve it, seat an assigned adversary,
and judge on ground truth, never on how the meeting *felt*.
