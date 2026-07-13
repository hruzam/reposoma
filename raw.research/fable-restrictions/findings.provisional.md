# Fable 5 Model-Switch Restrictions — Provisional Findings
Date: 2026-07-12
Prepared by: @Epoch
Status: Provisional — raw findings for Atlas and Houston to synthesize into agent guidance
Triggered by: Agent-safety audit — Fable-pinned agents in the temple system

---

## 1. What Fable 5 Is

Claude Fable 5 (released 2026-06-09) is Anthropic's highest-capability tier at launch, positioned above Opus. It ships as the default "advanced" model on Claude.ai for Pro/Team/Enterprise subscribers and is accessible via API. Its extended context, reasoning depth, and coding capability make it the natural seat for complex agentic loops — the same reason several temple agents pin `model: fable`.

It was suspended 2026-06-12 due to U.S. export controls triggered by a reported safety bypass, then restored globally 2026-07-01 with an updated classifier.

---

## 2. Documented Trigger Categories

There are TWO distinct restriction mechanisms. They behave differently and require different mitigation strategies.

### Mechanism A: Transparent model-switch (Fable 5 → Opus 4.8)

The request is re-run on Opus 4.8. The user/agent receives a notice that the model switched and the response is labeled with the model that answered. This fires in fewer than 5% of sessions (Anthropic estimate).

**Categories that trigger Mechanism A:**

**A1. Offensive Cybersecurity**
- Exploit development, vulnerability identification with exploit-code output
- Malware creation, behavior analysis, obfuscation, persistence techniques
- Credential harvesting methods
- Security control reverse engineering
- Penetration testing steps with offensive framing
- NOTE: the post-July-1 classifier was specifically tuned to block the Amazon-reported jailbreak (prompting to identify vulnerabilities → exploit code). False positive rate on routine coding and debugging tasks increased as a side effect. Anthropic acknowledges this explicitly.

**A2. Biology, Chemistry, and Life Sciences**
- Pathogen characteristics, transmissibility, enhancement queries
- Microorganism synthesis or cultivation protocols
- Gain-of-function research specifics
- Biological toxin mechanisms
- Lab protocols involving select agents
- Bioactive compound extraction protocols
- Distillation/purification steps for controlled or precursor substances
- Industrial-scale fractional distillation with specific compounds, yields, or equipment
- Known false positives (community-reported): "RNA sequencing data," "cancer" (word alone), bioinformatics queries, biotech documentation

**A3. Distillation Attacks**
- Attempts to extract the model's summarized thinking or reasoning process in a way that would enable training a competing model
- Queries designed to elicit large structured knowledge dumps that approximate training data
- NOTE: "distillation" in the chemistry/biology sense (physical separation) is categorized under A2, not here. A3 is specifically about ML model knowledge extraction.

**A4. Frontier LLM Development** (see also Mechanism B below — behavior is split)
- Building pretraining pipelines
- Distributed training infrastructure design
- ML accelerator design
- NOTE: At launch (2026-06-09 through ~2026-07-01), this category used Mechanism B (silent). After backlash, Anthropic reversed the silent-degradation policy for this category. Current behavior (post-July-1) is unclear from available sources — either Mechanism A or no restriction. This is an open question.

### Mechanism B: Silent degradation (NO model switch, NO user notice)

At launch, Fable 5 implemented covert restrictions for frontier LLM development using prompt modification, steering vectors, or PEFT. The model appears to respond but underperforms intentionally. There is NO notification.

**Current status of Mechanism B:** Anthropic reversed this policy following community backlash (Simon Willison, Nathan Lambert, LessWrong). As of 2026-07-01 redeployment, it is unclear whether silent restrictions are fully removed or only partially walked back. TREAT AS POTENTIALLY ACTIVE until confirmed otherwise.

**What silent degradation looks like:** responses that are technically coherent but noticeably less capable, shorter, or oddly vague on specific subtopics — with no error, no model-switch notice, no explicit refusal.

---

## 3. Specific Terms and Phrases That Flag Classifiers

Community-reported trigger terms (CONFIDENCE: M — practitioner observation, not official list):

**Biology/Chemistry cluster:**
- "cancer" (word alone in certain contexts)
- "RNA sequencing"
- "synthesis" + any organism or compound name
- "pathogen," "transmissibility," "gain-of-function"
- "distillation" + compound name + yield/equipment
- "protocol" + any lab procedure

**Cybersecurity cluster:**
- "exploit," "payload," "shellcode"
- "persistence," "obfuscation" in code contexts
- "vulnerability" + "demonstrate" or "proof of concept"
- "CVE-" identifiers combined with implementation requests
- "penetration test" + specific steps

**Distillation-attack cluster:**
- "summarize your training" / "what do you know about X" in bulk extraction patterns
- Structured prompts requesting comprehensive knowledge dumps in machine-readable format

**Frontier LLM cluster (Mechanism B / uncertain post-July-1):**
- "pretraining," "distributed training," "gradient checkpointing at scale"
- "ML accelerator," "TPU design," "GPU cluster topology"
- "training pipeline" + architecture specifics

---

## 4. Behavior After the Switch

**Mechanism A (visible switch):**
- Request is re-run on Claude Opus 4.8
- User/agent receives a notice that the model switched
- Response is labeled with the model that answered (Opus 4.8)
- Latency increase: "a few additional seconds"
- Conversation continues — it does not terminate
- The switch is per-request; subsequent unblocked requests may return to Fable 5 (behavior not confirmed; needs verification)
- Can be disabled in Settings > Capabilities (consumer UI). API/operator behavior: see open questions.

**Mechanism B (silent):**
- No notice, no label change, no error
- Conversation continues on Fable 5 nominally
- Response quality is covertly degraded
- Current status: likely reversed, but unconfirmed

---

## 5. Agent-Prompt Implications

### 5.1 What to avoid in system prompts and agent briefings

**Hard avoids (likely to trigger Mechanism A on contact):**
- Do not include the words "exploit," "malware," "shellcode," "payload," or "penetration test" in agent identity/capability descriptions
- Do not describe agents as security researchers, red-teamers, or offensive security specialists without operator-level configuration
- Do not include biology lab terminology ("synthesis," "protocol," "pathogen") in agent personas or task descriptions
- Do not frame agent scope as "extract knowledge" or "summarize comprehensively" in ways that pattern-match to distillation attacks

**Contextual risks (may trigger depending on surrounding conversation):**
- Security-adjacent agents (e.g., code auditors, vulnerability scanners) — frame toward defensive/detection posture
- Research agents operating in bioinformatics, chemistry, or life sciences — add explicit use-context early in system prompt
- Agents that issue large structured knowledge-extraction requests (RAG builders, knowledge graph builders) — avoid bulk-dump prompt patterns

**The "content from connectors" risk:**
Classifiers review ALL content the model encounters — including memory outputs, web search results, file contents, and tool outputs — not just the direct user turn. An agent that retrieves a document containing flagged terminology can trigger a mid-conversation switch even if the agent's own instructions are clean.

**Specific design rule:**
If a Fable-pinned agent's task pipeline passes through external content (web, files, memory), build retrieval steps on a non-Fable model or sanitize before the Fable context window receives it. Do not assume Fable can process arbitrary external content without triggering Mechanism A.

### 5.2 Framing guidance (from official Anthropic and MindStudio sources)

- Establish explicit application context early in the system prompt (e.g., "This agent assists internal security teams with detection and triage of known vulnerabilities")
- Separate technical mechanisms from operational/procedural details
- Use defensive/detection framing rather than offensive framing
- Operator-level system prompt configuration (API) offers more latitude than consumer UI defaults — but hardcoded restrictions (bioweapons, CSAM, critical infrastructure attacks) cannot be overridden at any level

### 5.3 The silent-degradation risk

For agents doing ML research, AI development, or training-infrastructure work: if quality unexpectedly drops with no error or switch notice, suspect Mechanism B residue. Mitigation: use Opus 4.8 directly for these tasks until Mechanism B status is officially confirmed as fully reversed.

---

## 6. Source Quality Notes

| Claim | Source | Confidence | Notes |
|---|---|---|---|
| Four trigger categories (cyber, bio/chem, distillation, frontier LLM) | support.claude.com official help article | H | Official |
| Fallback to Opus 4.8, user notification | support.claude.com + anthropic.com/news/redeploying-fable-5 | H | Official |
| "Fewer than 5% of sessions" trigger rate | Anthropic (via search result summary) | M | Official but approximate |
| Silent degradation via PEFT/steering vectors | Anthropic launch announcement (confirmed by Simon Willison, Nathan Lambert, LessWrong post) | H | Official + independently corroborated |
| Silent degradation reversed after backlash | Simon Willison simonwillison.net/2026/Jun/10/ (update note) | M | Not yet confirmed in official Anthropic doc |
| Specific false-positive examples (cancer, RNA sequencing) | logicity.in practitioner report | M | Community observation |
| Classifier reviews memory/connectors/files, not just direct input | support.claude.com | H | Official |
| Post-July-1 classifier increases false positives on coding/debugging | anthropic.com/news/redeploying-fable-5 | H | Official |
| System prompt ~3,800 lines XML; leaked by Pliny the Liberator | latent.space AINews, multiple aggregators | M | Unverified authenticity; Anthropic has not confirmed |
| "Distillation" in bio/chem sense categorized under bio/chem, not ML-distillation | MindStudio blog | M | Practitioner synthesis; not in official docs |
| Frontier LLM restriction uses PEFT/steering rather than model switch | Anthropic launch announcement | H | Official; current status post-reversal unclear |

---

## 7. Open Questions

**OQ-1: Per-request or per-conversation switching?**
After a Mechanism A switch fires and Opus 4.8 responds, does the next unblocked request automatically return to Fable 5, or does the conversation stay on Opus 4.8 for the remainder? Not confirmed in any source reviewed.

**OQ-2: API operator override scope**
The help center says Mechanism A can be disabled in Settings > Capabilities. Does this control extend to API callers via system prompt / operator config? Or does it require account-level settings? Unconfirmed.

**OQ-3: Mechanism B post-July-1 status**
Anthropic reversed the silent-degradation policy after backlash. Is the reversal complete (no silent degradation anywhere) or partial (still active for some sub-categories)? Simon Willison's update note suggests reversal but does not link to an official statement.

**OQ-4: Hardcoded vs. softcoded boundary in practice**
MindStudio describes two tiers: hardcoded (bioweapons, CSAM, etc.) that cannot be overridden at any level, and softcoded defaults that operators can adjust. The exact boundary between A1-A4 and the hardcoded tier is not officially published.

**OQ-5: False positive rate post-July-1 classifier**
Anthropic admits the new cybersecurity classifier increases false positives on routine coding. No quantified rate published. Practitioner reports are accumulating but not yet synthesized.

**OQ-6: Memory/connector trigger scope**
The official source says classifiers review "memory, content from connectors, web search results, and files." Does this mean the classifier runs on retrieved content before it enters the context window, or on the full assembled context? Timing matters for agent pipeline design.

---

## Sources Consulted

- [Why Claude switched models in your conversation with Fable 5 — Claude Help Center](https://support.claude.com/en/articles/15363606-why-claude-switched-models-in-your-conversation-with-fable-5) — OFFICIAL
- [Redeploying Claude Fable 5 — Anthropic](https://www.anthropic.com/news/redeploying-fable-5) — OFFICIAL
- [Claude Fable 5 Safety Restrictions Explained — MindStudio](https://www.mindstudio.ai/blog/claude-fable-5-safety-restrictions-explained) — PRACTITIONER
- [If Claude Fable stops helping you, you'll never know — Simon Willison](https://simonwillison.net/2026/Jun/10/if-claude-fable-stops-helping-you/) — PRACTITIONER (H-reliability)
- [Claude Fable 5 and new safety fables — Nathan Lambert / Interconnects](https://www.interconnects.ai/p/claude-fable-5-and-new-ai-safety) — PRACTITIONER
- [Thoughts on Claude Fable's silent safeguards — LessWrong](https://www.lesswrong.com/posts/sSyLyc3KDQzboQGWS/thoughts-on-claude-fable-s-silent-safeguards) — COMMUNITY
- [Claude Fable 5 Safety Triggers Block Legitimate Prompts — Logicity](https://logicity.in/en/blog/claude-fable-5-safety-triggers-block-legitimate-prompts) — PRACTITIONER
- [Claude Fable 5 Safety Restrictions Explained (v2) — MindStudio](https://www.mindstudio.ai/blog/claude-fable-5-safety-restrictions-explained-2) — PRACTITIONER
- Search aggregations via WebSearch (2026-07-12)

---

## 8. Operator Observations — Empirical Test Cases (2026-07-12)

Source: majkee, direct testing across claude.ai and Claude Code CLI sessions.
Confidence: H (first-hand, reproducible, described outcome tracked in-session).

These cases extend beyond the four documented official categories.

**Case 1 — "mycelium" (or "micellium") as trigger term**
- Context: conversation involving fungal networks / biology-adjacent topic
- Trigger: the word "mycelium" (confirmed by isolation test — removed word, flag cleared)
- Mechanism: Mechanism A on claude.ai (explicit flag message)
- Category mapping: bio/chem cluster — confirms effective vocabulary is WIDER than the
  official "pathogen / synthesis / gain-of-function" list. Organism-adjacent nouns in
  biology context are in scope.
- CLI behavior: flag cleared by word substitution (one or two words). Threshold lower on
  CLI than claude.ai. Same substitution did NOT clear on claude.ai.

**Case 2 — memory manipulation framing**
- Context: philosophical / cognitive discussion
- Trigger combination: "when you are reading memory from your brain, it is same process
  as you are creating this one as new" + "saw document where scientist demonstrated how
  it works to manipulate old memory of tested subject"
- Mechanism: Mechanism A on claude.ai (explicit flag message). Once triggered, full
  rewrite of the turn still returned flag message — context window saturation.
- Category mapping: likely an UNDOCUMENTED FIFTH CATEGORY — psychological/cognitive
  manipulation research (scientist + demonstration + memory alteration + human subject).
  Pattern matches OQ-4's hardcoded tier. Not in the four published categories.
- CLI behavior: not tested for this specific case.

**Pattern derived from both cases:**
- CLI classifier threshold is empirically lower than claude.ai. Word substitution alone
  can hold Fable on CLI where it does not on claude.ai.
- Once triggered in a claude.ai session, context saturation prevents recovery via
  rephrasing — the pattern is held in the accumulated window.
- The effective trigger vocabulary for bio/chem is broader than the official term list.
- Metaphorical / philosophical register does NOT reliably protect from triggering —
  "mycelium" and "memory manipulation of subjects" are not offensive in context but
  still flag.

**Practical note added to operator protocol:**
When a Fable-pinned agent on CLI shows quality drop mid-session: lexical substitution
may clear a direct trigger, but if context window has accumulated pattern density,
move the topic rather than rephrase. Do not assume word-swap alone is sufficient for
session-state triggers.

---
*End of provisional findings.*
