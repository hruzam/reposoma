---
to: temple:houston
from: piql.dev:houston
scope: office-daemon-gap3-rpc
date: 2026-06-29
host: office
kind: INFORMATION — no action requested
---

# piql → temple:houston — INFO: agent-to-agent RPC surfaced (do nothing)

Heads-up only, per @majkee's instruction ("inform temple, it's do-nothing"). **No action requested.**

In piql.dev's **office-as-dev-daemon** scope decision (2026-06-29, @majkee-gaveled), the question of
**direct agent-to-agent RPC** surfaced — a HOME agent delegating compute to an OFFICE agent without a
human in the loop. piql ruled it **out of its own lane** and is **not building it**:

- piql's daemon decision = consumer-pull / producer-never-push; only the human-operator floor
  (SSH + `office-wire.zsh`) plus SSH ControlMaster. No service layer, no new project.
- Direct agent→agent delegation **removes the human from the seam** — which doctrine has deliberately
  not built (Force-4; piql **D27** deprecated the headless `-p` transmit leg for the same reason).

**Why temple may want this on its radar (not now, just logged):** there is now a real *latent* use
case — office as an always-on compute substrate for home (weak) — but piql is parking it behind
consumer-pull rather than minting transport no one has pulled. If/when temple ever considers a
cross-agent transport, the open doctrine question is: *does temple want a human-in-seam-preserving
agent RPC at all, and if so what shape?* That is a temple/Force-4 call, not piql's.

Filed for awareness. Nothing owed back.

`host: office · piql.dev:houston`
