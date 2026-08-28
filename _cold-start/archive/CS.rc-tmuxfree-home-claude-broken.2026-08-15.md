CS · 2026-08-15 · rc.sh tmux-free launcher DONE · home claude install BROKEN (repair first)

commit : 50dce84 (ia-sync/main)   # the rc.sh work — all pushed
task   : /rc-launch → launch trajectory on reposoma@home from office
context: transport + launcher are SOLVED and deployed. The one open blocker is
         home's claude binary — a botched update left no working `claude`. Fix
         that FIRST, then a single mode-B launch finishes the original request.
resume : (repair home claude — see below) → then on home:
         rc.sh reposoma --agent trajectory --effort high

---

## DONE this session (don't redo)
- **Transport, permanent:** tailnet SSH ACL flipped `check`→`accept` for
  `autogroup:self` (Tailscale admin console). Headless ssh both directions now —
  office↔home. This is the phone-service foundation.
- **rc.sh rewritten → tmux-free A/B hybrid**, deployed to BOTH machines, pushed.
  Source of truth: `ia-sync/zsh/ai/rc.sh` (commits db15264, 330c5e7, 50dce84).
    - Mode A: `rc.sh <project>` → bare `claude remote-control` server via
      `setsid nohup` (no tmux, no pty). Pick agent inside the caught session.
    - Mode B: `rc.sh <project> --agent A --effort E` → interactive flag-form
      `claude --agent … --remote-control` wrapped in `setsid nohup script -qfc`
      (pty WITHOUT tmux). A specific phone-reachable session, settings preset.
    - `_stop` kills exact matched pids (NOT broad `pkill -f <name>` — that bug
      killed the caller's own ssh session mid-run; fixed in 50dce84).
- Design gavel: **minimize tmux** (majkee). Do NOT reintroduce tmux. `script`
  is the pty when one is needed.

## THE BLOCKER — repair home's claude install (do this FIRST)
Home's `claude` is broken since ~10:31 local today. An npm update to **2.1.233**
was **interrupted mid-reify** (`~/.npm/_logs/2026-08-15T08_31_*-debug-0.log`),
leaving only the package's fallback shim `bin/claude.exe` ("native binary not
installed") and an un-finalized symlink `~/.npm-global/bin/.claude-t2PFqKnX`.
No working `claude` resolves on home — not even in the login shell.

**majkee's read (act on this):** home's claude was likely installed by a PREVIOUS,
non-natural method (the `~/.npm-global` prefix) — NOT the official claude
installer. 2.1.233's new packaging (thin npm wrapper + platform-native optional
dep placed by a postinstall) does not survive cleanly under that legacy setup.
So the repair is NOT just "npm reinstall into npm-global" — it is to reinstall
home's claude the NATURAL way and retire the npm-global copy.

**Target end-state = mirror OFFICE (healthy):** office resolves a clean 2.1.233
at **`~/.local/bin/claude`** (native install), and has NO claude in
`~/.npm-global/bin`. Home should match that.

Repair steps for the next session:
  1. Reinstall home's claude via the OFFICIAL/native installer (land
     `~/.local/bin/claude`, like office). If the npm-global copy interferes,
     remove the stale `~/.npm-global/{bin/.claude-t2PFqKnX, lib/node_modules/@anthropic-ai/claude-code}`
     first (it only holds the broken shim).
  2. Verify: on home `claude --version` → 2.1.233, and `command -v claude` →
     `~/.local/bin/claude`.
  3. rc.sh needs NO change — `_claude_bin` already checks `~/.local/bin/claude`.

## THEN — finish the original request
On home (over `tailscale ssh hruzam@hruzam.tail36b8ab.ts.net`, or locally):
    rc.sh reposoma --agent trajectory --effort high
Expect a mode-B session, catch URL `https://claude.ai/code/session_…` in
`~/.cache/rc/reposoma.log`. Catch it from the Claude mobile app (session
"Reposoma"). That IS "launch trajectory on reposoma@home" made literal.

## State pointers
- Launcher source: `ia-sync/zsh/ai/rc.sh` (deployed live at `~/.config/zsh/ai/rc.sh` both boxes).
- Home launch logs: `~/.cache/rc/reposoma.log`.
- npm failure evidence: home `~/.npm/_logs/2026-08-15T08_31_47*/49*-debug-0.log`.
- Broken shim proof: home `~/.npm-global/lib/node_modules/@anthropic-ai/claude-code/bin/claude.exe`.

## Follow-up (not blocking)
- `/rc-launch` skill doc still describes the OLD tmux/agent-at-launch contract and
  prints tmux attach lines. Reconcile it to the A/B reality (A=pick-inside,
  B=preset via script pty). Engine tolerates the old flags so nothing breaks today.

## Cleanup / hygiene
- Throwaway test logs on home (harmless, deletable): `~/.cache/rc-ptytest.log`,
  `~/.cache/rc-agenttest.log`.
- Nothing is running on home now — the earlier hand-launched mode-A Reposoma
  session (pid 23558) was stopped during the mode-B switchover.

## Session advice
- Investigate-before-acting paid off: majkee held me back from a blind
  `npm i -g` into a possibly-wrong prefix; the real fix is the native installer.
  Confirm the install METHOD before "repairing" a package.
