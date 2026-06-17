# Decision Record — Machine-Provenance Markers: what locks

`status: LOCKED 2026-06-17 (gaveled by majkee)`
`date: 2026-06-17 · thread: cross-machine provenance / portability`
`shape: ADR — context · decision · consequences · what-an-agent-does-differently`
`resolves: O4 (proposed) in decisions/index.md`

---

## Context

The operator works across machines (office box i5-12400 = subai.devenv + temple work · home
laptop = a smaller Laravel project + its own resource guards). Durable artifacts travel between
machines — doctrine Force 2: the human moves between machines; the files are the continuity. Without
a host marker, an artifact cannot say *where* it was produced, and per-machine facts (resource limits,
which scripts are live) blur. Houston has no shell, so the mechanism had to be operator-confirmed and
dead-simple, not a daemon.

---

## Locked

**L1 — the host id.** `echo $MACHINE_NAME`, exported per-machine from `~/.config/zsh/config.zsh`
(office = `office`; home must set `home`). Fallback `hostname -s` only when the var is absent
(non-login shells).

**L2 — the convention.** Durable artifacts may carry a `host:` frontmatter field. Per-repo provenance
via `echo $MACHINE_NAME > .host` — a one-liner, **not** a sourced helper or framework (resist
frameworkitis). `reposoma/.host` = `office`.

**L3 — the machine-layer lighthouse.** `~/.config/zsh/AGENTS.md` is the navigational index for the
operator's shell/machine layer: the contract it exposes + a live-vs-parked map + the §4.7 guard.
**AGENTS.md (cross-tool), not CLAUDE.md.** Parked-but-useful scripts carry a `substrate.` filename
prefix; nothing is deleted. Indexed from the roster's knowledge-layers — one pointer, one direction.

**L4 — the boundary (§4.7).** The machine layer is the operator's **personal** layer. Agents read it
for host/resource facts; they must **not** bind its absolute paths into any project's consumer surface.
The temple/roster may index it (orchestration from outside); a project's `AGENTS.md` may not.

---

## Consequences

- Provenance is cheap and shell-native — no daemon, no dependency.
- The concurrency guard is **home-only** (`~/.shared/implementation.concurrency-guard.zsh`, hard-sourced
  by `ai-lifecycle.zsh`); a `$MACHINE_NAME`-gate (`[[ "$MACHINE_NAME" != home ]] && return 0`) scopes it.
- **Gotcha carried forward:** the home laptop's `config.zsh` must set `MACHINE_NAME="home"`, or home
  artifacts mislabel as `office` (its current `substrate.config.home.zsh` backup reads `office`).

---

## What an agent must do differently

- Stamp durable artifacts with `host:` where provenance matters; read `$MACHINE_NAME` (or `.host`) to
  know the box it stands on.
- Never hardcode the machine layer's absolute paths into a project surface (§4.7).
- Treat `substrate.`-prefixed scripts as **parked** — do not source or edit them as live.
