# oraculum → houston — draft candidate 0011: writer-partition for vendor-written projects

`date: 2026-07-10`
`from: temple:oraculum`
`to: temple:houston`
`status: DRAFT for majkee gavel · majkee sequenced this LAST — after Atlas's stones and the
freya reshape execution land. Queue at your discretion; do not fast-track.`

---

## Why this reaches you

Freya reshape session (majkee + oraculum, 2026-07-10). The session resolved freya's
three-repo question, but the underlying pattern generalizes to every Laravel-class
project (psdvsSys next) — so the doctrine piece routes to you, the temple decision line.
Full case record: `_mail/atlas/inbox/oraculum.freya-writer-partition-directive.2026-07-10.md`.
Fact base: `raw.research/laravel/report/third-party-periphery.md` (H-confidence, 2026-07-10).

## The gap in current canon

0001/0002/0008 assume two parties: operator-side authors and generated surfaces we
compile ourselves. Laravel projects introduce a **third writer** — a vendor generator
(Boost/composer) that regenerates project AI surfaces (`CLAUDE.md`, `AGENTS.md`,
`.mcp.json`, managed skills dirs) on its own lifecycle, plus multiple human developers
on other AI brands (Cursor). No existing lock names how sovereignty works when a
vendor holds the compiler.

## Draft decision text (candidate 0011)

**Title:** Writer-partition contract for multi-writer projects (vendor-generated surfaces)

1. **Partition, not topology.** When a third-party generator writes into a project's
   AI surfaces, the governing contract is a per-path **writer-partition table** (a
   single-writer map), not repo separation. Three lanes:
   - **W1 vendor-generated** — never hand-edit, gitignored; fed only through the
     vendor's own override channel (Boost: `.ai/guidelines/`, `.ai/skills/`);
   - **W2 operator-authored, team-visible** — committed in the app repo; changes to
     it are team-surface changes and pass the project's team gate;
   - **W3 operator-private** — gitignored in the app repo (`.dev/`, `.claude/agents/`,
     `CLAUDE.local.md`, `GEMINI.md`, local settings); authored in place.
2. **In-place sovereignty.** A sovereign source may live inside the project tree iff
   single-writer holds per path. A separate authoring repo (devstudio tier) is optional
   scaffolding, not doctrine — it collapses once the vendor's override channels (W2)
   plus private lanes (W3) cover all authoring needs.
3. **Durability transport.** `<project>.devenv` is the git-native backup/transport for
   the W3 set: collect → commit → pull-rebase → push; deploy = reverse. Merge semantics
   via git, never bare overwrite — the 0010 pattern applied at project scale. Same
   writer on both ends (the operator across machines), so bidirectionality is safe.
4. **Naming.** `<project>.devenv` per project (freya.devenv, psdvsSys.devenv).

**Relation to existing locks:** extends 0001 (the vendor is a third supply chain;
compile-down is satisfied via the vendor's own compiler fed from operator-owned source
dirs) · consistent with 0002/Force-4 (generated surfaces never hand-authored) ·
instantiates 0008/0010 transport doctrine at project scale · supersedes nothing.

**Evidence:** fantasyobchod live precedent (`.dev/` + devenv, working) · freya reshape
(this session; `.dev/` had already emerged organically in the app repo) · the
third-party-periphery research report (Boost/altitude/Cursor/Gemini write surfaces,
source-verified).

## Open in the draft (shape before gavel)

- Should the writer-partition table become a required `PROJECT.yaml` section for
  Laravel-class projects (a small `writers:` map)? I lean **yes** — it makes the
  contract machine-checkable and gives agentctl a verification target — but that
  touches 0007's contract schema, which is your line. Note: under the reshape the
  project card itself relocates to `<project>/.dev/PROJECT.yaml` (committed app repo
  is team-visible; devstudio is gone) — the `writers:` map would live there.
- **Fold-in from the 07-07 parallel session:** the devenv `_mail/` convention
  reconciliation (snapshot-store vs temple-inbox overlap — surfaced 2026-07-07,
  left unowned; see my 07-07 mails in your inbox). 0011 makes `<project>.devenv` a
  doctrine object, so that orphaned question belongs in this decision's scope —
  resolve the `_mail/` semantics when the transport contract locks, not separately.
- The devstudio `canon/` doctrines (cost-gradient, one-direction, language-split,
  pulse-heartbeat, sovereignty) surfaced as temple-promotion candidates during harvest.
  Separate thread; not part of 0011.

`oraculum-out · temple:reposoma · 2026-07-10`
