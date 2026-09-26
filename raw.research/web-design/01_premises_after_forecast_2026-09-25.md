---
artifact: premises-after-open-web-forecast
project: reposoma
scope: shared architecture and philosophical premises
written: 2026-09-25
language: en
author: Wave / Asymmetry
status: proposed-addendum-for-review
implementation_authority: false
supersedes: none
amends_by_proposal: 02-thread-synthesis-and-philosophical-record.md
companions:
  - 02_agent_readable_shop_2026-09-25.md
  - 03_identity_and_termbrana_2026-09-25.md
---

# 1. After the forecast: change the requirements, not the whole architecture

## Purpose and reading order

This is the common entry point for three independent briefs. Read this file for the changed premises, file 2 for a shop implementation direction, and file 3 for identity, knowledge, and Termbrana implications. They extend the September 22 handoff; they do not overwrite it or authorize implementation.

**My position:** do not rebuild around the prediction that applications, browsers, or the open web disappear. Design useful interfaces that remain useful whether agent mediation grows slowly or quickly. Add stronger source, freshness, and permission requirements where mediation can hide important context.

The new user direction is to preserve an ordinary human-facing shop while making its information deliberately accessible to agents. The identity question is whether the same development changes the vendor-independent framework. The answer proposed here is: **the identity's posture need not change; its rules for observing and acting need to become more explicit.**

Labels used throughout: **CARRIED FORWARD** means a recorded earlier principle; **USER DIRECTION** means the requested direction, not approval of every mechanism; **PROPOSED** means my recommendation; **VERIFIED** means bounded support from a cited source; **UNVERIFIED** means no live implementation evidence was obtained.

## 1. What the evidence actually changes

| Evidence checked on September 25, 2026 | What it supports | What it does not establish |
|---|---|---|
| Pew's July 22, 2025 study observed 900 U.S. adults' March browsing. Traditional-result clicks were 8% on search visits with an AI summary and 15% without. Search pages were reconstructed later. [E1] | A substantial association between answer-first search and fewer outbound clicks in that sample. | A causal percentage loss for this shop, every publisher, or all agent-mediated commerce. |
| Google said in August 2025 that aggregate organic clicks were relatively stable year-on-year and described improved click quality. The post is the provider's account, not an independent audit. [E2] | Relevant counterevidence against a simple total-traffic-collapse story. | Uniform outcomes across publishers, categories, or individual queries. |
| Wikimedia described revised human-traffic measurements, bot load, and concern about participation in October 2025. [E3] | Source production and maintenance deserve attention alongside access to the resulting text. | A measured extinction trajectory or a proof that AI alone caused the changes. |
| Google documents ordinary crawlability and content practices for its AI search features; no special AI text file or new schema is required for eligibility. [E4] | Existing web engineering is a defensible starting point. | That a private API will be automatically discovered by any agent, or that following the guidance guarantees inclusion. |

These sources justify treating discovery, producer sustainability, and source visibility as risks to measure. They do not justify the forecast's deadlines for the disappearance of shops, keyboards, or creators. The Czech text remains a supplied summary of forecasts; the original recording was not audited for this packet.

The studies above concern different populations and measurements. Do not combine their numbers into one growth or decline estimate. In particular, a publisher's advertising model and a merchant's completed-order economics are not interchangeable.

## 2. Delta against our actual previous handoff

The September 22 synthesis already separated ownership, authority, location, access, and freshness. It already argued for preserving relationships between records. These are not discoveries made today. [B2]

| Previous premise | Treatment now | Concrete consequence |
|---|---|---|
| Truth lives in files. | **CARRIED FORWARD, scoped.** Inspectable project records are the authority for recorded decisions, not magical proof of external facts. | Identify the authority for each class of fact. A shop's current offer may come from its application/database; the brief is not the price authority. |
| Survive high volatility. | **CARRIED FORWARD.** | Replace a reader, model, adapter, or UI without silently changing the meaning of a work record. |
| Keep independent tools well connected. | **CARRIED FORWARD.** | Keep the shop UI and the Sublime/Firefox/tmux tools. Connect them through bounded interfaces. |
| The web supplies shared addressability. | **NARROWED.** Access and continued source production cannot be assumed. | Preserve origin, observation time, version where available, access status, and a way to revisit or correct the claim. |
| Preserve relationships, not just objects. | **EXTENDED.** | Preserve relationships to the producer and current authority, not only between note, batch, and result. |
| Make data easy for agents to consume. | **NEW USER DIRECTION, qualified.** | Publish useful permitted facts; do not equate agent-readability with unrestricted copying or authority to transact. |
| More machine access is automatically beneficial. | **REJECTED as an assumption.** | Measure merchant outcomes, serving cost, errors, and loss of source context—not only request counts. |

**The meaningful addition is source renewal:** storing an answer is not the same as preserving the ability to obtain tomorrow's correction. This is a design concern, not a claim that adding metadata solves the public web's economics.

## 3. Five foundation stones

### Stone 1 — Authority belongs to a declared source and scope

For each consequential statement, ask: authoritative for what, in which context, at which revision or observation time? A merchant is authoritative about its offered price, not automatically about whether its product is objectively the best. A signed or hashed record can identify an origin or byte sequence without proving factual correctness.

**Design test:** when a saved note conflicts with a current offer, the system can explain which authority governs the proposed action and why.

### Stone 2 — Addressability is not authority or permission

An accessible URL should help an authorized reader locate information. It must not be interpreted as permission to modify the source, place an order, retrieve private fields, or install new instructions into an agent's identity.

**Design test:** a reader can inspect an approved public record while a write request without the relevant authorization is rejected.

### Stone 3 — Preserve human inspection alongside machine access

A machine-facing representation should retain a human route to the same object and its relevant context. Do not make an agent account the only way a customer can inspect an offer or a developer can inspect a work record.

**Design test:** a person can open the product or original pin from the agent's result and understand the basis of the decision.

### Stone 4 — Separate discovering, proposing, and committing

Reading a category is not a purchase. Attaching notes to a session is not a deployment. Preserve the existing distinction between automatic collection and authorized release/execution. [B1]

**Design test:** retries, source refreshes, and agent restarts cannot silently create new side effects. Important mutations use the application's existing authorization and transaction boundaries.

### Stone 5 — Make replacement and correction ordinary operations

Carry sufficient identifiers and evidence to replace a vendor adapter and to revise a mistaken conclusion. Keep the contract small; introduce fields only when they support an actual decision, recovery, or audit.

**Design test:** another authorized agent can resume the bounded work, find its sources, and identify outstanding permissions without inheriting a proprietary transcript.

These stones are an operational interpretation of our conversation. They are not a new universal framework or approved repository policy.

## 4. The producer and consumer must meet in the middle

**Shop, as producer:** publish coherent, bounded facts from the existing business authority; retain human links; communicate context and refresh conditions; measure service cost and useful outcomes.

**Agent/framework, as consumer:** carry provenance forward; distinguish stale from current; preserve unknowns; do not replace evidence with repeated summaries; honor actual access and action boundaries.

**Termbrana, as the work connection:** retain the captured observation and the comment separately, route a definite set of notes, and expose drift before relevant action.

This is a shared conceptual contract, not a reason to force shop JSON, agent memory, and every note into one identical schema. Commerce and developer work have different semantics.

A candidate addition to the philosophy is:

> Make facts easy to retrieve, their origin easy to inspect, and consequential actions hard to perform accidentally.

## 5. What we deliberately are not adding

No compulsory cloud migration, replacement IDE, new memory engine, agent marketplace, decentralized ledger, or universal ontology. No requirement for screenshots or an LLM to serialize facts that the shop already knows. No default conversion of an entire catalogue into Markdown.

A data publication path is not a promise that external agents will adopt it. The first consumer should be a named, testable integration. The usefulness of the ordinary human site remains a requirement, not a concession to an old technology.

## 6. Three next-thread scopes

| Thread | Its question | Its first output |
|---|---|---|
| Shop: machine-readable catalogue | What can a permitted reader discover correctly without replaying the visual UI? | Inventory of existing links, product markup, feeds, and read interfaces; one bounded pilot plan. |
| Reposoma: identity and evidence | What must survive when external sources or agent endpoints change? | Gap check against existing identity, source, receipt, and permission records. |
| Termbrana: observation to work | Can a changed source be detected without losing the original note or altering an already released batch? | One replayable source-drift test using the existing pin/block/session loop. |

Shared sequencing: inspect existing interfaces first; test a small read-only loop; add machinery only for a demonstrated gap. The shop can proceed independently of a Termbrana release.

**Packet boundary:** no repository, installed plugin, production shop, or running host was inspected or changed. Files were read from the earlier handoff and public sources were checked. No schedule was inspected, changed, or created in this work.

## Sources and baseline

[E1] Pew Research Center, July 22, 2025. Observational study, with March browsing and April reconstruction; inspected September 25, 2026. https://www.pewresearch.org/short-reads/2025/07/22/google-users-are-less-likely-to-click-on-links-when-an-ai-summary-appears-in-the-results/

[E2] Google, August 6, 2025, provider account; inspected September 25, 2026. https://blog.google/products-and-platforms/products/search/ai-search-driving-more-queries-higher-quality-clicks/

[E3] Wikimedia Foundation, October 17, 2025, organizational observations and interpretation; inspected September 25, 2026. https://wikimediafoundation.org/news/2025/10/17/new-user-trends-on-wikipedia/

[E4] Google Search Central, AI features and your website, guidance inspected September 25, 2026. https://developers.google.com/search/docs/appearance/ai-features

[B1] `01-termbrana-design-and-handoff.md`, September 22, 2026, especially §§2, 5–8. Read from the attached handoff, not treated as live implementation evidence.

[B2] `02-thread-synthesis-and-philosophical-record.md`, September 22, 2026, especially §§3.2–3.4 and 4. Read from the attached handoff. The earlier source inspections recorded there were not rerun here.

[B3] `03-wave-2-reposoma-master-instructions.md`, September 22, 2026, especially its source, independent-consultation, and Termbrana boundaries. Read as the current handoff posture, not proof of runtime loading.

## Baseline identity receipt

The three attached September 22 files above were read as historical design sources. SHA-256 identifies these exact copies, not their correctness or live repository status.

- `01-termbrana-design-and-handoff.md`: `e7c72bf086565adcd8ceccfebce4f3bf4218f25d1db4dcd419966fd750376cfa`
- `02-thread-synthesis-and-philosophical-record.md`: `ec8101d4bcf26b1e6babf651a1d437fd70c9fbebc0735f1d4c4ffa37cac07b60`
- `03-wave-2-reposoma-master-instructions.md`: `41721b1b3398aed6bfe60ce0ea6a4412c550178007566c91504e7165993a3629`
