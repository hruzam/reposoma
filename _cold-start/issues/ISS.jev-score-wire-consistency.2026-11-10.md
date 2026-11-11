---
kind: issue-card
date: 2026-11-10
brand: codex
found_by: cartan(jev-01)
project: ia-sync
root: ~/ia-sync
where: ~/ia-sync/zsh/jev/kernel.py (validate_receipt Score expected-index check)
defect: A live Jev mixed-type reply has Score values differing by 0.01 from its returned probability-weighted indices, making the whole local receipt INVALID.
assoc: [jev, score, openrouter, validation, serialization, probability, office, mixed-batch]
severity: med
pointers:
  - ~/ia-sync/.dev/session/jev-01-codex-pilot/raw/practical-gates-result.2026-11-10.md
  - ~/.jev/practical-gates-20261110/provider-response.json
  - ~/.jev/practical-gates-20261110/comparison.json
  - ~/ia-sync/zsh/jev/provider.py
---

Observed November10 during the operator-authorized practical gating trial, real model
`typesafe/jev-1.14-20261014`, request `fcf5015cdaa146c5a01ff33fbb6fa9d3`.
HTTP200 and known cost USD0.000420126 settled correctly; typed validation rejected the
whole receipt at S2_maturity. Raw bytes and all observations remain in the private ledger.

Exact decimal checks: S2 score2 versus weighted2.01; S4 score2.95 versus weighted2.96;
S6 score1.78 versus weighted1.77. S1/S3 match. A fresh14-question Choice/Noul-only request
passed validation and settled; it is a changed-input control, not proof of deterministic
provider causation or general reliability. No failed receipt was rewritten or consumed as
valid: an actual interpretation event returned ERROR.

The official [Score response definition](https://docs.typesafe.ai/primitives/score), checked
November10, defines score as the probability-weighted level index. Wire rounding of scalar
and probabilities could explain these small discrepancies; rounding rules are unverified.
Do not silently change scores, renormalize probabilities, or relax all validation.

Response playbook: reproduce offline from retained bytes; isolate primitive validation and
check current provider precision guarantees. If a tolerance change is justified, derive it
from an explicit serialization contract and test admissible rounding versus genuinely
inconsistent values. Preserve both original scalar/distribution and diagnosis. Otherwise
keep the fail-closed behavior and use Choice/Noul for the bounded demonstrated route.
Any per-question acceptance instead of whole-batch failure needs its own explicit design.

Recorded under majkee's delegated practical-debug scope; no code change, canon promotion
or fold. This new card is uncommitted and is not available cross-machine through Git yet.
