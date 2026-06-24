---
artifact: subai.devenv — project overview for fellow project leaders
date: 2026-06-24
author: "@Epoch (researcher seat, subai.devenv)"
audience: external — leaders of sibling/peer projects (reposoma, piql, temple)
status: descriptive snapshot (not a lock; not a research-change report)
read-with: PROJECT.yaml (contract) · flag.md (locks + why) · part1.blueprint.md (full design)
source-of-truth: subai.devenv/research/outputs/subai.project-overview.for-leaders.2026-06-24.md
---

# subai.devenv — what we are building (plain-language overview)

> This is written for leaders of *other* projects. It deliberately avoids in-house
> shorthand. The four core metaphors are defined once below, then used sparingly.
> Where the document says "verified," it means smoke-tested and runnable today;
> where it says "designed" or "horizon," nothing runs yet.

---

## 1. What it is — one sentence

**subai is a thin layer that wraps a *living* command-line AI agent (Claude / Cursor /
Antigravity) so we can both (a) see a little under its surface and (b) graft our own
small Python capabilities onto it — without replacing the agent and without depending
on any one vendor.**

It is explicitly **not**: a VS Code clone, an SDK/API wrapper, or a way to dodge a
subscription by driving the agent headlessly. The terminal/editor stays the surface;
the vendor's agent stays the engine; we attach only at the sanctioned extension points.

## 2. Why build it this way — the thesis

Three bets drive every design choice:

1. **The agent stays alive.** We never script the agent in "print/headless" mode as our
   engine. We attach to a *running, interactive* session. This keeps us inside what the
   vendor sanctions and out of the grey zone.
2. **Graft only at the sanctioned seam.** Every vendor (Claude, Cursor, Antigravity)
   exposes the *same two* official extension points: **MCP servers** (custom tools the
   agent can call) and **hooks** (callbacks on tool-use lifecycle events), plus
   markdown-defined skills/agents. We attach there and nowhere else. We never patch the
   agent's internal loop.
3. **Know-how survives vendor churn.** The valuable, durable part — decisions, design,
   capability logic — lives in **markdown + plain Python + git**. Tools are renewable
   glue. One source, many consumers. A capability that only works on one vendor is
   treated as a smell, not a feature.

The payoff: when any vendor ships a breaking changelog, our brain (the markdown +
the decision ledger) is untouched; only the thin glue needs re-fitting.

## 3. The four metaphors (defined once)

- **The pulse / the ledger** — Our single source of truth is one append-only file,
  `_substrate/dev.journal.jsonl`. Every decision is flattened into one line ("a pulse").
  Slogan: *truth lives in files; chatter may live in streams, but the moment something is
  decided it becomes a pulse.* This is how the project survives a power-cut or a lost
  session — you re-ground from the ledger.
- **A finger** — one small Python capability grafted onto the agent at the seam
  (an MCP tool or a hook). Examples below.
- **The skin** — non-invasive *readers* that render what the live session is doing
  (a terminal tail, an editor overlay). The skin reads; it never patches.
- **The cut / the seam** — the one architectural layer we are allowed to touch. See the
  diagram below.

## 4. Architecture in brief

A live agent session is layered like a cake. We "cut" at exactly one layer:

```
  SURFACE      the agent's terminal UI        ← our "skin" READS here, never writes
  ── THE CUT — our fingers attach HERE ──     ← MCP servers + hooks + markdown skills
  AGENT LOOP   the vendor's tool-use loop      ← closed; we do NOT touch
  TRANSPORT    calls to the model API          ← the SDK/headless trap; we do NOT build here
```

Around that seam sit two plumbing pieces, both plain files:

- **The pulse ledger** (`_substrate/`) — append-only truth, described above.
- **The message bus** (`_bus/`) — a markdown inbox where a human drops one instruction
  that fans out to many agents. Human stays the orchestrator.

Hardware constraint that shapes everything: the office box is a **no-GPU i5 / 16GB**.
So local parts stay light (Python stdlib; at most sqlite-vec / tantivy). Heavy numerics
run **out-of-process** in their own isolated environment, never on the spine. Models are
cloud.

## 5. Current state — be precise about what runs

Phase: **P1** (real capabilities being built on top of a verified P0 spine).

| Piece | State | Honest note |
|---|---|---|
| Core spine (ledger + 1 hook + skin tail + bus) | **verified** | runs clean, zero external deps, py3.14 smoke-tested |
| `privacy_gate` finger (T3) | **verified** (16/16 tests, fail-closed proven) | needs activation + one end-to-end cross-check |
| Spectral/numerics finger (T4) | **built, firewall-clean — but numerics UNRUN** | the math has never actually executed yet; it is the live parallel work front |
| `emit_pulse` / `recall_lighthouse` fingers | written | activate via `claude mcp add`; ends hand-maintenance of the ledger |
| Browser surface (part2) | **designed only** | nothing runs |
| Editor-as-IDE / Zellij+Rust (part3/4) | **horizon** | aspirational; do not assume it exists |
| `brick1.py` PTY-loop experiment | **uncommitted personal spike** | NOT canon, NOT on the spine — see §7 |

If you take one thing from this table: **the editor layer does not exist**, and the
spectral math has **not yet been run**.

## 6. Locked decisions (settled — please don't re-litigate)

Each is backed by a written decision record (`docs/decisions/0001–0004`) and summarized
in `flag.md`:

- **L1 — Ownership.** Two owners: **Claude** leads the code (numerics, deterministic
  tooling, the MCP+hook fingers); **Cursor** owns the surface/skin. **Gemini is a
  consultant only** (research + math cross-check), routed via a neutral CLI. Every brick
  speaks MCP so owners stay swappable. *(Flip-conditions are tracked, e.g. a GPU on the
  box or a clean paid Gemini CLI path would change this.)*
- **L2 — Spectral engine.** An out-of-process numerics brick. The agent reads only a
  *scalar* health signal of the agent-traffic graph (two lowest Laplacian eigenvalues:
  component-count `k` as a hard fragmentation alarm, Fiedler value `λ₂` as a fragility
  gauge), never raw matrices. Strict dependency firewall keeps numpy/scipy off the spine.
- **L3 — Privacy gate.** Before any text is fed into the live agent, an optional gate
  decides `pass / redact / block`. Trust is passed in as a `--policy` parameter, never
  baked in (a sibling project, piql, supplies the reference gate). Built and verified.
- **L4 — Headless worker-bus deferred.** Instead of an automated multi-agent dispatcher,
  we use a simple file-based mail system (`_mail/`) and keep the human in the loop. We
  revisit only when human routing is a *measured* bottleneck.

## 7. Open / in-flight (lead with the live ones)

- **The "brick1" seam-depth question — the current headline, unresolved.** An experiment
  drives a live agent through a terminal PTY file-loop (no headless mode, stdlib only).
  It is a genuine *third path* — neither the deferred automated bus nor the manual mail.
  **Our own rules don't yet say whether this is allowed**: it may violate the "attach only
  at MCP+hooks" law, or it may be a legitimate new seam. This is gated for challenge by our
  challenger seat before anything is adopted. It stays an uncommitted spike until then.
- **T4 spectral numerics** — running and cross-validating the math is the independent,
  parallel work front (does not depend on brick1).
- **Surface / multi-window rendering, a vector-search sidecar, and a longer-term
  "markdown-as-primary-channel" idea** — all designed or parked, none on the critical path.

## 8. How another project plugs in

- We already maintain cross-project "beacons" to **reposoma** and **piql**. piql ships our
  privacy gate; reposoma grounded several of our research locks.
- The clean integration contract is **MCP**: any capability you expose as an MCP tool, our
  agents can call, and vice-versa, without coupling to our internals.
- Our machine-readable contract is `PROJECT.yaml`; the human-readable "why" is `flag.md`.
  Those two files are the front door.

---

*Snapshot as of 2026-06-24. State claims (§5) reflect the 2026-06-23 session handoff and
the pulse ledger through v0023. This document is descriptive — it locks nothing.*
