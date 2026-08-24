# RUNBOOK: Global OpenRouter `stealth/ox-alpha`

```yaml
goal: Install and run stealth/ox-alpha as the global ox-alpha OpenRouter command using the operator's OpenRouter login.
state: verified_non_streaming_streaming_provider_rate_limited
participant_1: [codex, {brand: "Codex Code Agent / Executor"}, host: "office"]
```

## Source and scope

- Primary installation/usage source: `raw/openRouter-manual.md`.
- This is an OpenRouter model command, not a Codex custom agent.
- Portable runner: `~/ia-sync/zsh/ai/experimental/ox-alpha/runner.zsh`.
- Generic dispatcher: `~/ia-sync/zsh/ai/experimental.zsh`, sourced by `ai/base.zsh`.
- Credential location: `~/.config/zsh/.env/secrets.zsh`; never store the key in this runbook, `~/ia-sync`, a project, or `~/.codex`.

## Installation

1. Put the current credential in `~/.config/zsh/.env/secrets.zsh`:

   ```zsh
   export OPENROUTER_API_KEY="your-key-here"
   ```

2. Keep `~/ia-sync/zsh/ai/experimental/ox-alpha/runner.zsh` as the portable runner. It sends `stealth/ox-alpha` requests to `https://openrouter.ai/api/v1/chat/completions` with `reasoning: {enabled: true}`.
3. Wire `experimental.zsh` through `~/ia-sync/zsh/ai/base.zsh`. `exp-run <id>` resolves a runner lazily, so the existing recursive zsh deployment automatically carries every experiment.
4. Deploy the reviewed source to `~/.config/zsh/` using the normal ia-sync flow, then open a new shell or source `~/.config/zsh/ai/base.zsh`.

## Run

```zsh
ox-alpha "Explain the next step."
ox-alpha --no-stream "Reply with exactly: ox-alpha ready"
ox-alpha chat
exp-list
exp-run ox-alpha chat
ox-alpha --help
```

- Default is raw server-sent-event streaming, following the manual.
- `--no-stream` prints the full JSON response through `jq`; inspect `choices[0].message.reasoning_details` when reasoning evidence is needed.
- `ox-alpha chat` is the terminal UI: it retains history only for the active process, passes each assistant `reasoning_details` back unmodified on the next request, and clears history on `/exit`, `/quit`, or Ctrl-D.

## Verification

```zsh
zsh -n ~/.config/zsh/ai/experimental.zsh
zsh -n ~/.config/zsh/ai/experimental/ox-alpha/runner.zsh
zsh -f -c 'source ~/.config/zsh/ai/base.zsh; _exp_run ox-alpha --no-stream "Reply with exactly: ox-alpha ready"'
```

Expected successful response: `ox-alpha ready`, with a `reasoning_details` array in the JSON.

## Journal

- `Proxima, 2026-08-23: Initial runbook/manual collected.`
- `office, 2026-08-24: The operator rotated OPENROUTER_API_KEY and placed it in ~/.config/zsh/.env/secrets.zsh.`
- `office, 2026-08-24: Installed global portable engine ~/ia-sync/zsh/ai/openrouter.zsh and deployed it to ~/.config/zsh/ai/. Wired ox-alpha / ox-alpha-help through the existing zsh control-panel convention; no Codex agent was created.`
- `office, 2026-08-24: Non-streaming verification succeeded against Stealth: model stealth/ox-alpha replied "ox-alpha ready" and returned one reasoning.text reasoning_details item. completion reasoning_tokens: 0.`
- `office, 2026-08-24: Streaming verification immediately afterward reached OpenRouter but received HTTP 429 from Stealth's shared upstream pool (is_byok: false). The installed command is correct; retry when capacity returns or configure an OpenRouter provider key/routing if desired.`
- `office, 2026-08-24: Retired the repository-local scr/ Node SDK prototype; global zsh is the sole installed command surface.`
- `office, 2026-08-24: Added ox-alpha chat: a session-only terminal REPL that preserves response reasoning_details across turns without writing conversation data to disk.`
- `office, 2026-08-24: Moved Ox Alpha into the generic experimental-runner layout. deploy.sh already recursively syncs zsh/, so no per-experiment deployment mapping is needed.`

## References

- Raw manual source: `raw/openRouter-manual.md`
- Knowledge card: `raw.settings/raw.card.openrouter.md`
- Secrets: `~/.config/zsh/.env/secrets.zsh`
