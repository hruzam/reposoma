# Model substrates for the CLI observer

**From Asymmetry to majkee, Codex CLI and Claude Code · 9 November 2026**

Start with two independent experiments. Build a 161-parameter controller to decide whether a cache entry earns its place. Use `HuggingFaceTB/SmolLM2-135M-Instruct` to test whether adapting a pretrained language model helps a CLI interpret short requests. Both experiments target an 8 GB CPU machine. Run them sequentially so each gets a clean memory and timing measurement.

## Where this fits

Majkee’s original question was how two CLI sessions could reuse an observation when a window moves, scrolls or changes. Geometry can carry a known transform forward. A versioned cache can remember which evidence supports it. Learning gets a more interesting job at the point where a decision remains uncertain. Will retaining this fragment save work later? Which of two similarly named controls did the user mean?

*Sparks of Weight-Space Programming* suggested a test we can do on ordinary hardware. Express one known rule both in code and as explicit weights, then give a trained network the same inputs. That comparison belongs in the cache playground. The language experiment asks a different question about knowledge already present in pretrained weights. [Original report](https://rikiyat.github.io/blog/weight-space-programming/)

| Companion | When to open it |
| --- | --- |
| [Asymmetry.tiny-controllers.playground.md](https://chatgpt.com/library?file_id=libfile_6f0a7d2187a8819180b1c159563b3c4f&account_id=personal) | Full trace generator, feature definitions, cache baselines, budgets and continuation rule. Use the same filename if supplied locally. |
| [Asymmetry.incremental-observer.cli-handoff.md](https://chatgpt.com/library?file_id=libfile_d52103ac2b908191bb7697208cdf813d&account_id=personal) | Observer architecture, story, geometry and evidence rules. Its first phase, P0, runs independently with a deterministic synthetic observer. Integrating a model is a later decision. |

## The model choices

| Job | Selected substrate | What the CLI does with it |
| --- | --- | --- |
| Cache admission | Our own 8 → 16 → 1 ReLU network, 161 scalars | Assign one set of weights analytically. Train a separate set from scratch. Compare both with ordinary code and a learned linear model. |
| First generative experiment | `HuggingFaceTB/SmolLM2-135M-Instruct`, 135M class, Apache 2.0 | Score the frozen model first. Train a small LoRA adapter on short English examples. Preserve the original checkpoint. [Model card](https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct) |
| Czech and English text similarity | `sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2`, about 118M, Apache 2.0 | If label matching proves worthwhile, freeze the encoder and compare cosine similarity with the token baseline. A 384-dimensional vector can also feed a small supervised head. Cache by text, encoder revision and preprocessing version. [Model card](https://huggingface.co/sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2) |
| Text visible only in pixels | `microsoft/Florence-2-base`, about 230M, MIT | Try frozen inference on labeled crops when the DOM or accessibility reader lacks text. Compare the text and its coordinates with ordinary OCR. Carry crop-to-screen transforms and the observation revision with each result. [Model card and OCR output format](https://huggingface.co/microsoft/Florence-2-base) |

Two conditions would change the generative pick. If the required output becomes a **function name plus arguments**, try `google/functiongemma-270m-it` under the custom Gemma terms. Google designed it for task-specific function-call tuning. If **Czech generation** becomes a requirement, try `Qwen/Qwen3-0.6B` with `enable_thinking=False` and score Czech examples separately. The initial SmolLM2 pilot uses English. These are reserve candidates and each earns its own host measurement. [FunctionGemma](https://huggingface.co/google/functiongemma-270m-it) · [Qwen model and switch](https://huggingface.co/Qwen/Qwen3-0.6B) · [Qwen language coverage](https://qwenlm.github.io/blog/qwen3/)

## Experiment 1 · Write a rule into weights

On a full-cache miss, let `x[0]` be one if this exact versioned key was requested in the previous 1,024 requests, zero otherwise. The handwritten second-touch rule admits when the bit is one. The following executable check expresses the same decision using the complete network shape. Save the block as `check_weights.py` and run `python check_weights.py` with NumPy installed.

```python
import numpy as np

hidden_weights = np.zeros((16, 8), dtype=np.float32)
hidden_bias = np.zeros(16, dtype=np.float32)
output_weights = np.zeros(16, dtype=np.float32)
output_bias = np.float32(-0.5)
hidden_weights[0, 0] = 1
output_weights[0] = 1

rng = np.random.default_rng(42)
features = rng.random((256, 8)).astype(np.float32)
features[:, 0] = np.arange(len(features)) % 2
hidden = np.maximum(0, features @ hidden_weights.T + hidden_bias)
scores = hidden @ output_weights + output_bias
np.testing.assert_array_equal(scores > 0, features[:, 0] == 1)
parameter_bytes = sum(x.nbytes for x in
                      (hidden_weights, hidden_bias, output_weights, output_bias))
assert parameter_bytes == 644
print(f"{len(scores)} matching decisions; {parameter_bytes} parameter bytes")
```

Next, run the same equivalence check across a **20,000-event cache replay**. The code rule and its weight encoding must produce identical admissions, cache contents and hits. Use the playground’s invalidation rules, fixed LRU eviction and eight causal features. Train logistic regression and a separately initialized network to predict whether the same valid key recurs within 128 requests. Keep whole sessions apart across training, validation and test. A future event can supply a training label. Every runtime feature must be available at decision time.

Use the playground’s 512 MiB RSS target and 1 GiB whole-job ceiling for this numerical experiment. Count stale returns, misses, and the time spent extracting features, maintaining history and scoring decisions. The existing continuation criterion is at least 10% lower modeled total cost than the strongest validation-selected heuristic across multiple held-out regimes, with zero stale returns. Report the assumed cost of a miss and the break-even value. If a simple rule wins, deliver that rule with the replay evidence.

**A place for the fractal idea.** Once that comparison works, record one hypothesis about scale. For example, does change in a region’s parent help predict revisits after scrolling? Run paired replays with that feature and without it, accounting for the time needed to compute it. Preserve the original eight-input experiment as the reference.

## Experiment 2 · Adapt a pretrained text model

Give the CLI a collection of *recorded* observer labels. Each example contains a short request and two candidate records taken from the same observation. The generated output is one of three strings, `A`, `B` or `NONE`. Use `NONE` when the request has no unique match. Candidate identifiers are local to the example. The scorer maps an answer to the corresponding record. An answer proposes a record for inspection. Live input still uses the observer’s current-target validation.

| Request | A | B | Expected |
| --- | --- | --- | --- |
| Continue with my application. | button · Save draft | button · Resume application | B |
| Save what I have written. | button · Save draft | button · Discard draft | A |
| Print this invoice. | button · Download CSV | button · Email invoice | NONE |
| Open settings. | link · Account settings | link · Workspace settings | NONE |

**Prepare the data.** Give each row a flow ID, paraphrase-family ID, gold answer and a short reason. Prepare independent training, validation and test groups before fitting anything. Keep related flows and paraphrases in one split, balance answer positions, and keep reordered copies in the same split. Include both missing and ambiguous targets. Publish the task wording, seed and split identities. An initial set of a few dozen hand-checked cases can reveal plumbing errors. State the sample size with every subsequent quality claim.

**Implement three contestants.** The handwritten resolver can use word overlap, a small training-derived synonym list, and abstention on ties or zero evidence. Then score the untouched SmolLM2 checkpoint. Finally score the same checkpoint with LoRA enabled. Give both model arms identical prompts, chat formatting, decoding, token limits and parsing. Strip surrounding whitespace and require one exact allowed answer. Count malformed generations separately and as failures. Verifying only that a string parses would give a confident wrong target full credit.

**Run the checkpoint smoke test.** On the actual host, record the CPU model, available RAM, free disk, OS and Python version. Use an isolated environment with compatible CPU builds of PyTorch, Transformers, Hugging Face Hub and PEFT. Record the resolved package versions. With those packages installed, save the block below as `smol_smoke.py`. On Linux with GNU time, run `/usr/bin/time -v python smol_smoke.py`. The first invocation fetches the public checkpoint. Record its commit and use that exact revision for every later arm.

```python
import torch
from huggingface_hub import HfApi
from transformers import AutoModelForCausalLM, AutoTokenizer

torch.set_num_threads(1)
model_id = "HuggingFaceTB/SmolLM2-135M-Instruct"
revision = HfApi().model_info(model_id).sha
assert revision
tokenizer = AutoTokenizer.from_pretrained(model_id, revision=revision)
model = AutoModelForCausalLM.from_pretrained(
    model_id, revision=revision, dtype=torch.float32
).cpu().eval()
prompt = (
    "Choose the unique matching control. Reply A, B, or NONE.\n"
    "Request: Continue with my application.\n"
    "A: button | Save draft\nB: button | Resume application"
)
chat = tokenizer.apply_chat_template(
    [{"role": "user", "content": prompt}],
    tokenize=False, add_generation_prompt=True
)
inputs = tokenizer(chat, return_tensors="pt", add_special_tokens=False)
with torch.inference_mode():
    ids = model.generate(**inputs, do_sample=False, max_new_tokens=8)
answer = tokenizer.decode(
    ids[0, inputs["input_ids"].shape[1]:], skip_special_tokens=True
).strip()
print({"revision": revision, "input_tokens": inputs["input_ids"].shape[1],
       "generated": answer, "expected": "B", "correct": answer == "B"})
```

A wrong answer here is baseline evidence. Keep it with the output. Load from the pinned local snapshot for repeated timing runs and measure cold initialization separately from warm generation. [Checkpoint configuration](https://huggingface.co/HuggingFaceTB/SmolLM2-135M-Instruct/blob/main/config.json) · [Chat templates](https://huggingface.co/docs/transformers/chat_templating)

**Train a bounded adapter.** Proposed first settings are CPU FP32, batch size 1, at most 128 tokens including the target, rank 4 LoRA on `q_proj` and `v_proj`, alpha 8 and dropout 0. Inspect the loaded module names and log the matched modules and trainable count. Use a causal-language-model adapter. Freeze the base layers, disable the model’s inference cache during training, and optimize the adapter parameters. With the same chat template, mask the prompt and padding in the loss and supervise the answer plus its end token. Inspect a decoded training example and its supervised positions. Skip and count oversized examples or shorten the fixture while preserving both candidates. [PEFT quicktour](https://huggingface.co/docs/peft/quicktour)

Time ten optimizer steps on training examples and verify at least one adapter tensor changed. Record peak resident memory, available headroom and seconds per step. Use these measurements to choose an affordable step budget before continuing. An 8 GB machine also runs an OS and may have other active jobs. FP32 storage of 135 million scalars alone is about 540 MB. Activations, temporary buffers and runtime memory enter the actual peak. The numerical playground’s 1 GiB ceiling applies to Experiment 1. If the language pilot starts swapping or exceeds the available job budget, save the measured limit and completed baseline.

Save the adapter, its configuration and base commit. Reload it in a fresh process, check it reproduces the saved model’s greedy predictions on a fixed validation sample, then freeze the configuration for test. Record the training seed, optimizer, learning rate and number of updates. The reproducible unit is the pinned base plus adapter, tokenizer, prompt and data splits. [PEFT checkpoint format](https://huggingface.co/docs/peft/developer_guides/checkpoint)

**Make the decision.** For each arm report correct targets, wrong targets, correct abstentions, missed matches, malformed outputs, warm median latency and peak memory. Report counts by flow, including ambiguous cases. Choose any acceptance threshold on validation and evaluate the sealed test once. If LoRA improves on frozen SmolLM2, the adaptation result is worth reporting. If the handwritten resolver serves the task as accurately at lower cost, it earns the implementation slot. If outcomes vary by flow, name the failing flows before proposing a different substrate.

## Activation for Codex CLI or Claude Code

> Read this handoff and the applicable repository instructions. Work in an isolated directory. Run the numerical parity check and the cache playground’s bounded replay if its harness exists, or implement the minimal replay from its companion spec. Run the separate SmolLM2 frozen baseline and ten-step adapter pilot on the available CPU host. Continue within the measured budget. Keep the fixture, split, exact commands, revision, environment, resource measurements and failures together. Return a brief decision for each experiment and one hypothesis your observations support testing next. If a dependency blocks one experiment, finish the independent work you can run.

The return package should let the other CLI rerun the same cases from a clean shell. Include the code and fixtures, a small machine-readable results table, the adapter when trained, and a short Markdown decision with the reproduction command. Report observed values, estimates and unrun cases distinctly.

**Verification at handoff.** The embedded NumPy check ran successfully with 256 matching decisions and 644 parameter bytes. The SmolLM2 block passed Python syntax validation. The full replay, pretrained inference, adapter training and target-host measurements remain open.
