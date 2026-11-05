# Capability routing in Trinity

TC07 · extracted 4 November 2026 · primary paper checked; implementation untested.
[The Trinity, especially §3.6](https://arxiv.org/html/2610.36077v2).

The paper organizes requirements into a capability tree and evolves reusable
modules in a harness tree. A router uses public task information and verified
experience to choose a compatible configuration from a fixed, versioned pool.
Its capability organization and routing are distinct from the weather classifier's
feature splits.

The reusable idea is to describe a task by the capabilities it needs, then select
among evaluated configurations. The paper's self-improvement and benchmark claims
remain author-reported results, not evidence that a router will improve this workspace.

My small example, not a transcription of Trinity's actual routing policy:

```text
What must this task do?
  ├─ inspect an image → candidate configuration with visual input
  ├─ operate a tool  → candidate with that tool and its constraints
  └─ reason only    → candidate without additional tool machinery
Then: check compatibility, evaluate outcome, record the selected version.
```

My acceptance criterion for a future experiment: a router must beat a simple fixed
baseline on held-out tasks after accounting for routing cost, failures and leakage.
Log why a branch was selected and whether the task succeeded. This is a research
note; it grants no authority to modify the current harness.
