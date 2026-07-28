Here is the table of Gemini CLI models available as of June 19, 2026, focusing on the current Gemini 3.x generation. [1] 
Older models (Gemini 2.0 Flash/Lite) were retired earlier this month (June 1, 2026). For the best performance in the CLI, you should now target the 3.5 Flash and 3.1 Pro series. [2, 3, 4] 
## 📋 Gemini CLI Models (June 2026)

| Model Name [5, 6, 7, 8, 9] | CLI Model String | Best For... | Key Strength |
|---|---|---|---|
| Gemini 3.5 Flash | gemini-3.5-flash | 💻 Coding & Agents | Fastest. Best for loop-based coding agents & "action-first" tasks. |
| Gemini 3.1 Pro | gemini-3.1-pro | 🧠 Deep Research | Smartest. High reasoning capabilities for complex, ambiguous problems. |
| Gemini 3.1 Flash-Lite | gemini-3.1-flash-lite | ⚡ High Volume | Cheapest. Ultra-low cost for simple, repetitive background tasks. |
| Gemini 3.1 Custom | gemini-3.1-pro-preview-customtools | 🛠️ Tool Heavy | Tooling. Specialized variant for agents using many custom shell tools. |

CLI Tip: You can switch models in the Gemini CLI using the command:
/model gemini-3.5-flash (or your chosen model string)

------------------------------
## 💻 Optimal Choice for Coding: Gemini 3.5 Flash [10, 11]
Why: Released in May 2026, Gemini 3.5 Flash is explicitly designed to be the "workhorse" for engineering tasks. [6] 

* Performance: It outperforms the previous "Pro" models on coding benchmarks (like Terminal-Bench 2.1). [12, 13] 
* Behavior: It is tuned for "agentic loops"—meaning if you ask it to fix a bug, it is faster and more reliable at running the test -> fix -> verify cycle without getting stuck in over-thinking loops. [6] 
* Throughput: It generates code ~4x faster than Pro models, which is critical when you are waiting for a large refactor to complete in your terminal. [14] 

## 🧠 Optimal Choice for (Deep) Research: Gemini 3.1 Pro
Why: Released in Feb 2026, Gemini 3.1 Pro is the "Deep Think" powerhouse. [15, 16, 17] 

* Reasoning: It supports a thinking_level parameter (Low/Medium/High). For deep research, it performs an internal "monologue" to verify facts and logic before outputting the answer. [18, 19, 20, 21] 
* Context: It excels at synthesizing massive amounts of information (e.g., "Read these 50 PDFs and find the connection between X and Y") where accuracy is more important than speed.
* Ambiguity: Unlike Flash, which rushes to a solution, 3.1 Pro is better at asking clarifying questions or handling vague research prompts.

Recommendation:

* Use Gemini 3.5 Flash for 90% of your daily CLI work (coding, shell commands, quick answers).
* Switch to Gemini 3.1 Pro only when you need to solve a "stuck" logic problem or perform complex analysis. [22, 23, 24, 25] 


