# ollama-docs — substrate
_Fetched: 2026-07-10 | Mode: snapshot | Sources: 9/9_

---

## 16GB RAM shortlist

| model | tag | size | ctx | notes |
|-------|-----|------|-----|-------|
| qwen3 | qwen3:4b | 2.5GB | 256K | dense; thinking toggle (/set think); tool calling |
| qwen3 | qwen3:8b | 5.2GB | — | latest tag; tool calling; recommended default |
| qwen3 | qwen3:14b | 9.3GB | — | largest dense fit in 16GB |
| qwen3 | qwen3:30b | 19GB | 256K | MoE (A3B activated); over 16GB but lean on RAM if GPU-offloaded |
| llama3.2 | llama3.2:3b | ~2GB | — | compact; tool support |
| gemma3 | gemma3:4b | ~3GB | — | vision support; single-GPU |
| mistral | mistral:7b | ~4GB | — | v0.3; tool support |
| qwen2.5-coder | qwen2.5-coder:7b | ~4GB | 128K | code-focused |

Note: qwen3:30b-A3B activates only 3B parameters at inference — may run within 16GB RAM
with sufficient GPU VRAM offload despite 19GB model size.

---

## Ollama CLI essentials

```bash
# Install (Linux)
curl -fsSL https://ollama.com/install.sh | sh

# Core commands
ollama run <model>          # pull (if needed) + interactive chat
ollama pull <model>         # pre-download model
ollama list                 # list downloaded models
ollama show <model>         # model info (parameters, template, etc.)
ollama rm <model>           # remove model
ollama serve                # start server daemon (default: localhost:11434)
ollama ps                   # list running models

# Integration launches (v0.30.11+)
ollama launch claude        # Claude Code auto-install
ollama launch openclaw      # OpenClaw AI assistant

# In-session parameters
/set parameter num_ctx 40960     # set context window
/set parameter num_predict 32768 # max output tokens
/set think                       # enable thinking mode (qwen3-2504 models)
/set nothink                     # disable thinking mode

# Docker
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
```

---

## API endpoints

Base URL: `http://localhost:11434`

| method | path | description |
|--------|------|-------------|
| POST | /api/generate | Single-turn text generation |
| POST | /api/chat | Multi-turn chat; supports tools, images, streaming |
| POST | /api/embeddings | Generate embeddings |
| GET | /api/tags | List downloaded models |
| POST | /api/show | Model info |
| POST | /api/pull | Download model |
| POST | /api/push | Push model to registry |
| DELETE | /api/delete | Remove model |
| POST | /api/copy | Copy model |

⚠ Feed flag: docs.ollama.com/api returned intro page only — endpoint table above is
from prior knowledge; not fully verified this run. Fetch docs.ollama.com/llms.txt
on next run to confirm full current endpoint list.

### Generate (key fields)
```json
POST /api/generate
{
  "model": "qwen3:8b",
  "prompt": "Why is the sky blue?",
  "stream": false,
  "options": { "num_ctx": 8192, "temperature": 0.7 }
}
```

### Chat with tools
```json
POST /api/chat
{
  "model": "qwen3:8b",
  "messages": [{"role": "user", "content": "What's the weather?"}],
  "tools": [{
    "type": "function",
    "function": {
      "name": "get_weather",
      "description": "Get current weather",
      "parameters": { "type": "object", "properties": { "location": {"type": "string"} } }
    }
  }]
}
```
Response contains `tool_calls` array. Append tool result as `role: "tool"` message, then re-request.

---

## Tool calling patterns

Three patterns supported:

1. **Single-shot** — model calls one tool, result appended, final answer returned
2. **Parallel** — model calls multiple tools simultaneously before consolidating
3. **Multi-turn agent loop** — model autonomously decides when to invoke tools across N turns

Streaming: accumulate `thinking` + `content` + `tool_calls` across all chunks before
processing. Python SDK auto-parses function signatures as tool schema.

---

## OpenAI compatibility layer

Base: `http://localhost:11434/v1/`

```python
from openai import OpenAI
client = OpenAI(base_url='http://localhost:11434/v1/', api_key='ollama')
```

| endpoint | status | notes |
|----------|--------|-------|
| /v1/chat/completions | ✅ | streaming, JSON mode, vision (base64), tools |
| /v1/completions | ✅ | streaming |
| /v1/models | ✅ | lists local models |
| /v1/embeddings | ✅ | |
| /v1/images/generations | ⚠ experimental | |
| /v1/responses | ✅ | non-stateful; added v0.13.3 |

Gaps vs OpenAI API:
- Vision: base64 only — no image URLs
- No logprobs
- No `tool_choice`, `logit_bias`, `n` parameters
- api_key required but ignored

---

## Modelfile syntax

```dockerfile
FROM llama3.2                          # required; base model or path to GGUF/Safetensors
PARAMETER temperature 0.7              # inference parameter
PARAMETER num_ctx 8192                 # context window
PARAMETER top_k 40
PARAMETER top_p 0.9
PARAMETER stop "<|im_end|>"
PARAMETER repeat_penalty 1.1
PARAMETER num_predict 2048
REQUIRES 0.14.0                        # minimum Ollama version (new instruction)
SYSTEM """You are a helpful assistant."""
TEMPLATE """{{ .System }}{{ .Prompt }}{{ .Response }}"""
ADAPTER /path/to/lora.gguf             # LoRA adapter (Safetensors or GGUF)
MESSAGE user "Hello"
MESSAGE assistant "Hi! How can I help?"
LICENSE """MIT"""
```

Instructions are case-insensitive and order-independent. TEMPLATE uses Go template syntax.
Key variables: `{{ .System }}`, `{{ .Prompt }}`, `{{ .Response }}`.

---

## Qwen3 family map

### Qwen3-2507 (current — July 2026 release)

| variant | sizes | ctx | notes |
|---------|-------|-----|-------|
| Qwen3-Instruct-2507 | 4B, 30B-A3B, 235B-A22B | 256K→1M | instruction following, tool use, 100+ languages |
| Qwen3-Thinking-2507 | 4B, 30B-A3B, 235B-A22B | 256K→1M | SOTA open-weight reasoning; math/science/coding |

Both support tool calling and agent mode.

### Qwen3-2504 (prior release — still on Ollama)

| tag | params | size | notes |
|-----|--------|------|-------|
| qwen3:0.6b | 0.6B | 523MB | dense |
| qwen3:1.7b | 1.7B | 1.4GB | dense |
| qwen3:4b | 4B | 2.5GB | dense; 256K ctx |
| qwen3:8b | 8B | 5.2GB | dense; **latest tag** |
| qwen3:14b | 14B | 9.3GB | dense |
| qwen3:30b | 30B | 19GB | MoE (A3B activated); 256K ctx |
| qwen3:32b | 32B | 20GB | dense |
| qwen3:235b | 235B | 142GB | MoE (A22B activated); 256K ctx |

Total Ollama variants: 58 (quantization tiers).

### Thinking mode (Qwen3-2504 models)
```
/set think    # enable extended reasoning (slower, higher quality)
/set nothink  # disable thinking (faster, standard output)
```

---

## Agentic use patterns

### Minimal local agent (Python)
```python
from openai import OpenAI
client = OpenAI(base_url='http://localhost:11434/v1/', api_key='ollama')

def agent_loop(tools, messages):
    while True:
        resp = client.chat.completions.create(
            model="qwen3:8b", messages=messages, tools=tools
        )
        msg = resp.choices[0].message
        if not msg.tool_calls:
            return msg.content
        for tc in msg.tool_calls:
            result = dispatch(tc.function.name, tc.function.arguments)
            messages.append({"role": "tool", "content": result,
                             "tool_call_id": tc.id})
```

### Context tuning for agents
```bash
# In Modelfile or via /set parameter
PARAMETER num_ctx 32768      # agent loops need larger context
PARAMETER num_predict 4096   # allow longer tool reasoning chains
PARAMETER temperature 0.2    # lower for deterministic tool calls
```

### Streaming agent with thinking accumulation
Gather all chunks before processing: accumulate `thinking`, `content`, and `tool_calls`
fields across the full stream, then return consolidated fields in follow-up requests.

---

## Arch Linux notes

Install via script (AUR or official script — verify source):
```bash
curl -fsSL https://ollama.com/install.sh | sh
# Creates: systemd service (ollama.service), user (ollama), group (ollama)
```

Systemd management:
```bash
systemctl enable --now ollama   # start + enable on boot
systemctl status ollama
journalctl -u ollama -f         # live logs
```

GPU access on Arch — ensure user is in `video` group:
```bash
usermod -aG video $USER
```

NVIDIA on Arch: requires `nvidia` or `nvidia-dkms` package + CUDA.
AMD on Arch: ROCm support via `rocm-opencl-runtime`.
CPU-only fallback: works without GPU but significantly slower.

---

## Run metadata
- Feed flags: ollama-api-docs (docs.ollama.com/api returned intro only — full endpoint
  table partially from prior knowledge; add docs.ollama.com/llms.txt to sources on next pass)
- Manual-check (not fetched): none
- First run — no prior substrate for cross-reference
