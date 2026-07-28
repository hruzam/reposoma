Here is the comparison and technical details regarding the models, the Antigravity CLI architecture, and the   
  headless execution mode.
  ──────
  ### 1. GPT-OSS 120B (Medium) vs. Gemini Models
  
  (Claude excluded per request)
  
   Feature        │ GPT-OSS 120B (Medium)            │ Gemini 3.5 Flash        │ Gemini 3.1 Pro
  ────────────────┼──────────────────────────────────┼─────────────────────────┼─────────────────────────────────
   Developer      │ OpenAI                           │ Google DeepMind         │ Google DeepMind
   Type           │ Open-weight (Apache 2.0)         │ Proprietary             │ Proprietary
   Architecture   │ ~117B Mixture-of-Experts (MoE)   │ Dense speed-optimized   │ Dense reasoning-focused
   Context Window │ 128k tokens                      │ 1,000,000 tokens        │ 1,000,000 to 2,000,000 tokens
   Reasoning Mode │ Full internal Chain-of-Thought   │ Standard / Fast Agentic │ Three-Tier Thinking
                  │ (CoT)                            │                         │ (Low/Med/High)
  
  #### Capabilities & Strengths:
  
  • GPT-OSS 120B (Medium): High reasoning depth relative to its size, optimized for single-GPU deployment (using 
  MXFP4 quantization to fit into 80GB VRAM). Its open-weight nature allows for complete privacy, customization,  
  and local hosting. You get full visibility into the Chain-of-Thought reasoning steps, which is valuable for    
  debugging agent pipelines.
  • Gemini 3.5 Flash (Medium): The speed-optimized "frontier" engine. It features an enormous 1M token context   
  window and is highly optimized for fast, iterative tool calling and coding tasks. Despite being a "Flash" model,
  it frequently matches or outperforms older Pro models on agentic benchmarks due to modern instruction tuning.  
  • Gemini 3.1 Pro: The flagship reasoning model designed for massive codebase analysis. Its multi-million token 
  context and deeper reasoning capabilities make it suitable for long-horizon planning and processing huge       
  amounts of structural context without losing performance.
  
  #### Adding Other Models:
  
  Yes, you can add models that are not in the default visual list:
  
  1. Direct CLI Invocation: Use the  --model  flag with the provider prefix (e.g.,  ollama/  or  openrouter/ ):  
    agy --model "ollama/llama3.1:8b"
    agy --model "openrouter/meta-llama/llama-3-70b-instruct"
  
  2. Configuration: You can add custom endpoints by modifying your configuration file config.toml:            
    model = "ollama/llama3.1:8b"
    base_url = "http://localhost:11434"
  (Ensure API keys like  OPENROUTER_API_KEY  are exported in your environment for remote third-party APIs).      
  ──────
  ### 2. Technical Difference: Gemini CLI vs. Antigravity CLI
  
  Instead of standard packaging changes, the core architectural principles differ as follows:
  
  • Runtime & Language: Gemini CLI was built on Node.js, whereas Antigravity CLI ( agy ) is written in Go. This  
  makes  agy  significantly faster, less resource-heavy, and more responsive when running in server environments 
  or over SSH.
  • Sequential vs. Asynchronous Orchestration: Gemini CLI operated on a single-agent, synchronous block.         
  Antigravity CLI uses a multi-agent orchestration engine. It runs background tasks, handles background file     
  system monitoring, and coordinates concurrent subagents (such as the  research  or  self  subagents) without   
  blocking your primary terminal user interface (TUI).
  • Context Differential Compiling: Rather than sending complete file contents repeatedly on every turn,  agy    
  interacts with a local file system daemon to track AST changes and git diffs. It performs selective chunk      
  compression and targeting (using precise operations like  replace_file_content  instead of rewriting whole     
  files), which keeps token consumption efficient during continuous coding sessions.
  ──────
  ### 3. Headless Regime and the  -p  Flag
  
  The  -p  (or  --print  /  --prompt ) flag runs  agy  in a non-interactive, single-turn headless mode.          
  
  #### The "Penalties" and Trade-offs of  -p :
  
  1. Context Loss / Higher Token Burn: Using  -p  runs an isolated, stateless execution. Because it does not     
  preserve the session context or model history across calls, running sequential commands via  -p  requires      
  sending your full workspace state and instructions repeatedly. You lose the benefit of the persistent agent    
  memory cache, resulting in higher token costs and slower responses.
  2. Tool-Execution Blocking: Antigravity CLI requires interactive confirmation prompts for sensitive tools (file
  edits, shell commands). In headless  -p  mode, the process will hang indefinitely waiting for input unless you 
  explicitly bypass permissions using the  --dangerously-skip-permissions  flag or restrict tools via  --sandbox .
  3. No Asynchronous Features: Long-running background operations, reactive notifications, and subagent          
  delegation ( invoke_subagent ) are disabled or truncated in headless mode, as the CLI terminates immediately   
  after outputting the first response.
  ──────
  ### Summary of Work
  
  1. Researched the capabilities, architecture, and specifications of the  GPT-OSS 120B  model against the Gemini
  3.5/3.1 series.
  2. Provided instructions on how to configure third-party endpoints (Ollama, OpenRouter) via config.toml and 
  CLI flags.
  3. Detailed the architectural shift from Node.js-based Gemini CLI to Go-based Antigravity CLI.
  4. Explained the mechanics and trade-offs of headless  -p  execution.
