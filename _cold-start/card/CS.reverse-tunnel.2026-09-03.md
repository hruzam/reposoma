---
kind: cold-start-card
date: 2026-09-03
brand: claude
seat: oraculum (session fc-sync.oraculum.sella — ending; authoring FOR a Codex-led session)
project: ia-sync
projects: [ia-sync, nablarva]
root: ~/ia-sync
task: reverse tunnel (Cartan/Codex → named Claude seat via native --bg) — Cartan authors the RUNBOOK + prototype, Oraculum challenges, majkee gavels; the roles-swap test of the whole constitution
resume: cd ~/ia-sync && codex   # Cartan-led; then fire prompt-0. (Alternative: claude --agent oraculum first if majkee wants the challenge seat warmed early.)
model: fable
dedicated: cartan (architect — keys GIVEN, see the RETURN §Blessing) · oraculum (CHALLENGE pass before gavel) · majkee (gavel + enable)
recommend: let Cartan author freely inside the ten invariants + the RETURN's amendments; the test IS the swap — do not over-steer. majkee journals sittings via a PAD with a haiku/luna scribe (doubles as the vara test).
pointers:
  - ~/ia-sync/session/rellays-calude-codex/ORACULUM-CARTAN-reverse-tunnel-return.2026-09-03.md
  - ~/ia-sync/HANDSHAKE.md
  - ~/reposoma/raw.guides/tunnel/GUIDE.md
  - ~/ia-sync/zsh/ai/tunnel-codex.zsh
  - ~/unikuklatrix/nablarva/toolbox/termbrana/research/evidence/t06-tunnel-v0-roundtrip.md
---

## prompt-0

###### prompt

```text
You are @Cartan, opening the reverse-tunnel arc (Codex → named Claude seat). majkee
authorized you as architect; Oraculum's RETURN (pointer 1) CO-SIGNS the --bg direction
with amendments and gives you the keys explicitly. Your original POINT is preserved
verbatim in this card's body — it is your own brief back to you.

READ: the RETURN (all of A–E; C3 and B4 carry Oraculum's highest uncertainty — your live
observation outranks his inference) · HANDSHAKE §TABLE + Delivery rule · tunnel GUIDE ·
the forward shim (the mirror you are building) · t06 evidence (the FAIL is part of the
proof — yours will be too).

AUTHOR: the reverse RUNBOOK in a new nablarva session bed — suggested slug
~/unikuklatrix/nablarva/.dev/session/toolbox-termbrana-04-reverse/ (sibling numbering;
majkee may rename; visible-mode becomes 05). One gate: one full reverse round-trip
(Cartan→Claude-seat task, Claude→Cartan verified yield) live on office, receipts on disk.
Bind: your ten invariants + the RETURN's amendments (seat-scoped Stop hook in a DEDICATED
agent .md · dual-source reconcile · StopFailure→HOLD contract · opaque seat-internals ·
stop-then-resume lifecycle). Behavior proof = the RETURN §D six lanes, FAIL receipts kept.
Distinguish OBSERVED / DOCUMENTED / INFERRED throughout, as you asked of Oraculum.

GATES: Oraculum CHALLENGE pass on your RUNBOOK before build · majkee gavels + owns the
enable (law 2.4) and every commit/deploy · HANDSHAKE r4 wording ("driving seat ↔ stored
peer-vendor session") goes through the counter-sign flow, not your RUNBOOK · plain pull
(never rebase) in nablarva.
```

## Body — context preserved verbatim (Cartan's POINT, 2026-09-03 — no other disk home)

> @majkee has authorized Cartan to architect the second TABLE direction:
> Cartan / Codex → named Claude seat.
>
> Hard constraint: Do not use `claude -p`, Agent SDK, or stream-json. The announced 2026
> separation of `-p`/SDK usage from subscription quota was paused, but that policy remains
> a Damocles sword. The reverse tunnel must survive a future reclassification without
> accidentally consuming API/usage-credit pools.
>
> Observed on office: Claude Code 2.1.259 · native `claude --bg --agent <seat>` background
> sessions · `claude agents --json`, `logs`, `attach`, `stop`, `rm` · `claude --bg --resume
> <id> "<follow-up>"` · official docs: background sessions consume subscription usage like
> interactive · Stop hooks expose `session_id`, `last_assistant_message`, `transcript_path`;
> StopFailure reports rate-limit/authentication/billing failures.
>
> Candidate topology: Cartan → native Claude background-session controller → `claude --bg
> --agent <seat>` → saved Claude conversation; Stop/StopFailure hook → machine-local tunnel
> receipt → Cartan reconciliation. Operator intervention: Tailscale SSH → `claude attach
> <id>` (operator rail only, not TABLE transport). Anthropic Remote Control excluded; tmux
> emergency fallback only.
>
> Proposed invariants: (1) operator explicitly opens the TABLE, fixes seat/model/effort/
> permission posture; (2) open fails closed unless subscription-seat auth; (3) reject
> ANTHROPIC_API_KEY / Console / Bedrock / Vertex / Foundry routing; (4) no `-p` anywhere;
> (5) never resume while running — stop after completed yield, retain conversation, resume
> same ID; (6) terminal logs are observation only — Stop-hook receipt + RUNBOOK/STATUS/
> evidence carry durable truth; (7) state owner-bound, ignored, machine-local, beside the
> owning RUNBOOK; (8) changing agent/model/instrument = numbered sibling session; (9) dated
> billing-policy receipt is part of the proof — policy uncertainty puts the instrument on
> HOLD; (10) close removes the local handle only via supported Claude lifecycle — no
> deletion of transcripts/sessions by guessed paths.

**Small information:** Oraculum's RETURN answers the POINT's A–E in full (co-sign with
amendments · no hard collisions, HANDSHAKE r4 + GUIDE edits owed post-proof · three
lifecycle corrections · six-lane behavior proof · one instrument, TABLE, direction is a
parameter). majkee's framing: *this arc is the test of everything the three days built* —
the constitution proving itself with the roles swapped. PAD journaling by a haiku/luna
scribe doubles as the vara test.

**Drain:** consumed → `card/` → `archive/`.
