# Cloud Session Invariance — Can a Working Session Live Machine-Independently?
**Date:** 2026-07-20
**Filed under:** raw.research / harness
**Dedicated to:** harness builder · @Atlas task
**Status:** VERIFIED — live sources fetched 2026-07-20; all version-sensitive claims confirmed

---

## 1 — Cloud Execution: What Anthropic offers today

Three distinct offerings, all in some form of preview or beta as of 2026-07-20:

### Claude Code on the web (`claude.ai/code`)
Runs tasks in Anthropic-managed VMs. Each session gets a fresh Ubuntu 24.04 container with a cloned GitHub repository. Sessions persist through browser close and can be monitored from mobile. Started from the web UI or via `claude --cloud` from the CLI.

- **Plan gate:** Research preview. Available on Pro, Max, Team, and Enterprise (premium seats or Chat + Claude Code seats).
- **Activation:** Web onboarding at claude.ai/code, or `claude --cloud "task"` from the CLI.

### Remote Control (`claude remote-control`)
NOT cloud execution. The Claude session runs entirely on your local machine; the web/mobile interface is a window into it. Transcript is relayed through Anthropic servers but execution stays local.

- **Plan gate:** Available on Pro, Max, Team, Enterprise. Team/Enterprise requires Owner to enable the toggle.
- **Activation:** `claude remote-control`, `claude --remote-control`, or `/remote-control` inside a session.

### Claude Managed Agents (platform API)
Developer-facing API for running autonomous agents in managed cloud sandboxes. Not a Claude Code feature — a separate product accessed via the Anthropic Platform API. Requires `managed-agents-2026-04-01` beta header. Enabled by default for all API accounts.

- **Plan gate:** Any Anthropic API account (beta access). Separate from claude.ai subscriptions.
- **Cloudflare partnership:** Cloudflare also offers a fast execution environment for Managed Agents (announced alongside the product).

| Offering | Execution site | Primary use case |
|---|---|---|
| Claude Code on the web | Anthropic cloud VM | Single-repo agentic coding tasks |
| Remote Control | Your machine | Steer local session from phone/browser |
| Claude Managed Agents | Anthropic cloud (or self-hosted) | API-driven long-running autonomous tasks |

SOURCE: [Claude Code on the web docs](https://code.claude.com/docs/en/claude-code-on-the-web) — CONFIDENCE: H (official docs, verified 2026-07-20)
SOURCE: [Remote Control docs](https://code.claude.com/docs/en/remote-control) — CONFIDENCE: H
SOURCE: [Managed Agents overview](https://platform.claude.com/docs/en/managed-agents/overview) — CONFIDENCE: H

---

## 2 — Persistence Limits: Session lifetime

### Claude Code on the web

- **Browser persistence:** Sessions persist if you close your browser. The underlying VM lives beyond the browser tab.
- **Inactivity expiry:** Cloud sessions stop after "a period of inactivity" and the underlying environment is reclaimed. Exact timeout is NOT documented — the docs say "a period of inactivity" and surface `Could not resume session ... its environment has expired` when it triggers. The environment cache (filesystem snapshot) expires after "roughly seven days" if the setup script hasn't changed.
- **No documented max lifetime.** No turn limit or hard wall on session duration is published.
- **Network drop:** If the Remote Control local process loses network for more than "roughly 10 minutes," the session times out and the process exits. (This applies to Remote Control only, not cloud sessions.)
- **Context window:** Auto-compaction runs when the context window approaches capacity; `/compact` is available in cloud sessions. No separate context limit is documented beyond the underlying model's window.

### Remote Control (local-process model)

- **Hard constraint:** The local `claude` process must keep running. Closing the terminal or quitting VS Code ends the session.
- **Network resilience:** Session reconnects automatically if the machine sleeps and wakes. But: network outage exceeding "roughly 10 minutes" → session times out, process exits.
- **One remote session per interactive process** (use server mode for multiple).

### Claude Managed Agents

- **Session status machine:** `idle` → `running` → `rescheduled` (transient retry) → `terminated` (unrecoverable error). No published maximum session duration.
- **Self-hosted worker idle:** `--max-idle` defaults to 60 seconds after `end_turn` stop reason.
- **No published idle timeout for cloud-hosted sessions.** Only termination on unrecoverable error is documented.
- **Stateful by design:** history, sandbox state, and outputs persisted server-side. Sessions are explicitly not ZDR/HIPAA eligible because of this persistence.

SOURCE: [Claude Code on the web — limitations section](https://code.claude.com/docs/en/claude-code-on-the-web#limitations) — CONFIDENCE: H
SOURCE: [Remote Control — limitations section](https://code.claude.com/docs/en/remote-control#limitations) — CONFIDENCE: H
SOURCE: [Managed Agents — session operations](https://platform.claude.com/docs/en/managed-agents/session-operations) — CONFIDENCE: H

---

## 3 — Repo Reach: What is accessible in a cloud session?

### Claude Code on the web — what is IN and what is OUT

| Item | Available | Reason |
|---|---|---|
| Repo `CLAUDE.md` | YES | Part of the clone |
| Repo `.claude/settings.json`, hooks | YES | Part of the clone |
| Repo `.mcp.json` | YES | Part of the clone |
| Repo `.claude/skills/`, `.claude/agents/` | YES | Part of the clone |
| **User `~/.claude/CLAUDE.md`** | **NO** | Lives on your machine |
| **User `~/.claude/skills/`, `~/.claude/agents/`** | **NO** | Lives on your machine |
| User-level MCP servers (`claude mcp add`) | NO | Writes to local user config |
| Static credentials / API tokens | NO | No secrets store yet |
| Interactive auth (AWS SSO etc.) | NO | Requires browser login, not supported |

**Multi-repo:** A cloud session clones one GitHub repository. There is no documented mechanism to mount additional repos or arbitrary directories in the same session. The GitHub proxy limits API and release-asset requests to repositories attached to the session. Running `claude --cloud` from a non-GitHub repo bundles only the current repo (100 MB limit; untracked files excluded).

**Files outside the repo:** Not accessible. The VM starts from a fresh clone. Anything not committed to the repo is not present. No cross-project state, no `~/.remote` drop-box, no sibling repo checkouts.

### The temple's specific constraints

The temple's architecture depends on:
- `~/.claude/` globals (agent definitions, global CLAUDE.md, skills) — NOT available in cloud sessions
- Multi-repo reach (reposoma + each project's repo) — NOT supported; one VM = one cloned repo
- `~/.remote/` drop-box (cross-session state relay) — NOT available
- `_mail/` folders living outside a single repo boundary — NOT available
- MCP servers configured at user scope — NOT available

None of these can be worked around by committing to a single repo because the temple's structure is deliberately multi-repo by decision (0004 or equivalent — point-never-copy discipline).

SOURCE: [Cloud environment availability table](https://code.claude.com/docs/en/claude-code-on-the-web#the-cloud-environment) — CONFIDENCE: H

---

## 4 — Session Portability: Handoff between machines and cloud↔local

### Teleport (`--teleport`) — cloud-to-local

Pull a cloud session into the local CLI: `claude --teleport` (interactive picker) or `claude --teleport <session-id>`. Requirements: same claude.ai account, correct repository checked out, clean git state, branch pushed to remote. Teleport fetches the branch and loads full conversation history.

This is the closest thing to "session portability" that exists today. Direction: cloud → local only from CLI. Desktop app provides a "Continue in another surface" menu that can send a local session to the web.

### `--cloud` flag — local-to-cloud (one-way)

`claude --cloud "task"` starts a new cloud session that clones the current repo's GitHub remote at the current branch. NOT a handoff of an existing local session — it starts fresh in the cloud. The older `--remote` spelling is a deprecated alias.

### Remote Control resume (`--continue`, `--session-id`)

`claude remote-control --continue` resumes the most recent Remote Control session from the same directory. `--session-id <id>` resumes a specific one. This is machine-bound — it resumes a local process that serves the session.

### `--resume` vs `--teleport`

`--resume` reopens a conversation from THIS machine's local history only. It does not list cloud sessions. `--teleport` lists cloud sessions. They are distinct paths.

### Transcript portability

While Remote Control is connected, the transcript (messages, Claude responses, tool activity) is stored on Anthropic servers. This enables sync across devices but NOT true session migration — the local process is still required.

### Hard limits on portability

- Teleport is unavailable on Amazon Bedrock, Google Cloud Agent Platform, Microsoft Foundry, or when `ANTHROPIC_BASE_URL` points at a proxy/gateway.
- Organizations with Zero Data Retention cannot use cloud sessions or Remote Control.
- API key authentication is not sufficient for any of these features — claude.ai OAuth required.

SOURCE: [Move tasks between web and terminal](https://code.claude.com/docs/en/claude-code-on-the-web#move-tasks-between-web-and-terminal) — CONFIDENCE: H
SOURCE: [Remote Control — start a session / flags](https://code.claude.com/docs/en/remote-control#start-a-remote-control-session) — CONFIDENCE: H

---

## Hard Limits Table

| Constraint | Value / Behavior | Source |
|---|---|---|
| Cloud session repo access | One GitHub repo per session | Official docs — H |
| `~/.claude/` user globals in cloud | NOT available | Official docs — H |
| Multi-repo in one cloud session | NOT supported | Official docs — H |
| Files outside the cloned repo | NOT accessible | Official docs — H |
| Cloud VM resources | 4 vCPU / 16 GB RAM / 30 GB disk | Official docs — H |
| Environment cache expiry | ~7 days (resets on setup script change) | Official docs — H |
| Cloud session inactivity expiry | Undocumented exact timeout; "period of inactivity" | Official docs — M (imprecise) |
| Remote Control network drop timeout | ~10 minutes | Official docs — H |
| Remote Control: process must stay alive | Hard — close terminal = end session | Official docs — H |
| Managed Agents self-hosted idle | 60s default after `end_turn` | Official docs — H |
| Bundle size limit (non-GitHub repos) | 100 MB | Official docs — H |
| Teleport direction from CLI | Cloud → local only (not local → cloud) | Official docs — H |
| ZDR / HIPAA eligibility | Not available for any cloud/Remote Control feature | Official docs — H |
| API key auth for cloud features | Not supported — claude.ai OAuth required | Official docs — H |

---

## Sources

- [Claude Code on the web](https://code.claude.com/docs/en/claude-code-on-the-web) — CONFIDENCE: H — verified 2026-07-20
- [Remote Control](https://code.claude.com/docs/en/remote-control) — CONFIDENCE: H — verified 2026-07-20
- [Claude Managed Agents overview](https://platform.claude.com/docs/en/managed-agents/overview) — CONFIDENCE: H — verified 2026-07-20
- [Managed Agents — sessions](https://platform.claude.com/docs/en/managed-agents/sessions) — CONFIDENCE: H — verified 2026-07-20
- [Managed Agents — session operations](https://platform.claude.com/docs/en/managed-agents/session-operations) — CONFIDENCE: H — verified 2026-07-20
- [Managed Agents — reference / rate limits](https://platform.claude.com/docs/en/managed-agents/reference) — CONFIDENCE: H — verified 2026-07-20
- [Claude Cowork architecture overview](https://support.claude.com/en/articles/14479288-claude-cowork-architecture-overview) — CONFIDENCE: M — architecture confirmed; session limits not documented there
- [Cloudflare + Claude Managed Agents announcement](https://blog.cloudflare.com/claude-managed-agents/) — CONFIDENCE: M — secondary/partner source

---

## Verdict (addressed to majkee)

No current cloud offering replaces or even meaningfully complements the tailscale-reachable always-on office box as the temple's "invariant session." The reasons are structural, not cosmetic.

Claude Code on the web provisions one VM, clones one GitHub repo, and knows nothing of `~/.claude/` globals, sibling repos, `~/.remote/`, or `_mail/`. The temple's architecture is deliberately multi-repo and depends on user-level state that lives outside any single repository. There is no workaround inside the current cloud model — you would have to collapse the temple's structure into a single repo and commit all user-level config there, which contradicts the point-never-copy discipline and the sovereignty model.

Remote Control is closer to useful but is still machine-bound by design: the local process must keep running, a ~10-minute network gap kills it, and the web/mobile surface is just a viewport into the local session. It solves the "continue from phone" problem well; it does not solve the "machine-independent invariant session" problem at all.

Claude Managed Agents is a developer API, not a Claude Code replacement. It runs autonomous tasks against single sandboxes with no concept of the temple harness. It would require building a custom orchestration layer to approximate even a fraction of what the office box provides natively.

The tailscale-reachable office box with `claude remote-control` running is the correct architecture for the temple's invariant session today. The cloud offerings are complements for single-repo disposable tasks, not substitutes for a multi-repo, harness-heavy, always-on working environment. Revisit when Anthropic ships a secrets store for cloud sessions and documents multi-repo workspace support — neither exists as of this report.

---

*Epoch research · harness builder edition · 2026-07-20*
