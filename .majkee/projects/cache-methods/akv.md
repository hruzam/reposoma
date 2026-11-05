# AKV: cache engineering for agents

TC08 · extracted 4 November 2026 · primary paper checked; not reproduced.
[Cache Engineering for Agents](https://arxiv.org/html/2610.28577v1).

The paper separates retained transcript text from active attention state. `drop`
removes selected KV entries from future attention; `repos` adjusts retained key
position encodings. Its example policy keeps reasoning and recent tool responses,
dropping older tool-response KV incrementally.

**The key correctness issue is history dependence.** Computing C while attending
to A, then dropping A, need not produce the same C state as dropping A before
computing C. Identical surviving tokens and positions therefore do not necessarily
identify reusable state. AKV tracks operation history as well as tokens.

The authors report a 27.7% average cost reduction against their summarization
baseline, alongside benchmark and serving improvements. These are results of
their evaluated policies and implementation, not a portable savings guarantee.

My engineering takeaway: cache identity must capture relevant computation history.
Deleting old text in a chat client does not implement this method. Revisit the
paper when evaluating a serving engine with explicit KV operations; compare
correctness and quality as well as latency. Ordinary application eviction belongs
in [a different comparison](application-caches.md).
