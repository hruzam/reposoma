---
chapter-of: germline-forge
title: fold-scheme — global vs project seats, deploy legs vs manual, canonical homes, the workbench
verified: 2026-10-07 · deploy.sh legs read from ~/ia-sync/deploy.sh; Codex entry facts per codex-cli 0.160.0; Claude placement per B4 observation on claude 2.1.292
---

# fold-scheme — where each layer of a forged agent lives, and how it reaches a running session

`question answered: "what goes to ~/ia-sync and bash deploy.sh, what is put manually into the project, under which scheme?" (majkee 2026-10-07, item 3)`

## 1 · Two kinds of seat

- **GLOBAL seat** — the identity is the seat's whole body; it runs in any project (Atlas, Flight,
  the readers). Its renders live on the surgical table and spread by `deploy.sh`.
- **PROJECT seat** — the identity is shared, but the body that runs is composed *with a project
  addendum* (Houston in nablarva). Its renders live **in the project**, committed with it, and
  load from the project's own agent directories. The global render of the same slug, if any,
  is a project-less fallback.

Both kinds use the same five source files; only the render destinations differ.

## 2 · The table (authoritative for this guide's date)

| layer | global seat | project seat | mechanism to live |
|---|---|---|---|
| `identity.md` | `~/reposoma/.germline/agents/<slug>/identity.md` | the same file (never forked per project) | `git commit` in reposoma; `~/.germline` is a host symlink to it — **deploy.sh has no `.germline` leg by design** |
| `project/<project>.md` | — | `<project>/.germline/agents/<slug>/<project>.md` | committed with the project; manual |
| `binding.claude.md` · `binding.codex.md` | `~/reposoma/.germline/agents/<slug>/binding.<vendor>.md` (proposal — no global forge has used it yet) | `<project>/.germline/agents/<slug>/binding.<vendor>.md` (**gaveled** 2026-10-07) | committed with their owner repo; manual |
| Claude render | `~/ia-sync/claude/agents/<slug>.md` | `<project>/.claude/agents/<slug>.md` | global: `bash ~/ia-sync/deploy.sh` (rsync leg `claude/agents/ → ~/.claude/agents/`, additive, never deletes) on each machine after `git pull` · project: commit; Claude Code scans `<cwd>/.claude/agents/` at session start |
| Codex render — child | `~/ia-sync/codex/agents/<slug>.toml` | `<project>/.codex/agents/<slug>.toml` | global: deploy.sh leg `codex/agents/ → ~/.codex/agents/` · project: commit; selected by `spawn_agent` |
| Codex render — main session | a named profile in `~/.codex/config.toml` (`[profiles.<slug>]` carrying the composed instructions) | same file | **manual on each machine** — `config.toml` is local by design; no deploy leg; `codex --profile <slug> -C <root>` |
| workbench | `<bed>/raw/<slug>/` (the seven files) | same | nothing loads it; it dies with the bed after promotion; the only copy of the package until then |

## 3 · Facts the table rests on (dated; re-verify on upgrade)

- **Claude Code loads the agent body at session start** and resolves a project agent ahead of the
  same-name global one when started inside the project (observed 2026-10-07: a project
  `.claude/agents/houston.md` probe was the session body under `claude --agent houston`). A session
  started before a file was placed keeps the body it loaded.
- **The `/agents` wizard is removed** in claude 2.1.292; the operator edits the files directly.
  Proof of identity is behavioural ("do you know this sentence…").
- **Codex 0.160.0** exposes `--profile`, not `--agent`; files in `.codex/agents/` configure spawned
  sessions and provide no direct CLI selector; direct entry is a profile with
  `developer_instructions` (cartan(.germline), journal 2026-10-07 §1.1.1).
- **`deploy.sh` is additive rsync per leg** (`claude/{agents,skills,commands}`, `codex/{agents,skills}`,
  gemini, zsh); it copies files, it does not compose them; it never touches `.germline` or
  `config.toml`.
- **The runtime artifact is not the render.** Claude: a copy of the render at the destination.
  Codex: a TOML or a profile *carrying* the render's body. Name their writer in the build
  assignment — the Houston forge did not, and every behavioural proof on the Codex side waited on it.

## 4 · The sequence for one forged agent

```text
bed opens ── RUNBOOK names: slug · global|project · sole writers · write scopes · witness seat
   │
   ├─ sources: identity (if new) · addendum · binding.claude · binding.codex   ← each with home:
   ├─ renders by pipeline · README with manifest + the three checks               ← checks green = FREEZE
   ├─ witness (non-author seat) on a fresh session → verified: in the binding      ← may reopen; re-freeze
   ├─ (if the agent inherits a maintainer role) real audit from the card           ← gate input
   ▼
promotion (operator, reviewed merge): copy source + render to canonical homes · commit · stamp revision
   │   global: push ia-sync → other machine pulls → deploy.sh      project: travels with the project
   │   Codex profile: by hand on each machine
   ▼
keeper migration (if any) → points at the canonical card · one writer · one commit
```

## 5 · Anti-patterns seen

- Treating the workbench as canonical (a render stamped with a `raw/` path).
- A global thin wrapper "pointing at" a project source — unnecessary on Claude (project wins) and
  not a mechanism on Codex (no `.md` discovery); compose at build time instead.
- `sync.sh` (live → repo) run against a freshly authored, not-yet-deployed table file — it
  overwrites the table with the stale live copy (ia-sync caution, 2026-07-30).
- Assuming `deploy.sh` reaches `.germline` or `config.toml`. It does not.
