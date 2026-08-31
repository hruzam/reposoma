---
to: @Flight (tactical / Bash seat — majkee drives live)
from: @Atlas (primitive creator · 2026-08-31)
topic: codex-run.zsh — add a `-`/`--stdin` prompt-input mode (relay quote-safety reinforcement ②)
note: supersedes the copy in ~/ia-sync/_mail/kelvin/inbox/ (majkee prefers Flight; drop the Kelvin one)
priority: low (reinforcement, not a fix — the vulnerability is already closed agent-side by ①)
---

## Context — why this exists

The Codex relays (@astrobley, @mirror, @vega) inline the brief into the Bash command that
calls `~/.config/zsh/ai/codex-run.zsh`. A brief containing backticks or `$( )` inside DOUBLE
quotes executes in the relay's own host shell (break + injection); a literal `'` inside single
quotes truncates it. majkee flagged it 2026-08-31.

**Already shipped by Atlas this session (① — surgical table, STAGED, pending deploy):**
- `zsh/guides/codex-relay.contract.md` → new §"Prompt-passing discipline (quote safety)".
- `claude/agents/{astrobley,mirror,vega}.md` → each carries a matching quote-safety snippet.

① mandates a **single-quoted-delimiter heredoc**, which works with the CURRENT wrapper via
`codex-run "$(cat <<'CDX_PROMPT' … CDX_PROMPT\n)"`. So the vulnerability is closed with no
wrapper change. **This brief ② is optional reinforcement, not the fix.**

## The ask — a native stdin input mode

Give `codex-run.zsh` a stdin mode so agents can pipe a quoted heredoc straight in and drop the
`$(cat <<'…')` idiom (subtle; strips trailing newlines):

    ~/.config/zsh/ai/codex-run.zsh - "$model" <<'CDX_PROMPT'
    …brief verbatim…
    CDX_PROMPT

### Spec
- When `$1` is `-` or `--stdin`: `prompt="$(cat)"` — slurp all of stdin FIRST, then shift so the
  model resolves from the remaining arg.
- **Preserve back-compat:** positional `codex-run "<prompt>" [model]` must still work unchanged
  (relays + the contract's fallback path rely on it).
- **`< /dev/null` on the `codex exec` call stays MANDATORY** (stdin-hang #20919). No conflict:
  stdin is fully consumed by `$(cat)` before `codex exec` runs.
- Retry branch (`script -qfc … $(printf '%q' "$prompt")`): `printf '%q'` already handles a
  multi-line prompt — but verify the retry path with a newline-bearing stdin prompt, since that
  branch re-parses through a shell.

### Verify (Bash seat — do it live WITH majkee, per his offer)
Author on the ia-sync table, dry-run deploy, then verify from a fresh Codex session
(ia-sync/AGENTS.md rule). Probes:
1. Heredoc body with `` `date` ``, `$(whoami)`, `"`, `'`, and a blank line → Codex receives it
   byte-literal, nothing executed on the host.
2. A body line that resembles but isn't the delimiter → still literal.
3. Positional form still works (regression).
4. Retry branch with a multi-line prompt.

## After deploy
Once ① and ② are both live, make the contract's stdin note non-conditional and repoint the
relay snippets to prefer the `-` form. Substrate note to Houston/piql optional — I lean no
(additive, relay-scoped).

— Atlas
