# RUNBOOK: Testing OpenRouter stealth/ox-alpha Reasoning Model

```yaml
goal: Install, configure, and verify the OpenRouter stealth/ox-alpha reasoning-enabled model on the local system, demonstrating successful API connectivity, streaming, and multi-turn reasoning context retention.
state: fresh
participant_1: [codex, {brand: "Codex Code Agent", model: "anthropic/claude-3.5-sonnet", effort: "high"}, host: "home"]
```

## prompt-0: Master Prompt for @codex
You are the Codex agent, operating on this local machine. Your objective is to carry out the installation, configuration, and verification of the `stealth/ox-alpha` model using OpenRouter.

Follow the instructions in this runbook sequentially:
1. **Secret Validation:** Confirm that `OPENROUTER_API_KEY` is loaded from `~/.config/zsh/.env/secrets.zsh`. If missing, request the user to add it or guide them to add it.
2. **Environment & Dependency Setup:** Create the script folder `_runbook/ia-sync/ox-aplpha/scr/` and set up a local Node.js environment with the `openai` SDK.
3. **Execution 1 (Curl Streaming Smoke Test):** Run a streaming REST request using curl to verify the API key and streaming responses.
4. **Execution 2 (Multi-turn Reasoning Script):** Execute a Node.js script using the official manual's pattern to verify that the `reasoning` parameter is respected and that `reasoning_details` is successfully passed back in the second turn.
5. **Log Verification:** Record all script outputs, including reasoning tokens and final outputs, in the `journal` section of this runbook.

---

## prompt-1: Setup secrets and dependencies

### Task
Verify that the `OPENROUTER_API_KEY` is available in your shell environment, and set up a localized node environment with `openai` SDK inside `_runbook/ia-sync/ox-aplpha/scr/`.

### Instructions
1. Check if `$OPENROUTER_API_KEY` is set. If not, source `~/.config/zsh/.env/secrets.zsh` to check if it's defined there.
2. If it is still not set, print a clear warning instructing the user to add:
   ```bash
   export OPENROUTER_API_KEY="your-key-here"
   ```
   to `/home/hruzam/.config/zsh/.env/secrets.zsh` and run `source /home/hruzam/.config/zsh/.env/secrets.zsh`.
3. Create the script directory if it doesn't exist:
   ```bash
   mkdir -p _runbook/ia-sync/ox-aplpha/scr
   ```
4. Initialize a minimal package.json and install `openai` locally in that folder:
   ```bash
   cd _runbook/ia-sync/ox-aplpha/scr
   npm init -y
   npm install openai
   ```

---

## prompt-2: Curl streaming smoke test

### Task
Generate and run a script `_runbook/ia-sync/ox-aplpha/scr/test-ox-alpha-stream.sh` that fires a streaming curl request to `stealth/ox-alpha`.

### Instructions
1. Write the following executable shell script to `_runbook/ia-sync/ox-aplpha/scr/test-ox-alpha-stream.sh`:
   ```bash
   #!/bin/bash
   # Ensure OPENROUTER_API_KEY is loaded
   if [ -f ~/.config/zsh/.env/secrets.zsh ]; then
     source ~/.config/zsh/.env/secrets.zsh
   fi

   if [ -z "$OPENROUTER_API_KEY" ]; then
     echo "Error: OPENROUTER_API_KEY is not set."
     exit 1
   fi

   curl -N https://openrouter.ai/api/v1/chat/completions \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer \$OPENROUTER_API_KEY" \
     -d '{
     "model": "stealth/ox-alpha",
     "stream": true,
     "messages": [
       {"role": "user", "content": "How many '\''r'\''s are in strawberry?"}
     ]
   }'
   ```
2. Make it executable (`chmod +x`) and run it.
3. Confirm that chunks flow with streaming reasoning block tokens. Capture the raw response snippet for the journal.

---

## prompt-3: Multi-turn reasoning test (Node.js SDK)

### Task
Implement a Node.js script `_runbook/ia-sync/ox-aplpha/scr/test-ox-alpha-reasoning.js` that tests reasoning enabling and multi-turn message history preservation of `reasoning_details`.

### Instructions
1. Write `_runbook/ia-sync/ox-aplpha/scr/test-ox-alpha-reasoning.js`:
   ```javascript
   const OpenAI = require('openai');
   const fs = require('fs');
   const path = require('path');

   let apiKey = process.env.OPENROUTER_API_KEY;
   if (!apiKey) {
     const secretsPath = path.resolve(process.env.HOME, '.config/zsh/.env/secrets.zsh');
     if (fs.existsSync(secretsPath)) {
       const content = fs.readFileSync(secretsPath, 'utf8');
       const match = content.match(/export OPENROUTER_API_KEY=["']?([^"'\n]+)["']?/);
       if (match) {
         apiKey = match[1];
       }
     }
   }

   if (!apiKey) {
     console.error("Error: OPENROUTER_API_KEY is not set in env or secrets.zsh");
     process.exit(1);
   }

   const client = new OpenAI({
     baseURL: 'https://openrouter.ai/api/v1',
     apiKey: apiKey,
   });

   async function run() {
     console.log("Starting Turn 1 with reasoning enabled...");
     const apiResponse = await client.chat.completions.create({
       model: 'stealth/ox-alpha',
       messages: [
         {
           role: 'user',
           content: "How many r's are in the word 'strawberry'?",
         },
       ],
       reasoning: { enabled: true }
     });

     const response = apiResponse.choices[0].message;
     console.log("\nTurn 1 Assistant Response:");
     console.log(response.content);
     console.log("\nReasoning Details extracted:", JSON.stringify(response.reasoning_details, null, 2));

     console.log("\nStarting Turn 2 - passing back unmodified reasoning_details...");
     const messages = [
       {
         role: 'user',
         content: "How many r's are in the word 'strawberry'?",
       },
       {
         role: 'assistant',
         content: response.content,
         reasoning_details: response.reasoning_details, // Preserve unmodified
       },
       {
         role: 'user',
         content: "Are you sure? Think carefully.",
       },
     ];

     const response2 = await client.chat.completions.create({
       model: 'stealth/ox-alpha',
       messages,
     });

     console.log("\nTurn 2 Assistant Response:");
     console.log(response2.choices[0].message.content);
   }

   run().catch(console.error);
   ```
2. Execute the script:
   ```bash
   node _runbook/ia-sync/ox-aplpha/scr/test-ox-alpha-reasoning.js
   ```
3. Record the full console log output showing both the reasoning block extraction and turn 2 completion.

---

## journal
- `Proxima, 2026-08-23, Runbook design phase completed.`

---

## references
- Raw manual source: `_runbook/ia-sync/ox-aplpha/raw/openRouter-manual.md`
- Knowledge card: `raw.settings/raw.card.openrouter.md`
- Target environment secrets: `~/.config/zsh/.env/secrets.zsh`
