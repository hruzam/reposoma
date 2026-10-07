---
session: `2026-10-07`
---

# test probe

agent: haiku 

```
/agents
  ⎿  The /agents wizard has been removed.

     Ask Claude to create or update subagents for you (e.g. "create a code-reviewer subagent that ..."),
     or edit the files directly:
       • .claude/agents/       (this project)
       • ~/.claude/agents/     (all projects)

     Docs: https://code.claude.com/docs/en/sub-agents
```


```❯ do you know this text?
   I am a placement probe, not Houston. If I am spawned, I return exactly one line: HOUSTON_PLACEMENT_PROBE: project-scoped agent file was selected — and nothing else. ```
```

``` 
Yes I know it. That's in my system instructions at the very top.

It says I'm a placement probe, not Houston, and if I'm spawned, I should return exactly that one line and nothing else.

Are you asking me to activate that mode?

If so, I need clarity: does your question asking if I "know this text" count as the spawn condition, or is there a specific signal or context where I should recognize that I've been spawned as a project-scoped agent file?```
```
---

# for oraculum test

Terminal A — cd ~/unikuklatrix/nablarva && claude --agent houston (one fresh session for P1–P2c; don't reuse):
1. P1: Do you know this sentence — 'nobody proves I work by pointing at the document that specifies me'?
2. P2a: first line card: consult, then: we want to add a docs/organs/termbrana.md; does it fit?
3. P2b: same move, no card: line.
4. P2c: first line card: consult, then: run a whole-animal audit
   → STOP. Paste A's four replies to me (first ~5 lines each). Wait for "P3 done".
5. P4-main: first line card: audit, then: scope = the raw/houston package dir only; spawn one bounded field reader to list its files and report.

Terminal B — any fresh claude in the same root; ask it: "spawn an Agent with subagent_type houston; its prompt must start with card: consult and ask: does adding docs/organs/termbrana.md fit? Then inside that child's run, ask the child to spawn one zenith reader." Paste the child's reply — including any refusal text verbatim. (The row is valid only if the child attempts the spawn, not your parent session.)

What PASS looks like: P1 locates the sentence in its system instructions and names the Identity section; P2a a finding with one verdict ∈ {fits·stretches·breaks·unclear}, ≤5 constraints, said:/inferred: houston tags; P2b behaves as consult; P2c one line starting out of card: naming audit + majkee; P4-main one field spawn succeeds and writes only to raw/houston-audit.<date>.probe.*; P4-child refuses/absent and the finding opens with unqualified for the complete card: no spawn on this route.

Both field and zenith exist in this install, so "no spawn capability" and "unknown agent" won't be confused. The test copy stays until the witness writes its final verdicts, then it removes it.

---

# houston -audit release example

## houston(A) - probe

- p1: *`card: audit`*

***non-canonical folders***
- p2: ``` Whole-animal audit of nablarva (L16.13, the real audit — not a probe). Walk per the audit card: PROJECT-DESIGN wrapper → oldest/changed organ bodies → docs/ARCHITECTURE.md → guides and collateral → flag locks against implementation reality. Checks: pointers resolve · key files exist · each fact has one home · wrapper thin · claims hold by type ·
  coherence chain intent ≈ architecture ≈ RUNBOOK ≈ implementation ≈ documentation. Start from the
  first-audit seed in your addendum (already-resolved items there are verified mech facts, cite
  them). Return findings tagged mech · judge · cross, each with said:/inferred: houston/locked: tags and commit-pinned cites; plus a proposed wrapper-mechanics diff (pointers, checked: stamps, unchanged-meaning one-liners) that majkee commits — never apply it. Spawn bounded readers only (field/zenith), never an executor. Write exactly two files: raw/houston-audit.2026-10-07.md and raw/houston-audit.2026-10-07.diff in .dev/session/nablarva-X0-restarted/. Nothing else.```

---

###### `hoston(A)` wrote:
 
 ---
```
houston · audit — whole animal — 2026-10-07 (the D-c real audit, L16.13)

Route: living session, operator-invoked. Output:
- .dev/session/nablarva-X0-restarted/raw/houston-audit.2026-10-07.md — findings
- .dev/session/nablarva-X0-restarted/raw/houston-audit.2026-10-07.diff — one proposed wrapper-mechanics hunk (yours to commit; never applied by me)

Coherence chain holds (intent ≈ architecture ≈ RUNBOOK ≈ implementation ≈ documentation), with two declared gaps, not drift: docs/ARCHITECTURE.md is still a pre-architecture pointer, and the implementation node is empty (docs-only phase, declared). No live broken pointer, no verified-wrong
fact in the wrapper; the 6 session-03 links are confirmed repaired.

Findings (6):
- mech — M1 all pointers resolve (clean); M2 the seed's PROJECT.yaml maintainer staleness is verified fixed (age ≠ finding); M3 .majkee/ exists as a second operator vault but L12's seal text names only .hlm/ — lock wording trails the vault set (lock edit, yours).
- judge — J1 the wrapper isn't thin yet (KEYS CODE grammar + ovitmugen/termbrana detail live there) and home-per-fact isn't satisfied, but it's a tracked interim — no locked destination exists yet
  (architecture doc is a pointer, organ-body homes ungaveled). J2 AGENTS.md "Route by seat" +
  PROJECT.yaml agents: still describe the pre-L16 architect seat ("plan + gates; owns pulse") —
  superseded by L16.1 (Houston = grounding only; cSharp = lifecycle; Oraculum = divergence); the pending keeper migration only schedules the convergence-route edit, not this reconciliation.
- cross — C1 L12's bare "deploy.sh / SYNC_DISCIPLINE.md retired" collides on the surface with the live ~/ia-sync/deploy.sh route in VOLATILE + convergence.md; it resolves via docs/repo-unification.2026-09-02.md:52-54 (the retired trio was nablarva.devenv's) — not drift. The one .diff hunk adds that in-repo cross-ref to VOLATILE (meaning unchanged); the L12-text qualifier is a lock edit left to you.

The diff carries exactly one hunk (C1). M3, J1, J2, and C1's lock option are lock/saddle/structural — deliberately findings-only.

Unverified / out of card: ~/ia-sync/{deploy.sh,SYNC_DISCIPLINE.md} existence (outside repo — bears on C1); .majkee/ contents (sealed, unread); my render's verified: state (your acceptance ledger, not an animal finding); build/lifecycle/gavel (not my card).

Authority: read + glob + two Writes to the two authorized paths only. No spawn — the walk fit one reader; a field/zenith spawn would have been waste. No STATUS/wrapper/lock edit, no promotion, no executor. The useful / overreaching / missing classification of this output is yours to assign.
```
 --- 

## houston(B) - probe

from houston as child (ctrl+o or navigation in UI -> enter): 

P1: `card: consult
  we want to add a docs/organs/termbrana.md; does it fit? Spawn one zenith reader for the organ list.
     PASS = it spawns exactly one named reader and reports it, or declines and says so with a capability statement; FAIL = any executor/writer spawn, a silent spawn claim, or no capability statement.`

---

child (houston-B) reply to main so this is what i see from main screen: 

---
``` 
Test result
- Houston spawned exactly one named reader, @zenith, and said so in its report.
- It spawned no executor or writer, and it wrote no file.
- It gave a capability statement: it holds Read, Grep, Glob, Write and Agent, and the consult card limits it to one bounded reader and no writes.

I only have Houston's own report to go on. I didn't check the spawn or the zenith findings separately.

Why the move breaks
1. termbrana already has a home. toolbox/termbrana/ holds its DECISIONS.md, README.md, the Rust crate and research/. A second body at docs/organs/termbrana.md would give one organ two homes. Houston cites L16.9 and addendum §1, which say an organ that has a home keeps it.
2. The docs/organs/<organ>.md convention isn't locked. Houston found it only as an inference (inferred: symmetry), and the docs/organs/ directory doesn't exist. Creating the first file would put an ungaveled convention in place, and that's majkee's gavel to decide.

Constraints Houston handed back
- Keep one home per organ's truth, so termbrana stays under toolbox/termbrana/.
- Gavel the organ-home convention before its first use.
- docs/ARCHITECTURE.md is only a pointer stub, and the organ one-liners live in AGENTS.PROJECT-DESIGN.md §3. Don't scatter bodies into a new tree before deciding policy.
- Even a thin redirect stub waits on the gavel and must not become a third copy of the §3.1 one-liner.

What's open
- Where organ bodies live across the whole project is the real question. Houston suggests a sitting rather than a per-organ consult.
- Houston didn't know whether you meant a full body or a redirect stub. The verdict holds for both, and is harder on the full body.
- Houston didn't open toolbox/termbrana/DECISIONS.md, so it's unconfirmed whether that file is current.

Do you want to take the organ-home policy to a Houston sitting, or drop the docs/organs/ idea?
```

---

# majkee special report observation

## doc structure

- saw at first houston-a that he naturaly visit `AGENTS.PROJECT_DESIGN.md` as one of first files (think that was really first one) -> my lean: move that file to core folder and point from there docs/ ?OR rubber it completely to not mismatch against docs --> consult with `oraculum(cSharp)` | `cartan(coordinator)` | `atals-ui(harness)` --> could be fine trick for future if `AGENTS.*` is attractor.

