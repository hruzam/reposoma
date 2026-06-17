<!-- PUBLISHED MIRROR · do not edit here · source: piql.dev/guides/piql-bus-usage.md · regenerate with: sync-guides -->

# piql bus — usage

## The `piql` command (privacy-gated cloud assistant)
Runs your text through the local privacy gate, then to Claude. Add this to a sourced zsh file
(e.g. `~/.config/zsh/`) — name it **`piql`**, NOT `pip` (bare `pip` collides with Python's pip):

```zsh
piql() { /home/hruzam/www/piql/piql.dev/bus/pip/pip.zsh "$@" }
```

Then:
```zsh
piql "summarize this for me: ..."
echo "$SOME_TEXT" | piql "review this"
```
Stdout = Claude's answer (pipeable). Notices (what was redacted / blocked) go to stderr.

## Exit codes
- `0` = answer returned
- `2` = BLOCKED by the privacy gate (high-risk; nothing sent to cloud)
- `1` = the tool itself broke (gate unavailable, backend missing/errored)

## What it does
1. `bus/prefilter/` scans your text (gemma3:4b + deterministic matchers): API keys, passwords,
   internal IPs, client codenames, emails.
2. Safe-with-redaction → masks those spans (`[REDACTED:category]`) → sends scrubbed text to Claude.
3. High-risk → blocks; nothing leaves the box.

## Config
- `bus/pip/config.json` — `cloud_backend_cmd` (default `claude --print`; swap to add cursor/agy later),
  `prefilter_path`.
- `bus/prefilter/policy.json` — client denylist + categories + model + endpoint.

## Tests
- `bus/prefilter/tests/run-tests.zsh` — gate detection (10 cases)
- `bus/pip/tests/run-tests.zsh` — pip gating/redaction logic (5 criteria)

## Before you depend on it (hardening, deferred)
The safety-critical secret catch leans partly on the model. If piql moves sandbox → depend-on,
expand deterministic secret regexes in the gate (AWS/GitHub/JWT/key headers) so a leak can't slip
on model nondeterminism. See `session/bus/tasks/BRICK_01_PRIVACY_PREFILTER.md`.

## Footprint & doctor

**Registry** — a machine-local TOML map of every path piql depends on (Ollama service, models dir,
bus scripts, cloud backend binary, Tailscale, session repo). Lives at:

```
~/.config/piql/registry.toml
```

Not committed to the repo. Each machine keeps its own copy. Generic enough to become
`.piql/registry.toml` if piql evolves into a portable primitive.

**Health check** — run `piql-doctor` (available after sourcing `piql.env.zsh`) to verify the full
stack in one shot:

```zsh
piql-doctor
```

Prints `OK / WARN / FAIL` per check and a summary line. Exits non-zero only if any check FAILs.
The doctor is self-contained (hardcoded paths; does not parse the registry) and lives at
`bus/piql-doctor.zsh`.
