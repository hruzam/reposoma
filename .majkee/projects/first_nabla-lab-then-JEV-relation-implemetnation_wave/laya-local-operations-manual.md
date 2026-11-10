# Laya on majkee’s local machines

Research and CLI-agent installation manual · 7 November 2026 · Agent: Wave

## 1. Decision

**Run the decision model on office first, using CPU PyTorch and one explicitly selected checkpoint. Home is also a plausible CPU inference host.** Download software and weights once; inference can then run offline on the PC. A CLI here means the terminal on that PC, not a cloud CLI or hosted inference service.

This document prepares installation; it does not report an installation on either host. Neither host was accessed or benchmarked. In the research workspace, Python 3.12.14 was available, but torch, transformers, huggingface_hub and laya were absent. No model weights were downloaded and no inference or training was run.

### The two projects named Laya

| Item | What it is | Role in this installation |
|---|---|---|
| [aayushch/laya](https://github.com/aayushch/laya) | Local notification and productivity application; uses LLM backends including Ollama and LM Studio | Unrelated application; do not clone it to run these weights |
| [convaiinnovations/laya](https://huggingface.co/convaiinnovations/laya) | Open-weight structured decision checkpoints | The requested model family |
| [NandhaKishorM/laya](https://github.com/NandhaKishorM/laya) | Python runtime, CLI, HTTP service, evaluation and training tools for those checkpoints | The correct implementation |
| Ollama | A separate model runtime/server | Not required for this path; do not assume these checkpoints can be loaded with `ollama run` |

The notification application consumes an inference backend; it is not an alternative implementation of Ollama’s inference libraries. The decision model’s own runtime supplies the local loading and inference path we need. Its HTTP API is a typed-decision API, not a general chat-completions API.

### Recommended shape

Start with a direct Python process or interactive local CLI. Once repeated use justifies it, keep one local HTTP process alive and let your agents call it. Avoid a new model process per classification and a separate model copy per agent.

A local script or agent sends a request to a local Laya process. That process reads a local checkpoint and returns JSON decisions. Model inference does not require an OpenAI, Anthropic or hosted Hugging Face inference account.

## 2. What the model does

Laya’s original checkpoints use encoder models with decision heads. Supply a state and questions with a finite answer space. It scores answers without generating a prose response token by token.

| Primitive | Requested answer | Typical use |
|---|---|---|
| `choice` | One named option and probabilities | Route a ticket to billing, technical or another team |
| `score` | Ordinal level / score over supplied criteria | Rate urgency |
| `noul` | Probability of a true/yes outcome | Detect an explicitly defined property |

This makes it a candidate for small local routing and classification tasks around your agent workflow. It cannot replace a general coding agent. A closed output space removes prose parsing problems; it does not prevent wrong decisions.

The runtime metadata and the requested model card declare Apache-2.0. Keep their license notices with redistributed artifacts. Open weights do not by themselves establish that the entire training-data pipeline is available or independently reproducible.

The publisher describes reinforcement learning with proper scoring rules and probability calibration. That is a training objective, not proof that a reported probability is correct on your inputs. Calibration depends on the task, data distribution, checkpoint and question wording.

### Original checkpoint family

The publisher’s verification manifest at the inspected source revision lists:

| Checkpoint | Encoder | Parameters | Weight file | Default token budget |
|---|---|---:|---:|---:|
| English | ModernBERT-large | about 421M | 842,609,210 bytes | 512 |
| Multilingual | mmBERT-base | about 322M | 643,835,514 bytes | 1,024 |
| Typed decisions | ModernBERT-large | about 421M | 842,609,220 bytes | 1,024 |

The English checkpoint is at the root of `convaiinnovations/laya`; the bundle also contains `multilingual/` and `typed-decisions/`. Separate Hub repositories are available for the latter two. The examples below use only the bundled repository, with one fixed revision, to avoid mixing repository-specific commit IDs.

For Czech and Spanish, start with multilingual. English is a useful English-only comparator. The typed-decisions specialization is not automatically best for an unrelated task. The multilingual checkpoint supports a larger budget up to 8,192 tokens through the runtime; use that only after measuring accuracy, truncation and RAM on representative documents. The question/options also consume the sequence budget.

### Runtime versions and the additional Vega lane

The inspected source snapshot identifies itself as **0.4.27**, at Git commit:

`4444f2f56acdd31a633d594e9f3227f853241d9e`

This is a verified source version, not a claim that the same version is currently published on PyPI. The Hugging Face card still describes older runtime releases. Recent source versions add a separate `vegaml` dependency and optional Vega reader; some Router paths enable that lane automatically. Those are additional models and behavior, not replacement weights for the original checkpoints.

For a reproducible first experiment, the scripts here use **`laya.Agent(local_directory, device="cpu")`**, without `vegaml=True`. The HTTP example explicitly constructs `Router(..., vega=False)`. Do not start the first experiment by enabling images, audio, video, all-model preload, TileLang or compilation.

### Material quality limits

Upstream documents label sensitivity, wrong answers on negated requests and weak ordinal scoring. The English `noul` primitive can follow generic option labels rather than the state. High reported confidence has occurred on incorrect negation answers. Guard presets have also missed instructions embedded inside ordinary-looking documents.

Use semantic choice labels or neutral `A`/`B` keys, test reversed option order, and include negated and quoted instructions. For a boolean decision, a two-option `choice` is a useful comparator to `noul`. Where using `noul`, define both outcomes explicitly and test neutral model-facing labels:

```json
{"type":"noul","instructions":"Does this message explicitly request a refund?","criteria":{"true":"the sender requests a refund","false":"the sender does not request a refund"},"labels":{"true":"A","false":"B"}}
```

Do not turn classification confidence into authority to execute shell commands, delete files or send messages. During evaluation, record suggestions and compare them with labels. Existing permissions and deterministic application checks remain in control.

## 3. Host assessment

Profiles read from `hruzam/reposoma`, branch `core`:

- [`raw.guides/machine-home/GUIDE.md`](https://github.com/hruzam/reposoma/blob/core/raw.guides/machine-home/GUIDE.md), file blob `7f1b56bc64070ad2f56fd3215a26ea315ca392b1`, verified 28 June 2026; explicitly marked stale.
- [`raw.guides/machine-office/GUIDE.md`](https://github.com/hruzam/reposoma/blob/core/raw.guides/machine-office/GUIDE.md), file blob `d221f7f44b382581eb740003d2e1ba6e3ec31489`, verified 15 July 2026.
- Home’s `resource-control.md`, blob `b3443483816a1c5a04cc5a3a06f749f69ee70a8c`, verified 29 June 2026.

| Host | Recorded hardware | Inference assessment | Training assessment |
|---|---|---|---|
| Office, `hruzam-120922` | i5-12400, 6 cores / 12 threads; 15 GiB RAM; NVMe | Preferred first host. One checkpoint on CPU should be practical for low-rate classification | Small frozen-encoder experiments are plausible; full fine-tuning is not a comfortable default without a suitable GPU |
| Home | Ryzen 5 3500U; 8 logical CPUs; 9.6 GB usable RAM | Plausible for one model, short requests, low concurrency, with desktop memory headroom | Limit to data preparation and small head-only pilots initially |

These are engineering estimates, not measured compatibility or speed results. Neither profile supplies a supported discrete GPU or VRAM inventory. Home’s Vega integrated graphics do not establish usable CUDA/ROCm acceleration. Use CPU first. These profiles describe Manjaro, so do not treat the hosts as freshly installed vanilla Arch.

The weight download size is not process RAM. FP32 parameter storage alone is roughly 1.57 GiB for 421M parameters or 1.20 GiB for 322M, before activations, intermediate tensors, loading peaks and Python/PyTorch. Provision several additional GiB for a pilot. Reserve roughly **4–6 GiB of available RAM and 10 GiB free disk** before a one-model trial, then replace those planning figures with measured peak RSS. Long sequences, more questions and concurrent processes can exceed this allowance.

Full FP32 Adam-style training can require roughly 16 bytes per trainable parameter for parameters, gradients and optimizer state before activations: about 6.3 GiB at 421M parameters. This estimate is not a training minimum. Actual peak use can be considerably higher.

Home’s resource guide contains claims that need correction before reuse: zswap requires backing swap; setting `zswap.enabled=1` alone does not provide swap capacity. Also, reducing an earlyoom free-memory trigger from 15% to 10% acts later. This installation does not change swap, bootloader, earlyoom, PHP services or desktop settings.

### Live preflight — run on the target PC

```bash
date -Iseconds
hostname
cat /etc/os-release
lscpu
free -h
swapon --show
df -h "$HOME"
python3 --version
command -v uv || true
command -v nvidia-smi || true
lspci -nn
```

Record results locally. Confirm physical cores and `MemAvailable`, not just installed RAM. Recheck free memory after starting the ordinary browser/editor workload. If an NVIDIA GPU is present, record `nvidia-smi`; choose a supported PyTorch build only after identifying the card and driver.

## 4. Install on the local PC

All paths below are proposed new paths. They do not override your project path registry. If putting this under an existing repository, first read its `AGENTS.md`, project state and handoffs, and inspect `git status --short` and `git diff`. Do not write over another agent’s work.

### A. Create an isolated Python environment

Use Python 3.12 for a conservative wheel-compatibility starting point. Do not use `sudo pip`, `--break-system-packages` or a global `pip install -U`.

If `uv` is already installed:

```bash
mkdir -p "$HOME/local/laya-lab"
cd "$HOME/local/laya-lab"
uv python install 3.12
uv venv --python 3.12 .venv
source .venv/bin/activate
python -m ensurepip --upgrade
python -m pip install --upgrade pip
```

Alternatively, if `python3.12` is already available:

```bash
mkdir -p "$HOME/local/laya-lab"
cd "$HOME/local/laya-lab"
python3.12 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

If neither is available, install a supported Python/uv using the host’s established package workflow. On Manjaro, avoid a partial repository upgrade just to install one package. A virtual environment does not fix a missing binary wheel for an unsupported Python version.

### B. Install CPU PyTorch, then the pinned Laya source

```bash
python -m pip install torch --index-url https://download.pytorch.org/whl/cpu
git clone https://github.com/NandhaKishorM/laya.git source
git -C source checkout --detach 4444f2f56acdd31a633d594e9f3227f853241d9e
python -m pip install './source[serve]'
python -m pip check
mkdir -p records models runs data
git -C source rev-parse HEAD > records/source-commit.txt
python -m pip freeze > records/requirements.lock.txt
python -m pip inspect > records/pip-inspect.json
```

The `serve` extra is for the later HTTP service. It can be omitted for a direct-Python-only experiment. A source pin fixes Laya’s code, but not its dependency resolution; the lock records the installed result. Rebuild from the recorded CPU index and lock, preferably with saved wheels, before calling the environment reproducible.

Check the actual installation:

```bash
python - <<'PY'
import importlib.metadata as m
import torch
for name in ('laya', 'torch', 'transformers', 'huggingface_hub', 'vegaml'):
    print(name, m.version(name))
print('CUDA build:', torch.version.cuda)
print('CUDA available:', torch.cuda.is_available())
print('CPU threads:', torch.get_num_threads())
PY
laya --help
laya-train --help
laya-evals --help
```

For the CPU installation, `torch.version.cuda` should be `None`. If dependency resolution replaced it with a CUDA build, resolve that in a fresh environment rather than downloading unused GPU dependencies indefinitely. Keep the working environment intact while diagnosing a candidate.

The Hub page’s autogenerated Transformers snippets are not the installation contract. The actual loader expects `rl_agent_config.json`, decision-head weights, an encoder config and a tokenizer. Use the Laya package’s loader.

## 5. Download and pin the original weights

The upstream verification manifest names bundled Hub revision:

`1c5edc17a7acd8701df6fc341c0d179f1c62c982`

This is a publisher-selected verification snapshot, not necessarily the newest Hub commit. It makes a stable baseline. Its listed weight hashes are:

| Variant | SHA-256 of `model.safetensors` |
|---|---|
| English | `891102d372688fc2a094dac56a384bc537b87c63f21f9f3dac0be2b7cbc8d86c` |
| Multilingual | `9d628fd971b700382ac6f65920a86f149777b2e748e0c955fb3b19695aa8f204` |
| Typed decisions | `4fa56de72383a9d3efa9cfa78955733c81b9fc8067a587ca4beb82c78107a24e` |

Do not apply a commit SHA from the bundled repository to a separate multilingual repository. GitHub code commits and Hugging Face weight commits are also different identities.

Save the following as `download_model.py` in the lab directory. Run it once per desired variant. It downloads only the checkpoint’s required artifacts, verifies the weight hash and records hashes for the complete downloaded payload. Existing target directories are refused. A failed download remains available for inspection under the hidden staging name; it is not promoted.

```python
import argparse
import hashlib
import json
import os
from pathlib import Path

def sha256(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()

def main():
    from huggingface_hub import snapshot_download
    p = argparse.ArgumentParser()
    p.add_argument('variant', choices=['english', 'multilingual', 'typed-decisions'])
    a = p.parse_args()
    revision = '1c5edc17a7acd8701df6fc341c0d179f1c62c982'
    hashes = {
        'english': '891102d372688fc2a094dac56a384bc537b87c63f21f9f3dac0be2b7cbc8d86c',
        'multilingual': '9d628fd971b700382ac6f65920a86f149777b2e748e0c955fb3b19695aa8f204',
        'typed-decisions': '4fa56de72383a9d3efa9cfa78955733c81b9fc8067a587ca4beb82c78107a24e',
    }
    prefix = '' if a.variant == 'english' else a.variant + '/'
    root = Path('models').resolve()
    root.mkdir(exist_ok=True)
    target = root / (a.variant + '-' + revision[:12])
    stage = root / ('.' + target.name + '.download')
    if target.exists() or stage.exists():
        raise SystemExit('Target/staging path already exists; inspect it before proceeding.')
    stage.mkdir()
    snapshot_download(
        repo_id='convaiinnovations/laya', revision=revision,
        allow_patterns=[prefix + x for x in (
            'model.safetensors', 'rl_agent_config.json', 'encoder/*', 'tokenizer/*')],
        local_dir=str(stage),
    )
    checkpoint = stage / prefix if prefix else stage
    actual = sha256(checkpoint / 'model.safetensors')
    if actual != hashes[a.variant]:
        raise SystemExit('Weight hash mismatch; staging was not promoted.')
    required = ['rl_agent_config.json', 'model.safetensors', 'encoder', 'tokenizer']
    for name in required:
        if not (checkpoint / name).exists():
            raise SystemExit('Missing artifact: ' + name)
    payload = {}
    for f in sorted(checkpoint.rglob('*')):
        rel = f.relative_to(checkpoint)
        if f.is_file() and '.cache' not in rel.parts:
            payload[rel.as_posix()] = sha256(f)
    manifest = {'repo': 'convaiinnovations/laya', 'revision': revision,
                'variant': a.variant, 'files': payload}
    (stage / 'download-manifest.json').write_text(
        json.dumps(manifest, indent=2) + '\n', encoding='utf-8')
    os.rename(stage, target)
    print(target / prefix if prefix else target)

if __name__ == '__main__':
    main()
```

```bash
python download_model.py multilingual
# Optional comparators; do not load them all at once on home:
python download_model.py english
python download_model.py typed-decisions
```

Choose the downloaded multilingual directory:

```bash
export LAYA_CHECKPOINT="$HOME/local/laya-lab/models/multilingual-1c5edc17a7ac/multilingual"
```

Preserve the original download as provenance. The Laya loader may normalize `tokenizer/tokenizer_config.json` for Transformers compatibility. For an experiment requiring byte-for-byte originals, make a separate working copy and record its post-normalization hashes. Do not mistake that normalization for trained weight changes; never silently re-baseline a changed `model.safetensors`.

## 6. Local inference and offline proof

### Direct Python smoke test

Save this as `smoke.py`:

```python
import json
import os
import time
import torch
import laya

torch.set_num_threads(int(os.environ.get('LAYA_THREADS', '2')))
questions = {
    'department': {
        'type': 'choice',
        'instructions': 'Which team should handle this message?',
        'criteria': {
            'billing': 'invoices, payments, duplicate charges, refunds',
            'technical': 'bugs, crashes, service outages',
            'other': 'messages outside these topics',
        },
    },
}
t0 = time.perf_counter()
agent = laya.Agent(os.environ['LAYA_CHECKPOINT'], device='cpu')
print(json.dumps({'load_seconds': time.perf_counter() - t0}), flush=True)
for text in [
    'We were charged twice. Please refund the duplicate.',
    'Aplikace se po otevreni nastaveni pokazde zavre.',
    'No quiero cancelar mi cuenta; solo quiero corregir la factura.',
]:
    t0 = time.perf_counter()
    result = agent.predict(text, questions)
    print(json.dumps({'state': text, 'wall_seconds': time.perf_counter() - t0,
                      'result': result}, ensure_ascii=False), flush=True)
```

Run on home with two threads; start office at four and compare two/four/six:

```bash
export HF_HUB_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
export HF_HUB_DISABLE_TELEMETRY=1
export LAYA_THREADS=2
export OMP_NUM_THREADS=2
export MKL_NUM_THREADS=2
python smoke.py > runs/smoke.jsonl
```

These environment variables refuse Hub access; they do not constitute a system-wide network firewall. For a stronger offline proof, run the same test with network access disabled in your normal local sandbox, or while the PC is disconnected. Do not change the host’s network or SSH configuration during a remote session merely to prove this.

A pass means: the process exits successfully, outputs valid decisions, records the selected local checkpoint and does not fetch additional models. It does not mean the three classifications are correct. Inspect every output, particularly the Spanish negation example. Run the English checkpoint separately on English text only; it is not the Czech-language baseline.

If `/usr/bin/time` is present, measure peak RSS:

```bash
/usr/bin/time -v -o runs/smoke-resources.txt python smoke.py > runs/smoke-measured.jsonl
```

Measure cold process load separately from warmed inference. Run representative short/medium/long inputs, including actual question counts. Report p50/p95/p99 only with enough repetitions; record CPU threads, competing workload and peak RSS. The publisher’s approximately 33 ms T4 GPU claim is not a CPU latency promise for either PC.

### Human-facing CLI

```bash
# Routing only; this does not prove that weights loaded:
laya 'Please refund the duplicate charge' --json

# Actual prediction, explicit model, interactive process keeps it loaded:
LAYA_REVISION=1c5edc17a7acd8701df6fc341c0d179f1c62c982 \
  laya --device cpu --model multilingual --preset triage --json
```

The upstream CLI uses the Hub cache, not `LAYA_CHECKPOINT`. The preceding downloader uses explicit local directories. Therefore a CLI prediction may require its own initial online cache population. Run it once online with the same revision, then repeat offline. For strictly local-directory loading, use `smoke.py` or the HTTP service below. `laya --model /some/path` is not the documented way to select an arbitrary checkpoint in this CLI.

### Script interface: one process, JSONL streams

For agent integration, save this as `predict_jsonl.py`. It loads the local model once, reads one JSON object per line and emits one result per line. Request errors are explicit and leave an overall nonzero exit status. Model-load errors terminate the process.

```python
import json
import os
import sys
import torch
import laya

torch.set_num_threads(int(os.environ.get('LAYA_THREADS', '2')))
agent = laya.Agent(os.environ['LAYA_CHECKPOINT'], device='cpu')
failed = False
for number, line in enumerate(sys.stdin, 1):
    if not line.strip():
        continue
    try:
        row = json.loads(line)
        if not isinstance(row, dict) or 'state' not in row or 'questions' not in row:
            raise ValueError('Each line must contain state and questions')
        result = agent.predict(row['state'], row['questions'])
        output = {'line': number, 'id': row.get('id'), 'result': result}
    except Exception as exc:
        failed = True
        output = {'line': number, 'error': type(exc).__name__, 'detail': str(exc)}
    print(json.dumps(output, ensure_ascii=False), flush=True)
sys.exit(2 if failed else 0)
```

```bash
python predict_jsonl.py < data/requests.jsonl > runs/predictions.jsonl
```

The request format can also be the labeled case format in section 8; `expected` is ignored during prediction. Keep diagnostics on stderr. Never interpret an error record as a negative classification.

Use direct subprocess calls at low frequency. For many agents, use one resident process with bounded requests. A shell tool calling the local endpoint is enough; MCP is optional.

## 7. Resident HTTP service on your PC

Save this as `serve_local.py`. This uses upstream HTTP handling with an explicitly constructed, encoder-only Router. Both built-in language routes point at the same selected local checkpoint so an automatic route cannot fetch another one. For useful language routing, later register separate local English and multilingual paths and measure their combined RAM.

```python
import os
from pathlib import Path
import torch
import uvicorn
from laya import Router
from laya.serve import create_app

path = Path(os.environ['LAYA_CHECKPOINT']).expanduser().resolve(strict=True)
if not (path / 'rl_agent_config.json').is_file():
    raise SystemExit('Not a complete Laya checkpoint directory')
torch.set_num_threads(int(os.environ.get('LAYA_THREADS', '2')))
router = Router(
    models={name: str(path) for name in ('english', 'multilingual', 'typed-decisions')},
    device='cpu', default='multilingual', max_loaded=1, preload=False,
    auto_task_detection=False, vega=False,
)
router.load('multilingual')
app = create_app(router)
uvicorn.run(app, host='127.0.0.1', port=8765, workers=1)
```

Run it from the activated local environment:

```bash
HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1 \
LAYA_MAX_CONCURRENT=2 LAYA_MAX_TOKEN_BUDGET=1024 \
  python serve_local.py
```

The shared alias mapping prevents extra downloads, but requesting a different alias can cause the same checkpoint to reload. Consumers should consistently request `model: "multilingual"`. The response’s routing name is an alias; record the actual directory and manifest when comparing weights.

In a second local terminal:

```bash
curl --fail --silent --show-error http://127.0.0.1:8765/health
curl --fail --silent --show-error http://127.0.0.1:8765/v1/systemone \
  -H 'Content-Type: application/json' \
  --data-binary @- <<'JSON'
{"model":"multilingual","state":"We were billed twice; please refund the duplicate.","questions":{"department":{"type":"choice","instructions":"Which team should handle this?","criteria":{"billing":"invoices, payments, refunds","technical":"bugs and outages","other":"other topics"}}}}
JSON
```

Keep one worker; extra workers duplicate model memory. A successful `/health` is a liveness check. Also run a representative prediction to verify readiness and the actual device. A request to use CUDA can fall back to CPU in upstream runtime behavior, so device requests are not evidence of GPU execution.

### Optional systemd user service

Create `~/.config/systemd/user/laya-local.service` after the foreground test passes. Replace `YOUR_USER` and paths with the actual result of `echo "$HOME"`; systemd environment entries are not shell expansion contexts.

```ini
[Unit]
Description=Local Laya decision service

[Service]
Type=simple
WorkingDirectory=%h/local/laya-lab
Environment=LAYA_CHECKPOINT=/home/YOUR_USER/local/laya-lab/models/multilingual-1c5edc17a7ac/multilingual
Environment=HF_HUB_OFFLINE=1
Environment=TRANSFORMERS_OFFLINE=1
Environment=HF_HUB_DISABLE_TELEMETRY=1
Environment=LAYA_THREADS=2
Environment=OMP_NUM_THREADS=2
Environment=MKL_NUM_THREADS=2
Environment=LAYA_MAX_CONCURRENT=2
Environment=LAYA_MAX_TOKEN_BUDGET=1024
ExecStart=%h/local/laya-lab/.venv/bin/python %h/local/laya-lab/serve_local.py
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

```bash
systemctl --user daemon-reload
systemctl --user start laya-local
systemctl --user status laya-local
journalctl --user -u laya-local -n 60 --no-pager
# Enable at login only after validation:
systemctl --user enable laya-local
# Routine operations:
systemctl --user stop laya-local
systemctl --user restart laya-local
```

Do not enable lingering or alter machine boot policy as part of the initial pilot. For home, consider a user-service `MemoryHigh`/`MemoryMax` only after measuring real startup peaks and verifying cgroup support; an arbitrary hard limit can create a restart loop.

### Use from the other PC

If normal authenticated SSH between your hosts already works, forward the loopback service rather than exposing another network listener:

```bash
# Run on the client PC; substitute the office SSH name already used in your setup:
ssh -N -L 8765:127.0.0.1:8765 OFFICE_SSH_NAME
```

Then call `http://127.0.0.1:8765` on the client. Inference remains on office. For direct network serving later, explicitly configure authentication and the network access policy; the initial service stays on loopback.

### Optional MCP

The correct runtime has `laya[mcp]` and `laya-mcp-server`; MCP is not necessary for local inference. Install the extra only in a candidate environment if wanted. Its client configuration should use the absolute virtual-environment executable. Follow the runtime’s `docs/cli-mcp.md` for the exact configuration. Prefer an HTTP-backed/shared arrangement when multiple clients would otherwise each spawn a model process. Do not assume an agent client’s MCP configuration syntax is identical across vendors or versions.

## 8. Evaluating checkpoints and weight changes

Separate five changes: **question definitions**, **selected checkpoint**, **calibration**, **trained parameters**, and **runtime/backend**. Change one axis per experiment. A trained checkpoint is not a loose `.safetensors` file: keep its matching config, encoder architecture and tokenizer.

### Dataset contract

Use UTF-8 JSONL. Each line is a case. The following is one complete example; write it as one physical line:

```json
{"id":"billing-en-001","language":"en","tags":["duplicate-charge"],"state":"We were charged twice; please refund the duplicate.","questions":{"department":{"type":"choice","instructions":"Which team should handle this message?","criteria":{"billing":"invoices, payments, refunds","technical":"bugs, crashes, outages","other":"other topics"}}},"expected":{"department":"billing"}}
```

Start by validating the schema:

```bash
laya-evals validate data/test.jsonl
```

Build a few hundred independently labeled cases before treating aggregate accuracy as useful. Keep Czech, English and Spanish slices where relevant. Include ordinary traffic, ambiguous/out-of-domain text, empty/very short input, spelling errors, quoted instructions, positive/negative pairs, long input with the decisive sentence near the end, and reordered/renamed options. Group near-duplicates, threads and templates in the same data split.

Maintain separate training, calibration and final test sets. If you repeatedly select candidates on a test set, it has become a development set; reserve another final holdout. Label disagreements are data to inspect, not errors to hide. A tiny smoke fixture verifies execution only.

### Full evaluator against an explicit local directory

Save as `evaluate_local.py`. This uses the upstream metrics rather than implementing a second metric engine. It expects a dataset with no per-row `model` override and uses the pinned source API.

```python
import argparse
import hashlib
import json
import os
from pathlib import Path
import torch
import laya
from laya import evals

p = argparse.ArgumentParser()
p.add_argument('dataset')
p.add_argument('output')
p.add_argument('--calibration')
a = p.parse_args()
output = Path(a.output)
if output.exists():
    raise SystemExit('Output exists; choose a new run directory.')
dataset = evals.Dataset.from_jsonl(a.dataset)
torch.set_num_threads(int(os.environ.get('LAYA_THREADS', '2')))
checkpoint = os.environ['LAYA_CHECKPOINT']
agent = laya.Agent(checkpoint, device='cpu', calibration=a.calibration)
report = evals.evaluate(agent, dataset, batch_size=1, on_error='fail', config={
    'dataset_sha256': hashlib.sha256(Path(a.dataset).read_bytes()).hexdigest(),
    'checkpoint': str(Path(checkpoint).resolve()), 'calibration': a.calibration,
    'threads': torch.get_num_threads(), 'device': str(agent.device),
})
output.mkdir(parents=True)
(output / 'report.json').write_text(
    json.dumps(report.to_json(), ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
(output / 'report.md').write_text(report.to_markdown(), encoding='utf-8')
```

```bash
python evaluate_local.py data/test.jsonl runs/multilingual-baseline
# Select a different complete local checkpoint, then run the same dataset:
LAYA_CHECKPOINT="$HOME/local/laya-lab/models/candidate-001" \
  python evaluate_local.py data/test.jsonl runs/candidate-001
laya-evals compare runs/candidate-001/report.json \
  --baseline runs/multilingual-baseline/report.json \
  --tolerance choice_accuracy=0.02
```

Choose the tolerance before evaluating; 0.02 is an example absolute margin, not a recommended universal acceptance rule. The compare command supplies a regression signal, not your complete promotion policy. Review the JSON and per-case errors. The upstream tool exits nonzero on a failed gate; do not discard the exit status.

For built-in Hub checkpoints, the official CLI also supports:

```bash
laya-evals run data/test.jsonl --model multilingual --device cpu \
  --revision 1c5edc17a7acd8701df6fc341c0d179f1c62c982 \
  --slice language --slice tag --json runs/hub-baseline.json
```

That CLI uses its cache. It does not automatically use `LAYA_CHECKPOINT`.

### What to compare

| Dimension | Record / decision |
|---|---|
| Correctness | Accuracy, macro/per-class performance, confusion matrix and important false positives/negatives |
| Probability quality | Brier score and ECE; keep the binning scheme and sample count fixed; inspect reliability by task/language |
| Ordinal outputs | MAE and within-one-level, not just exact accuracy |
| Review policy | Coverage and error among accepted answers; count abstentions explicitly |
| Robustness | Negation pairs, label/order sensitivity, truncation, out-of-domain cases |
| Performance | Cold load, warm p50/p95, peak RSS, throughput at the intended concurrency |
| Provenance | Code commit, dependency lock, checkpoint file hashes, question and dataset hashes, device and thread count |

A threshold flag can annotate an answer without removing its argmax. The application must actually honor the review/abstention field; do not infer that an answer was blocked because the configuration contained `min_confidence`. Do not gate on upstream `action.act_probability`, which upstream documents as unreliable.

## 9. Changing weights, calibration and training

### A. Select another published checkpoint

Download it into a new versioned directory. Update `LAYA_CHECKPOINT`, run the same tests, and keep the old directory. Restart the resident service to load the new model; changing an environment file does not replace parameters already in memory. Keep the same question schema for a fair comparison.

For a newer Hub revision, resolve the desired commit on the Hub, record it, download to a new staging directory and record SHA-256 hashes for all artifacts. Obtain the expected weight digest from an independently inspected publisher file entry if available. A locally computed hash identifies downloaded bytes; by itself it does not authenticate the publisher.

### B. Recalibrate probabilities without training weights

Temperature scaling changes confidence, normally leaving the selected argmax unchanged. It does not repair a classifier that consistently chooses the wrong label. Save a separate calibration JSON and bind it in your experiment record to the exact checkpoint/question/data hashes.

The verified runtime provides `laya.calibrate.records_from_labeled`, `Agent.fit_temperatures`, `Agent.save_calibration` and `Agent.load_calibration`. Records are raw per-question logits plus targets, not the rounded output probabilities. The following complete `calibrate_choice.py` handles hard-labeled `choice` questions with dictionary criteria in their default order. It deliberately refuses other primitive types and explicit option reordering; their target construction must follow their own option-order contract.

```python
import argparse
import json
import os
from pathlib import Path
import torch
import laya
from laya.calibrate import records_from_labeled

p = argparse.ArgumentParser()
p.add_argument('dataset')
p.add_argument('output')
a = p.parse_args()
if Path(a.output).exists():
    raise SystemExit('Calibration output exists; choose a new filename.')
pairs = []
for number, line in enumerate(Path(a.dataset).read_text(encoding='utf-8').splitlines(), 1):
    if not line.strip():
        continue
    row = json.loads(line)
    targets = {}
    for qid, question in row['questions'].items():
        if (question['type'] != 'choice' or
                not isinstance(question.get('criteria'), dict) or
                'option_order' in question):
            raise SystemExit(f'Line {number}: only dictionary choice/default order supported')
        labels = list(question['criteria'])
        gold = row['expected'][qid]
        if gold not in labels:
            raise SystemExit(f'Line {number}: unknown target {gold!r}')
        targets[qid] = [float(label == gold) for label in labels]
    pairs.append((row['state'], row['questions'], targets))
if not pairs:
    raise SystemExit('No calibration cases')
torch.set_num_threads(int(os.environ.get('LAYA_THREADS', '2')))
agent = laya.Agent(os.environ['LAYA_CHECKPOINT'], device='cpu')
with torch.no_grad():
    records = records_from_labeled(agent, pairs)
report = agent.fit_temperatures(records, compute_ece=True, seed=0)
agent.save_calibration(a.output)
print(json.dumps(report, default=str, indent=2))
```

```bash
python calibrate_choice.py data/calibration.jsonl calibration-domain-v1.json
python evaluate_local.py data/test.jsonl runs/calibrated-v1 \
  --calibration calibration-domain-v1.json
```

Use enough independent calibration examples per task/option-count bucket and inspect the fitter's low-count warnings. The minimum accepted by a fitter is not evidence of statistically reliable calibration. Do not fabricate raw logits by taking the log of rounded served probabilities. The complete training command below performs its own held-out calibration and is the simpler end-to-end path when you are already training.

Re-evaluate the calibrated candidate on untouched data using `evaluate_local.py --calibration calibration-domain-v1.json`. Do not reuse a calibration file after changing weights, tokenizer, labels, domain or backend without a fresh assessment. Upstream may warn and still load a mismatched calibration map; your release process must enforce compatibility.

### C. Frozen-encoder fine-tuning: first local training experiment

Use a real, labeled training set in the same JSONL schema. This changes the decision-head parameters while holding the encoder fixed. It still needs forward passes through the encoder and is not guaranteed to learn the task.

```bash
laya-train --data data/train.jsonl --base "$LAYA_CHECKPOINT" \
  --micro-batch 1 --grad-accum 8 --max-len 512 --dry-run

laya-train --data data/train.jsonl --eval data/dev.jsonl \
  --base "$LAYA_CHECKPOINT" --out models/head-candidate-001 \
  --freeze-encoder --device cpu --epochs 4 \
  --micro-batch 1 --grad-accum 8 --max-len 512 --seed 0 \
  > runs/head-candidate-001.log 2>&1
```

`--dry-run` checks data/tokenization and may need tokenizer/config artifacts; it is not a training benchmark. Reducing `max_len` is a real model-behavior change: use the same intended budget when evaluating the candidate. Do not point `--out` at the original download.

The run exports a complete checkpoint, training settings and calibration information. Inspect skipped rows, class counts, optimizer updates, loss, calibration warnings and before/after metrics. An epoch checkpoint is an exported model snapshot; do not assume that `checkpoint_latest/` includes optimizer/RNG state or guarantees exact interrupted-training continuation. The inspected CLI exposes no general `--resume` switch.

Train on `train`, use `dev` for selection, and run the chosen candidate once on final test. The trainer takes an internal calibration slice out of the training input. If you require a separately governed calibration split, inspect the pinned Python training API and explicitly control that workflow rather than assuming a nonexistent `--calibration-data` option.

### D. Full fine-tuning

Remove `--freeze-encoder` only after a small run demonstrates a learnable task and memory feasibility. On these recorded CPU hosts, this may be slow and memory-constrained. Do not buy hardware on an unmeasured estimate; measure a pilot or use an already available suitable GPU machine for training, then copy the complete exported checkpoint back for local CPU inference.

For a CPU full-fine-tune pilot, keep micro-batch 1 and start with short sequences. For an identified supported NVIDIA GPU, use the official PyTorch selector and a separate CUDA environment; set `--device cuda`, record VRAM and compare actual device use. No cloud inference service is needed in either case.

Changing individual tensor values by hand is not the normal adaptation procedure. It bypasses the training objective and calibration, and is unlikely to produce a useful controlled effect. Prefer training, temperature fitting or a checkpoint swap, depending on the problem.

### E. Optional Vega fitting is a separate experiment

Recent versions expose frozen-reader feature fitting through `Agent(vegaml=True).fit(...)` and calibration. That can be worth comparing with head-only training, but it loads different reader weights and changes the inference path. Give it its own environment, manifests, memory measurements and baseline. Do not mix Vega-only conformal `prediction_set`/`route` claims into the original encoder’s output contract.

## 10. Promotion, rollback and maintenance

### A release is a bundle of decisions

Keep the following together under a run/release directory:

- Runtime commit, Python version, dependency lock and wheel provenance.
- Complete checkpoint and file hashes; publisher repository/revision if applicable.
- Exact questions, token budgets, thread count, backend and calibration artifact.
- Data split identities/hashes, measured metrics, error review and promotion decision.
- Previous release path and rollback command.

Store large weights outside ordinary git history unless the repository deliberately uses a large-file system. Put source, question definitions and release manifests in git. Back up weights or a verified recoverable source, not only the virtual environment.

### Promotion procedure

1. Finish the candidate in a new directory and verify its artifacts.
2. Run the fixed correctness/robustness/resource evaluation; review important regressions.
3. Save the candidate’s complete environment/checkpoint/question/calibration identity.
4. Update the service’s `LAYA_CHECKPOINT` to the exact tested directory.
5. Run `systemctl --user daemon-reload` if the unit changed, then restart the service.
6. Check health and one real prediction; confirm actual model/device and memory.
7. Roll back immediately if the served result differs materially from the tested candidate.

Rollback: restore the former checkpoint/environment/calibration paths and restart. Replacing a symlink while the process is alive does not hot-swap the loaded model. Never overwrite the current weight file while serving it.

### Upgrade routine

Use a new environment for runtime upgrades. Review upstream changes, especially automatic model routing, checkpoint compatibility and dependency additions. Install the candidate code pin, run `pip check`, record a new lock, then run the existing evaluation against the same weights. Only afterward consider changing the weights. This distinguishes a runtime regression from a model change.

### Routine commands

```bash
systemctl --user status laya-local
journalctl --user -u laya-local -n 80 --no-pager
free -h
df -h "$HOME"
du -sh models runs source .venv
python -m pip check
sha256sum "$LAYA_CHECKPOINT/model.safetensors"
```

Keep request bodies out of general service logs by default when they contain private project data. Track duration, error code, checkpoint identity and queue/load observations. Maintain bounded log retention using the host’s established logging policy.

Before deleting old weights, confirm that no active service, previous-release reference or calibration artifact depends on them. Remove one named retired experiment directory at a time. Avoid clearing the entire shared Hugging Face cache to recover space.

### Stop and remove

Stop/disable the user service first. Preserve manifests, evaluation reports and any locally trained checkpoint before removing the lab environment. Remove only the service/unit and lab paths created for this project; do not remove shared Python, GPU drivers, caches or other applications.

## 11. Troubleshooting

| Symptom | Check / correction |
|---|---|
| `import laya` loads the wrong thing | Confirm active `.venv`, `python -m pip show laya`, and imported module path; a local `laya.py` file can shadow the package |
| Missing `rl_agent_config.json` | Wrong project, incomplete checkpoint, or parent directory supplied instead of `multilingual/` |
| Transformers suggests `LayaTypedDecisions` but import fails | Use the installed Laya loader; do not rely on autogenerated Hub snippets |
| Offline load tries a download | Missing local encoder/tokenizer files, wrong path, or a Router selected another model; use explicit local Agent |
| CLI says routing succeeded but no weights exist | Routing-only mode is not inference; use `--predict`, a preset or the direct smoke script |
| CPU slower than expected | Compare 2/4/6 physical-core threads; separate load time; reduce input and option counts; avoid one process per request |
| Process killed or desktop stalls | Inspect available RAM, peak RSS and OOM logs; reduce batch/concurrency; stop all-model preload |
| Server repeatedly reloads | Consistent model alias, one checkpoint; inspect cache cap and request model names |
| GPU requested but no speedup | Inspect actual device, supported GPU and installed torch build; do not infer from requested flags |
| High confidence, wrong answer | Inspect negation, label/order bias and distribution shift; recalibration alone cannot fix wrong argmax |
| Training looks good, final result fails | Check split leakage, duplicate templates, question drift and whether selection used calibration data |
| Quantized/exported model differs | Treat export/quantization as a new candidate and repeat accuracy/calibration tests |

ONNX is a possible later CPU optimization. It is not required to establish local feasibility. Export uses the complete matching checkpoint/config/tokenizer; quantization changes numerical behavior. Follow the pinned `scripts/export_onnx.py --help` and `docs/fast-backends.md`, and compare against eager CPU before promoting it. Do not assume a GGUF conversion or llama.cpp backend supports this decision-head architecture.

## 12. Brief for the local installing agent

**Goal:** Install original Laya decision-model CPU inference locally, starting on office; preserve rollback and provide measured evidence.

**Scope:** A new isolated lab directory and optional user service. Do not install the unrelated notification application. Do not change global Python, GPU drivers, swap, network policy or existing agent configuration as incidental setup.

**Execute:** Inspect repository/host state; run preflight; install pinned runtime in a fresh environment; download multilingual at the pinned Hub revision and verify its weight digest; run explicit local inference offline; measure startup/RSS/warm latency; evaluate a fixed labeled fixture; then propose or enable the resident service within majkee’s requested scope.

**First acceptance:** Complete checkpoint loads, JSON decisions are produced offline, no unintended reader/checkpoint downloads occur, the machine remains usable, and the report states actual device, memory, timing and semantic failures. No invented pass claim if weights or dependencies could not be obtained.

**Leave:** An installation record, question/data files, hashes/locks and the following handoff. Commit project-managed changes using that repository’s rules; do not stage unrelated edits.

## AI HANDOFF

**Goal:** Research and prepare local Laya installation and operation on majkee’s hosts.  
**Current state:** Correct runtime and checkpoint family identified; original supplied GitHub link is an unrelated application. Host profiles inspected. Manual prepared; no host installation, model download, inference or training performed.  
**Decisions made:** Office first; CPU eager execution; multilingual baseline; original encoder lane; one checkpoint/process; explicit local paths; offline validation and measured promotion.  
**Files changed:** This standalone manual. No GitHub repository files changed.  
**Validation performed:** Python blocks parsed with Python's AST parser, shell blocks checked with `bash -n`, JSON examples parsed, and referenced loader/router/evaluation/training APIs checked against source. These are static checks; runtime acceptance remains for the local installer.  
**Open questions / risks:** Current host RAM/GPU inventory; dependency resolution; real CPU latency/RSS; task-specific quality, negation/label sensitivity and calibration.  
**Recommended next move:** Run live preflight on office, then the isolated installation and offline smoke test.  
**Agent:** Wave

## Sources and verification scope

Primary sources inspected on 7 November 2026. Runtime source snapshot: `4444f2f56acdd31a633d594e9f3227f853241d9e`. Default-branch documentation and Hub pages may evolve; retain this date and verify changes before adopting a different runtime.

1. [Unrelated notification application](https://github.com/aayushch/laya).
2. [Requested checkpoint/model card](https://huggingface.co/convaiinnovations/laya).
3. [Runtime repository](https://github.com/NandhaKishorM/laya).
4. [Pinned package metadata](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/pyproject.toml).
5. [Checkpoint verification manifest](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/verify/checkpoints.json).
6. [Loader and calibration persistence](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/laya/agent.py).
7. [Router and Vega controls](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/laya/router.py).
8. [CLI and optional MCP](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/docs/cli-mcp.md).
9. [HTTP implementation](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/laya/serve.py).
10. [Evaluation API](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/laya/evals.py).
11. [Fine-tuning guide](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/docs/finetune.md) and [training CLI](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/laya/train_cli.py).
12. [Guardrail limitations](https://github.com/NandhaKishorM/laya/blob/4444f2f56acdd31a633d594e9f3227f853241d9e/docs/guardrail-limitations.md).
13. [English weight size/digest](https://huggingface.co/convaiinnovations/laya/blob/main/model.safetensors).
14. [PyTorch installation selector](https://pytorch.org/get-started/locally/).
15. [Hugging Face snapshot downloads and revision controls](https://huggingface.co/docs/huggingface_hub/en/guides/download).
16. [Kernel zswap documentation](https://docs.kernel.org/admin-guide/mm/zswap.html) and [earlyoom](https://github.com/rfjakob/earlyoom).

Host-profile links and file blob identities appear in section 3. Benchmark and calibration claims above are publisher reports, not independent reproduction. Hardware feasibility and initial resource budgets are labeled estimates. The operational layout, evaluation procedure and promotion policy are recommendations for this local installation.
