# SwaT: translating cached state between models

TC06 · extracted 4 November 2026 · research result, not independently reproduced.
[Swarm Telepathy: Prefill-Free KV-Cache Transfer Across Families](https://arxiv.org/html/2610.15095v1).

SwaT learns a transformation between model families' KV representations. Instead
of communicating only a textual summary and having the receiver prefill it, the
method transfers translated internal state. The sender and receiver backbones
remain frozen; learning the bridge is still part of the method.

The paper reports gains in its multi-agent evaluations, including cross-family
and vision-to-text cases. This supports a research lead about latent communication,
not a guarantee that arbitrary chat services can exchange their internal caches.

My use criterion: revisit only when both models expose the relevant state and the
translation can be trained and evaluated. Check task coverage, communication budget,
training expense, compatibility and failure behavior against text communication.
Treat this separately from [AKV's within-trajectory cache control](akv.md).
