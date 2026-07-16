# TASK — Gemini Coder: Patch-Protocol Build (Tier 1)
# Gaveled by operator 2026-07-03: model=gemini-3.5-flash · astrobley-integrated · 4-iteration / ~50K ceilings

**Executor:** @Trajectory
**Concept source:** `_mail/toAll/inbox/draft.gemini-coder.patch-protocol.2026-07-03.md` (gaveled)
**Infra base:** deployed `~/.config/zsh/ai/` (post fix-pass — processor.sh has bounded `_gai_rest_call`)

## Step 1 — `astrobley.sh`: add `--patch` mode

New branch alongside existing modes:

```
astrobley.sh --patch <ledger.json> ["new user message"]
```

Behavior:
- If ledger file missing AND message given → create ledger: `{"contents":[{"role":"user","parts":[{"text":"<message>"}]}]}`
- If ledger exists AND message given → append user turn (jq), then call
- If ledger exists, no message → call with ledger as-is (re-fire after 503)
- Payload: `systemInstruction` = contents of persona file (Step 2), `contents` = ledger array,
  `temperature: 0.2`, model **`gemini-3.5-flash`** (pinned, gaveled — do not read GEMINI_MODEL env)
- REST via `_gai_rest_call` (existing timeouts + single 503/429 retry). NO gemini CLI — ever, in this mode.
- Success: print extracted text to stdout **only**, append model turn to ledger (jq)
- Failure: `[UNAVAILABLE: <reason>]` exit 0 — ledger left un-appended so re-fire is clean
- Size guard: if ledger file > 200KB, warn on stderr (`ledger approaching ~50K-token ceiling — trim or split task`), still proceed

## Step 2 — Persona file: `~/.config/zsh/ai/personas/astrobley-patch.md`

Plain text (operator-tunable without touching the script). Content contract:

```
You are a senior PHP implementer working over a stateless API. You receive code
context and a task. You have NO tools, NO file access, NO documentation access —
work only from what is in the conversation.

OUTPUT CONTRACT — absolute:
- Respond with a unified diff ONLY (git format: --- a/path, +++ b/path, @@ hunks
  with correct context lines). No prose, no explanation, no markdown fences.
- Multiple files → one diff, multiple file sections.
- If you cannot produce a correct diff from the given context, respond with
  exactly one line: QUESTION: <the single most important thing you need>
- Never invent file paths or APIs not present in the provided context.
```

## Step 3 — Ledger convention (documented, not enforced by script)

- Location: project-local `session/gemini-coder/<task-id>.ledger.json` (script takes any path)
- One task = one ledger. Never reuse across tasks.
- Driver loop lives with the orchestrating agent (Claude Code / Trajectory), NOT in the script:
  1. Build context pack: target file(s) full + dependency signature stubs + task statement
  2. `astrobley.sh --patch ledger.json "<context pack + task>"` → capture stdout
  3. `git apply --check` on work branch — reject non-diff output outright
  4. Apply + run tests. Green → done. Red → next turn with failing output as the message.
  5. **Ceiling: 4 iterations** (gaveled), then stop and hand to human.

## Step 4 — Smoke test (mechanism only, NOT the pilot)

Timeout-wrapped:
```
tmpl=$(mktemp /tmp/coder-smoke.XXXX.json)
timeout 150 ~/.config/zsh/ai/astrobley.sh --patch "$tmpl" \
  'Context: file a/src/Greeter.php contains: <?php class Greeter { public function greet(): string { return "hi"; } }
   Task: change greet() to return "hello".'
```
Pass criteria: exit 0, stdout non-empty, first non-blank line starts with `---`, `diff`, or `QUESTION:`;
ledger now has 2 turns. Then re-run with a follow-up message → ledger has 4 turns.

## Step 5 — Documentation

- `guides/guide-for-user.md`: new section "Patch protocol (coding with Gemini)" — the 5-step
  driver loop, ledger convention, 4-iteration ceiling, re-fire-on-503 note
- `guides/guide-for-builder.md`: persona file location + how to tune the contract
- `ai/README.md` + `~/.config/zsh/AGENTS.md`: file-map entries for `personas/` and the `--patch` mode

## Out of scope
- The live PHP pilot (operator brings the task; runs as its own session)
- Any gemini CLI involvement in this mode
- reposoma AGENTS.md ImportProcessor escape (still ungaveled)
