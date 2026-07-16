# octo-launcher — keyboard handoff guide  `[FINISH-LINE — build after the octopus workflow skills exist]`

`date: 2026-07-16 · author: @Atlas · target: ~/.config/zsh/ai/ (machine layer — 0009).`
`nature: HANDOFF guide, authored reposoma-side. Installed by the zsh-layer builder (Maxwell / a scoped zsh pass) following ~/.config/zsh/guides/guide-for-builder.md (§Architecture rules = LAW). @Atlas does NOT hand-edit the zsh temple-family scripts — I hand the spec; their builder installs it.`

## What it is
One alias that drops @majkee into the octopus head (Flight) with a small on-screen help
of the available octopus skills/commands. A **signpost, not orchestration** — the loop
logic stays in the agents (regime line: *keyboard launches, agents orchestrate*).

## Three parts, two homes

| Part | Home | Owner | Shape |
|---|---|---|---|
| launch alias `octo` | `ai/keyboard.zsh` (a partition) | zsh-builder | `alias octo='claude --agent flight'` — **interactive / supervised, NOT the headless empty-folder trigger** |
| claviature panel entry | `ai/keys.zsh` `_KEYS_FAMILY_MAP` | zsh-builder | register prefix `octo` → label `Octopus` (unregistered = UNSORTED drift) |
| in-session cheat-sheet `/octo` | `~/.claude/skills/octo/SKILL.md` | **@Atlas** | one screen: the program-pulse workflow + the octopus skills/commands |

**Convergence:** your "small help on the line" and your "same for the claviature" are the
**same mechanism** — register one `octo`/`Octopus` family and `keys` renders it. One move,
both asks.

## Boundary (why this is a handoff, not an Atlas build)
`ai/` is bonded to **decision 0009**; the claviature spec is **LOCKED (2026-07-11)**;
`keyboard.zsh` is aliases-only; *the builder guide is LAW*. That domain is the machine
surface — not a Claude Code primitive. I own only the `/octo` skill on the Claude side.

## Finish-line trigger — UNBLOCKED 2026-07-16
The octopus workflow skills now exist, so the cheat-sheet has real content. Remaining to
ship the launcher: the `/octo` cheat-sheet skill (@Atlas) + the zsh install — the `octo`
alias + the `Octopus` keys-family — by the zsh-builder following `guide-for-builder.md`.

## Skill inventory
- [x] program-pulse read/write (add-to-line / pull-from-line) — BUILT `~/.claude/skills/program-pulse/SKILL.md`
- [x] review-companion (Recorder, program-review mode) — BUILT (`recorder.md` extended)
- [ ] `/octo` cheat-sheet skill — @Atlas, build alongside the launcher

## One regime nail
`octo` drops you into **Flight, interactive**. It is a door you walk through, never a loop
that runs itself. The moment any variant goes autonomous, **0012-L8 circuit breakers apply**
(token ceiling · human commit gate · dead-man's-switch · 3-fails-stop).
