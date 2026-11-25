---
card: card.claude-ai
brand: Anthropic — claude.ai (chat + Projects)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~weeks
half_life_days: 21
recheck:
  - https://support.claude.com/en/articles/12138966-release-notes
  - https://www.anthropic.com/news
  - https://releasebot.io/updates/anthropic/claude
surface_type: chat (NO filesystem; standing instructions + retrieved knowledge)
---

## Refresh delta 2026-11-25
PARTIAL: default model per claude.ai plan after Sonnet 5.5 / Opus 5.5 NOT checked (no official page read states one); support release notes read through a summarizing fetch (page is a single un-paginated list, covered Sep 1 - Nov 24); Fable 5.2 launch-offers article seen only as a search snippet.
_Since last verify 2026-10-08. Sources live-fetched 2026-11-25 by @Epoch sibling (pass 2): support.claude.com release notes (article 12138966), claude.com/pricing, support articles 15424964 (Claude Fable models on your plan), 11145838, 11049741, 8325606, anthropic.com/news + model posts._

### Models (H unless noted; anthropic.com/news posts)
- **Nov 9: Claude Fable 5.2 + Mythos 5.2** — same underlying model, different safeguards. $8/$40 per M tokens in/out (fast mode $16/$80); API id `claude-fable-5-2`; "lower price" than 5.1 (5.1 price not stated); up to 30% faster output than 5.1; ~55% fewer safety blocks. Fable 5.2: all users/platforms. Mythos 5.2: vetted users only (Cyber / Life Sciences Verification Programs). Post recommends Opus 5.5 as the daily driver, Fable/Mythos for more demanding work. Medium effort default in Claude apps. Source: anthropic.com/news/claude-fable-and-mythos-5-2. H
- **Oct 7: Haiku 5.5** ($0.10/$0.50 per M in/out up to 100k prompt, $0.50/$2.50 above; `claude-haiku-5-5`). "fastest, most capable small model". Post does not mention claude.ai or Free access. Source: anthropic.com/news/claude-haiku-5-5. H
- **Sep 28: Sonnet 5.5** ($2/$10, same as Sonnet 5; up to 30% cheaper for most work, 30%+ faster; `claude-sonnet-5-5`). Release note: "a faster, lower-cost complement to Claude Opus 5.5". Source: anthropic.com/news/claude-sonnet-5-5 + support release notes. H
- **Sep 22: Opus 5.5** ($4/$20 per M, down from Opus 5's $5/$25; `claude-opus-5-5`; 40% cheaper to run than Opus 5 on typical workloads; release note: performs at Fable 5.1 level on most work). 5-hour limits raised on Pro/Max/Team/seat Enterprise plus a saveable rate-limit reset. Sources: anthropic.com/news/claude-opus-5-5 + release notes. H
- None of the model posts or release notes states a claude.ai default model. Claude Code docs (via search snippet, not read in full) say Opus 5.5 is the Claude Code default for Pro/Max/Ultra/Team/Enterprise/API: that is Claude Code, not claude.ai chat. M/L. claude.ai chat default per plan: NOT verified.

### Plans & prices (claude.com/pricing, read 2026-11-25) H
- Free $0: Sonnet, Haiku; limited usage reset every 5h and weekly; no Opus, no Fable.
- Pro $20/mo monthly, $17/mo annual ($200 upfront): Opus, Sonnet, Haiku; Fable via usage credits.
- Max $100/mo (5x Pro every 5h and weekly): Opus/Sonnet/Haiku; Fable up to 50% of weekly limit; $100/mo API credits. (Search summary mentioned a "Max 20x $200" tier from older support articles; pricing page lists Ultra at $200 instead. Support article 11049741 mentions only $100 and a path to Ultra.)
- **Ultra $200/mo** (new since last verify): 10x Pro weekly, verified accounts have no 5-hour limit; Opus/Sonnet/Haiku; Fable up to 50% of weekly limit (separate Fable weekly limit); $200/mo API credits that cannot be used in Claude Code or the Claude apps (support 11145838). Usage credits available after weekly limit.
- Team (2-150 seats): Standard $20/seat/mo annual ($25 monthly); Premium $100 annual ($125 monthly), 5x Standard; Fable at 50% of weekly limits on Premium; up to $500/mo pooled API credits.
- Enterprise: $20/seat/mo annual (20-seat min) plus usage at API rates; Opus/Sonnet/Haiku/Fable.
- Fable gating (support 15424964 "Claude Fable models on your plan"): Max, Ultra, premium Team and premium seat-based Enterprise: Fable up to 50% of weekly limits, then usage credits. Pro and standard Team seats: Fable 5.2 and 5.1 run on pay-as-you-go usage credits, not plan limits (outside launch offers). Standard seat-based Enterprise: org must enable usage credits. Seat-based Enterprise default set to a Fable model moves to Fable 5.2 unless admin opts out; Fable 5.2 stays off on Enterprise until admin enables. Usage-based Enterprise/API: standard API rates. H
- Launch offer (search snippet of support 17506494, L/M): Pro/standard Team got one week of Fable within limits (50% cap) to Nov 16 plus one reset; Max/Ultra/premium got 1-3 Fable resets (expire 2027-03-08). Conflict: anthropic.com Fable 5.2 post says "Fable is included for up to 50% of weekly usage limits on Pro and standard Team seats" — that is the launch promotion, now ended; steady state is usage credits per 15424964. Free excluded.

### Release notes (support.claude.com, article 12138966; summarized read, entries below H-ish M on wording)
- **Nov 24:** Monthly recap (Reflect) out of beta for Free/Pro/Max/Ultra, can include Claude Code sessions and cloud Cowork tasks. Beta: install artifacts as Mac/Windows apps; send/save files to connected apps (Pro/Max/Ultra gradual; Team/Enterprise owner enables).
- **Nov 20:** Computer use beta on Team/Enterprise; refreshed iOS design (iOS 26+). **Nov 17:** Claude Desktop Stable/Latest channels. **Nov 12:** Claude Meetings beta (Team/Enterprise). **Nov 6:** Enterprise project cost-tracking tags (beta). **Nov 5:** Enterprise security/admin features; Personal Finance beta (US, Pro/Max/Ultra).
- **Oct 21:** Claude Duet research preview (Pro/Max). **Oct 7:** Max and Team plans get monthly API credits (claim via Console billing). **Sep 25:** plugin developer portal. **Sep 16:** Cowork merges into standard chat (Pro/Max rollout); Artifacts/Design/Slides/Docs on all plans incl. Free. **Sep 15:** Salesforce plugin beta. **Sep 10:** smart reports beta (Enterprise). **Sep 1:** Fable 5.1 / Mythos 5.1.
- No Fable 5.2 entry and no default-model entry appears in the release notes. Footer points to docs.anthropic.com/en/release-notes/overview for older history; not followed.
- **Nov 10** (Whiteboards, Sheets beta, Claude Data GA, MCP Apps) / **Nov 23-24** (Claude Ship, Skills over MCP beta, MCP Tasks/Elicitation GA): from releasebot only, NOT in the support release notes list read this pass. M/L.
- Not card-relevant: Oct 27 GSA 40% government discount. Claude Code v2.1.332 not re-verified (outside card sources).

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: support.claude.com release notes (article 12138966), live-fetched 2026-10-08 by @Epoch._
- **Oct 7:** Claude Haiku 5.5 launched; Max and Team plans gain monthly API credits (claim by linking a Console org in billing). H
- **Sep 28:** Claude Sonnet 5.5. **Sep 22:** Claude Opus 5.5 (Anthropic: 40% cheaper to run than Opus 5). H
- **Sep 25:** developer portal for submitting plugins to the Claude directory. H
- **Sep 16:** Cowork features rolling into every conversation (no mode pick; gradual for Pro/Max, web/desktop/mobile); Claude Design / Slides / Docs added (Artifacts on all plans incl. Free; Enterprise beta, off by default). H
- **Sep 15:** Salesforce plugin beta (paid plans, org approval). **Sep 10:** smart reports beta (Enterprise). H

# claude.ai — chat & Projects (the architect / authoring surface)

## Refresh delta 2026-09-02
- **Claude Opus 5 launched Jul 24, 2026** — replaces Opus 4.8 in the tier stack; ~half the price
  of Fable 5 ($5/$25 per M tokens in/out, same as 4.8); 1M context; became Enterprise seat-based
  default. Source: anthropic.com/news/claude-opus-5, tech-ish.com 2026-07-24. CONFIDENCE: H.
- **Claude Fable 5.1 and Mythos 5.1 launched Sep 1, 2026** — replace Fable 5 / Mythos 5; same
  underlying model, different safeguard levels (Mythos 5.1 = trusted-access only, life-sciences/
  cybersecurity work). Cost reduction + fewer false-positive refusals vs Fable 5. Knowledge cutoff
  June 2026. Source: anthropic.com/news, system card PDF (www-cdn.anthropic.com, 2026-09-01),
  techcrunch.com 2026-09-01. CONFIDENCE: H.
- **Fable 5.1 app access is plan-gated**: Max and Team Premium get it inside their weekly
  allowance (~50%); Pro and Team Standard must pay via usage credits on top of the subscription —
  same split as Fable 5 had. Source: support.claude.com/en/articles/15424964, notebookcheck.net
  2026-09 coverage. CONFIDENCE: M (aggregator-sourced, not the primary support article read directly).
- **Memory system overhaul, two steps**: Jul 10 — moved from daily-summary memory to individual,
  categorized entries Claude reads/updates during conversations; Aug 25 — memory now spans chat
  AND Cowork-in-the-cloud, with editable topics and a new "sensitive topics" exclusion setting in
  Settings. Source: support.claude.com release notes (fetched 2026-09-02). CONFIDENCE: H.
- **Text watermarking disclosed Aug 14, 2026** — Anthropic published how output watermarking works
  and its impact on generations; relevant to any downstream artifact-authenticity assumption.
  Source: anthropic.com/news. CONFIDENCE: H.
- **Sonnet 5 remains the Free/Pro/Team default** (launched Jun 30, unchanged since last verify);
  Enterprise seat-based plans now default to **Opus 5**, not Sonnet 5 — this is new since 2026-07-16.
  Source: edtechinnovationhub.com 2026-09 coverage of the Sonnet-5-default rollout, cross-read
  against the Opus 5 launch note. CONFIDENCE: M (tier-default split inferred from two secondary
  sources, not a single primary statement).
- Previously logged Jun–Jul items (Claude Code Artifacts, Cowork web/mobile expansion, M365 write
  tools, Gov Desktop, HIPAA self-serve, Claude for Teachers, Slack tag, MCP org auth, Trusted
  Devices) found **no contradicting update** in this window — treated as still current, not
  re-verified line-by-line. CONFIDENCE: L (carried forward, not re-fetched individually).
- No evidence found of new Projects-specific feature changes (custom instructions / project
  knowledge mechanics unchanged) between 2026-07-16 and 2026-09-02. CONFIDENCE: M (absence-of-news
  inference from release notes + news page, not an explicit "no change" statement).

## What it is (and isn't)
- A reasoning + authoring surface. NO disk write, NO agent/skill/hook files. It PRODUCES
  artifacts (config, prompts, plans) as text for transcription.
- Best-fit LARVA roles: architect (@Houston), agent-builder (authoring brain), recalibration researcher.

## The two configuration levers
1. **Project** — a workspace with:
   - **Custom instructions** (standing prompt baked into every chat in the project)
     ← this is where a researcher's / builder's "system prompt" lives.
   - **Project knowledge** (files/text, retrieved via search during chats) ← feed the RELATIVE cards here.
2. **Style** — customizes writing/tone separately from instructions.

## Toggles that matter
- Web search / Deep research (live grounding — powers "recalibrate vs training data").
- Code Execution & File Creation (produces downloadable artifacts).
- Memory / search-past-chats — now categorized-entry based (Jul 10) and cross-product with Cowork
  (Aug 25), with a per-topic sensitive-exclusion setting.
- **Claude Design** (Jun 2026, sidebar) — design system import (GitHub repo, design files, raw upload),
  direct canvas editing, Claude Code sync. Available at `claude.ai/design`. Admin-toggled on Team/Enterprise.

## Model tier (2026-11-25)
Claude Mythos 5.2 (vetted users only) / **Fable 5.2** (Nov 9; same model, $8/$40 per M) > Opus 5.5
($4/$20) > Sonnet 5.5 ($2/$10) > Haiku 5.5 ($0.10/$0.50). Fable 5.1 remains available on plans
alongside 5.2. Per-plan claude.ai DEFAULT model after the 5.5 releases: NOT verified (no official
page states it). Free plan: Sonnet + Haiku only. Pro/Max/Ultra/Team/Enterprise: Opus, Sonnet, Haiku.
Fable gating: Max/Ultra/premium Team within 50% of weekly limit; Pro/standard Team via usage
credits only; standard seat-based Enterprise needs admin-enabled credits; Fable 5.2 off by default
on Enterprise until admin enables. Plans: Free $0, Pro $20 ($17 annual), Max $100, Ultra $200,
Team Std $20-25 / Premium $100-125 per seat, Enterprise $20/seat + usage (claude.com/pricing).

## The date fact (load-bearing for researchers)
- The interface INJECTS the current date; the model does NOT know it from weights. "Today is <date>"
  in a prompt works because the harness supplies it. Keep that line in researcher prompts.

## Limits
- NO autonomous scheduling. Standing instructions shape behavior WHEN invoked; the chat does not
  wake itself on a date. (Recurring radar → CLI/automation layer.)
- Project-knowledge edits do not disrupt a running thread; freshness for an in-flight thread isn't
  guaranteed → for a running thread, paste new context rather than rely on re-index.

## Recommendation for LARVA
Host the **agent-builder** and the **recalibration researcher** here as Projects with standing
instructions. Feed the RELATIVE cards as project knowledge so they reason against current reality.
Claude Design is available but not yet load-bearing in LARVA workflow — assess when stable.
Claude Code Artifacts are usable on Pro/Max for publishing session outputs as live pages.
</content>
