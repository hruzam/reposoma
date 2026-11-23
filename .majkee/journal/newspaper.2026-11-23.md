# THE EPOCH GAZETTE — Monday, 23 November 2026

_Desk: @Epoch (researcher). Gap edition: covers 8 Oct → 23 Nov. Commissioned by majkee in a settings-file session; most of the desk's time went to one question (settings.json vs settings.local.json) and to the card-freshness books. Every item carries its source and a confidence mark: **H** = official page/changelog fetched today · **M** = reliable secondary or partial read · **L** = single weak source, treat as rumour. Anything I could not verify is said so at the bottom._

---

## FRONT PAGE — the card books are 46 days stale, and the tool shipped 37 releases

The previous gap edition was filed 8 Oct. Since then **Claude Code went from v2.1.293 to v2.1.330 (20 Nov)** (**H**, code.claude.com/docs/en/changelog), and the freshness checker's own arithmetic says **18 of 20 dated settings cards are past their half-life** (see STALENESS DESK). Both facts point the same way: nothing in `raw.settings` dated 8 Oct should be quoted for versions without a re-fetch.

---

## THE TOOL THAT SHIPS DAILY — Claude Code v2.1.326 → v2.1.330

Only the newest five releases were read; **v2.1.294–325 were not itemised** (the changelog page is ~1.4M characters; see limits). Items worth a human's attention:

1. **v2.1.330 (20 Nov):** `claude auth login` can sign in to organizations managed in the Enterprise Admin Console, and then applies the org's settings and cloud provider/gateway. Recurring scheduled tasks and `/loop` now run up to **30 days instead of 7** while their session lives (tasks created earlier still end at 7). (**H**)
2. **v2.1.329 (19 Nov):** an automatic retry when `max_tokens` exceeded a model's limit was removed — and **reverted in 2.1.330**. Behind a gateway with a lower output cap, set `CLAUDE_CODE_MAX_OUTPUT_TOKENS`. (**H**)
3. **Hooks, a nuance on last edition's "fail closed" item:** in **Code Mode**, a `PreToolUse` hook that errors no longer blocks the script's tool call; to block, set `"onFailure": "block"` (v2.1.329). `"onFailure": "block"` is also supported for `mcp_tool` hooks (v2.1.328). This is Code Mode only — it does not reverse the v2.1.288 fail-closed behaviour reported 8 Oct. (**H**; my reading that the two are separate is an inference, **M**)
4. **v2.1.327 (17 Nov):** `claude mcp add-json <name> -` reads the server JSON from stdin (keeps tokens off the command line); `ExitWorktree` now asks before removing a worktree that may hold unsaved work. (**H**)
5. **v2.1.326 (16 Nov):** `claude mcp add --scope project` now **stops** rather than overwrite `.mcp.json` when it lists servers at top level with no `mcpServers` key. (**H**)

_Sources: code.claude.com/docs/en/changelog, fetched 23 Nov (**H**)._

---

## SETTINGS DESK — `.claude/settings.json` vs `.claude/settings.local.json`

Asked by majkee; answered from the live settings page (**H**, code.claude.com/docs/en/settings, 23 Nov).

- **Scope.** `settings.json` is the shared project file (commit it); `settings.local.json` is personal, one project only. Precedence high→low: managed → `--settings` → **local** → **shared project** → user. Lists (`permissions.allow` …) **merge** across files; scalars take the highest level. Exceptions taking one whole value: `fallbackModel`, `modelPicker`.
- **Writer.** Claude Code writes the local file ("Yes, and don't ask again" → an `allow` rule; output style from `/config`). It never writes the shared one.
- **Gitignore.** Claude Code adds `**/.claude/settings.local.json` to the *global* git excludes on its first write. A file created by hand is **not** ignored until you ignore it.
- **Location (v2.1.211+).** The local file lives at the git repo root (the main checkout's root in a worktree), not the starting directory; older starting-dir files are still read. The shared file is read from the session's primary working directory.
- **Trust.** Shared-file `allow` rules, `additionalDirectories`, `extraKnownMarketplaces`, most `env` wait for workspace trust; `deny`/`ask` apply at once. Local-file `allow` rules skip the trust step while the file is untracked.
- **Gotchas.** A local `allow` does not outrank an `ask` from project/managed. `permissions.defaultMode` `auto`/`bypassPermissions` is ignored from project/local (before v2.1.257, `bypassPermissions` worked from any file). Cloud sessions do not read the local file.
- **Consequence for the books.** The card said "settings.local.json (personal, gitignored)" and nothing else — fixed in `raw.card.claude-code.md` (commit `e0c0ccb`, pushed). `worktree.bgIsolation` exists as a key, scope "Any file"; its allowed values and default were **not read** (**L** on what `none` does beyond the index's one-line description).

---

## ANTHROPIC MODELS

Search results (several aggregators, a Wikipedia-derived listing, a community timeline; **no Anthropic page read**) agree: **Claude Fable 5.2 (`claude-fable-5-2`) and Claude Mythos 5.2 (`claude-mythos-5-2`) shipped 9 Nov 2026.** Fable 5.2 is reported as broadly available at **$8 / $40 per Mtok**, output "up to 30% faster than Fable 5.1", and 49.1% on FrontierCode 2.0 at xhigh vs 32.4% for Fable 5.1. Mythos 5.2 is reported as restricted (Cyber and Life Sciences Verification Programs). **Confidence M** — names and dates agree across sources, but prices and benchmark numbers come from secondary sites and should be re-fetched from anthropic.com before anyone routes on them.

The September–October lineup (Opus 5.5, Sonnet 5.5, Haiku 5.5) is unchanged in what I could see.

---

## GOOGLE & THE ANTIGRAVITY CHANGEOVER

No November item surfaced. The search returned only the May–June story (Gemini CLI sunset announced 19 May; stopped serving requests **18 Jun** for AI Pro/Ultra and free Code Assist users; remains reachable on paid API keys; `agy` is the successor, with `agy plugin import gemini` as a migration path). (**M**: Google developers blog + press.) The 8 Oct entries (Gemini CLI v0.63.0, `agy` 1.3.0 verbosity default) have **not been re-checked**; both cards are 46 days old.

---

## CURSOR

Third-party tracker only (havoptic.com; **M**): **2026.11.05** live app building (database, auth, hosting, shareable link); **2026.11.06** realtime voice chat with agents. Cursor's own changelog did not confirm either in this run.

---

## STALENESS DESK — the card books as of 23 Nov

Source: card headers read this run (`verified:` and `half_life_days:`), 22 cards, 20 carrying a date. The checker (`harness-stale`) judges each card against its **own** half-life, not a global number.

- **Past half-life — 18 cards.** Worst by overshoot: `ai-news` (46d vs 2), `arch` and `laravel` (46d vs 7), `codex-cli` (46d vs 10), `claude-code` / `gemini-cli` / `openrouter` / `model-effort` (45–46d vs 14), `machine.office` (131d vs 90), `gemini-models` (82d vs 45). The rest of the 2026-10-08 set: `agent-docs`, `claude-ai`, `cursor-ide`, `eagle`, `gemini-gems`, `gty`, `reposoma`, `session-hygiene`.
- **Inside half-life — 2:** `nature` (133 of 180) and `autonomous-orchestrator` (46 of 60).
- **No `verified:` field:** `raw.card.gty.addendum-by-majkee-headless-regime.md` — not card-format; the checker will skip it.
- **Partial refresh today:** the *Settings hierarchy* section of `claude-code` is re-verified 23 Nov; its header still reads 2026-10-08, so the checker still counts it stale.
- **Mail.** The weekly `zsh.stale-settings-cards-*` mail of 16 Nov (`stale_count: 21`) is still unread in `_mail/toAll/inbox/`, with the 9 Nov one. Its table has three rows with empty names (`eagle`, `machine.office`, `reposoma`) — a generator bug. The `_mail` README says "monthly reminder"; the inbox shows **weekly** Monday mails since 7 Sep — one of them is wrong.

---

## CORRECTIONS & LIMITS OF THIS EDITION

- Claude Code releases **v2.1.294–325 were not read**; items above cover only v2.1.326–330. The 37-release count is arithmetic from v2.1.293 → v2.1.330, not an itemised list.
- **No `--version` was run** on any CLI. Versions are *upstream latest*, not what is installed anywhere.
- **Not covered this edition:** OpenAI/Codex, OpenRouter, Laravel, Arch news, newsletters (Import AI, The Batch, Interconnects), the open-model corner. Cards for these are among the 18 stale ones; this edition does not refresh them.
- **Fable/Mythos 5.2** and **Cursor** items rest on aggregators; **no vendor page was read**.
- `worktree.bgIsolation` values/default **not read**.
- Cards touched today: `claude-code` (Settings hierarchy section only).

_Filed by @Epoch · 2026-11-23 · next edition on request._
