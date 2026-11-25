---
card: card.gemini-cli
brand: Google — Gemini CLI
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-11-25
half_life: ~1 week (stable ~weekly: 15 stable tags v0.58.0→v0.71.1 in 12 weeks; nightlies near-daily) — line ACTIVE, not parked
half_life_days: 7
recheck:
  - https://geminicli.com/docs/changelogs/
  - https://github.com/google-gemini/gemini-cli/releases
  - https://google-gemini.github.io/gemini-cli/ROADMAP.html
  - https://antigravity.google/docs/cli/gcli-migration       # successor (CONFIRMED)
  - https://github.com/google-antigravity/antigravity-cli/releases
  - https://aistudio.google.com/docs/changelog
verify_cmd: gemini --version
auth_survival: paid Gemini API key OR enterprise license   # see VOLATILE
---

## Refresh delta 2026-11-25

_Scoped opens (NOT verified): local gemini/agy versions; whether the enterprise Code Assist exception still holds after 2026-05-19; the --allowed-tools removal version._

_Since last verify 2026-10-08. PASS 1+2 by @Epoch siblings, live-fetched 2026-11-25: github.com/google-gemini/gemini-cli/releases (pages 1-10 read: v0.58.0-preview.0 → v0.72.0-preview.0), geminicli.com (changelogs, cli/model, cli/headless, cli/cli-reference, reference/policy-engine), antigravity.google/docs/cli/gcli-migration (read in full, all headings), developers.googleblog.com/an-important-update-transitioning-gemini-cli-to-antigravity-cli/, github.com/google-gemini/gemini-cli/issues/8609, github.com/google-antigravity/antigravity-cli/releases, aistudio.google.com/docs/changelog. GitHub release pages show day+month only — year 2026 INFERRED from nightly tags like `20261124` (M→H for dating, tag stamps are explicit). Release headlines come from a page-summarizer, not raw notes (M). Local `gemini --version` / `agy --version` NOT run. PARTIAL — opens listed at the end._

### Headline
- **Gemini CLI is ACTIVE.** Latest stable **v0.71.1 (24 Nov)**; preview **v0.72.0-preview.0 (24 Nov)**. 15 stable tags in ~12 weeks (v0.58.0 on 1 Sep → v0.71.1 on 24 Nov): roughly one minor per week, usually landing Mon/Tue-ish, with two minors the same day on 19 Nov (v0.69.0 + v0.70.0) as a catch-up. Source: github.com/google-gemini/gemini-cli/releases. H
- **half_life "PARKED" is wrong** and is replaced (see frontmatter changes): ~1 week, ACTIVE. Decision delegated to @Epoch; basis = cadence above. H

### Stable/preview itemisation (v0.58 → v0.72.0-preview.0; year 2026 inferred from tag stamps)
| Stable | Date | Headlines (summarizer-read) |
|---|---|---|
| v0.58.0 | 1 Sep | symlink fix in ignore-path handling; shellExecutionService cleanup; Docker/container socket isolation in macOS Seatbelt; a2a-server stale cancel fix; write-policy safety checkers; history rollback/retry nudge opts |
| v0.59.0 | 8 Sep | SSRF prevention in MCP OAuth discovery; fail-closed workspace trust + mcpServers filtering in restricted mode |
| v0.60.0 | 15 Sep | RFC 9207 issuer checks in MCP OAuth; extension env-change consent prompts; hardcoded API key removed; macOS Seatbelt temp isolation; NTFS 8.3 mitigation; untrusted-tool-output provenance; web-fetch destination validation |
| v0.61.0 | 23 Sep | explicit versioned Flash model IDs preserved; prompt-injection mitigation via build files/untrusted flags; sandbox FS hardening |
| v0.62.0 | 29 Sep | MCP tool-call titles as structured signatures; OAuth refresh-token retention; ConPTY hardening; **PR #29443 "Feat/gemini 3.8 flash 3.5 flash lite"** |
| v0.63.0 | 6 Oct | retry progress indicator; MCP enablement-config error distinction; bounded tool output; autonomous plan execution in non-interactive mode; invalid `diff.external` override removed; auth infinite-loop fix |
| v0.64.0 | 13 Oct | a2a-server V1→V2 settings migration; ACP usage reporting; headless folder-trust propagation; atomic serialized file writes; Ctrl+C abort fix |
| v0.65.0 | 20 Oct | read-only workspace settings in untrusted folders; OAuth RFC 9207 callback `iss`; OTLP custom headers; Enter-key hang + auth retry-loop fixes |
| v0.66.0 | 27 Oct | **banner: CLI "not optimized for Gemini 4"**; keybindings `keys` array; signal forwarding; opt-in private-network MCP OAuth; gsutil→gcloud storage |
| v0.67.0 | 4 Nov | `models` command + `--list-models`; IDE companion bridging for container sandboxes; thought signatures; spending-cap errors as terminal quota errors |
| v0.68.0 | 10 Nov | extension validation; `/model` Auto listing; dotted Gemini 3 model names recognised; **explicit gemini-2.5-flash selection preserved**; SubagentStop hook mapping; 429 cool-down countdown |
| v0.69.0 | 19 Nov | `/stats` heatmap; standalone `theme.json`; `/model` argument validation; configurable API headers timeout; bounded multimodal outputs; headless abort fix |
| v0.70.0 | 19 Nov | `${VAR:-default}` handling; worktree kept across auth restarts; accurate output-token limits in model listing; skips MCP servers with insecure command permissions; policy `argsPattern` via re2js |
| v0.71.0 | 24 Nov | async PowerShell parsing (spinner freezes); dev worker to private artifact registry |
| v0.71.1 | 24 Nov (Latest) | patch: cherry-pick of a2a-server bearer-token auth + input validation |
| v0.72.0-preview.0 | 24 Nov | nested `.gitignore` negation; Windows home-path expansion; resume most-recently-active session; a2a-server auth |
Previews/nightlies seen: v0.58.0-preview.0 (25 Aug) … v0.71.0-preview.0 (19 Nov). Last nightly observed `v0.71.0-nightly.20261124.gaafdfdfb5`. Source: github.com/google-gemini/gemini-cli/releases?page=1..10. H (tags/dates) / M (headlines, summarizer)
- **Nightly-cadence clause** ("nightly cadence continuing daily (v0.59.0 track)"): nightlies are near-daily but not strictly (e.g. no nightly tags seen for 4 Oct, 9 Oct, 11 Oct, 15 Oct, 26 Oct, 29 Oct — gaps up to 2 days; several nightlies carry no change list). Track is now v0.71/0.72, not v0.59. H
- No release page from v0.58 to v0.72.0-preview mentions Antigravity, Gemini 3.6/3.7, or a deprecation of `--allowed-tools` by name. Only two Gemini-4 signals: the v0.66.0 banner (and its docs mirror, below). H (absence on summarised pages; M)

### Gemini 3.6+/Gemini 4 in Gemini CLI headless (gap 3)
- **Gemini 4: NOT supported/optimised.** geminicli.com/docs/cli/headless, /cli/model and /cli/cli-reference all state: "Gemini CLI has not been optimized for Gemini 4 Argon. To use Gemini 4 Argon, please use Antigravity." v0.66.0 (27 Oct) shipped the banner. No release v0.58→v0.72 adds Gemini 4 models. H
- **Gemini 3.8 Flash / 3.5 Flash-Lite: PROBABLY added in v0.62.0 (29 Sep)** via PR #29443 "Feat/gemini 3.8 flash 3.5 flash lite" — title only; not confirmed in code/docs. M/L. geminicli.com/docs/cli/model still lists only Auto(Gemini 3) = gemini-3-pro-preview / gemini-3-flash-preview and Auto(2.5) = gemini-2.5-pro / gemini-2.5-flash; `--model` aliases: `auto`/`pro` → gemini-2.5-pro or gemini-3-pro-preview (preview flag), `flash` → gemini-2.5-flash, `flash-lite` → gemini-2.5-flash-lite. Docs do not mention 3.6 or 3.8. Docs lag releases. H (docs text) / L (3.8 support)
- Headless docs: formats `--output-format json|stream-json` (JSONL events init/message/tool_use/tool_result/error/result); `--model` and `--allowed-tools` not mentioned on the headless page. `--model` default `auto`; `/model`/`--model` do not override sub-agent models. H
- Net: for scripted use pick 2.5/3-line model IDs only after 2026-12-01 re-test (see matrix); for Gemini 4 use `agy`.

### Sunset / enterprise wording (gap 2) — resolved to primary source
- **Official announcement** (developers.googleblog.com, dated 2026-05-19): "On June 18, 2026, Gemini CLI and Gemini Code Assist IDE extensions will stop serving requests for **Google AI Pro and Ultra**" subscribers, and for those using it free via **Gemini Code Assist for individuals**; no new installs on GitHub organisations. Exempt: orgs using Gemini CLI/IDE extensions via a **Gemini Code Assist Standard or Enterprise license** — access "unchanged"; Gemini CLI "will remain accessible via **paid Gemini and Gemini Enterprise Agent Platform API keys**". The post does NOT mention "unpaid tier" or "Google One". H
- **geminicli.com wording** (changelogs, cli/model): "replaced by Antigravity CLI on June 18th, 2026 for **unpaid tier and Google One users**". This is the site's own gloss; narrower/different terms from the blog. Both can be true (AI Pro/Ultra are Google One-bundled plans — that mapping is my inference, M/L). Card should quote the blog: "Google AI Pro/Ultra + free Code Assist for individuals". H (quotes)
- **"indefinitely" (enterprise)**: that word is NOT in the blog text read; blog says access "unchanged" with no end date stated. Card wording "indefinitely" is the card's, not Google's. Whether the exception is still in force on 2026-11-25: no newer official statement found; Gemini CLI releasing weekly is consistent with it (M). **Still open: not re-verified past 2026-05-19.**
- **Migration doc `antigravity.google/docs/cli/gcli-migration` read in full** (headings: Overview, First-launch onboarding, Converting extensions to plugins, Expected import output, Context files and workspace rules, Updated skills paths, MCP config formatting changes, Directory mapping, Required schema updates, Next steps). The body contains NO eligibility, pricing, enterprise, Google One, Pro/Ultra or Code Assist text (those appear only as sidebar nav "Plans and billing"). H
- **Config-path conflict resolved (per migration doc, H):** global MCP = `~/.gemini/config/mcp_config.json`; workspace MCP = `.agents/mcp_config.json`; skills = global `~/.gemini/skills/` (also accepts `~/.gemini/antigravity-cli/skills/`), workspace `.agents/skills/`; context = `GEMINI.md`/`AGENTS.md` in cwd + `~/.gemini/GEMINI.md`. `~/.gemini/antigravity-cli/` appears in that doc ONLY for skills, NOT for MCP config. So the card's "separate config tree `~/.gemini/antigravity-cli/`" is incomplete, and a claim of `~/.gemini/antigravity-cli/mcp_config.json` (gty card) is NOT supported by the migration doc. Whether agy ALSO reads an `antigravity-cli/mcp_config.json` at runtime is not verified (doc is a migration guide, not a path reference). Treat `~/.gemini/config/mcp_config.json` as documented; flag gty card for the same fix.
- Other doc facts: first `agy` launch offers (a) convert extensions + global config, (b) move session tokens to OS keyring, (c) map visual/buffer settings; extensions→plugins via `agy plugin import gemini`; remote MCP key `url`/`httpUrl`→`serverUrl`; "partial parity" (some themes/visual overlays unsupported). H

### Stability matrix + deprecation clock (gap 4)
- `gemini-2.5-pro` and `gemini-2.5-flash` deprecated 2 Nov; route on **2026-12-01** to `gemini-3.8-flash` and `gemini-3.5-flash-lite` respectively (API changelog; read pass 1). H. Gemini CLI still lists both as the "Auto (Gemini 2.5)" pair and `flash`→gemini-2.5-flash (docs, cli-reference); v0.68.0 explicitly preserves an explicit gemini-2.5-flash selection. H.
- The ✓ marks date from the 2026-07-03 triage on gemini v0.49.0 — never re-run. After 12-01 the model behind those IDs changes, so ✓ is no longer a valid claim. Replacement cells are in REPLACEMENTS. Note: 2026-12-01 is 6 days away — re-run triage then.
- Nightly/Gemini 3.x CLI row ("CLI instability reported 2026-06-27") unchanged, still untested.

### Known bug #8609 (gap 5)
- **CLOSED as completed 2025-10-15** by SandyTao520; opened 2025-09-17; last activity 2026-03-22 (community script for compacting oversized sessions). No linked PR/branch. Closing rationale: "All our 2.5 models have 1M context window and the router only returns flash or pro for these" — i.e. the scenario (auto-switch to smaller-context model) was judged impossible, NOT fixed in code; the separate `/compress` `maxOutputTokens` (~100K vs 65,536 API max) failure was not addressed in the closing comment. Parent #9033 "Fix memory compression edge cases and usability issues". Priority p2. Source: github.com/google-gemini/gemini-cli/issues/8609. H
- Implication: "crash bug" is closed-as-not-reproducible-by-design, not fixed; since auto routing now includes Gemini 3.x (different context windows) the closing rationale may be stale. Keep manual `/compress` mitigation. M.

### `--allowed-tools` removal timing
- geminicli.com/docs/cli/cli-reference: "`--allowed-tools` — **Deprecated.** Use the Policy Engine instead" (policy page now at `/docs/reference/policy-engine`; old `/docs/core/policy-engine/` redirects). **No removal date or version is stated** there; the policy-engine page does not mention `--allowed-tools`/`tools.allowed` at all, and only says the legacy `tools.exclude` is deprecated in favour of `deny` policy rules (no timing). No release v0.58→v0.72 mentions removal. The card's "removal at v1.0" is therefore UNVERIFIED (carried from an earlier source). H (docs) / L ("v1.0")

### Antigravity CLI (`agy`) and Gemini 4 API (from pass 1, kept)
- agy newest **1.5.17 (Nov 25)**, 1.5.16 (Nov 24), 1.5.15 (Nov 23), 1.5.14 (Nov 21), 1.5.13/1.5.12 (Nov 19) (page printed "2025" — typo, 2026). Source: github.com/google-antigravity/antigravity-cli/releases. H (year M)
  - Gemini 4 Neon in `/model` and `--model`: 1.5.12 with `GEMINI_API_KEY`; 1.5.13 with ADC (`AGY_ADC_AUTH`) / enterprise model gateway. H
  - Headless: `--output-format json|stream-json` no longer ERROR for a run that succeeded after retry (1.5.14); `--remote-agent` gains `--mode plan` (1.5.14); with `GEMINI_API_KEY` `--remote-control`/`--remote-agent` exit code 2 at launch (1.5.12); `-r`/`--resume` alias for `--conversation` (1.5.16). H
  - Auth: proactive OAuth refresh + pre-stream 401 retry; MCP OAuth `offline_access` (1.5.17); macOS SSH keychain→file fallback (1.5.16); `AGY_CLI_AUTO_COMPACT_OVERRIDE` env (1.5.15). H
- Gemini 4 API family (aistudio.google.com/docs/changelog): argon `gemini-4-argon` (Oct 13); carbon (Nov 10, $2/$10 intro through Nov 30); hydrogen (Nov 12, $1.50/$7.50, free tier); neon (Nov 18, $3/$15, 1M ctx). H
- Other deprecations: `gemini-3.5-flash` (Oct 8) → `gemini-3.6-flash`; `gemini-3.7-flash` (Oct 8) → `gemini-3.8-flash`. H

### Still open (not verified)
1. Enterprise Code Assist exception still in force as of 2026-11-25 (last official text 2026-05-19).
2. Local `gemini --version` / `agy --version` on either machine.
3. Whether v0.62.0 really enables gemini-3.8-flash / 3.5-flash-lite in CLI (PR title only).
4. `--allowed-tools` removal version/date (docs silent).
5. Whether agy reads any MCP config under `~/.gemini/antigravity-cli/` (doc lists only `~/.gemini/config/mcp_config.json`).
6. Behaviour after 2026-12-01 routing (not yet happened); CLI stability triage not re-run.

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: github.com/google-gemini/gemini-cli/releases, live-fetched 2026-10-08 by @Epoch. Only newest release itemized at the time (full v0.58→v0.72 itemisation now in the 2026-11-25 delta). Year of release inferred from nightly tags (CONFIDENCE M). Local `gemini --version` not run._
- **Latest stable v0.63.0** (Oct 6, 2026): retry progress indicator during connection recovery; distinguishes missing MCP-enablement config from malformed JSON; bounded tool output size + better memory in long agent loops; removed invalid `diff.external` override; temp-dir cleanup on background shell exit; fixed infinite auth loop; autonomous plan execution in non-interactive mode; output truncation disabled when `maxChars` ≤ 0. H/M
- Releases page carries no Antigravity-migration notice (absence on that page ≠ proof). Superseded: line is ACTIVE, not parked (see 2026-11-25 delta).

# Gemini CLI — native build surface

## Refresh delta 2026-09-02
- **Stable release moved: v0.58.0 (2026-09-01)**, nightlies at v0.59.0 track (e.g.
  v0.59.0-nightly.20260902). Source: github.com/google-gemini/gemini-cli/releases. CONFIDENCE: H.
- **Local `gemini --version` (office, 2026-09-02) = 0.56.0** — two minor versions behind GitHub
  stable (0.58.0). Repo is still actively released; local install just hasn't pulled latest.
  CONFIDENCE: H (local truth given).
- **Antigravity CLI migration is COMPLETE for individual/free/Pro/Ultra users** — the June 18
  2026 cutoff has passed, confirmed no grace period, confirmed by google blog + multiple
  independent trackers. CONFIDENCE: H.
  Source: developers.googleblog.com/an-important-update-transitioning-gemini-cli-to-antigravity-cli/
- **Enterprise exception still holds**: Gemini Code Assist Standard/Enterprise license holders
  continue on Gemini CLI "indefinitely" with full support + latest models — no published
  end-of-life date found. CONFIDENCE: H.
- **No 1:1 feature parity confirmed still true** as of this pass — same caveat as prior card.
  CONFIDENCE: M (independent trackers, not primary Google doc).
- Crash bug #8609 (context-overflow on auto-switch) and the CLI stability matrix below were NOT
  re-verified this pass (line parked, proportionate-effort scope) — treat as inferred-stale,
  re-run stability triage if the CLI line becomes active again. CONFIDENCE: L (carried forward).

## ⚠ VOLATILE — read first (sunset + crash risk)

**Sunset (PAST — confirmed):**
- **2026-06-18:** Gemini CLI stopped serving requests for Google AI Pro and Ultra subscribers and free Gemini Code Assist for individuals (blog 2026-05-19; geminicli.com says "unpaid tier and Google One users"). No grace period. Already happened. Re-confirmed 2026-11-25 (blog + geminicli.com).
- **SURVIVES via paid Gemini / Gemini Enterprise Agent Platform API key, or enterprise Code Assist license.**
  ← imago's `selectedType: gemini-api-key` is on the surviving path.
- ACTION: confirm BOTH machines' `gemini` auth = API key (not personal Google login).

**Antigravity CLI transition (CONFIRMED — HIGH confidence, migration now COMPLETE for non-enterprise):**
- Antigravity CLI is the primary platform for non-enterprise users as of this pass (2026-09-02).
- **What survives the migration:** Agent Skills, Hooks, Subagents, Extensions (as "Antigravity plugins").
  GEMINI.md survived; runtime did not.
- **Architecture change:** Go binary, closed-source, async/parallel agents, unified backend with Antigravity 2.0 desktop.
  Config per migration doc (read 2026-11-25): global MCP `~/.gemini/config/mcp_config.json`, workspace `.agents/mcp_config.json`, workspace skills `.agents/skills/`; `~/.gemini/antigravity-cli/` is documented only as an accepted global-skills location (`~/.gemini/antigravity-cli/skills/`). Still NOT 1:1 parity ("partial parity").
- **Enterprise exception:** Standard/Enterprise license holders continue on Gemini CLI with full support + latest models — no end-of-life date published for this track.
- **Gemini CLI repo still active**: stable v0.71.1 published 2026-11-24, preview v0.72.0-preview.0 same day; ~weekly stable minors since v0.58.0 (2026-09-01); nightlies near-daily on the v0.71/0.72 track (not strictly daily — gaps up to 2 days).
- ACTION: Park an `agy` contingency; don't over-invest in Gemini-CLI-specific glue that `agy` may not honor 1:1.

**Known crash bug — context overflow on model auto-switch (GitHub issue #8609 — CLOSED as completed 2025-10-15, no linked fix PR; maintainers' rationale: all 2.5 models are 1M-context so the router can't pick a smaller one; the `/compress` maxOutputTokens failure was not addressed in the close comment; checked 2026-11-25):**
- Long session on large-context model (e.g., 1M-token) accumulates history → CLI auto-switches
  to smaller-context model → accumulated context exceeds new model's cap → API error.
  Documented case: input 8.1M tokens > 1M cap → unrecoverable.
- `/compress` recovery ALSO fails: attempts `maxOutputTokens = ~100K`; API max = 65,536.
  Session becomes completely stuck — no recovery path available in the CLI.
- **Mitigation (kept — "closed" is not "fixed"; Gemini 3.x routing may invalidate the closing rationale):** run `/compress` manually as a checkpoint every ~20–30 turns in long sessions.
  Use `/chat save` → `/clear` → `/chat resume` for hard branching. Don't rely on auto-compaction.

## Config home
- User/global: `~/.gemini/`      → settings.json, agents/, commands/, extensions/, skills/, GEMINI.md
- Project:     `<repo>/.gemini/`  (same shapes); workspace config wins on conflict.

## Native primitives
1. **Subagent** (preview 🔬) — `<~/.gemini|.gemini>/agents/<name>.md`. YAML frontmatter + body = system prompt.
   - Tool WILDCARDS: `*` (all), `mcp_*` (all MCP), `mcp_<server>_*` (one server).
   - **Isolated context loop:** subagent's intermediate tool calls (file reads, greps) are purged from
     the main session history. Orchestrator receives only the concise return summary. Context-clean by design.
   - **Recursion guard:** subagents CANNOT spawn sub-subagents. Prevents token cascade; hard limit.
   - Manage via `/agents`. Registration: first-wins, project-prioritized.
   - External (headless) invocation: `gemini "@<name> <task>"` — `@name` prefix in the
     prompt selects the agent. Equivalent of `claude --agent <name> "task"`.
   - Interactive invocation: `gemini` → then `/agents` TUI to switch seat.
   - Dead: `gemini -a <name>` (removed). Tested/dead: `GEMINI_AGENT=<name>` (no effect).
   - **Built-in codebase investigator subagent** added (recent stable): explores workspace + resolves
     relevant context to improve overall performance; invoked automatically.
2. **Skill** — `skills/<name>/SKILL.md`  (SAME Agent Skills standard as Claude → portable).
3. **Custom command** — `commands/<name>.toml`  (TOML, not markdown) → `/name` or `/<ext>.name`.
   (`~/.gemini/commands/`, project `.gemini/commands/`.) Manage: `/commands`.
4. **Hook** — intercept/customize CLI behavior (supported in extensions).
5. **MCP** — `settings.json` `mcpServers{}` or `gemini mcp add|list|remove`. Per-server includeTools/excludeTools/trust, OAuth.
6. **Extension** (packaging unit) — `extensions/<name>/`: `gemini-extension.json` + GEMINI.md +
   commands/*.toml + skills/*/SKILL.md + agents/*.md + policies/*.toml. Use `${extensionPath}`.
7. **Policy Engine** — tiered `.toml` rules (extension rules = tier 2). Native replacement for hand-rolled param-allowlists.

## Session hygiene (see card.session-hygiene for full comparative analysis)
- **Without subagents:** every prompt + response appended to running context. No isolation. Context rot inevitable on long sessions.
- **With subagents (preview):** isolated context loop; main session receives summary only. Mirrors Claude Code's clean pattern.
- **Shell-spawned isolated sessions:** orchestrator writes task to file → fresh `gemini` process via shell. Full context reload per spawn (expensive), but hermetically isolated.
- **Crash risk:** see bug #8609 in VOLATILE above (closed 2025-10-15 without a code fix). Manual `/compress` checkpoints remain the mitigation (not re-tested).

## Context file
- `GEMINI.md` is native; `contextFileName` is configurable → point at `AGENTS.md` for cross-tool parity.

## Native strengths (vs Claude Code)
- **Model routing / automatic fallback** built in (your model/scan/synth triad partly absorbed).
- Plan Mode (+ research subagents), checkpointing/rewind, session export/import, sandboxing, trusted folders,
  headless mode, A2A remote subagents. Gemini 3 default; Gemma 4 via API default.

## VOLATILE / watch
- Stable moves ~weekly, nightlies near-daily (stable v0.71.1 as of 2026-11-24; preview v0.72.0-preview.0 — check GitHub for latest).
- Subagents are PREVIEW → less stable than Claude's GA subagents. Recursion guard is a hard limit.
- **`--allowed-tools` CLI arg is deprecated** ("Use the Policy Engine instead", geminicli.com/docs/cli/cli-reference, 2026-11-25). Removal version/date is NOT stated in any official page read (the card's earlier "v1.0" is unverified, L). `tools.allowed` deprecation: not found on the pages read (the policy page deprecates `tools.exclude` instead). Migrate to Policy Engine: https://geminicli.com/docs/reference/policy-engine (old /docs/core/policy-engine/ redirects).
- **Antigravity CLI (`agy`)** is the confirmed successor and now the primary non-enterprise platform (agy 1.5.17 on 2026-11-25; Gemini 4 Neon supported from 1.5.12). Gemini CLI is "not optimized for Gemini 4 Argon" (geminicli.com, v0.66.0 banner). Enterprise end-of-life for Gemini CLI still not published.

## CLI stability matrix (carried forward from 2026-07-03 triage on gemini v0.49.0 — NOT re-run; 2.5-* rows re-marked 2026-11-25 for the 2026-12-01 routing change)

Based on: triage.gemini-hang.2026-07-03.md + handoff.gemini-rebuild.addendum-hang.2026-07-03.md + report.gemini-fix-pass.2026-07-03.md.

| Use case | Safe? | Notes |
|---|---|---|
| Interactive UI session (short) | ✓ | < 20 turns, manual /compress |
| Interactive UI session (long) | ⚠ | Bug #8609: crash past ~50 turns |
| Headless one-shot (CLI -p < /dev/null) | ✓ | Stable; stdin regression fixed v0.49.0 (issue #6715) |
| Headless one-shot (REST API) | ✓✓ | Preferred — no TTY, no noise, no MCP init |
| Automated loop / agentic CLI | ⚠ | Token bloat, 503 cascade risk, 10-min agentic timeout |
| @agent in prompt (any scripted mode) | ✗ | Agentic loop — confirmed hang Class C (90s+, triage 2026-07-03); NEVER in scripts |
| Gemini 2.5-flash | ✓ until 2026-11-30 (07-03 triage); UNTESTED from 2026-12-01 | Deprecated 2026-11-02; API-side the ID routes to gemini-3.5-flash-lite on 2026-12-01 (a different model behind the same ID). CLI alias `flash` → gemini-2.5-flash; v0.68.0 preserves explicit selection. Re-run triage after 12-01 |
| Gemini 2.5-pro | ✓ until 2026-11-30 (07-03 triage); UNTESTED from 2026-12-01 | Deprecated 2026-11-02; API-side the ID routes to gemini-3.8-flash on 2026-12-01 (a Flash-class model replaces a Pro; 3.8-flash rates). CLI `auto`/`pro` aliases resolve to gemini-2.5-pro or gemini-3-pro-preview. Re-run triage after 12-01 |
| gemini-3.5-flash (REST) | ✓ | HTTP 200 confirmed 2026-07-03; REST probe via key enumeration |
| gemini-3.5-flash (CLI agentic) | ⚠ | Agentic-first design; prefer REST for scripted use |
| Gemini 3.x other (CLI) | ⚠ | CLI instability reported 2026-06-27; agentic-first, timeout/silent-fallback risk |

Confirmed hang classes (empirical triage 2026-07-03, gemini v0.49.0):
- Class C (primary): `@agent` in prompt → agentic loop even with -p and < /dev/null; 90s timeout confirmed
- Class B: positional arg in $() without -p → immediate hang
- Class A (stdin blocking): fixed in v0.49.0 (< /dev/null still required as regression insurance)
- Class D (latent): curl without --max-time → network stall hangs indefinitely

Note on Gemini 3.x: matrix above references gemini-3.5-flash, which per card.gemini-models is
now the "legacy" Flash in the 3.x line (3.6/3.7-flash have since shipped) — re-run stability
triage if the CLI line becomes active again; do not assume 3.6/3.7-flash inherit the same
✓/⚠ marks untested.

Recommendation: REST-primary for all headless/scripted use. For any CLI invocation in scripts:
`timeout 180 gemini -p "..." < /dev/null`. Never use @agent-in-prompt in scripted paths.

## Recommendation for LARVA
Keep CLI alive via API key. Mirror the portable skills corpus (read from the shared dir).
Antigravity is confirmed AND now the primary track for non-enterprise use — treat `agy`
contingency as active, not speculative. GEMINI.md and Skills are portable;
Extension/command TOML format is the most likely migration friction point.
</content>
