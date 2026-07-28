## process (directive — token-economy probe, mirrors task1)
Read ONLY what this task needs — **do NOT scan the RAG, do NOT read temple/decisions/**:
- this card
- `_mail/README.md` (the addressing convention — filename shape, receiver-owns-message, no-sent-copy)
- `~/.config/zsh/ai/base.zsh` (the signpost — source it to get `temple-project-root`, the `project-name → repo-root` resolver you will reuse)

If you can see your context/token footprint, **report that number — it IS part of the test result** (same as task1).
Before you start: if any GOAL choice below has a cleaner shape, **say so first** — do not silently diverge.

> NOTE: the AI-bonded machine-layer scripts now live under `~/.config/zsh/ai/` and are sourced from
> `ai/base.zsh` (decision 0009). Source the signpost; do not hard-code individual script paths.

## GOAL — a native zsh cross-project `_mail` synchronizer, folder-reaction triggered (NOT a git hook)

This builds **0008 L7's deferred piece**: cross-repo mail delivery. A message authored in one project, addressed
to another project's agent, must land in the *receiver's* repo inbox. Keep it **thin**: it moves messages, it does
**NOT** diff canon and does **NOT** touch the existing canon-doorbell (that is a separate transport — leave it).

1. **Script** `~/.config/zsh/ai/mail-sync.zsh` (under the `ai/` namespace, 0009 L1). Ferries a staged outbound
   message into the **receiver's** repo at `<receiver-repo-root>/_mail/<agent>/inbox/<sender>.<scope>.<YYYY-MM-DD>.md`.
   Resolve `<receiver-repo-root>` via `temple-project-root <project>` (obtained by sourcing `ai/base.zsh`) — never
   invent paths, never mint a second project→root map. Honor `_mail/README.md` exactly: **receiver owns the message ·
   NO sent-copy (move, not copy) · carry `host:`**.

2. **Trigger = a native `systemd.path` unit** watching the selected outbound folder(s) — same lightweight machinery
   as `harness.timer`, **no bespoke daemon, NO git hook**. On change → run the sync. Units under
   `~/.config/systemd/user/` (e.g. `mailsync.path` + `mailsync.service`), Persistent; the `.service` ExecStart MUST
   reference the `ai/` path (0009 L3). (Path-triggered is deliberate: mail wants prompt delivery, unlike the
   rare/latency-tolerant canon-doorbell.)

3. **Registry.** Reuse `temple-project-root` for project→root resolution. Record the **watch-set** (which outbound
   folder(s) to watch) in `~/.config/zsh/registries/ai.json` under a NEW key, e.g. `mail-sync-watch:`. **If you judge
   a separate registry file cleaner than reusing `ai.json`, say so before starting.** Do NOT duplicate the project map.

4. **Debug command** `aimail-sync` = a **dry-run**: echo what it *would* ferry (each `source → resolved destination`)
   and move **nothing**. The path-triggered run does the real move. (Pure echo to terminal, like `aihs-stale`.)

5. **Verify-it-fires (the gate — 0009 L5: test the REAL trigger, not the script by hand):** stage one synthetic test
   message addressed to a known project, **start/exercise the `systemd.path` unit**, confirm the message lands at the
   correct receiver inbox with the right filename and **no sent-copy**. Report `systemctl --user status` + the
   dry-run + the live-fire result. A silently-dead syncer is THE failure mode.

6. **Guardrails:** native zsh only · **no third-party install, no sudo** (if a genuine install is needed → STOP and
   report) · **no `~/`/absolute paths bound into any repo, beacon, or canon** (machine layer only) · carry `host:`.

7. **When done:** shift this card from `_mail/astrobley/inbox/` → `archive/`. If the syncer earns a manual, add a
   chapter on it to `~/.config/zsh/guides/ai.md` (the master AI-bonded-scripts guide).

## scope fence (do not cross)
- Cross-repo **mail-staging only**. Do NOT replace, duplicate, or modify the canon-doorbell (`temple-doorbell` /
  the `post-commit` hook) — it is a different transport and stays as-is.
- Do NOT diff canon, do NOT enumerate what changed — that is the propagation pass's job, not this one.

— prepared by Houston (temple architect) for @majkee to dispatch · host: office · 2026-06-27
