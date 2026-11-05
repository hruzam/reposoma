# Application caches: eviction and freshness

Extracted 4 November 2026 from TC31; checked against primary documentation.

**Eviction** chooses what to remove under capacity pressure. LRU favors recently
used entries; LFU favors frequently used entries. Redis implements approximations
of these policies; LFU frequency decays so older popularity need not dominate forever.
Inspect the implementation rather than assuming an exact textbook algorithm.
[Redis eviction documentation](https://redis.io/docs/latest/develop/reference/eviction/).

**Expiration** makes a key unavailable after its configured lifetime. Invalidation
is the application decision that a cached result no longer satisfies its contract.
A capacity policy does not decide how fresh a result must be. Redis's expiration
command provides a time limit; selecting that limit is still an application choice.
[Redis EXPIRE](https://redis.io/docs/latest/commands/expire/).

## FIFO and LRU, a concrete counterexample

FIFO removes the oldest inserted entry. LRU removes the least recently used entry.
This is an independently constructed example, not a replay of the reel. Capacity is
three equal-size entries; all misses insert a value; both caches start empty.

| Request | FIFO, oldest insertion first | LRU, least recent first |
|---|---|---|
| A | miss → A | miss → A |
| B | miss → A B | miss → A B |
| C | miss → A B C | miss → A B C |
| A | hit → A B C | hit → B C A |
| D | miss → B C D | miss → C A D |
| B | hit → B C D | miss → A D B |

Here FIFO gets two hits and LRU one. I verified this trace with a small local
simulation. It disproves a universal claim that LRU always wins; it does not rank
the methods for your workload.

Modern queue-based policies can also filter new objects before admitting them to
long-lived storage. The S3-FIFO authors describe a small initial queue, a main queue
and a ghost queue containing keys without values. Their method is additional
context, not something identified in the screenshot.
[S3-FIFO author project](https://s3fifo.com/).

## How to compare for a real task

My proposed comparison is to replay the same request trace under a fixed byte
budget. Include metadata overhead, warm-up, variable object sizes and changing
popularity. Measure backend work and p95/p99 latency, not just object hit rate.
Choose freshness and tenant/access boundaries before optimizing hits. Record
whether an incorrect or stale hit can produce a wrong result; a high hit rate
does not compensate for that failure.
