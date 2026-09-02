---
what: Date-calibrated research pass — Gemini model lineup, Gemini CLI status, multimodal capability delta, pricing/quota, deprecations. Requested for a local "operating partner / multimedia expert" seat design.
state: RESEARCH-SNAPSHOT
verified: 2026-09-01
next: []
---

# @Epoch research report — Gemini state refresh

Date: 2026-09-01
Triggered by: date-calibrated research pass, tight-scope local "operating partner / multimedia
expert" seat design; caller flagged all Gemini-related training knowledge as stale.
Scope: project-specific overlay (Gemini model lineup, Gemini CLI, multimodal capabilities,
pricing, deprecations) — not the default CLI-runtime radar in full.

**Everything below is VOLATILE.** Model strings, prices, and CLI status are moving fast in
this family (multiple breaking events inside the last 8 weeks). Nothing here should be
hardcoded into config without a re-check at time of use.

---

## Delta vs ~2026-07 assumptions (top-line table)

| Area | ~2026-07 assumption (likely stale) | 2026-09-01 verified state | Confidence |
|---|---|---|---|
| CLI identity | "Gemini CLI" is the tool | Gemini CLI is being **retired for individual/free/Pro/Ultra users** — replaced by **Antigravity CLI** as of 2026-06-18. Gemini CLI itself still exists but only for enterprise (Code Assist Standard/Enterprise) or paid API-key auth. | H |
| Frontier model | Gemini 3 Pro / early 3.x Flash | Two live families: **Gemini 3.x** (3.1 Pro, 3.7 Flash, 3.6 Flash, 3.5 Flash, 3.5 Flash-Lite, 3.1 Flash-Lite) is frontier; **Gemini 2.5** (Pro/Flash/Flash-Lite) is the cheaper fallback, no official shutdown date yet despite some tracker claims. | H |
| Newest model | none/unclear | **Gemini 3.7 Flash**, released 2026-08-13, is the newest, cheapest-per-capability Flash (coding/agentic-tuned, introductory pricing through 2026-12-31). | M-H |
| Image model | Imagen 4.0 family | Imagen 4.0 models shut down 2026-08-17; replaced by **gemini-3.1-flash-image** / **Nano Banana 2 / Nano Banana Pro**. | H |
| Free tier | Pro models free-tier-eligible | Since 2026-04-01, **Pro-tier models are no longer on the free tier** — only Flash/Flash-Lite are free (5-15 RPM, ≤1000 req/day). | M |
| gemini-2.0-flash* | assumed current/cheap | Shut down 2026-06-01. Any config referencing `gemini-2.0-flash` or `gemini-2.0-flash-lite` is dead. | H |
| CLI auth | GEMINI_API_KEY direct | Antigravity CLI initially dropped BYO-API-key support at the June cutover, then **restored** `GEMINI_API_KEY` support in v1.1.13 (2026-08-14) via `modelProvider: "gemini"` in settings.json. | M |
| API key format | Standard API key = permanent auth path | **Separate from the CLI transition:** Google is retiring "Standard" Gemini API keys entirely — unrestricted standard keys already rejected since 2026-06-19; **ALL standard keys (including paid pay-as-you-go, restricted or not) stop working "September 2026"** (no exact day confirmed), replaced by service-account-bound "auth keys." This hits Gemini CLI's `GEMINI_API_KEY` auth path directly, independent of the Antigravity migration. | H (dates/mechanism) / L (exact September day) |

---

## Findings (most recent first)

### 1. Gemini CLI → Antigravity CLI transition (the single biggest structural change)
WHAT changed: Google announced it is "unifying efforts into Google Antigravity," retiring
Gemini CLI as the consumer-facing tool. Antigravity CLI became generally available on
2026-05-19. On **2026-06-18**, Gemini CLI and the Gemini Code Assist IDE extensions stopped
serving requests for Google AI Pro, Google AI Ultra, and free individual users. Enterprise
users on Gemini Code Assist Standard/Enterprise licenses, and anyone authenticating with a
paid Gemini/Gemini Enterprise Agent Platform API key, are unaffected and can keep using
Gemini CLI.
SINCE: 2026-05-19 (Antigravity GA) / 2026-06-18 (Gemini CLI individual cutoff)
SOURCE: developers.googleblog.com "An important update: Transitioning Gemini CLI to
Antigravity CLI" (fetched 2026-09-01); corroborated by github.com/google-gemini/gemini-cli
discussion #28017 ("Gemini CLI Has Stopped Serving Requests...") and theregister.com
2026-05-20 "Bye-bye, Gemini CLI; Google nudges devs toward Antigravity"
CONFIDENCE: H (official Google blog + first-party GitHub discussion, cross-confirmed by
independent press)
IMPACT: If any local config or doctrine still names "Gemini CLI" as the free/individual
consumer entry point, that's stale. Any project referencing plain `gemini` CLI auth via a
personal Google account (not an API key, not enterprise license) is likely broken since
2026-06-18.
ACTION: For a project-contract overlay, check whether the local Gemini usage authenticates
via API key (still works) or personal Google/Pro-Ultra login (broken since June). Re-point
doctrine mentioning "Gemini CLI" toward Antigravity CLI as the actively-developed consumer
tool, while noting Gemini CLI persists as an enterprise/API-key-only path.

### 2. Antigravity CLI restores BYO API-key support
WHAT changed: At the June cutover, Antigravity CLI had no way to use a standalone Google AI
Studio API key (no BYOK). As of **release 1.1.13 (2026-08-14)**, `GEMINI_API_KEY` was
restored as a direct-API option — set `modelProvider: "gemini"` in settings.json and export
`GEMINI_API_KEY`.
SINCE: 2026-08-14
SOURCE: github.com/google-antigravity/antigravity-cli issue #78 and discuss.ai.google.dev
threads on "how to use API key with Antigravity" (surfaced via web search 2026-09-01; not
independently re-fetched from the primary issue thread this run)
CONFIDENCE: M (aggregated search summary, not directly fetched from the GitHub issue —
recommend a direct fetch before hardcoding this into a config)
IMPACT: A pure API-key-only local seat (no enterprise Code Assist license, no Pro/Ultra
subscription) now has a working path again on Antigravity CLI, closing a ~2-month gap.
ACTION: Before wiring this into any harness, fetch
github.com/google-antigravity/antigravity-cli/issues/78 directly to confirm exact settings
schema — this is second-hand in this pass.

### 3. Gemini CLI version and maintenance cadence
WHAT changed: Gemini CLI itself is still being actively released — latest stable is
**v0.55.1 (2026-08-11)**, with **v0.57.0** published ~6 days before this search (so roughly
late Aug 2026). Recent changes: stricter HTTPS enforcement for
`GoogleCredentialsAuthProvider` (blocks cleartext leakage), `coreTools` config key migrated
to `tools.core`, session-ID rotation on model fallback, capacity-exhaustion now a terminal
error (no more silent retry hangs).
SINCE: v0.55.1 = 2026-08-11; v0.57.0 ≈ late Aug 2026 (exact date not directly confirmed)
SOURCE: geminicli.com/docs/changelogs/latest (fetched 2026-09-01); npmjs.com/package/@google/gemini-cli
(search snapshot, "6 days ago" relative to search date)
CONFIDENCE: M (changelog page fetched directly = H for v0.55.1 content; the v0.57.0 date is
relative/inferred = L, needs a direct npm fetch to pin)
IMPACT: Despite the Antigravity pivot, the Gemini CLI codebase is not abandoned — it's still
shipping weekly-ish patches, just scoped to enterprise/API-key users now.
ACTION: If the project only cares about Antigravity CLI going forward, deprioritize tracking
Gemini CLI release notes; if it deliberately stays on Gemini CLI via API key, keep watching
this changelog for the `coreTools`→`tools.core` style breaking config renames.

### 4. Gemini 3.7 Flash — newest model as of this pass
WHAT changed: Gemini 3.7 Flash released, "built for complex coding, agentic workflows, and
reliable multi-step execution." Priced at $0.75/1M input, $3.75/1M output through
2026-12-31 (introductory rate; expected to rise in 2027).
SINCE: 2026-08-13
SOURCE: ai.google.dev/gemini-api/docs/models (fetched 2026-09-01); venturebeat.com "Google's
Gemini 3.7 Flash targets coding and agents with a 50% introductory price cut" (search
snapshot); ai.google.dev/gemini-api/docs/pricing (fetched 2026-09-01)
CONFIDENCE: H (official docs pages fetched directly)
IMPACT: This is the current best cheap/fast utility-call model for agentic/coding work,
displacing 3.5 Flash and 3.6 Flash for that niche.
ACTION: For "cheap fast utility calls," default to Gemini 3.7 Flash; re-check price after
2026-12-31 when the introductory rate expires.

### 5. Current model lineup and recommended picks
WHAT changed (state, not a delta): Two live families as of 2026-09-01:
- **Gemini 3.x (frontier):** 3.1 Pro (preview, deep reasoning/agentic), 3.7 Flash (newest,
  coding/agentic), 3.6 Flash, 3.5 Flash, 3.5 Flash-Lite, 3.1 Flash-Lite (cheapest).
- **Gemini 2.5 (fallback):** Pro, Flash, Flash-Lite — official deprecations page currently
  lists "No shutdown date announced" for these, though some third-party trackers guess
  2026-10-16 (unconfirmed, do not treat as fact — see Finding 6).
- **Multimedia-specific models**, separate from the general chat lineup:
  - Vision/image generation: **Nano Banana 2** (fast), **Nano Banana 2 Lite** (ultra-low
    latency), **Nano Banana Pro** (4K professional), replacing the shut-down Imagen 4.0 line.
  - Video: **Veo 3.1** (cinematic, synchronized audio) and the newer **Gemini Omni Flash**
    (video generation/editing/keyframe interpolation/extension with native audio) — Omni
    appears to be a preview/rolling-out tier, treat as less stable than Veo 3.1.
  - Audio: **Gemini 3.1 Flash Live** (real-time audio-to-audio dialogue), **Gemini 3.1 Flash
    TTS** (low-latency speech generation), **Gemini 3.5 Transcribe** (speech-to-text).
  - Multimodal embeddings: **Gemini Embedding 2** (text, images, video, audio, PDFs in one
    embedding model).
SOURCE: ai.google.dev/gemini-api/docs/models (fetched directly 2026-09-01)
CONFIDENCE: H for the model list itself (official docs); M for which are GA vs preview
(the docs page groups some as "Preview" explicitly — 3.1 Pro, Gemini 3 Flash (plain), Omni
Flash, Flash Live, Flash TTS, Live Translate all still preview-tagged as of this fetch).

**Recommendation for the "operating partner / multimedia expert" seat:**
- (a) multimedia/vision/audio work → **Gemini 3.1 Pro** for reasoning-heavy multimodal
  understanding (still preview — confirm GA status before production-locking); **Nano
  Banana Pro** for image generation/editing; **Gemini 3.1 Flash Live** for real-time
  audio dialogue; **Veo 3.1** for stable video generation (Omni Flash is newer but preview
  — riskier to depend on today).
- (b) cheap fast utility calls → **Gemini 3.7 Flash** (newest, cheapest-per-capability for
  agentic/coding utility work) or **Gemini 3.5 Flash-Lite** ($0.30/$2.50 per 1M) if the task
  doesn't need 3.7's agentic tuning.
CONFIDENCE: M (recommendation synthesized from H-confidence model facts; the GA/preview
line matters and should be re-checked at implementation time, not just research time)

### 6. Gemini 2.5 retirement — conflicting signals, flagged not resolved
WHAT changed: nothing confirmed — flagging a conflict. Official
ai.google.dev/gemini-api/docs/deprecations lists Gemini 2.5 Pro/Flash with "No shutdown date
announced." Some third-party trackers (search-aggregated, not independently verified this
run) claim 2026-10-16 as a retirement date for these models.
SOURCE: ai.google.dev/gemini-api/docs/deprecations (fetched 2026-09-01, official) vs.
unnamed aggregator trackers surfaced in search results (not fetched directly)
CONFIDENCE: L for the 2026-10-16 date — treat as rumor until the official page changes.
CONFIDENCE: H that no official shutdown date exists as of 2026-09-01.
IMPACT: Do not build a hard migration deadline around Gemini 2.5 sunset yet.
ACTION: Re-check ai.google.dev/gemini-api/docs/deprecations directly if this project still
depends on any 2.5-family model, especially close to Oct 2026.

### 7. Deprecated/sunset models a July-2026 config might still reference
WHAT changed: Confirmed shutdown dates (official page, fetched 2026-09-01):
- `gemini-3-pro-preview` → shut down 2026-03-09 (replace: `gemini-3.1-pro-preview`)
- `gemini-2.0-flash`, `gemini-2.0-flash-001`, `gemini-2.0-flash-lite`,
  `gemini-2.0-flash-lite-001` → shut down 2026-06-01 (replace: `gemini-3.6-flash` /
  `gemini-3.1-flash-lite`)
- `gemini-3.1-flash-image-preview`, `gemini-3-pro-image-preview` → shut down 2026-06-25
- `gemini-3.1-flash-lite-preview` → shut down 2026-05-25
- `gemini-2.5-flash-lite-preview-09-2025` → shut down 2026-03-31
- `gemini-2.5-flash-preview-05-20` → shut down 2025-11-18
- `gemini-2.5-flash-image-preview` → shut down 2026-01-15
- Imagen 4.0 family (`imagen-4.0-generate-001`, `-ultra-generate-001`, `-fast-generate-001`)
  → shut down 2026-08-17 (replace: `gemini-3.1-flash-image`)
- `text-embedding-004` → shut down 2026-01-14; `embedding-001` → shut down Oct 2025
SOURCE: ai.google.dev/gemini-api/docs/deprecations (fetched directly 2026-09-01)
CONFIDENCE: H
IMPACT: A config frozen at ~2026-07 could plausibly still reference `gemini-2.0-flash*`
(dead since June), Imagen 4.0 (dead since Aug 17 — very recent, easy to have missed), or any
of the `-preview` image models retired in late June.
ACTION: Grep any local config/harness files for `gemini-2.0-flash`, `imagen-4.0`,
`gemini-3-pro-preview`, `gemini-2.5-flash-preview-05-20`, `gemini-2.5-flash-lite-preview`,
and `embedding-001`/`text-embedding-004` — all are confirmed dead strings.

### 8. Pricing and free-tier snapshot
WHAT changed / current state:
- Free tier: Flash and Flash-Lite models (3.7 Flash, 3.6 Flash, 3.5 Flash) are free-of-charge
  on the free tier; Pro-tier models dropped from free tier 2026-04-01. Rate limits ~5-15
  RPM, up to 1,000 req/day.
- Gemini 3.1 Pro (preview): $2.00/1M input, $12.00/1M output up to 200K context, stepping to
  $4.00/$18.00 above 200K.
- Gemini 3.7 Flash: $0.75/$3.75 per 1M (introductory, through 2026-12-31).
- Gemini 3.5 Flash-Lite: $0.30/$2.50 per 1M.
- Gemini 2.5 Flash-Lite: $0.10/$0.40 per 1M (text/image/video input).
- Nano Banana 2 (image gen): $0.50 input / $60 output per 1M (token-based image pricing).
- TTS: $1.00 input / $20.00 output per 1M.
- Grounding with Google Search: 5,000 free requests/month shared across Gemini 3.x, then $14
  per 1,000 requests.
- Context caching: ~80% discount vs standard rates.
SOURCE: ai.google.dev/gemini-api/docs/pricing (fetched directly 2026-09-01)
CONFIDENCE: H (official pricing page, directly fetched)
IMPACT: Meaningful cost-shape difference from a "Pro models on free tier" mental model — any
free-tier assumption for Pro-class work is now wrong (since April 2026).
ACTION: If the local seat plans to use Gemini 3.1 Pro for multimedia reasoning, budget for
paid tier — no free path exists for Pro-class models anymore.

### 9. Multimodal capability delta — practical, not marketing
WHAT changed: Compared to the mid-2026 generation (Gemini 2.5 era), the newer Gemini 3.x /
Omni line adds:
- Native unified generation+understanding across video/image/text/audio in one architecture
  claim (Gemini Omni), vs. 2.5-era models routing generation tasks to separate specialist
  models (Imagen for images, Veo for video, separate TTS).
- Real-time audio-to-audio dialogue as a distinct product (Gemini 3.1 Flash Live) rather than
  a single "audio understanding" capability bolted onto a text model.
- Video generation with editing, keyframe interpolation, and extension (Gemini Omni Flash) —
  a step beyond straight text-to-video (which is what Veo 3.1 still primarily does).
- Multimodal embeddings that span text/image/video/audio/PDF in one model (Gemini Embedding
  2), useful for a multimedia-expert seat needing cross-modal search/retrieval.
SOURCE: search-aggregated from ai.google.dev/gemini-api/docs/models,
mindstudio.ai "What Is Google Gemini Omni?" blog posts, vo3ai.com "Gemini Omni" announcement
page (not independently fetched/verified this run — these are secondary/marketing-adjacent
sources)
CONFIDENCE: L-M — the "native unified architecture" framing is closer to marketing language
than a verified technical claim; the concrete product list (Flash Live, Flash TTS, Omni
Flash, Embedding 2) is corroborated by the official models page (H) but the *comparative*
"could not do this in mid-2026" framing is inferred, not directly sourced from a
before/after technical comparison.
IMPACT: For practical seat design, trust the concrete product list over the "unified
architecture" narrative — build against specific model endpoints (Flash Live, Flash TTS,
Nano Banana Pro, Veo 3.1), not against a vague "omni" capability claim, since Omni Flash
itself is still preview-tagged.
ACTION: If a genuine before/after technical comparison matters for a design decision, this
is a candidate for @field or @mirror cross-check rather than another Epoch search pass — the
available sources are mostly vendor-adjacent blogs, not independent technical benchmarks.

---

## Community read: Antigravity CLI (2026-09-01)

Triggered by: follow-up question from the operator — they run Gemini CLI on a paid
pay-as-you-go API key (not free/Pro/Ultra), use it for tight-scope multimedia subagents and
a blind-triangulation second voice, and are NOT planning to migrate to Antigravity CLI
without evidence. This section is a narrow practitioner-voice pass (Reddit/HN/GitHub
issues/dev blogs), not a repeat of the official-docs findings above.

### 1. Reception since launch — praised for the IDE, criticized for the CLI regression
WHAT changed: Community sentiment is split by surface. Antigravity as an *IDE* (VS Code fork,
agent-manager UI) gets some praise for agent-orchestration UX. Antigravity *CLI* specifically
draws sustained criticism as a step down from Gemini CLI. On the HN thread titled "Google's
Antigravity bait and switch," commenters catalogued concrete regressions: no visible
quota/context-size tracking (Gemini CLI had this), no manual context compaction, forced chat
restarts kill any background/long-running process (e.g., a Telegram listener that Gemini CLI
could keep alive across sessions), weaker extension/hook framework for policy control, poor
WSL/Linux support (agent reportedly can't run Linux commands under WSL, doesn't persist
credentials — re-login every session), and `~/antigravity-server` growing to 4GB+ after a few
chat sessions. One commenter summarized the pattern as "Classic Google problem: nobody gets
promoted for maintaining anything" — read as a broader complaint about Google abandoning a
working tool (Gemini CLI) for a rebrand rather than iterating.
SINCE: ongoing since the 2026-05-19 Antigravity GA and 2026-06-18 forced-migration date;
this HN thread's exact post-date wasn't independently pinned this run.
SOURCE: news.ycombinator.com/item?id=48222529 ("Google's Antigravity bait and switch",
fetched 2026-09-01)
CONFIDENCE: M (single HN thread fetched directly — real practitioner voices, but one
thread's comment section is not a statistically representative sample; treat as directionally
reliable, not exhaustive)
IMPACT: For a seat that values persistent background processes, visible quota/context
tracking, and fine-grained policy hooks — the operator's stated use case (tight-scope
multimedia subagents, blind-triangulation second voice) — Antigravity CLI is reported to be
strictly worse than Gemini CLI on exactly those axes as of this pass.
ACTION: If any of quota-visibility, manual compaction, or persistent background sessions
matter to the operator's subagent design, do not assume Antigravity CLI has parity with
Gemini CLI on those points — verify directly against a current Antigravity CLI instance
before depending on any of them.

### 2. Stability/maturity vs Gemini CLI — actively-patched but visibly rougher
WHAT changed: google-antigravity/antigravity-cli has an active GitHub issue tracker with
open reports including: `cortex` ENOENT errors on step outputs, MCP server tools becoming
invisible after session start, print-mode tool-using turns intermittently ending as CANCELED
or SUCCESS-with-empty-response, subscription-quota sync errors, and a forced-continuation
deadlock (coordinator looping empty "continue" injections while waiting on subagents — now
fixed per changelog). Recent releases describe "hardening and fixes for intermittent failures
in background tasks, print mode, and interactive flows," which itself signals those failure
modes were common enough to need dedicated hardening passes. Separately, a security
vulnerability was patched (2026-04, The Hacker News): Antigravity's `find_by_name` tool had
insufficient input sanitization, letting untrusted source content in a project bypass "Strict
Mode" and trigger arbitrary code execution via prompt injection.
SINCE: issues and hardening passes ongoing through August 2026; the security patch was 2026-04
SOURCE: github.com/google-antigravity/antigravity-cli/issues and
/blob/main/CHANGELOG.md (search-aggregated, not each issue individually fetched);
thehackernews.com "Google Patches Antigravity IDE Flaw Enabling Prompt Injection Code
Execution" (2026-04, search snapshot)
CONFIDENCE: M (issue tracker content came from aggregated search summary, not a direct fetch
of individual issue threads — recommend a direct fetch of the issues list before treating
issue counts/severity as precise)
IMPACT: Antigravity CLI reads as immature relative to Gemini CLI's ~1-year-older, more
battle-tested codebase — print-mode reliability (empty responses, CANCELED turns) is
specifically concerning for any scripted/headless subagent use, which is close to the
operator's stated use case.
ACTION: If ever testing Antigravity CLI for headless/print-mode subagent calls, budget for
retry/validation logic around empty-response and CANCELED-turn failure modes — do not assume
print mode is as reliable as Gemini CLI's equivalent.

### 3. Paid-API-key Gemini CLI users — NOT pressured on the CLI front, but hit by a SEPARATE,
   more urgent deadline: standard API keys themselves
WHAT changed: Two independent tracks, easy to conflate:
- **CLI-identity track:** Google's public messaging is explicit that paid-API-key and
  enterprise Gemini CLI users are "unaffected" by the Antigravity CLI push — no deprecation
  warning or feature freeze specific to Gemini CLI itself was found in this pass. Gemini CLI
  continues shipping regular releases (v0.55.1 → v0.57.0 across Aug 2026, per Finding 3
  above) — a live, maintained codebase, not a frozen one.
- **API-key-format track (the actually urgent one):** Separately from the CLI branding fight,
  Google is retiring the "Standard" Gemini API key type entirely, regardless of which CLI or
  SDK uses it. Unrestricted standard keys were already rejected starting **2026-06-19**.
  **ALL standard keys — including restricted, paid, pay-as-you-go keys — stop working
  "September 2026"** (official ai.google.dev/gemini-api/docs/api-key page confirms this
  wording; no exact day-of-month was found in this pass, only the month). Replacement is an
  "auth key" bound to a Google Cloud service account, generated via a stated 7-step migration
  in AI Studio (create new key → auth key generated automatically → swap env var → delete old
  key). This deadline applies to `GEMINI_API_KEY`-style auth on Gemini CLI directly, since
  that is a Standard key by default.
SINCE: 2026-06-19 (unrestricted-key cutoff, already passed) / "September 2026" (all-key
cutoff — could be any day this month, unconfirmed)
SOURCE: ai.google.dev/gemini-api/docs/api-key (fetched directly 2026-09-01, official); cross-
confirmed by doit.com blog and discuss.ai.google.dev thread "Action Required: Restrict Gemini
API keys by June 19" (both search-snapshot, not directly fetched for the September date)
CONFIDENCE: H that the September 2026 all-standard-key cutoff exists and is official; L on
the exact day within September — this is potentially THIS MONTH relative to the report date
(2026-09-01).
IMPACT: This is the actual near-term risk to the operator's setup, not Antigravity CLI. If
the operator's Gemini CLI is authenticating via a Standard-type paid API key (the common/
default AI Studio key type), it may stop working at some unconfirmed point in September 2026
— independent of any CLI choice.
ACTION: URGENT, separate from the Antigravity question — check whether the operator's current
GEMINI_API_KEY is a "Standard" or "auth" key type in AI Studio / Google Cloud console. If
Standard, migrate to an auth key now; do not wait for a specific date since the exact
September cutoff day is unconfirmed and could already be close. This is worth its own
direct-fetch follow-up pass (AI Studio console or Google Cloud release notes) to pin the
exact date, not something to defer.

### 4. Signal on killing the API-key CLI path entirely
WHAT changed: No source found in this pass states or implies Google plans to kill the
API-key-authenticated *Gemini CLI tool* itself (as opposed to the Standard *key format*,
covered in Finding 3). The enterprise/API-key carve-out language from the original migration
announcement (Finding 1 in the main report) has not been walked back or narrowed in any
source surfaced this run.
SINCE: n/a — absence-of-signal finding, as of 2026-09-01
SOURCE: same set as Finding 1 (developers.googleblog.com, github.com/google-gemini/gemini-cli
discussions) plus this pass's HN/GitHub-issues search — no new deprecation announcement found
CONFIDENCE: M (absence of evidence is not strong evidence of absence; this is a live-moving
area and a monthly re-check is warranted given how fast the CLI/API-key landscape has moved
in 2026)
IMPACT: The Gemini-CLI-via-API-key path looks stable *as a tool*, but is entangled with the
Standard-key retirement above — the tool surviving doesn't help if its auth mechanism is
retired underneath it.
ACTION: Re-run this specific question (Gemini CLI API-key-path survival) in ~4-6 weeks or
whenever the September Standard-key cutoff date is confirmed, whichever comes first.

### 5. One-line verdict for this operator
Stay on Gemini CLI as-is for now — Antigravity CLI shows real, community-documented
regressions (no quota/compaction visibility, killed background processes, rougher print-mode
reliability) that directly hit the operator's multimedia-subagent use case, so there is no
concrete reason to test it yet; but treat this as separate from an URGENT, unrelated action
item — confirm whether the current GEMINI_API_KEY is a "Standard" key, and if so migrate to
an "auth" key before the unconfirmed-day-in-September-2026 cutoff, since that will break
Gemini CLI regardless of the Antigravity question.

---

## Sections to refresh
- [ ] Confirm exact npm publish date/version for `@google/gemini-cli` v0.57.0 (only got a
  relative "6 days ago" timestamp this run — pin an absolute date before citing as H).
- [ ] Directly fetch github.com/google-antigravity/antigravity-cli/issues/78 to confirm the
  GEMINI_API_KEY / `modelProvider: "gemini"` settings.json schema (currently M-confidence,
  second-hand).
- [ ] Re-check ai.google.dev/gemini-api/docs/deprecations closer to Oct 2026 to resolve the
  Gemini 2.5 sunset-date conflict (official page says none announced; trackers guess
  2026-10-16).
- [ ] If a multimedia-expert seat design decision depends on the "unified omni architecture"
  claim, route through @field or @mirror — current sourcing is vendor-adjacent blogs, not
  independent technical verification (Finding 9).
- [ ] Confirm GA vs preview status of Gemini 3.1 Pro, Gemini Omni Flash, Flash Live, Flash
  TTS, and Live Translate before any production lock — all preview-tagged on the official
  models page as of this fetch.
- [ ] **URGENT:** Pin the exact September 2026 day when the Gemini API stops accepting
  Standard API keys entirely (only "September 2026" confirmed via official docs this pass,
  no day-of-month). Check whether the operator's current key is Standard or auth type and
  migrate proactively — do not wait for the exact date to surface.
- [ ] Directly fetch a handful of individual google-antigravity/antigravity-cli GitHub issues
  (not just the aggregated search summary) to get precise issue counts/severity before citing
  Antigravity CLI stability as more than directionally M-confidence.
- [ ] Antigravity CLI Reddit sentiment specifically was not found this pass (search tooling
  returned no direct Reddit results) — if Reddit-specific voice matters, a direct
  reddit.com/r/GoogleGeminiAI or r/Bard search pass is still open.
