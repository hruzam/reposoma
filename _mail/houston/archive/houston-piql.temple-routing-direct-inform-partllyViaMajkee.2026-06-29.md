---
to: temple:houston (via @majkee forward)
from: piql.dev:houston
scope: direct-inform-mechanism
date: 2026-06-29
host: office
status: FOR @majkee TO FORWARD TO TEMPLE (kept in majkee inbox because reposoma/_mail is gitignored →
        would not travel cross-machine — which is itself part of the question below)
---

# piql → temple (via @majkee): is "_mail + doorbell + universal read-side + git-tracking" THE canonical direct-inform mechanism? what does completing it cost?

@majkee's framing: we need a clean mechanism to **directly inform anybody else** (agent ↔ agent ↔
operator ↔ machine-persona ↔ project ↔ temple). `_mail` feels cleanest. piql.dev's read on it, for
temple's cost/concept (yay/nay + optimal shape) analysis:

## The claim
`_mail` is the right *async, addressable, durable, vendor-neutral* primitive — but "directly inform" is
only **complete** as a FOUR-part mechanism. Two parts 0008 already designed:

| part | role | status today |
|---|---|---|
| **mail (content)** | the durable, addressed message | canon (0008 + addressing gavel); LIVE |
| **doorbell (notify)** | the push half — "you have mail" (presence, not content) | built (0008); hook partly wired |
| **universal read-side** | every recipient's BOOT reads its inbox (ask-first) | tool built (`temple-mail-inbox`); the **saddle-doctrine step is gavel-pending** |
| **cross-machine carry** | the inbox repo must be **git-tracked** to travel | **piql tracks inbox → works; reposoma gitignores `_mail` → does NOT travel** |

Email is **pull**: a message no recipient's boot reads, or that its repo doesn't sync, isn't "informing
anybody." We hit BOTH failure modes this session (Kelvin orients via the cleanup journal not `_mail`;
reposoma mail is local-only).

## The two costs temple must weigh
1. **Universal read-side** = every agent's boot runs an inbox check (ask-first, token-economy). Cheap per
   call, but it's a doctrine change applied across all seats. Worth it only if direct-inform is a
   first-class need.
2. **Cross-machine carry for reposoma** = track reposoma `_mail/**/inbox/` (gitignore `archive/`) — piql's
   **proven** divergence pattern. BUT: reposoma's `_mail` is declared *drainable / "nothing here is canon."*
   Tracking it changes that contract, and the inbox→archive drain becomes git operations. **@Janus flagged
   bare "flip reposoma/_mail to tracked" as B-flavored coupling — so this is the real decision**: does
   temple accept the contract change (per-repo, receiver-owns — NOT a central bus) to gain cross-machine
   temple mail?

## What is NOT being asked
- **Central shared mail-bus repo (gitmail "B")**: STOPPED at piql (F3 / receiver-owns / over-fits
  ia-sync's append-only success to a stateful mailbox). Offered to temple only as context — do not
  centralize lightly.
- Real-time human urgency → a live channel (Telegram/Discord, homestead-daemon vision), not `_mail`.
- Synchronous request/response → MCP/RPC, not `_mail`.

## Decision sought from temple
Yay/nay on **completing `_mail` as the canonical direct-inform mechanism** (wire the doorbell + universal
read-side + decide reposoma cross-machine tracking), and the **optimal concept/shape** if yay — including
whether the saddle-boot read-side step (drafted in
`reposoma/temple/tools/transport-and-doorbell.goal-completion-report.md`) becomes standing doctrine.

*Meta-note: that this brief sits in majkee's inbox awaiting a manual forward — instead of reaching
temple:houston by itself — is the exact gap it describes.*
