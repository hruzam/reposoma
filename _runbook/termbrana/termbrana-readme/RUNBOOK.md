---
goal: Review and close the evidence-backed Termbrana README without changing the M0 gate, ensuring all claims match the captured evidence and the open M0 status.
state: fresh
participant_1: [claude-code, {brand: "Claude Code CLI", model: "claude-3-7-sonnet", effort: "high"}, host: "office"]
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
You are executing the Termbrana README handoff and closure task.
Read-only source context and active state:
- Cold-Start Card: /home/hruzam/reposoma/_runbook/termbrana/termbrana-readme/raw/CS.termbrana-readme.2026-08-24.md
- Active Nablarva Pulse: /home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md
- Session-02 Status: /home/hruzam/unikuklatrix/nablarva/.dev/session/toolbox-termbrana-02-m0-truthspike/status.md
- M0 Evidence: /home/hruzam/unikuklatrix/termbrana/research/evidence/

Your primary directive:
Review the Termbrana README (/home/hruzam/unikuklatrix/termbrana/README.md) against the captured evidence files and status.md. Make sure every single claim is strictly evidence-backed and aligns with the open, non-frozen M0 gate.

Allowed modifications:
- ONLY /home/hruzam/unikuklatrix/termbrana/README.md (clarity, truthfulness, link correction)
- ONLY /home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md (to document the accepted disposition once done)

GATED:
- Do NOT perform git commit or push.
- Do NOT alter any other file, flag, or topology.

Steps to execute:
1. Run "git -C /home/hruzam/unikuklatrix/termbrana diff e319ed4 HEAD -- README.md" to see the full set of modifications made to the README.
2. Read the evidence files in "/home/hruzam/unikuklatrix/termbrana/research/evidence/" and compare the README's technical assertions. Look for discrepancies, specifically around:
   - Zellij PTY and rendering limitations.
   - Pinned host tooling versions (Zellij 0.44.3, Rust 1.95.0, wasm32-wasip1).
   - Expected permissions and permissions granted logic.
3. Apply any necessary surgical updates to README.md using your file editing tools to align claims perfectly with truth and evidence.
4. Run "git -C /home/hruzam/unikuklatrix/termbrana diff --check" and verify all local links.
5. Compile the cargo target to ensure no build instructions were broken:
   "cargo -C /home/hruzam/unikuklatrix/termbrana build --release --target wasm32-wasip1 -p termbrana-zellij"
6. Prepare a concise summary report of your findings, corrections made, and the diff.
```

---

## prompt-2

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
