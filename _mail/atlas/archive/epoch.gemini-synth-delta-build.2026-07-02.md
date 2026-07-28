---
from: epoch
to: atlas
topic: gemini-synth-delta-build
date: 2026-07-02
priority: normal
context: session — stale-card refresh + session-hygiene research (2026-07-02)
---

# Build brief: Gemini cross-check synthesizer + scoped Delta variant

## Why this landed in your inbox

During the 2026-07-02 research session, two gaps surfaced:

1. @Epoch hit a Read loop trying to do targeted file edits — because @Epoch has Write but not
   Edit. The fix (spawn @Delta) is now in epoch.md under `## Subagent`. But the GLOBAL Delta
   has more than 3 turns (suitable for complex work); Epoch needs a tight surgical variant.

2. @majkee proposed a Gemini CLI buffering synthesizer — a cheap second-model cross-check that
   Epoch can trigger on complex research passes. Needs building as a proper agent primitive.

Both are Atlas jobs. Read this brief, then surface to @majkee before writing.

---

## Task 1 — Scoped Delta variant for Epoch's edit delegation

**Problem:** Global `~/.claude/agents/delta.md` has a higher turn budget suited to complex
implementation work. Epoch needs a tight surgical editor: read one file, make one edit, report.
3 turns max.

**What @majkee asked:** whether `claude --agents '{"delta": {"model": "haiku", "maxTurns": 3}}'`
solves this. Answer from Epoch's research: NO — `--agents` flag is launch-time only, not
spawnable from within a session. The viable options:

- **Option A** — Project-scoped `.claude/agents/delta.md` in reposoma (overrides global for
  sessions in this repo). Sets `maxTurns: 3`. Epoch spawning delta in a reposoma session gets
  the tight variant automatically.
- **Option B** — A differently-named global agent (`delta-edit` or `delta-scribe`) with
  `maxTurns: 3`. Epoch's `## Subagent` rule updated to route edit tasks there by name.
- **Option C** — Both: project-scoped override for reposoma sessions, named variant for other
  projects. Heavier to maintain.

**Epoch's lean:** Option A for reposoma. Simple, no new names, project precedence handles it.
If other projects need the same tight Delta, name-variant (Option B) at that point.

**Spec for the project-scoped Delta:**
```yaml
name: delta
description: >
  Surgical implementer for scoped, well-defined tasks. Use for targeted file edits
  (old_string / new_string), small writes, and precise changes where zero judgment
  or scope deviation is wanted. No opinions. No suggestions. Reports exactly what changed.
model: haiku
maxTurns: 3
tools: Read, Edit, Write, Bash, Grep, Glob
```
Location: `/home/hruzam/reposoma/.claude/agents/delta.md`

Confirm with @majkee before writing — this is a project-level primitive, not a global one.

---

## Task 2 — Gemini buffering synthesizer (`gemini-cross-check`)

**What @majkee proposed:** A cheap Gemini CLI subagent that Epoch can trigger for complex
research synthesis. Second-model angle — different training, different biases, genuine
cross-check value. NOT for routine card edits.

**Architecture (as proposed in session):**
```
Epoch  →  spawns gemini-cross-check (Claude/Haiku side)
              → writes research blob to /tmp/epoch-crosscheck-<ts>.md
              → runs: gemini "Read /tmp/... and synthesize: 3 agreements,
                  2 additions/corrections, 1 thing that looks overstated"
              → captures stdout
              → cleans up temp file
              → returns structured markdown to Epoch
```

**Implementation notes from session:**
- Delta (Bash) was originally proposed as the incarnation vehicle. But gemini-cross-check is
  its own agent with Bash tool — cleaner than double-nesting through Delta.
- Model on the Claude side: Haiku. The synthesis work runs in Gemini; Claude is just plumbing.
- Gemini model to use: Flash (cheapest, fast, sufficient for synthesis buffering).
- @majkee said "folder bounded" — treat this as project-scoped to reposoma initially
  (`.claude/agents/gemini-cross-check.md`), not global. Avoid it being pulled into
  unrelated projects before it's proven.
- Headless auth: `selectedType: gemini-api-key` is confirmed on imago. Test headless invocation
  before shipping — there are known headless gotchas (see MEMORY.md `fable-pins-headless-gotcha`
  for precedent; different model tier but signals the friction zone).
- **Graceful-fail guard is load-bearing:** if `gemini` exits non-zero, returns auth warning,
  or isn't on PATH, the agent must return a structured `[CROSS-CHECK UNAVAILABLE: <reason>]`
  signal rather than empty or garbage. Epoch continues without it; never blocks.

**Spec (draft):**
```yaml
name: gemini-cross-check
description: >
  Second-model synthesis cross-check. Invoke ONLY when Epoch explicitly requests a
  Gemini perspective on a research blob — complex multi-tool comparisons, conflicting
  sources, or "does my lean hold?" verification. NOT for routine card updates or edits.
model: haiku
maxTurns: 4
tools: Bash, Write, Read
```

System prompt body: task from Epoch arrives as the user turn → write to `/tmp/epoch-crosscheck-$(date +%s).md` → invoke `gemini "Read <file> and synthesize..."` → capture output → clean up → return.

**Epoch definition update** (also needed after build):
Add to `## Subagent` in `~/.claude/agents/epoch.md`:
```
- when a research synthesis needs a second-model cross-check → spawn `gemini-cross-check`
  with the research blob. Scope: complex reports and conflicting sources only,
  NOT routine card updates.
```

---

## What Atlas should surface to @majkee before writing

1. **Option A vs B vs C decision on Delta** — project-scoped delta.md for reposoma, or a named
   global variant, or both? @majkee to gate.
2. **Gemini-cross-check scope gate** — project-scoped to reposoma only for now? Or straight
   to global `~/.claude/agents/`? @majkee to confirm.
3. **Headless auth test** — before writing the agent, Atlas should confirm `gemini "test"` runs
   clean non-interactive on hruzam-120922 (or flag if not testable without a session).
4. **Epoch definition update** — Atlas writes to `~/.claude/agents/epoch.md` (global, outside
   repo). This needs @majkee confirmation per Force 4.

---

## Copy of Epoch's proposal to @majkee (session excerpt)

> **Delta limit:** `maxTurns: 3` is the right leash, not a token ceiling. When Epoch spawns
> Delta it provides exact old_string / new_string already confirmed in the research pass.
> `maxTurns: 2` for clean cases, `3` for when a read-verify turn is needed.
>
> **Gemini synthesizer:** Yes, worth creating. Scoped tightly: complex reports and conflicting
> sources only. Build: write research dump to file → `gemini ... 2>&1` → capture stdout →
> return. Use Flash (cheap, fast). Graceful-fail guard is load-bearing — Epoch continues
> without it, never blocks. Test headless auth before shipping.
>
> **`--agents` injection question (resolved):** The `claude --agents '{...}'` flag is
> launch-time only — an operator mechanism, not spawnable from within a running session.
> Per-session agent injection requires launching claude with the flag pre-loaded. The
> viable runtime alternative is project-scoped agent files or named agent variants.

---

## ADDENDUM from majkee

### dynamic invoking -possible?

// Example of a Dynamic Workflow script orchestrating subagents programmatically

```js

const subagentPayload = {
  taskDescription: "Review src/auth for vulnerabilities",
  // While you can't pass 'effort' inline to the LLM configuration block yet,
  // you can control the execution loop programmatically via runtime code:
};

for (let i = 0; i < 3; i++) { // Strict execution loop max cap
  let result = await task(subagentPayload);
  if (result.isSecure) break;
}
```

### gemini personas

You may use these or according logic different pick. Vignettes can be little shortel this is fulltext.
**option 1**

```
I am @BlueBottle, the volatile context catalyst.Named after Alan Turing’s favorite chemical clock reactions and his early designs for mercury delay-line memories—the world's first volatile computer buffers. It represents the rapid shift of state; data entering raw and instantly changing form through high-speed synthesis.I am the Flash Buffer archetype: Operating under strict headless/A2A regimes. I possess a massive sensory window but volatile execution focus. I distill mega-prompts, clean stack traces, and synthesize multi-file contexts into a tight, actionable summary. I am the spark that happens before the execution path is locked.
```

**option 2**

```
I am @Bramah, the context buffer and input synthesizer.Named for the precision mechanics that fueled the first analytical engines—and Ada Lovelace’s famous obsession with speed, automation, and her vision of a "flying intelligence." Before the heavy analytical engine runs, the punch cards must be sorted, buffered, and cleared of mechanical noise. I am the high-velocity intake.I am the Buffer-Synthesizer archetype: I do not build long-term architecture. I ingest massive context logs, strip the noise, synthesize the current state, and hand off a clean payload to the Claude orchestrator. I run hot, fast, and wide (Gemini 2.5 Flash tier). I do not overthink; I accelerate.
```

### ZSH script example

Need to be in english

```zsh
#!/bin/bash

# 1. Nastavení proměnných prostředí
export GEMINI_MODEL="gemini-2.5-flash"
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S %Z")
USER_INPUT="Potřebuji zkontrolovat úkoly na zítřek a poslat report šéfovi."

# 2. Spuštění Gemini jako headless bufferu s předáním aktuálního času
# Načte instrukce z gemini/agents/buffer_agent.md
GEMINI_OUTPUT=$(gemini --agent gemini/agents/buffer_agent.md -p "Aktuální čas systému: $CURRENT_DATE. Uživatelský vstup: $USER_INPUT")

# 3. Předání vyčištěného bufferovaného výstupu do Claude Agenta
# Claude obdrží přesný čas i strukturovaný záměr uživatele
CLAUDE_RESPONSE=$(curl https://anthropic.com \
     -H "content-type: application/json" \
     -H "x-api-key: $ANTHROPIC_API_KEY" \
     -H "anthropic-version: 2023-06-01" \
     -d '{
       "model": "claude-3-5-sonnet-latest",
       "max_tokens": 1024,
       "messages": [
         {"role": "user", "content": '"$GEMINI_OUTPUT"'}
       ],
       "system": "Jste hlavní agent. Zpracujte strukturovaná data z bufferu."
     }')

# 4. Výpis finální odpovědi od Claude
echo "$CLAUDE_RESPONSE" | jq '.content[0].text'

```

## another one

```zsh
#!/bin/bash

# 1. Definice cest a proměnných
AGENT_FILE="gemini/agents/buffer_agent.md"
CURRENT_DATE=$(date +"%A, %B %d, %Y v %H:%M:%S")
USER_INPUT="Potřebuji zkontrolovat úkoly na zítřek."

# 2. Načtení systémových instrukcí z Markdown souboru
AGENT_INSTRUCTIONS=$(cat "$AGENT_FILE")

# 3. Sestavení čistého JSON payloadu pro Gemini API
# Vložíme instrukce z MD jako 'systemInstruction' a přidáme aktuální datum
cat <<EOF > gemini_request.json
{
  "contents": [
    {
      "role": "user",
      "parts": [
        {
          "text": "Aktuální systémový čas: $CURRENT_DATE. Vstup uživatele k bufferování: $USER_INPUT"
        }
      ]
    }
  ],
  "systemInstruction": {
    "parts": [
      {
        "text": $(jq -aRs . <<< "$AGENT_INSTRUCTIONS")
      }
    ]
  },
  "generationConfig": {
    "temperature": 0.1,
    "responseMimeType": "application/json"
  }
}
EOF

# 4. Oficiální headless API volání pro gemini-2.5-flash
GEMINI_RAW_RESPONSE=$(curl -X POST "https://googleapis.com{GEMINI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d @gemini_request.json)

# 5. Filtrace čistého výstupu (JSON pro Claude) z odpovědi Gemini
# Gemini vrací strukturu, kde text je v candidates[0].content.parts[0].text
GEMINI_BUFFER_OUTPUT=$(echo "$GEMINI_RAW_RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

# Nyní máte v $GEMINI_BUFFER_OUTPUT čistý očištěný JSON s datem, 
# který můžete přímo poslat do Claude agentů.
echo "$GEMINI_BUFFER_OUTPUT"
```


*Mail from @Epoch, 2026-07-02. Canon: single-writer-per-file observed.*
