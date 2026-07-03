# TASK : GEMINI CLEANUP

HERE: `/home/hruzam/.config/zsh`
session for: reengineering gemini bluebottle and LOCK same pattern for any field subagents

---

**Read firs all**
- this task is for your reincarnation **NOT** think about much, just add your cathes, leans or synthetize to this task

## RE/SEARCH
1. study gemini deeply, underlined (but not only): running in headless regime,gemini as claude subagent (CLI), optimal agent inhjection (md OR json, which type of script)
- if nothing which can reply questions in @raw.settings/ -> go on internet search
according `<date>`
- google papers and git patterns + stack overflow with practical implementations
- check data also here https://geminicli.com/docs/core/policy-engine/
- map reported mechanism of massive 
2. find actually against vendor shifts most flexible way how to inject on bash alias -> zsh OR command -> sh
partner for claude --> standardizing

## GEMINI BUILD SPECIFICATION

***field:*** `HERE/ai`,
1. if can be whole agent with personality injected to session as core agent NOT subagent -> each from agents: `Vega`, `Astrobley`, `Orby`, `Bluebottle` should have their own 'call to arms script' `<name>.{zsh, sh, py,...}`
- basic only for UI session
- extended with subcommands as bluebottle has 


--> BLUEBOTTLE MUST BE re-CREATED ON ALL CASES

reingeneering bluebottle
1. bluebottle grades: 
- ***fast headles one shot buffer*** fast in-out headles by command 
- ***fast UI bufer*** - living session subagent
2. vega as thinking sibling
- ***thinking headles one shot buffer*** fast in-out headles by command 
- ***thinking UI bufer*** - living session subagent

--> same model type or level for fast, pro for thinking

## CLEANUP gemini agents,

***field:*** `HERE/ai`, `HERE/AGENTS.md` 

kill: `/home/hruzam/.config/zsh/ai/gemini-agents.zsh`
kill: `/home/hruzam/.config/zsh/ai/gemini-base.zsh` 
NEW script One file for commands, aliases -> keyboard file
NEW script One file as processor (common functions)
NEW scripts for agents
create and add to README.md rule dev standard 
1. just recomand light-house here ``
2. wiring to `HERE/guides/<guide-for-builder>` when creating something here (f.e....also 'dont forget on `AGENTS.md`'), if NOT create one extendable
3. wiring to user `HERE/guides/<guide-for-user>` , if NOT create one extendable
4. reading `<guides>` rules
f.e.
- script (grep to chapter...)
- ai panel ...

## FINALIZE

1. ***field:*** `raw.settings/` + template, readme
- extend process and output cards
-add information that part of gemini cards research must be also accross community reports about stability (e.g. 2026-06-27 majkee found out, that model line 3 is unstable as CLI, stucks, failures, reading to much - token bloat...) -> synthesis to card contain some matrix (like coding tasks, buffering or fast search) usage, effort

2. ***field:*** `/home/hruzam/.claude/agents/epoch.md` 
- put propper gemini buffering subagent run book via harness (autocommand or bash, or inject json,...)

## PROCESS SCHEDULE
- plan mode -> subtasks, clarifications, plan for two groups: claude CLI 2x1+1 || ClCo CLI 1+1, gemini CLI 1+1 (end session user),gemini are strong buffers or coders when has very clean instructions
- 2 paralel atlas sessions (or one Atlas, one gemini team) each on its task lines -> run -> common handoff (explicitly defined file)
--> trajectory organize stress and run test (has bash) -> if OK, task finished, bye :)

---

# ATLAS PREINCARNATION LEAN

> Atlas, space for your comments, catches,...

## Confirmed facts from build session (2026-07-02/03)

- `-p` flag: **REAL** — `gemini --skip-trust -m gemini-2.5-flash -p "..."` confirmed by Oraculum's direct bash attempts. Reached API stage (503 = overload, not flag rejection).
- `--agent` flag: **DOES NOT EXIST** — "Unknown argument: agent". The script example in the mail was illustrative pseudocode.
- `@name` selector (`gemini "@bluebottle ..."`) puts Gemini in **interactive/agentic loop** — wrong for headless. Avoid.
- REST API (curl) is **more reliable** than CLI for headless — no TTY dependency, no startup noise, no retry loops on 503.
- `GOOGLE_API_KEY` takes priority over `GEMINI_API_KEY` when both are set (CLI logs it explicitly). Mirror in scripts.
- `printf '%s'` not `echo` when piping to jq — trailing newline from echo breaks JSON parse (this was the silent blocker).
- CLI stdout contains 4 known noise types: `--allowed-tools deprecated`, `Both GOOGLE_API_KEY...`, `[STARTUP] phase`, `/tmp permission denied` warnings. None fatal; all strip-able.
- `bluebottle.md` (Gemini agent file) persona is **baked** — regardless of input file, output genre is cross-check. Research pass requires `--raw` mode (no system prompt). This is why the Gemini research leg in nabla-lab P1 produced no usable research cards.

## Clarification needed before RE/SEARCH

- "map reported mechanism of massive" — massive what? Assuming: 503 failure cascade + token bloat + over-reading pattern (CLI scans /tmp, reads all context). Confirm.
- The policy engine URL (`https://geminicli.com/docs/core/policy-engine/`) appears in the `--allowed-tools deprecated` warning. RE/SEARCH should map what the new policy engine replaces and whether it affects agent injection (MD vs JSON).

## Structural leans for BUILD

**Script portability:** Use `.sh` (POSIX) over `.zsh` for per-agent scripts. Claude Code's Bash tool spawns in a bare bash environment — does not source `.zshrc`. Scripts callable from agents must be shell-portable.

**One script per agent, two modes:** No arg → UI session. With arg or flag → headless one-shot. This maps to the "basic / extended" spec. Same file, mode detected at runtime.

**REST API primary, CLI fallback (not reversed):** curl path is reliable, clean, controllable. CLI fallback is noisy, TTY-sensitive, 503-prone under load. The build session got this right eventually.

**`--raw` is load-bearing from day one:** Not an add-on. Without it, no Gemini research leg is possible (persona blocks §0-style pass). New bluebottle must be built with both modes from the start.

**Processor/keyboard split:** The two new files replacing gemini-base.zsh + gemini-agents.zsh:
- `keyboard.zsh` → aliases only, sources processor + agent scripts. Interactive shell only.
- `processor.zsh` → common functions: API key resolution, payload builder, graceful-fail wrapper, jq extractor. Sourced by keyboard + callable by agent scripts.
- Per-agent: `bluebottle.sh`, `vega.sh`, `orby.sh`, `astro.sh` — each self-contained, own two-mode logic.

**Temple family (`temple-*.zsh`) stays untouched** — none of the cleanup touches them. Confirm scope boundary before any deletes.

## Dependencies to update after rebuild

- `reposoma/.claude/agents/gemini-cross-check.md` calls `~/.config/zsh/ai/bluebottle.zsh` directly — must be updated to new path/name after bluebottle is re-created.
- `~/.claude/agents/epoch.md` `## Subagent` references `gemini-cross-check` — the FINALIZE runbook task lands here.

## Parallel session split lean

RE/SEARCH must gate BUILD — the policy engine findings + headless injection map may change the build spec. Suggested order:
1. Session A: RE/SEARCH → produces spec addendum (JSON vs MD, policy engine impact, `-p` flag depth)
2. Session B: BUILD + CLEANUP (starts from spec addendum as input) — can split: one seat takes agent scripts, one takes keyboard/processor/README/guides
3. Trajectory: stress + run test (has Bash, can call the new scripts directly)

Handoff file location for parallel sessions: suggest `reposoma/_mail/toAll/inbox/` or a dedicated `session/handoff.gemini-rebuild.md`.
