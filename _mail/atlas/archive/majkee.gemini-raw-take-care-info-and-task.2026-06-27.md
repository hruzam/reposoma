

## 1. gemini circle

### 1.1. majkee wrote
I thing I found something, because gemini wrote scritp with gemini aliases although knew from me that
  parametter -a is now killed and add epoch to gemini list. I do not understand, when did PHP with gemini CLI as coder was very fine, now quite often stucked, making mistakes on easy tasks. Maybe is problem with me or google started to do anything terible (gemini updated today). after 1, 2, I will refresh session here and we can repair.

  My suspect is model gemini-3.1-pro-preview

### 1.2. Vegas recomendation

1. Directory-Bound Default Personas:
      If your workspace has a local configuration (e.g., .gemini.json, .gemini.toml, or a .env file in the directory
  where you start the shell), check if it defines a default persona. In many advanced CLI orchestrators, running the
  naked gemini command inside /home/hruzam/vacuole automatically spawns you as the specific vacuole agent, and in
  /home/hruzam/reposoma as the reposoma agent, without needing command flags.
   2. Clean-Slate Command Sessions:
      If you must work through the orchestrator but want to stop token bleeding, run a session reset (such as a
  /clear or /reset slash-command if supported, or starting a completely fresh terminal command line) frequently.
  Resetting the session history drops your token window back to baseline instantly.
   3. Local Shell Wrappers:
      You can inspect the wrapper scripts in raw.superset/bin/ (like the gemini entry point). If the orchestrator
  accepts an environment variable (e.g., GEMINI_AGENT=astrobley or AGENT_PERSONA=astrobley), you can create a simple
  alias in your ~/.zshrc:

   1     alias gemini-astrobley="GEMINI_AGENT=astrobley gemini"
      This bypasses flag restrictions by instructing the backend engine directly before initialization!

### 1.3. task for Vega

Nice, than please                                                                                                
   1. do for me new zsh subfolder ai and there `gemini-base.zsh` this will be global aliases and common function    
   script which I will wire to my config.zsh -> designed for most common gemini CLI based operations. Put there all 
   aliases (if they have kebab case names some shortcuts be fine) for all gemini agents.                            
   2. and one more common ai.zsh which will be wired to config.zsh and will be used as chain gate f.e. for just     
   created script `harness-check.zsh` or in point 1. mentioned `gemini-base.zsh`. All wiring aliases in common      
   script needs to have it own partition in script. Less notes and descriptional frontmatters -> this belonging to  
   `@/home/hruzam/.config/zsh/guides/ai.md`, you can add here also the part you've just gave me about token         
   hygiene.                                                                                                         
   --> questions? 

---

# 2. to Atlas as substrate

## 2.1. Optimal Scope of Use for Gemini Models
When selecting Gemini models for your development workflows, you must balance raw reasoning power against execution speed, stability, and token costs. Google separates these capabilities into distinct tiers (Pro, Flash, and Flash-Lite) across different generational model lines. [1, 2] 
Given the current stability and connection issues with the newer Gemini 3/3.5 preview endpoints in CLI configurations (such as endpoint mapping bugs and automatic session downgrades), sticking to the mature Gemini 2.5 line is highly recommended for production-grade coding tasks. [2, 3] 
### 2.1.1. Gemini 2.5 Line (Recommended for Stable Coding & CLI Agents)

* Optimal Scope: Local terminal automations, complex codebase reasoning, syntax-heavy tasks, and multi-file code execution.
* Why Use It: The API endpoints are fully stabilized (Generally Available), meaning they do not drop connections mid-task or struggle with unexpected endpoint schema variations like the 3.5 preview builds. [2, 4, 5, 6] 

### 2.1.2. Gemini 3 / 3.5 Line (Best for Agentic Actions & Complex Workflows) [7]

* Optimal Scope: Native sub-agent workflows, browser/desktop automation via Computer Use, and massive multi-modal parallel operations.
* Why Avoid for CLI Coding Right Now: These frontier models utilize a complex "Planning/Thinking Mode" and native multi-step orchestration that frequently triggers timeout errors, rate-limit failures, or silent fallbacks within simpler CLI agent builds. 

------------------------------
### 2.1.3. Comparison Matrix: Gemini 3.x vs. Gemini 2.x
This side-by-side comparison focuses strictly on terminal-ready definitions (API Model IDs) required to explicitly set your model via environment variables or CLI flags. 

| Feature / Grade  | Gemini 3 / 3.5 Series (Preview / Agentic) | Gemini 2.5 Series (Stable / Recommended) |
|---|---|---|
| Pro Grade (Highest Reasoning) | gemini-3.1-pro gemini-3.0-pro | gemini-2.5-pro gemini-2.5-pro-preview |
| Flash Grade (Speed & Efficiency) | gemini-3.5-flash gemini-3.1-flash | gemini-2.5-flash |
| Flash-Lite Grade (Lowest Latency) | gemini-3.1-flash-lite | gemini-2.5-flash-lite |
| Specialized Variant (Automation) | gemini-3.5-flash (with built-in computer_use) | gemini-2.5-computer-use |
| Context Window | 1,000,000 Tokens | 1,000,000 Tokens |
| CLI Stability Status | Low (High risk of API dropouts / timeout blocks) | High (Stable production endpoints with fixed schemas) |

------------------------------
## 2.2. Terminal Implementation Example
To permanently step back to the stable 2.5 line for your main agent build without hitting the 3.5 preview errors, configure your export sequence using the exact terminal definitions provided above: [2] 

### 2.2.1. Force the CLI to use the rock-solid 2.5 Pro version

```zsh
export GEMINI_MODEL="gemini-2.5-pro"
GEMINI_AGENT=astrobley gemini
```

---

### 2.2.2. Zsh Scripts and Automation Examples
Here are three tailored Zsh configurations designed to lock your model choices, bypass broken endpoints, and automatically clear frozen CLI agent caches.

#### Option A: Persistent Zsh Functions (~/.zshrc)
Add these to your ~/.zshrc file. They allow you to launch your custom agent build (astrobley) under a specific, locked model tier without typing out the full export string every time.

**Run main agent with the ultimate coding/architect model**
function gemini-architect() {
    export GEMINI_MODEL="gemini-2.5-pro"
    echo " -> Launching Main Agent [astrobley] via Stable Architect Model: $GEMINI_MODEL"
    GEMINI_AGENT=astrobley gemini "$@"
}

**Run main agent with the fast "scalpel" model for quick edits**
function gemini-scalpel() {
    export GEMINI_MODEL="gemini-2.5-flash"
    echo " -> Launching Main Agent [astrobley] via Fast Scalpel Model: $GEMINI_MODEL"
    GEMINI_AGENT=astrobley gemini "$@"
}

Usage in terminal: gemini-architect --explain-code or gemini-scalpel "fix typo in index.js"

---

#### Option B: Automated Session Recovery Script (gemini-reset.sh)
If your CLI agent hangs due to the known Gemini 3.5 API runtime issues or context bloat, this standalone script kills the stuck processes and flushes the corrupt context cache.

```zsh
#!/usr/bin/env zsh

echo " Cleaning up frozen Gemini CLI processes..."
pkill -f "gemini" 2>/dev/null

echo " Flushing local agent cache and temporary session files..."
rm -rf ~/.cache/gemini-cli/* 2>/dev/null
rm -rf /tmp/gemini-* 2>/dev/null

if command -v gemini &> /dev/null; then
    echo " Resetting CLI internal configuration state..."
    gemini config reset --silent 2>/dev/null
fi

echo " Setting fallback environment to stable 2.5-pro..."
export GEMINI_MODEL="gemini-2.5-pro"

echo " Done! System ready for a clean run."
```
------------------------------

## 2.3. Expanded Model Matrix with Architectural Scopes
Below is the definitive matrix mapping the precise terminal API IDs to their optimized, explicit development roles.

| Feature / Grade | Gemini 3 / 3.5 Series (Preview / Agentic) | Gemini 2.5 Series (Stable / Production) | Operational Persona & Codebase Scope |
|---|---|---|---|
| Pro Grade (Highest Reasoning) | gemini-3.1-pro gemini-3.0-pro | gemini-2.5-pro gemini-2.5-pro-preview | The Project Architect • Multi-file code generation • Structural refactoring • Finding hidden architectural bugs |
| Flash Grade (Speed & Efficiency) | gemini-3.5-flash gemini-3.1-flash | gemini-2.5-flash | The Coding Scalpel • Single-function optimization • Writing unit tests • Fast regex and syntax adjustments |
| Flash-Lite Grade (Lowest Latency) | gemini-3.1-flash-lite | gemini-2.5-flash-lite | The Linter / Boilerplate Generator • Real-time inline code completion • Writing simple boilerplate • Log parsing and terminal log triage |
| Specialized Variant (Automation) | gemini-3.5-flash (with computer_use) | gemini-2.5-computer-use | The Automation Operator • End-to-end integration testing • Browser-based UI debugging • Bash script execution pipelines |

---

## 2.4.

For your Agent Builder, here are the essential environment flags and configuration mechanisms designed to control the Gemini CLI directly from the terminal or orchestration scripts.

### 2.4.1. Context Window Management (Token Reduction)
When running a Flash model as a fast "scalpel," you want to prevent it from loading the entire project history or massive unneeded source files for a simple edit. Restricting the context slashes Time-to-First-Token (TTFT) latency and prevents session crashes.

* GEMINI_MAX_CONTEXT_TOKENS: Hard-caps the total input window size. If the conversation or file tree exceeds this, the CLI drops the oldest history items.
* GEMINI_MAX_OUTPUT_TOKENS: Limits the length of the generated response, forcing the model to provide dense code instead of verbose explanations.

### 2.4.2. Configuration for an ultra-fast "scalpel" agent (small context, instant response)
export GEMINI_MODEL="gemini-2.5-flash"
export GEMINI_MAX_CONTEXT_TOKENS=16384     # Caps input to roughly 12,000 words
export GEMINI_MAX_OUTPUT_TOKENS=1024       # Keeps output short, punchy, and code-centric

### 2.4.3. Hyperparameters (Code Precision vs. Creativity)
For coding and system architecture tasks, minimizing hallucinations is critical. Default model settings are often too creative for deterministic environments. Your Agent Builder should enforce low temperature values for strict code generation.

* GEMINI_TEMPERATURE: Setting this between 0.0 and 0.2 ensures the model delivers predictable, repeatable syntax and sticks strictly to your instructions.
* GEMINI_TOP_P and GEMINI_TOP_K: Controls the token sampling pool. Keeping these tightly constrained prevents the model from choosing uncommon or experimental code patterns.

### 2.4.4. Strict developer mode to eliminate creative deviations
export GEMINI_TEMPERATURE=0.1
export GEMINI_TOP_P=0.95

### 2.4.5. CLI Stream Control and Role Injection
These flags assist your main agent in parsing terminal outputs and injecting behaviors on the fly without touching physical configuration files.

* GEMINI_SYSTEM_INSTRUCTION: Injects a global system prompt directly via the environment. This bypasses or overrides standard GEMINI.md logic, allowing your Agent Builder to change the agent's persona dynamically.
* GEMINI_STREAM: Toggles real-time output streaming. If your builder script needs to capture raw output into a variable for secondary automation, always set this to false.

### 2.4.6. Injecting an instant, specialized role with streaming disabled for script capture
export GEMINI_STREAM=false
export GEMINI_SYSTEM_INSTRUCTION="You are a strict POSIX compliance linter. Output ONLY raw bash code blocks, no chat."

### 2.4.7. Quick Template for Your Agent Builder
Your Builder agent can combine these flags into a single inline execution string to spin up isolated, highly optimized tasks:

GEMINI_MODEL="gemini-2.5-flash" GEMINI_TEMPERATURE=0.0 GEMINI_MAX_CONTEXT_TOKENS=8192 GEMINI_AGENT=astrobley gemini "fix internal compiler error in main.go"

---

**ATLAS TASK 1**
1. Put  `raw.settings` as some separate card about gemini but not to `/home/hruzam/reposoma/raw.settings/raw.card.gemini-cli.md` - but with controlled frontmatter as have mentioned one. This can be controller from time to time. With `half_life_days: 45` 

**ATLAS TASK 2**
1. --allowed-tools cli argument and tools.allowed in settings.json are deprecated and will be removed in
   1.0: Migrate to Policy Engine: https://geminicli.com/docs/core/policy-engine/ --> same card as abowe or directly to gemini-cli (lefting to you to make decission).



