# Guide — spawn a headless remote-control Claude session

> Scope: `remote-control`. Script: `spawn-rc.sh`.
> Provenance: applications-in-common session, majkee mobile-driven, 2026-08-14.
> First working run: `~/unikuklatrix/nablarva`, agent `flight`, model `opus`.

## The problem it solves

`claude --remote-control` starts an **interactive** session. When launched from a
context with **no controlling terminal** — an agent's Bash tool, cron, `ssh -T`, a
mobile relay — claude detects no TTY, silently falls back to `--print`, and dies:

```
Error: Input must be provided either through stdin or as a prompt argument when using --print
```

So a plain `claude … --remote-control &` from a headless context never registers a
session. It looks like a flag problem; it's a **TTY** problem.

## The fix

Wrap the launch in `script -qec`, which allocates a pseudo-TTY. `setsid` detaches it
so it survives the caller. The interactive session then boots normally and registers
with Remote Control — attachable from a phone or another client.

```bash
cd <dir> && setsid script -qec "claude --agent <agent> --model <model> --remote-control" <log> >/dev/null 2>&1 &
```

## Normalized usage

```bash
spawn-rc.sh <dir> [agent] [model]
#   agent default: flight     model default: opus
```

- The log file stays **empty** — that's expected. Interactive TUI output is terminal
  control sequences, not plain text.
- Verify with: `pgrep -f 'claude --agent <agent> .* --remote-control'`
- Stop with:   `pkill -f 'claude --agent <agent> .* --remote-control'`

## Gotchas that bit us

| Symptom | Cause | Fix |
|---|---|---|
| dies asking for prompt/stdin | no TTY → falls back to `--print` | wrap in `script -qec` |
| `--remote-controll` unknown flag | typo, one trailing L | `--remote-control` |
| model won't resolve (`claude-opus-4-8`) | non-existent model string | use alias `opus` or a valid dated full name |
