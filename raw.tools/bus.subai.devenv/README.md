---
artifact: raw.tools · bus.subai.devenv — markdown message bus (build report)
source-of-truth: /home/hruzam/www/ovum/subai.devenv/_bus/
status: BETA, spine verified py3.14 · workers unverified (see u5)
date: 2026-06-17
reporter: "@Houston (claude basement)"
laws-touched: MEDIUM · PORTABILITY · SEAM · LIGHT
adopt: copy _bus/ into any project; edit bus.config.json; zero external deps
---

# bus.subai.devenv — the markdown message bus

A portable record of the bus built inside `subai.devenv`. Catalogued here in
`raw.tools/` so other projects/teams can adopt the *shape* without re-deriving it
(PORTABILITY LAW: one source, N consumers).

## What it is
A markdown file as the **shared input bus**: **one human message → N agent readers.**
Instead of a cramped terminal line you write markdown (context, anchors, trees) into
`in.md`, set a `to:` line, and `submit`. The same message fans out to several agents,
so you get multi-agent broadcast (consensus / tentacles) for free. Replies land
**laned by `from`** in the skin — one window, divided per reader.

This is the cross-brand broadcast spine of the three-team topology:
`claude` (living, reads its own card) · `gemini` / `agy` / `cursor` (workers, headless).

## Source of truth (do not duplicate — reference)
```
_bus/
  bus.py            # ~110 lines, stdlib only. submit = parse → emit pulse → fan-out
  bus.config.json   # the portable contract: per-agent mode + run template
  in.md             # the human writes here; `to:` + `subject:` frontmatter
  README.md         # operator quickstart
  inbox/            # cards a living agent reads itself (no -p trap)
  outbox/           # worker stdout reports land here
  done/             # standing cards move here when closed
```
Canonical code lives in the project; this card is the know-how, not a fork.

## How it works (the flow)
1. Human edits `in.md`, sets `to: claude, gemini`, runs `python3 _bus/bus.py submit`.
2. `bus.py` parses `to:`/`subject:`, then **emits one `?` pulse** into the medium
   (`_substrate/dev.journal.jsonl`) — `from:@human → to:@claude+@gemini`. Every submit
   flattens to truth (MEDIUM LAW).
3. Per target it writes a card `inbox/<agent>.<pulseid>.md`:
   - **living** (claude) → card dropped; the running session reads it itself. No
     `claude -p` headless/SDK trap (SEAM LAW).
   - **worker** (gemini/agy/cursor) → headless dispatch via the `run` template,
     stdout captured to `outbox/<agent>.<pulseid>.md`, plus a result pulse
     (`.` success / `!` failed) back into the medium.
4. `--dry` previews + drops cards but never dispatches a worker.

## The contract — `bus.config.json`
The one swappable piece. `{file}` expands to the per-agent card path. Verify exact
CLI flags / model ids before trusting worker runs (open thread u5).
```json
{
  "agents": {
    "claude": { "mode": "living" },
    "gemini": { "mode": "worker", "run": "gemini -p \"$(cat {file})\"", "timeout": 600 },
    "agy":    { "mode": "worker", "run": "agy -p \"$(cat {file})\"",    "timeout": 900 },
    "cursor": { "mode": "worker", "run": "cursor-agent -p \"$(cat {file})\"", "timeout": 600 }
  }
}
```

## Adopt in 3 steps
1. `cp -r _bus/` into the target project (sits beside a `_substrate/pulse.py`).
2. Edit `bus.config.json` — name your agents, set `mode` + `run`.
3. `echo "to: claude" >> in.md && $EDITOR in.md && python3 _bus/bus.py submit`.

## Verified
`bus.py` runs clean on py3.14, zero external deps. The `submit` path + pulse emission
+ card drop are smoke-tested. **Worker dispatch is NOT yet verified** — the `run`
templates and model ids are placeholders pending u5 (exact `gemini` / `agy` /
`cursor-agent` flags).

## Laws honored
- **MEDIUM** — every `submit` flattens to a pulse before any side effect; resonance
  (the chat) is volatile, the dispatch is truth.
- **PORTABILITY** — vendor-neutral `{file}` template; same markdown → N brands. A
  finger that worked on only one vendor would be a smell; this targets the whole row.
- **SEAM** — living claude reads a dropped card; never `-p` as the engine. Workers use
  their own sanctioned headless mode, not a patched agent loop.
- **LIGHT** — stdlib only (`re`, `json`, `subprocess`, `pathlib`). No watcher, no DB.

## Open threads
- **u5** — verify real worker CLI flags + model ids (gemini post-06-18 sunset / agy
  `-p` semantics / cursor-agent invocation) before trusting headless dispatch.
- **u2** — a `piql` privacy gate in front of cloud/bus dispatch (parked).
- **By design, NOT bugs** — no file watcher, no auto-submit, no routing. Explicit
  `submit` only. The value is the *shape*, not a gadget. Don't over-engineer it.
