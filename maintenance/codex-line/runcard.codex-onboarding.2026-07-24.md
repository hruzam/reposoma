# RUNCARD — Codex-line onboarding (nabla-lab program) · 2026-07-24

`command seat: @Oraculum (majkee directive 2026-07-24, buffering-cycle approved)`
`gavel record: 0005 Amendment A1 — GAVELED LIVE 2026-07-24 (majkee in-session "Skip → write")`
`canon: temple/decisions/0005-flat-partnership.md (A1 appended) · index row updated`
`predecessor line: maintenance/gemini-line/ (frozen — protocol evidence; the ledger+diff+`
``git apply --recount` coder protocol transfers vendor-free)`

## Program state

| WS | What | Who | Status |
|----|------|-----|--------|
| 0 | 0005-A1 amendment | Oraculum | ✅ WRITTEN + GAVELED 2026-07-24 |
| 1 | Install-research pass | @Epoch | ✅ DONE 2026-07-23/24 |
| 1b | zsh gemini layer loud-park | @Delta | ✅ DONE + hazard fixed (sourcing-safe guards, verified) |
| 2 | Install + headless smoke | @Trajectory + majkee | ✅ GREEN 2026-07-25 — results below |
| 3 | Harness build (2 cards + wrapper) | atlas-auto → seat review → @Delta fix | ✅ STAGED + VERIFIED 2026-07-25 |
| 3g | Guides (user + builder) → raw.guides/ | @Epoch manual pass → Oraculum distill | ✅ DRAFTED 2026-07-25 (gavel with WS5 or standalone) |
| 4a | Nabla-lab: stone trial (THE CLEAN RE-BLIND) | Oraculum + majkee | ⬜ NEXT — **needs majkee's stone** |
| 4b | Nabla-lab: coder live-fire = scaffold `larvaTmux` pad in the factory | Oraculum + krakens, special factory session | ⬜ SHAPED — needs majkee's one-line pad intent + larvaTmux existence answer |
| 5 | Bookkeeping gavel batch | Oraculum + @Delta | ⬜ LAST |

## WS2 RESULT (2026-07-25, @Trajectory, nested non-TTY Bash — the real environment)

- **Version:** codex-cli 0.145.0 · **credential file: `~/.codex/auth.json`** (CONFIRMED — was UNVERIFIED)
- **Nested smoke: NESTED-OK, primary path** — `< /dev/null` wrapper sufficient, no `script -qfc`
  fallback needed on this box. Exit 0 AND `turn.completed` present. usage: in 16314 (12032 cached) / out 9.
- **Write smoke: green** — proof.txt exact (self-verified by Codex via od). usage: in 45162 (38144 cached) / out 147.
- **`--list-models` DOES NOT EXIST** — per-call `-m <model>` only; no enumeration. Model pins are
  blind → a version upgrade dropping a model fails silently. Wrapper treats unknown-model errors loudly.
- **G8 — stdout pollution:** human-readable line `Reading additional input from stdin...` precedes the
  first JSON object ON STDOUT. Bare `jq` consumers abort. Wrapper filter mandatory: `grep '^{'`.
- **E1 — economics:** trivial calls cost 16–45K input tokens (system/context overhead, mostly cached).
  Plus quota is per-task/message, 5h rolling window. **Contract: batch tasks — never micro-call.**
- **`--ephemeral` ≠ filesystem isolation** — session persistence only; writes land in cwd under
  `workspace-write`. Callers manage cwd explicitly.
- **Untested:** throttle/429 shape. First live throttle = data; capture verbatim (underline).
- Evidence: `evidence/` jsonl files. No commits yet (WS5 batch).

## WS3 RESULT — the staged trio (`.larva/agents-staging/`, invisible to sessions until mount/restart)

- **`codex-run.zsh`** — canonical wrapper, single home of ALL mitigations. `zsh -n` PASS.
  Behavior: `timeout ${CODEX_TIMEOUT:-300}` · `< /dev/null` (G1) · `--ephemeral` (G5) ·
  `--sandbox workspace-write` · optional `-m` · optional `CODEX_WORKDIR` cd.
  **Raw-vs-filtered split (review fix, see below):** raw merged stream kept; JSON derived via
  `grep '^{'` (G8). Diagnosis tree: empty raw → one `script -qfc` retry (G2) → exit 4 ·
  raw-without-JSON → verbatim raw tail to stderr + pattern classify (auth/429/model → exit 5, else 3) ·
  JSON without `turn.completed` → raw diagnostics + classify (exit 5/3) · success = `turn.completed`
  in stream, NEVER `$?` (G3) → last `agent_message` text to stdout, `usage:` object to stderr.
- **`codex-coder.md`** — kraken link (Sonnet DRAFT). Scope-gate (refuses vague scope) · wrapper-only
  invocation (staging path fallback until mount) · E1 batch contract (bounces micro-tasks) ·
  brownfield ledger protocol (`git apply --recount` ALWAYS · ground-truth current file ·
  reserved-zsh-vars line) · no-narration · graceful-fail relay of exit 3/4/5 · reports usage.
- **`codex-crosscheck.md`** — the Vega seat's voice (Haiku DRAFT). THE RULE leads the contract
  (position-free briefs; refuses + reports leaks) · one call per brief · verbatim return, no
  reconciliation · graceful-fail passthrough.
- Model pinning: cards pin nothing — default rides the CLI's bundled model (GPT-5.6 Sol as of
  0.144.6+). Pin decision = roster gavel (WS5) if wanted.

**Review-at-the-seam record (2 defects caught pre-fire this program):**
1. WS1b: Delta's park-guard `exit 2` would have killed every new shell via the base.zsh sourcing
   chain — caught at seat review, fixed to `return 2 2>/dev/null || exit 2`, fire-verified.
2. WS3: atlas-auto's wrapper filtered stderr+stdout to JSON-only *before* diagnosis — plain-text
   errors (auth/429) would be swallowed and misdiagnosed as silent-exit. Caught at seat review;
   Delta fix (raw/filtered split + plain-text branch) verified `zsh -n`.
**Protocol lesson (→ WS5 fold):** *happy-path testing never exercises error plumbing — wrapper/guard
class artifacts get fresh-eyes review of their FAILURE paths before first use; in routine ops route
them through the @Assay gate (0012) by default.*

## WS3g — guides drafted (2026-07-25)

- `raw.guides/codex-line.user.md` — daily driver: five surprises, Rosetta table, quota hygiene,
  when-which-mind (failure-mode asymmetry: Claude omission vs Codex commission — the triangulation payoff).
- `raw.guides/codex-line.builder.md` — harness author: gotcha taxonomy G1–G8+E1, wrapper failure
  signals, config precedence + silently-ignored project keys, headless contract, multi-agent-V2
  landmines (keep OFF), hooks protocol, UNVERIFIED list + refresh discipline.
- Notable Epoch 07-25 finds folded: default model now GPT-5.6 Sol · `wire_api="responses"` required ·
  hooks bidirectional (exit 2 = block) · `shell_environment_policy` secret-filtering · `notify` key =
  temple-doorbell candidate · `/import` migrates config FROM Claude Code · `~/.codex/hooks.json`
  exists on disk by default — inspect before assuming empty.
- zsh layer gets POINTER only (ai/README.md line at WS5 deploy) — point-never-copy.

## WS4 — nabla-lab (∇ — the triangulation lab)

- **4a · Stone trial = the clean re-blind 0005 §Process demanded** (founding run contaminated — Janus
  06-19; never re-run on Gemini; A1 transfers it here). One real open question **from majkee**
  (offered candidates: 0008 L10 silence-default · 0008 executor topology — both parked opens, double
  value) · position-free brief · Claude line + Codex line blind → X vs X' → gap measured → bounded
  argument → majkee. Output doubles as the clean worked example for
  `raw.canon/canon.blind-triangulation.md`. Needs only the wrapper — not the mounted cards.
- **4b · Coder live-fire — SHAPED:** special session in the factory
  (`~/www/elements-factory/applications-in-common`, own CLAUDE.md — fresh saddle, foreign-project
  discipline). Task: Codex scaffolds the **`larvaTmux` pad** per the factory pad pattern
  (`.dev/session/<name>/`: handoff.json · session.md · task-line.md · tasks/). ⚠ `larvaTmux` NOT
  on this disk — gitignore-shadow or other-machine uncommitted (0003) or to-be-born; majkee answers
  + gives one-line pad intent. Batched single call · ledger protocol · assay-style verify.
- **Quota discipline:** lean, ~3–5 calls total (E1 makes this bite harder than planned — batch).

## WS5 — bookkeeping gavel batch (one pass, at the end)

Mount gavels (2 cards → ~/.claude/agents/, wrapper → ~/.config/zsh/ai/ per 0009) · guides gavel
(3g) if not done standalone · roster.md seat rows (0006-consistent: coder Sonnet·medium, crosscheck
Haiku·medium — DRAFT; model-pin decision) · system-map edges · gemini-cross-check card retire/
re-point (@Atlas ticket, A1) · **ai/README.md + zsh driver-doc pointer lines → raw.guides/** ·
memo-to-monkey refresh · ia-sync commit (Delta zsh guards pass1+fix, wrapper deploy) · majkee.news
line · protocol lessons fold (WS1b return-first · WS3 seam-review) · bash-shebang `print` polish on
guarded gemini scripts · runcard stamped CLOSED.

## Underlines (carried, not this cycle)
- _Kimi K2 army onboarding_ — trigger: real task volume (direct API, no MCP, ~$0.20–0.50/task)
- _Gemini token refund_ — operator action
- _Grok Build / Qwen Code watchlist_ — @Epoch re-scan next quarter
- _0011 reserved draft_ — unrelated, still in flight
- _Epoch delta-check on Codex changelog_ — before any new harness work if >1 week stale; guides
  re-pass if >1 month (CLI ships weekly)
- _Throttle-shape capture_ — first live 429 gets recorded into this runcard
- _`notify` key as temple doorbell_ — candidate integration, schema UNVERIFIED; revisit post-WS5

## Artifact map
- `runcard.codex-onboarding.2026-07-24.md` — THIS, the working doc
- `evidence/` — WS2 jsonl evidence (nested + write smokes)
- `.larva/agents-staging/` — codex-run.zsh (verified) · codex-coder.md · codex-crosscheck.md
- `raw.guides/codex-line.user.md` + `raw.guides/codex-line.builder.md` — WS3g drafts
- @Epoch WS1 + manual-pass reports · @Delta WS1b/WS3-fix reports — summarized above; full text in
  session transcripts 2026-07-23…25
- `../gemini-line/` — frozen predecessor; protocol lessons in its parked handoff
