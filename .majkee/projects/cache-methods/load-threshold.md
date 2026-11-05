# Why six percentage points can change overload

Extracted 4 November 2026 from TC31 / frame S191, Systems in Motion.
The source image is retained because its precise numerical claim has no recovered
original post URL. The calculation below is myShell's derivation, not a reproduction
of the animation.

The frame labels incoming traffic as **2,000 requests/s**, backend capacity as
**1,200/s**, FIFO hits as **39%**, and LRU hits as **45%**. It also displays
257 dropped requests versus zero, without a visible time horizon or queue model.

Assume every miss produces one backend request, every hit avoids that request,
and ignore refresh work, retries and writes. For incoming rate `R`, hit fraction
`h` and backend capacity `B`:

```text
backend arrival rate = R × (1 − h)
break-even hit rate  = 1 − B/R
                     = 1 − 1200/2000
                     = 40%
```

| Hit rate | Backend requests/s | Relative to capacity |
|---|---:|---|
| 39% | 1,220 | 20/s above |
| 40% | 1,200 | At capacity; no spare margin |
| 45% | 1,100 | 100/s below |

The useful insight is the threshold: a modest hit-rate change can move the backend
from growing backlog to spare capacity. This mechanism is more informative than
the slogan that one policy is better.

The displayed **257 drops cannot be inferred from these rates alone**. Duration,
bursts, service-time distribution, initial queue depth and queue capacity are
missing. Zero drops is likewise unverified. With real traffic, average utilization
below capacity can still allow bursts and high tail latency.

The practical decision is to measure backend arrival and service rates over time,
including retry/refresh amplification. Then test policies with the same trace and
queue model. Do not carry the reel's percentages into capacity planning.
