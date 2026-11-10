# VIST and Cache Access Session Brief

**For:** majkee and the nablarva CLI teams  
**From:** Wave  
**Date:** 27 October 2026  
**Status:** Research substrate and proposed experiments. Runtime qualification pending; no project contract changes are implied.  
**Scope:** Native session observation, actual KV access, C2C, and agent-managed caches. Hooks are excluded.

## 1. Questions the session should resolve

1. Which VIST screen-derived observations can native runtime interfaces replace on our installed clients?
2. Where do we actually have permission and technical capability to read, insert, retain, and restore model caches?
3. Does latent transfer improve a representative task enough to justify its computation, transport, and recovery requirements?

Keep these questions separate. A cache mechanism can improve model communication without exposing session lifecycle. A native session API can replace screen inference without exposing model tensors.

The reviewed repository baseline was `hruzam/nablarva`, branch `core`, commit `6b8d1d3d5543ac3edf8dfcc1e8c9dbf10dde2251`. The relevant folder is `.dev/session/nablarva-X4-vist/`. Begin by reading the current flag, X4 contracts, and applicable working-tree instructions; record HEAD and existing changes. The reviewed snapshot is context, not a claim about today's checkout. [P1–P3]

## 2. Evidence to carry into the session

| Finding | Evidence level | What would establish local applicability |
|---|---|---|
| Hosted OpenAI and Anthropic caching exposes prefix reuse and usage information; no supported raw KV export/injection interface was found in the inspected documentation. | Documentation inspection; scope-limited negative finding. | A documented interface and successful minimal read/injection probe. A transcript, cache key, or hit counter is insufficient. [S1–S2] |
| Claude documents `claude agents --json`, including live interactive sessions and native activity/wait information. | Current documentation, not our installed-client test. | Version-qualified output, identity binding, and controlled transitions. [S3] |
| Codex documents a shared runtime and app-server methods including `thread/loaded/list`, `thread/read`, and status notifications. | Current documentation. | Connection to the runtime owning the actual session. Upstream defaults do not establish installed behavior. [S4–S5] |
| Transformers and LMCache provide actual cache access under controlled inference. | Released interfaces; no experiment executed here. | Same-model capture/restore with preserved continuation. [S6–S7] |
| C2C has released model/fuser code; AKV has released cache-management code. | Research implementations. | Reproduce each in its own supported environment. They are not assumed to form a compatible combined stack. [S8–S9] |

## 3. Session structure and parallel work

Suggested first session: 10 minutes to fix scope and versions, 15 minutes to inventory accessible interfaces, 20 minutes to agree experiments and measurements, and 15 minutes to assign the smallest next probes.

- **Observation team:** native discovery, state semantics, identity, freshness, and comparison with existing terminal evidence.
- **Inference team:** controlled cache access, compatibility, continuation, and optional C2C or AKV trials.
- **Verifier:** independently labelled fixtures, measurement review, negative cases, and evidence-backed removal recommendations.
- **Chair:** select workload, acceptable quality loss, latency budget, and which architectural changes the evidence justifies.

Use the project's four questions: conventional name, established solutions, open edges, and what is specific to our case. The conventional subjects here are runtime introspection, event observation, prefix caching, cache checkpointing, and representation transfer.

## 4. Testbed A — Native session observation

### Discovery

Record client versions, launch arguments, relevant configuration, process/start identities, session IDs, and server ownership. Use installed help before assuming a command or schema exists. Probe Claude's JSON listing where supported; for Codex, inspect the owning runtime through its documented protocol. Do not assume a `codex agents --json` option.

Discovery reads existing sessions. Resuming, migrating, restarting, sending prompts, or starting an unrelated server is a separate operation, not a way to manufacture passive observation. Check whether discovery itself creates processes, sessions, requests, or configuration changes. [S3–S5]

### Controlled cases

Run interventions and fault injection in disposable sessions. Compare native state, persisted transcript evidence, and terminal evidence for the same session.

| Case | Independent evidence | Required observation |
|---|---|---|
| Idle → work → idle | Driver action, controlled tool acknowledgments, independently witnessed boundaries | Correct transitions and measured delay. |
| Waiting for approval or input | Deliberately triggered, independently labelled prompt | Waiting is distinguished from idle; reason retained when supported. |
| Quiet tool still running | Tool writes start acknowledgment, remains alive silently, then records exit | Silence never establishes completion. |
| Misleading output | Tool prints `Done` or prompt-like text before its recorded exit | No false completion from text alone. |
| Observer outage or delayed data | Driver interrupts the observer/connection and records the interval | Stale/unknown is explicit; rereading old data does not renew its freshness. |
| Session/server restart | Driver records process-start or server-incarnation changes | Old observations cannot silently bind to the new instance. |
| Similar names or reused pane/PID | Distinct session identities and known bindings | No cross-session attribution. |
| Missing fields, changed schema, reordered/replayed events | Frozen raw fixtures | Unknown/rejection and duplicate handling; no invented state meaning. |

Ground truth must not come solely from the source being evaluated. A live process proves existence, not model progress. Mark unobservable facts as unknown. If a boundary is only known within an interval, retain that interval instead of inventing an exact timestamp.

Treat activity, input readiness, and task acceptance as different facts. Native `idle` or `done` is not proof that the assigned work is correct. Define the exact operational meaning of any proposed `ready` signal before evaluating it.

## 5. Testbeds B and C — Controlled inference

### B — Same-model cache access

Start here before semantic fusion. Pin model revision, tokenizer, runtime, cache layout/dtype, device configuration, and decoding settings.

1. **Access:** obtain actual tensors; record shape, dtype, resident bytes, and the continuation metadata the runtime requires.
2. **Identity roundtrip:** compare ordinary inference with capture → unchanged restore → continuation. Compare next-step logits using a declared numerical tolerance, then greedy continuation. Record divergences, including near-tie changes.
3. **Recovery:** restart the test process and restore retained state; separately reconstruct from inputs. Distinguish functional agreement from byte-identical reproduction.
4. **Compatibility:** test wrong model revision, tokenizer, shape, positions, and provenance. The harness must reject unsupported combinations before inference; record the native runtime's behavior separately.
5. **Branch isolation:** reuse a fixed prefix for two independent continuations. Confirm one branch cannot mutate the other's state.

Transformers exposes in-process cache objects. LMCache documents retrieve/store and a prefill → modify → decode workflow; its store operation is not a general unconditional overwrite. Begin with the documented workflow of the pinned implementation. [S6–S7]

### C1 — C2C semantic transfer

Use the released example with its supported directional model/fuser pair first. Compare **receiver alone, donor alone, text handoff, C2C, and optional text+C2C hybrid**. The published hybrid result makes it a relevant baseline; choosing text versus latent transfer need not be an exclusive choice. [S8]

Use the same tasks and externally available information. Record prompt and computation differences rather than concealing them. Include repository questions, patch selection, and tool-result interpretation with independently scored answers.

- Disable fusion and check recovery of the equivalent receiver invocation.
- Compare helpful, irrelevant, wrong, and stale donor information; count induced errors as well as improvements.
- Begin with aligned shared input. Divergent histories require an explicit alignment rule and are a separate hypothesis.
- Reject incorrect fuser direction or version in the harness.
- Record donor preparation, extraction, transformation, transport, receiver execution, and peak memory.

### C2 — AKV cache management

Keep this experiment separate from C1. Compare **full history, explicit text truncation/summary, Drop, and Drop+Reposition** in AKV's supported serving stack. Include identical visible inputs with different cache-operation histories, followed by continuation and restoration tests. Its OpenAI-compatible request syntax does not make these extensions available on hosted OpenAI endpoints. [S9]

Preserve source inputs, model/fuser revisions, required position metadata, ordered operations, and artifact hashes. A transcript alone may not reconstruct a transformed computational state.

## 6. Minimal programmatic bed

Prefer a small replayable harness. These are proposed roles and filenames, not existing commands or a new VIST contract:

| Component | Responsibility |
|---|---|
| `driver.py` | Exercise disposable cases and append independent oracle events. |
| `collect.py` | Read an available source, preserve raw output, append observations; never dispatch work. |
| `normalize.py` | Pure transformation from raw fixtures to explicit state/unknown. |
| `evaluate.py` | Join observations to oracle episodes and paired inference trials; emit metrics. |

Each run retains `manifest.json`, `raw/`, `observations.jsonl`, `oracle.jsonl`, `trials.jsonl`, and `verdict.md`. Keep oracle labels out of normalizer inputs. Keep raw evidence immutable and regenerate derived views.

Illustrative observation, **not a recorded result**:

```json
{
  "schema": "probe-0.1",
  "run_id": "observation-01",
  "seq": 1,
  "host_id": "host-a",
  "runtime_instance": "pid-plus-start-identity",
  "session_id": "session-uuid",
  "clock_domain": "host-a:boot-uuid:monotonic",
  "observed_ns": 1000000000,
  "source": "native-session-api",
  "source_version": "record-installed-version",
  "native_state": "idle",
  "activity": "idle",
  "readiness": "unknown",
  "freshness": "unknown",
  "raw_ref": "raw/000001.json"
}
```

Receipt time establishes when we read something, not when the source last established its truth. Preserve source timing and connection-health evidence when available. Sequence numbers establish local ordering, not upstream completeness. Compare monotonic timestamps only within the same clock domain; cross-host latency needs an explicit clock-offset/error model or measurement at one endpoint.

## 7. Mathematics and measurement

### Observation quality

For readiness claims with independently known ground truth:

$$
F_R = \frac{\#\{\text{ready claims while oracle says not ready}\}}{\#\{\text{ready claims with known oracle}\}}.
$$

If the denominator is zero, report undefined. Also report incorrect ready claims per non-ready opportunity, unknown/stale duration, and a confusion matrix including unknown. These measure different failure modes.

Report usable observation coverage separately from correctness. For transition detection:

$$
D = \frac{N_{\mathrm{detected\ transitions}}}{N_{\mathrm{eligible\ transitions}}},\qquad
L_e=t_{\mathrm{first\ valid\ detection},e}-t_{\mathrm{oracle},e}.
$$

Report sample count, p50/p95/max lag **among detections**, together with misses and the declared detection deadline. Never drop misses to improve latency figures. For uncertain oracle times, report lag bounds.

### Cache memory and network cost

For batch size one, uniform full-attention layers, and uncompressed elements:

$$
S_{\mathrm{KV}}=2LNH_{\mathrm{KV}}db.
$$

Here `L` is layers, `N` cached tokens, `H_KV` KV heads, `d` head dimension, and `b` bytes per element. Use KV heads, not query heads. Actual layouts, windowing, sharding, and metadata require measuring tensor/storage bytes. [S6]

The hypothetical values `L=32, N=8192, H_KV=8, d=128, b=2` give **1,073,741,824 bytes = 1 GiB**. For actual wire payload `S_wire` and link rate `R` in bits/s:

$$
T_{\mathrm{network}}\geq\frac{8S_{\mathrm{wire}}}{R}.
$$

One GiB over 1 Gbit/s therefore needs at least **8.59 seconds**, before overhead. This is a calculation, not a C2C measurement; shared-memory transfer needs a different model.

### Paired end-to-end benefit

For task `i`, measure from equivalent starting conditions to the final usable result:

$$
\Delta t_i=t_{\mathrm{text},i}-t_{\mathrm{cache},i},\qquad
\Delta Q_{\mathrm{pp}}=\frac{100}{n}\sum_i(q_{\mathrm{cache},i}-q_{\mathrm{text},i}).
$$

Here `q` is binary task success. Retain each paired outcome, especially newly introduced failures. Separate cold and warm runs; randomize execution order. Report preparation-inclusive latency and incremental handoff latency separately when donor state is precomputed. Measure the actual critical path; overlapping stages cannot simply be summed.

If training/setup has cost `C_setup`, and per-task costs use the same units, amortization requires:

$$
n>\frac{C_{\mathrm{setup}}}{c_{\mathrm{text}}-c_{\mathrm{cache}}}
$$

with a positive denominator and acceptable task quality. Pretrained weights remove local training expenditure, not runtime costs.

### Evidence strength

Start with 5–10 smoke cases and, if useful, 30–50 paired tasks as an exploratory pilot. These are workload suggestions, not reliability thresholds. If a decision depends on small differences, expand with paired uncertainty estimates.

With zero failures in `n` independent, identically distributed Bernoulli episodes, the one-sided 95% upper failure-rate bound is:

$$
p_{\mathrm{upper}}=1-0.05^{1/n}\approx\frac{3}{n}.
$$

Zero failures in 30 such episodes still permits about **9.5%**; in 300, about **1.0%**. Repeated polls of the same episode are correlated and cannot be counted as independent trials. A selected synthetic corpus also does not establish the production distribution.

## 8. Decisions and required handoff

Agree latency budgets and quality tolerance before examining results. A corpus intended to justify replacing an observer should contain no false completion, stale-as-fresh reporting, or identity misbinding; that is a corpus acceptance condition, not a universal guarantee.

Possible decisions:

- **Replace a detector** only for the facts, versions, and runtime configurations qualified by evidence.
- **Retain a fallback** for a demonstrated coverage gap; name the gap.
- **Keep the native adapter small** when direct state reporting covers the requirement.
- **Stop a hosted-cache branch** when no supported tensor interface is available; retain the exact capability gap for later review.
- **Continue a controlled-inference experiment** only when the next test resolves a concrete quality, access, performance, or recovery uncertainty.

Each team returns: versions and configuration; verified/unsupported/unknown capabilities; raw run references; commands actually executed; metrics with denominators and misses; failures; and one next decision. No adapter may infer project-task success from activity alone.

### Pasteable session opener

> Read this brief and the current nablarva flag/X4 contracts. Inventory our actual installed interfaces. Separate documented capability, observed behavior, and hypothesis. Select the smallest probe that could disprove our preferred approach. Return evidence, remaining gaps, and the exact VIST responsibility we can remove or must retain. Leave hooks outside this session and keep project-contract changes as proposals until the evidence is reviewed.

## Sources

Documentation and source inspection: 27 October 2026. Installed runtime behavior remains to be measured.

- **P1:** [VIST principle at the reviewed repository commit](https://github.com/hruzam/nablarva/blob/6b8d1d3d5543ac3edf8dfcc1e8c9dbf10dde2251/.dev/session/nablarva-X4-vist/raw/vist-01-principle-and-applications.md).
- **P2:** [Project flag](https://github.com/hruzam/nablarva/blob/6b8d1d3d5543ac3edf8dfcc1e8c9dbf10dde2251/.dev/session/flag.md) and [HELLO contract](https://github.com/hruzam/nablarva/blob/6b8d1d3d5543ac3edf8dfcc1e8c9dbf10dde2251/.dev/session/nablarva-X4-vist/raw/hello-01-contract.md).
- **P3:** [Termpanum source contract](https://github.com/hruzam/nablarva/blob/6b8d1d3d5543ac3edf8dfcc1e8c9dbf10dde2251/.dev/session/termpanum-X0-source-contract/raw/source-contract.md).
- **S1:** [OpenAI prompt caching](https://developers.openai.com/api/docs/guides/prompt-caching).
- **S2:** [Anthropic prompt caching](https://platform.claude.com/docs/en/build-with-claude/prompt-caching).
- **S3:** [Claude Code agent view and JSON session listing](https://code.claude.com/docs/en/agent-view).
- **S4:** [Codex app-server protocol](https://developers.openai.com/codex/app-server).
- **S5:** [Codex developer commands](https://learn.chatgpt.com/docs/developer-commands).
- **S6:** [Transformers cache explanation](https://huggingface.co/docs/transformers/main/en/cache_explanation).
- **S7:** [LMCache KV Cache SDK](https://docs.lmcache.ai/mp/sdk.html).
- **S8:** [C2C paper v2](https://arxiv.org/html/2510.03215v2) and [released inference example at inspected commit](https://github.com/thu-nics/C2C/blob/bdb932aa63637959074a9a6fd59992a4d0d9ad22/script/playground/inference_example.py).
- **S9:** [Cache Engineering for Agents](https://arxiv.org/abs/2610.28577) and [AKV system instructions at inspected commit](https://github.com/thu-nics/AKV/blob/c567a429a058f1abce3b2879e69978b09e0fda4c/akv/system/README.md).
