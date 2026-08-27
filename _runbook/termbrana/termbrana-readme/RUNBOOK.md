---
goal: Review and close the evidence-backed Termbrana README without changing the M0 gate, ensuring all claims match the captured evidence and the open M0 status.
state: fresh
participant_1: [claude-code, {brand: "Claude Code CLI", model: "fable", effort: "high"}, host: "office"]
participant_2: [codex, {brand: "Codex CLI", model: "gpt-5.6-sol", effort: "high"}, host: "office"]
---

# RUNBOOK: Termbrana README Handoff & Closure

## Source and Scope

- **Primary Source (Cold-Start Card):** `raw/CS.termbrana-readme.2026-08-24.md`
- **Target Repository:** `/home/hruzam/unikuklatrix/termbrana/` (branch `core`)
- **Central Governance File:** `/home/hruzam/unikuklatrix/nablarva/.dev/session/flag.md` (specifically L11 and L9)
- **Active Pulse:** `/home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md`
- **Session-02 Status:** `/home/hruzam/unikuklatrix/nablarva/.dev/session/toolbox-termbrana-02-m0-truthspike/status.md`
- **M0 Evidence Folder:** `/home/hruzam/unikuklatrix/termbrana/research/evidence/`
- **Authority / Allowed Writes:** 
  - `/home/hruzam/unikuklatrix/termbrana/README.md`
  - `/home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md`
- **Gated Actions:**
  - Commit or Push to Termbrana repository.
  - Milestone 0 (M0) host-contract freeze.
  - Flag or topology changes.
  - Codex deployment.

---

## Action Plan (The Repair Queue)

The objective is to carefully review the Termbrana `README.md` (currently committed in `3960454` with 153 insertions) against the actual evidence in `/home/hruzam/unikuklatrix/termbrana/research/evidence/` and the pending M0 gates to make sure it is completely truth-backed.

### Step 1: Claim-by-Claim Evidence Review
We must cross-reference claims made in the expanded `README.md` against corresponding evidence:
1. **Zellij & Tooling versions** in README section `Build and load the probe harness` match `research/evidence/host-versions.md` (Zellij 0.44.3, rustc 1.95.0, target `wasm32-wasip1`).
2. **API and capture boundary findings** match `research/evidence/api-surface-0.44.3.md` and `research/evidence/t02-pane-content-semantics.md` (e.g., that no `raw_pty` is reachable, and `dump-screen` returned empty for plugin panes).
3. **M0 Gate status** matches `status.md` (noting that the M0 gate is **not frozen** because human-in-the-loop steps on the operator pad `pad.1-m0-runtime-confirm.md` are still pending).

### Step 2: Content Adjustments for Veracity
Refine the `README.md` to:
- Correct any overstated or inaccurate developer/model claims.
- Resolve any dead local file or section links.
- Maintain clarity on the exact nature of the M0 truth-spike phase.

### Step 3: Local Checks
Validate the file modifications:
- Run `git -C /home/hruzam/unikuklatrix/termbrana diff --check` to verify no whitespace issues.
- Confirm any changed build commands compile successfully on the host by verifying:
  `cargo build --release --target wasm32-wasip1 -p termbrana-zellij` (no-op or success).

### Step 4: Disposition Recording
Upon successful review and any needed edits, update the active Nablarva pulse file (`/home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md`) to reflect the completed README review state under the `2026-08-24 · Termbrana README handoff` section, or append a fresh entry if necessary.

---

## prompt-0

###### prompt

```text
Termbrana M0 closure — office session.                                                        

 0 · Verify host before anything. Run ls /usr/bin/php74 && command -v valet. Both present = office, 
 proceed. Absent = you are on home, where zellij is ABSENT and termbrana cannot build — stop and say
 so. Do not trust any file's host: header; zsh/AGENTS.md, zsh/CLAUDE.md and the ai/temple-*.zsh 
 headers all declare "office" regardless of where you actually are. See ~/ia-sync/AGENTS.md §"Which 
 host am I on?".

 1 · Read, in this order. nablarva/AGENTS.md → .dev/session/flag.md (L6, L9, L11 — L11 governs 
 termbrana entirely) → .dev/session/pulse.md top entry → 
 toolbox-termbrana-02-m0-truthspike/status.md → pad.1-m0-runtime-confirm.md.

 2 · The only legal path. L11: "One integration owner; no parallel coding before M0 freezes the host
 contract." Do not open M1 work, do not touch termbrana-core, do not plan lanes. Close M0 or do 
 nothing.

 3 · First action — check the pad's >MAJKEE report fences. STEP 0 was sat 2026-08-16 (<MATCH>). 
 STEPS 1–5 were still empty as of 2026-08-25.
 - Empty → hand majkee the pad. One step, one concept, wait for his report, then the next. You 
 drive, he is the hands. Never run ahead. Steps 2–3 are zellij action pipe probes; step 4 judges 
 resize/flicker; step 5 is the largest evidence gap.
 - Filled → fold results into the PENDING-OPERATOR rows of research/evidence/t02–t05 + 
 pane-content-matrix.md, then @Assay fresh-eyes over the full evidence set (handoff gate law — the 
 writer does not verify their own work), then freeze.

 4 · Two things to resolve before freezing.
 a) termbrana/README.md carries an uncommitted +153/−3 expansion by @Cartan. It is not stashed. 
 Review it against CS.termbrana-readme.2026-08-24.md. Do not git checkout it away.
 b) The machines are Manjaro (ID=manjaro), not Arch. research.epoch.host-versions.2026-08-15.md 
 justified the M0 pins on "Arch extra in sync with upstream" — wrong repo; Manjaro holds packages 
 behind Arch on staged branches. PAD-01 confirmed the pins empirically so they probably hold, but 
 decide explicitly whether to accept or re-verify before freezing a contract whose stated reasoning 
 cites the wrong distro.
 c) · Before freezing, re-verify the pins on office and record the distro. The host contract is a 
 machine-layer commitment. Run zellij --version && rustc --version && cargo --version on office and 
 compare against research/evidence/host-versions.md. Record ID=manjaro in the evidence file — the 
 pins came from Manjaro repos, not Arch, and the frozen contract should say which.

 5 · Gates. majkee owns commit, push, flag locks, and the M0 freeze itself. No termbrana-local 
 agent, harness, devenv twin, pulse, or beacon (L11). DECISIONS.md = product-technical ADRs only, 
 each citing its authorizing flag line.

 6 · After freeze. Session 03 (m1-core) opens, parallel lanes become legal, @Flight branch group 
 eligible. The A5 benchmark corpus (5 frozen sessions / 15 retrieval tasks) freezes during M1 — do 
 not forget it when 03 opens.
                                                            
 7 · Machine-layer carry. Read the HOME — 2026-08-25 entry in ~/ia-sync/journal.host-cleanup.md. 
 Office's zsh tree has never been drift-audited; home had 37 orphans. Run zsh 
 ~/ia-sync/zsh/blessings/zsh-orphans.zsh when convenient — report-only, no delete path.

```

---

## prompt-1

###### prompt

```text
Now that the README review is complete and verified:
1. Draft the update to be appended or integrated into the Nablarva Pulse file (/home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md) under the "2026-08-24 · Termbrana README handoff + Codex cross-section" header or as a fresh session line.
2. The entry must concisely state that the evidence-backed README has been reviewed, claims matched to evidence/status, checks verified, and is ready for @majkee's review.
3. Present the final proposed pulse entry for approval. Do not commit.
```

---

## Journal

- `Proxima, 2026-08-24: Created runbook for the Termbrana README handoff. Copied the cold-start card to raw/CS.termbrana-readme.2026-08-24.md and prepared the master prompt cascade.`

---

## References

- **Cold-Start Card:** `raw/CS.termbrana-readme.2026-08-24.md`
- **M0 Evidence:** `/home/hruzam/unikuklatrix/termbrana/research/evidence/`
- **Central Pulse:** `/home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md`
