# Codex line — daily-driver guide (Claude-native operator)

`status: DRAFT for gavel · 2026-07-25 · @Oraculum distill of @Epoch passes 2026-07-23/25 + live smoke`
`scope: you, driving Codex CLI by hand alongside Claude Code · builder concerns → codex-line.builder.md`
`seat: the Vega chair (0005 A1) — Codex CLI = ChatGPT's terminal embodiment; same models, same`
`subscription, SAME QUOTA POOL as the ChatGPT app. Heavy chat use eats the CLI budget.`

## The five surprises for a Claude Code native

1. **Sessions are first-class threads.** Every run persists as JSONL under `~/.codex/sessions/…`.
   `/resume` reopens, `/fork` branches without touching the original, `/archive` retires.
   Claude Code's `--continue/--resume` is anonymous by comparison. **`/fork` before risky work is
   the checkpoint idiom** — there is no reliable undo.
2. **It starts executing sooner than you expect.** GPT-5.6 Sol compresses planning and proceeds
   under inferred assumptions — by design. Claude recites the plan; Codex acts on it. If you need
   the plan surfaced first, ask for it explicitly (`/plan`).
3. **Approval is two orthogonal axes**, not one prompt stream: `sandbox_mode`
   (read-only / workspace-write / danger-full-access) × `approval_policy` (untrusted / on-request /
   never). `--full-auto` = on-request + workspace-write shorthand. Know which axis is limiting you.
4. **Goal Mode exists** (`/goal <objective>`) — a persistent objective loop surviving session
   boundaries (states: pursuing/paused/achieved/unmet/budget_limited). No Claude equivalent.
   Costs ~462 tokens per continuation turn — a quota tax; use deliberately. ⚠ compaction can
   silently strip goal continuation prompts (known sharp edge).
5. **Sessions run up to ~7h with AUTO-compaction** — Claude compacts when you say so; Codex
   compacts itself as it approaches the limit. Best manual `/compact` point: >70% utilization at a
   logical milestone.

## Rosetta table (the rows that matter daily)

| Claude Code | Codex CLI | Note |
|---|---|---|
| `CLAUDE.md` (walks UP, `@import`) | `AGENTS.md` (walks DOWN from git root; 32KiB cap) | Codex reads AGENTS.md natively; Claude needs `@AGENTS.md` — our repos already do this |
| `~/.claude/settings.json` | `~/.codex/config.toml` (+`[profiles.*]`, `--profile`) | project `.codex/config.toml` exists but many keys silently ignored there (builder guide) |
| subagents (Task tool) | `spawn_agent` (`[features] multi_agent_v2`) | off by default; depth cap 3; known model-override bug |
| skills `/skills` | `~/.codex/skills/` + `.codex/skills/` | `$skill-name` in prompt also triggers |
| hooks in settings.json | `~/.codex/hooks.json` (11 events, `/hooks` to inspect/trust) | richer than Claude's |
| auto-memory `MEMORY.md` | `memories_*.sqlite` (`[features] memories`, off by default) | plus `goals.sqlite` |
| `/cost` | `/usage` · `/status` | see quota hygiene |
| — | `Alt+,` / `Alt+.` | LIVE reasoning-effort adjust in TUI |
| — | `/diff` · `/review` · `/personality` | dedicated pre-commit diff view; review pass |
| `--image` / paste | `-i file.png` (also audio, v0.145+) | works in `exec` too |

## Quota hygiene (Plus)

- **Two independent meters:** 5h rolling window + 7-day cumulative cap — shared across CLI, IDE
  extension, cloud tasks, AND the ChatGPT app. You can exhaust one with headroom in the other.
- **Check:** `/usage` or `/status` in the TUI. ⚠ known bug: status surfaces sometimes disagree —
  cross-check before trusting one. platform.openai.com/usage is historical only.
- **Burns fastest:** high reasoning effort on big tasks · Goal Mode loops · parallel cloud tasks ·
  Sol vs mini ≈ 6.7× credit difference.
- **Stretch:** `[profiles.fast] model = "gpt-5.4-mini"` for routine work · effort `low` for edits,
  `high` only for architecture · pipe context in (`git diff | codex exec -`) instead of letting it
  tool-call around · one free rate-limit reset per eligible Plus account (Settings → Usage → Credits).
- **Temple rule (E1, live-measured):** every exec call carries 16–45K input-token overhead —
  **batch tasks, never micro-call.**

## When to reach for which mind (community consensus, mid-2026 — M confidence)

| | Claude | Codex (GPT-5.6 Sol) |
|---|---|---|
| Planning, architecture dialogue | ✓ explicit, assumption-surfacing | compressed, proceeds on inference |
| Terminal-heavy autonomous execution | | ✓ (Terminal-Bench ~83%, ~72% fewer output tokens) |
| Very large-context coherence | ✓ holds longer | drops earlier |
| Structured/JSON output | good with instruction | ✓ mature schema enforcement |
| Failure mode | **omission** — skips edge cases | **commission** — invents plausible-but-wrong APIs |

Practical split (and ours by design): **Claude orchestrates and plans; Codex executes.** For
triangulation the failure-mode asymmetry is the payoff — the two minds err differently, which is
exactly what makes the second opinion worth having (0005 §Method).

## Do-nots

- Don't script bare `codex exec` — the wrapper (`codex-run`) holds the safety net (builder guide).
- Don't trust exit codes or a single status surface.
- Don't leave Goal Mode running unattended on Plus quota.
- Don't treat Codex output as Claude-flavored: verify invented API names (commission profile).

`refresh: model strings + quota figures are volatile; @Epoch delta-check if this guide is >1 month old.`
