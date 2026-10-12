---
title: Muticula — master brief (the animal plan)
status: proposed · awaits majkee's veto on D1, D2
born: 2026-09-26 · voice session majkee × Nabla, folded in chat
phase: B (architecture) → C (build order, §5)
---

# Muticula

tmux + cuticula: the thin outer layer that keeps concurrent CLI sessions from abrading each other in one working tree.

**Tags.** Provenance: `[ARCH]` settled in the voice session — majkee's X, shaped together (dialogue consensus, not triangulated) · `[NABLA]` added while folding — not yet argued, veto-able · `[OPEN]` needs a decision. Tier: `[CORE]` build first · `[v2]` grow only when its trigger fires. A heading's tag covers its body unless a line says otherwise.

---

## 1. The animal `[ARCH]`

**What.** A file-backed concurrency guard for several agent CLI sessions (Claude Code, Codex, …) sharing one git working tree. One script; its `watch` mode is the only long-running piece.

**Field problems it answers.**
1. Shared bookkeeping — task journal, invariant file — is the main collision point: every session head writes it.
2. Whole-tree git verbs (`git add -A`, `git commit -a`) sweep a neighbor's work into your commit.
3. `git diff` is a global surface: a session rebuilding its picture from the diff adopts a neighbor's changes as its own.
4. Read-once claims: the first session checks for neighbors at start and never again. The second sees the first; the first never learns about the second.
5. Rare cross-cutting operations — migration, mass rename, dependency change — whose footprint no per-file claim can express.

**Stance.** Coordinate in one shared tree instead of isolating each session. A mix of pessimistic (claim before you touch) and optimistic (check again at commit), borrowed from how processes share files and databases share rows. Isolation — worktrees — is Alternative B (§9).

**Scope** `[NABLA]`. One repo, one machine, local filesystem, cooperating sessions.
**Out of scope** `[NABLA]`. Security: a seatbelt against accidents, not a wall against a session that means to get around it. Runtime isolation: §8.

**Roles.**
- **C# ("sharp")** — session head. First in, holds the observation line across the whole task, last out. Owns every Muticula write for its team.
- **Spawn** — sub-agent under a sharp. Works locally, reports up, never calls Muticula write verbs.
- **Human** — the top voice. Only the human reaps a dead sharp or clears a frozen beacon; in v0 also the relay between sharps. Recognized cheaply: no `MUTICULA_ID` in the environment `[NABLA]`.
- **Maintainer** — folds abandoned work back. In v0: the human.

## 2. Invariants

1. **Machine says stop; only an authorized voice says go.** Every automatic path ends in refusal or hold, never in release. Release, override and co-ownership belong to the owner, a higher rank, or the human. A policy bug makes Muticula too cautious, never too reckless. `[ARCH]`
2. **Checks ride on actions.** No polling, no clock for sessions. Awareness refreshes at `claim` and at `commit` — and the commit is the one action nobody skips. The only clock in the system faces the human (leg 3). `[ARCH]`
3. **No verb waits on another session.** Every verb answers at once: exit 0 / 3 / 4. Waiting inside a hook or a tool call runs into the CLI's timeouts; a refused sharp retries at its next natural checkpoint. The lock is held for milliseconds and its wait is bounded. `[ARCH]` concern · `[NABLA]` rule
4. **One writer per file.** Per-sharp files have one writer. Human overrides are appended as tombstones in the human's own file, never edits of a sharp's file. Shared views — registry, journal — are projections: rebuilt, never edited. One `flock` serializes check-then-act across files; it is never held while thinking, and readers never take it. `[NABLA]` — carried from larva's invariants (one writer per file, derived-is-disposable, tombstones)
5. **In a shared tree, every whole-tree git verb is a cross-session write.** Sharps get path-scoped verbs only, and stage/commit only through the gate. `[ARCH]`, generalized `[NABLA]`

## 3. State `[CORE]`

Intent `[ARCH]`: a registry of sessions with purpose and state, a journal per session, a live status `.md` per head, settled states gathered in one main journal. Layout `[NABLA]`:

Location: `$(git rev-parse --git-common-dir)/muticula/` — next to git: never tracked, never dirties the tree, one per repo, visible from worktrees too. → D2

```
muticula/
  lock                  flock target — check-then-act only
  sharps/<id>           <state> <rank> <since> <purpose…>             writer: sharp <id>
  claims/<id>           one path per line · dir/ = subtree ·
                        <path> ack:<holder> = knowing co-claim          writer: sharp <id>
  status/<id>.md        live state, carries a `pending:` line           writer: sharp <id>
  log/<id>              append-only: <id>'s verbs, plus its own notes   writer: sharp <id>
  settled/<ts>.<id>.md  settled entry, write-once                       writer: sharp <id> at close · human at reap
  beacon                empty = dark · <id> <since> <why…>              writer: its lighter, one at a time
  human                 append-only: reap · freeze · clear              writer: the human (watchdog on their behalf)
  journal.md            the book: settled/* in name order               writer: the projector — rebuilt at close / reap
```

- **Registry = `muticula ls`** — a view over `sharps/`, `claims/`, `status/`, `beacon`, `human`. The one central place, without a shared write head: field problem 1 is gone by construction.
- **Last seen** = mtime of `log/<id>`. Every verb appends; no extra field.
- **Journal** = settled entries only, materialized so an editor can watch it. Nobody edits it.
- **States**: active → closed (the sharp's `close`) · abandoned (the human's `reap`). A reaped sharp's claims are void from the tombstone on; its own files stay untouched.
- **Ids are single-use.** A closed or reaped id never reopens; identity lives in the file lineage.

## 4. The three legs `[CORE]`

### Leg 1 — Claims: the map `[ARCH]`
- **Claim before you touch.** Narrow paths, or `dir/` for a subtree. Claims belong to the team and are advisory: they constrain commits, not the editor (§8).
- **Check-then-act under the lock.** A live claim of another sharp overlaps — same path, or one is a `dir/` prefix of the other → exit 3 with holder, rank, since. Otherwise the path joins `claims/<id>`.
- **Awareness rides on output** `[NABLA]`. Every `claim` and `commit` prints one neighbors line — `c2 · app/model/ · 3m · beacon dark`. The first sharp learns about the second the next time it acts: read-once asymmetry gone, no polling.
- **Dirty on arrival** `[NABLA]`. Claiming a path that already has uncommitted changes lists them as inherited — typical after a reap.
- **Contested path — explicit ways forward only.** The holder releases, or a sharp of higher rank `ack`s: a knowing co-claim. Equal or lower rank → the holder decides; the human relays in v0. Rank is flat, set by the human at launch — e.g. Opus 3 · Sonnet 2 · Haiku 1. `[ARCH]` Opus-over-Sonnet · `[NABLA]` mechanics
- **What an ack consents to** `[NABLA]`. A co-claimed file is committed whole: whoever commits it records both sharps' edits.
- If rank rules ever want sub-cases, stop and open a separate thread — don't inflate `ack`.

### Leg 2 — The gate: `muticula commit` `[ARCH]`
The check is welded to the one action nobody skips. A wrapper, not a git hook: a hook reacts inside someone else's commit; the wrapper owns the commit and decides what goes in.

**Correction to the voice session** `[NABLA]`. Scoping `git add` is not enough. The index is one file shared by every session in the tree — a neighbor's staged paths ride a plain `git commit`. The gate commits by pathspec, `git commit -- <paths>` (git's `--only` mode): it records exactly those paths from the working tree and ignores whatever else sits in the index.

```
muticula commit -m "<msg>"
  1  take the lock
  2  beacon lit by another · beacon frozen · I'm reaped   → exit 4
  3  mine    = changed paths under my live claims (the whole tree if I lit the beacon)
     foreign = changed paths under others' claims            → left alone
     orphan  = changed paths under no claim                  → reported, never staged
  4  git add -- <untracked in mine>
     git commit -m "<msg>" -- <mine>
  5  append "commit <sha> <paths>" to log/<id>; print the neighbors line
  6  release the lock — commits are serialized, so sharps never race git's own index.lock
```

**`muticula diff`** `[NABLA]` — my picture only: `git diff HEAD -- <my claims>` plus my untracked files. Sharps rebuild their buffer from this, never from the global diff (field problem 3).

**Deny list** — in each CLI's own permission layer, zero code. `[ARCH]` for `add -A` · `[NABLA]` the rest
- stage / commit: `git add`, `git commit` in every form → only through `muticula commit`
- tree rewrites: `git stash`, `git reset --hard`, `git checkout -- .`, `git restore .`, `git clean`
- HEAD movers: `git pull`, `git merge`, `git rebase`, `git switch`, `git checkout <branch>` → human only; they rewrite everyone's tree
- human verbs: `muticula reap`

Rule syntax differs per CLI, and not every CLI can deny single commands — check current docs `[unverified · training-era]`. Where a CLI can't, the agent contract (§5) is the only fence.

### Leg 3 — The beacon: a global barrier `[ARCH]`
*Maják* — the blinking roof light, not the lighthouse.
- **Binary.** Dark or lit. One question: is a cross-cutting operation in flight?
- **Beacon-class** `[NABLA]` = a footprint that can't be written as claims: migrations, mass renames, dependency/lockfile changes, router rewrites, the human's HEAD movers.
- **Clean floor to light** `[NABLA]`. `beacon on` refuses (exit 3) while uncommitted changes exist outside the lighter's own claims, and names the paths and holders that must commit or release first. Once lit, the lighter holds the whole tree; everyone else gets exit 4 on `claim` and `commit` — hold, tell the user. Without the clean floor, the lighter could only commit its cross-cutting change by sweeping neighbors' work.
- **Normal path.** The lighter turns it on before the operation and off after. It stays lit only when forgotten.
- **Watchdog.** `muticula watch` runs in a multiplexer pane or popup and faces the human. Every 5 min while lit: `lit by c1 for 25m: <why> — keep / off?` Keep resets the strikes; off clears; silence is a strike.
- **Kill switch.** The human's `muticula beacon off`, from any terminal, any time.
- **Strike 3 (~15 min unanswered) → freeze.** The lighter is refused too; only the human clears. Whatever the lighter hadn't committed stays on the floor — the human commits or discards it. `[OPEN]` → D1
- **A file, not a process** `[NABLA]`. The beacon survives crashes on purpose. Without `watch`, a forgotten beacon simply holds — same fail direction.

## 5. Surface `[CORE]` `[NABLA]`

| verb | who | effect | exit |
|---|---|---|---|
| `open "<purpose>"` | sharp | register, set purpose, print the status-file path; implicit on the first verb | 0 |
| `claim <path>…` | sharp | take paths; `dir/` = subtree | 0 · 3 held · 4 hold |
| `release [<path>…]` | sharp | give back; all if none | 0 |
| `ack <path>` | sharp ranked above the holder | knowing co-claim | 0 · 3 rank too low |
| `diff` | sharp | my changes only | 0 |
| `commit -m "<msg>"` | sharp | the gate | 0 · 4 hold · 1 git error |
| `beacon on "<why>"` / `off` | sharp / human | light on a clean floor / clear | 0 · 3 floor dirty · 4 already lit |
| `close` | sharp | settled entry, release all, rebuild the journal | 0 |
| `ls` | anyone | registry: sharps, purpose, claims, last seen, pending, orphans, beacon | 0 |
| `reap <id>` | human | tombstone: claims void, settled as abandoned | 0 |
| `watch` | human | the beacon watchdog | — |

**Exit codes.** `0` go · `1` error · `3` held by another — work elsewhere, tell the user, retry later · `4` hold — beacon, freeze or reaped: stop, tell the user.

**Env.** `MUTICULA_ID`, `MUTICULA_RANK`, set by the human at launch: `MUTICULA_ID=c1 MUTICULA_RANK=3 claude`. Spawns inherit both — identity is per team.

**Settled entry** — a fixed envelope; the content stays the sharp's. `[ARCH]` "the structure must be clear" · `[NABLA]` fields
```
## <iso-time> · <id> · closed | abandoned
purpose: …   rank: …   commits: <sha …>
<status/<id>.md verbatim — without a `pending:` line, the envelope writes `pending: (not stated)`>
```

**Implementation.** bash + `flock(1)` + git. Every write is temp + rename; `flock -w` bounds any lock wait. Budget ~250 lines; past ~300 → port (§7).

**Agent contract** — paste into CLAUDE.md / AGENTS.md:
```
You are sharp $MUTICULA_ID. Muticula guards this shared working tree.
- Claim before you touch: muticula claim <path>  (dir/ = subtree). Claim narrow, release early.
- See your own work with: muticula diff — never plain git diff.
- Commit only with: muticula commit -m "…"
- Exit 3: someone holds it. Work elsewhere or tell the user. Don't fight it.
- Exit 4: hold — beacon, freeze, or you were reaped. Stop and tell the user.
- Before a cross-cutting change (migration, mass rename, dependency change, router rewrite):
  muticula beacon on "<why>" — and muticula beacon off when done.
- Keep your status file current (path from muticula open), with a pending: line.
- Spawns: no muticula write verbs; report to your sharp.
- Last act: muticula close
```

**Build order** — each step ships alone:
0. Deny list in each CLI — zero code, kills the sweep today.
1. State dir, lock, `claim` / `release` / `ls` / `diff`.
2. `commit` — the gate.
3. `close` / `reap`, settled entries, the journal book.
4. `beacon` + `watch`.

## 6. Decisions — majkee's veto `[OPEN]`

**D1 — The beacon after three unanswered pings: freeze or clear?**
Both directions were voiced in the session, and Nabla endorsed both in consecutive turns — a slip. This brief defaults by invariant 1.
- **Freeze** (default). Stalled beats corrupted. Cost: while you're away, everything waits for you.
- **Clear.** Cheaper in the common case — a beacon forgotten after a finished operation. It fails in exactly the case the beacon exists for: an operation dead halfway across a footprint no claim covers. And it is the machine saying go.

If a real class of operations wants *clear*, that is the trigger for graded operations (§7), not a reason to flip the default.

**D2 — State in `.git/muticula/` (default), or tracked in the tree?**
- `.git/muticula/`: never tracked, never dirties the tree, survives a move to worktrees. Cost: the journal is not in git history.
- Tracked: the journal is in history — but a shared tracked file is the original hotspot. If history matters, one actor, the human, snapshots `journal.md` into a commit. Sharps never do.

## 7. Growth — only when the trigger fires `[v2]`

- **Edit-time check** `[NABLA]` — a pre-edit hook in the CLI: instant allow/deny against claims, never waits. *When:* unclaimed edits keep surfacing as orphans. `[unverified · training-era: hook API per CLI]`
- **Sharp inbox** `[NABLA]` — `inbox/<id>`, append-only, shown at `claim` / `commit`. *When:* you, as the relay, become the bottleneck.
- **Wait line** `[ARCH]` idea, deferred — FIFO per contested path. *When:* a sharp keeps losing the same path.
- **Claim lease** `[ARCH]` corner (the dead sharp) — silence expires claims; the gate already fences a sharp that wakes up; dirty-on-arrival shows the next claimant what it inherits. Still the machine saying go: argue it against invariant 1 first. *When:* reaping by hand becomes a chore.
- **Graded operations — the traffic light** `[ARCH]` idea · `[NABLA]` scoping. Its one legitimate job: choose the beacon's fail direction per operation — fragile → freeze, routine → clear. Never ownership; that stays with rank. Two mechanisms deciding one question will disagree. *When:* D1's single default proves wrong for a real class of operations.
- **One Rust binary** `[NABLA]`. *When:* the script passes ~300 lines or needs real parsing.

## 8. Known limits `[NABLA]`

- **Claims are advisory until the edit-time check exists.** An unclaimed edit inside someone's claimed file rides their next commit; the gate can't see who typed what.
- **Shared tree, shared runtime.** A neighbor's half-edit can break your test run or build. Muticula prevents contamination, not interference. If this dominates → §9.
- **Team identity.** Spawns inherit the sharp's id; the sharp/spawn split is convention, not mechanism.
- **Moves touch two paths.** `git mv a b` needs both claimed.
- **Seatbelt, not a wall.** A session can unset its env, or find a gap in the deny list.

## 9. Alternative B — the open door `[ARCH]`

Muticula answers the first fork — coordinate in one tree, or isolate each session — with *coordinate*. B is the other branch, deliberately not designed here. Anyone may open it, any time. Opening it is the normal turn-back, not a failure: one solution didn't fit, find another.

**Signals.** Interference (§8) dominates; sharps spend more time holding (exit 3 / 4) than working.
**Bridge** `[NABLA]`. The state lives in git's common dir, so claims and the beacon stay visible across worktrees — parts of Muticula may survive into B.

---

**Provenance.** Born in the 2026-09-26 voice session, folded in chat the same day. Dialogue consensus, not triangulated — a heterogeneous challenger pass before code is still open. Restart: the earlier Muticula build is not an input to this brief; carried is the name. **Next:** veto D1 and D2 → Phase C, build step 0.
