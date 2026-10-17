for-nabla.Tmux.chatbot ---
From myShell, incorporating Astrobley's bounded consultation
2026-10-17 · personal design refinement · proposed, not implemented

# Prompt history, pending work, and RUNBOOK/tmux attachment

Majkee asked whether the composer could identify sent and pending prompts, retain JSONL history,
and attach either to a RUNBOOK bed or an ordinary tmux session. The shared recommendation is yes:
retain a durable exchange workspace and attach live terminal endpoints to it.

## Pending needs a reason

| View | Observation behind it |
|---|---|
| Draft | An editable prompt is still being composed. |
| Ready | An exact rendered version exists and awaits dispatch. |
| Delivery unknown | An attempt may have submitted the prompt, but its outcome is unresolved. |
| Awaiting receipt | A human or adapter reports submission; recipient acknowledgment is absent. |
| Awaiting return | The recipient explicitly accepted a bounded task; its result is outstanding. |
| Returned | A correlated result exists, ready for the integration owner's review and fold proposal. |

These are message-workflow observations, not competing project STATUS fields. A single `sent`
flag cannot distinguish copying, submission, acknowledgment, acceptance, and completion. Keep
delivery-attempt history separate from the current message view. Cancellation, supersession,
and corrections should be explicit observations.

Before an automated delivery attempt, durably record that the attempt is starting. An interruption
before its outcome is recorded produces delivery uncertainty; it must not silently become unsent
or trigger a duplicate retry. A receipt identifies the exact message version. Acceptance names
the accepted scope and does not establish task completion.

## Own JSONL history, with readable prompt versions

An illustrative layout is:

```text
workspace.json          stable identity and attachment references
drafts/                 editable prompts
prompts/<id>/<rev>.md    exact frozen renders
events.jsonl            append-only observations
index.json              disposable current/pending projection
```

Events should carry message/version identity, timestamp, actor, attempt identity, destination
binding revision, and evidence references as applicable. Hashes identify exact rendered bytes;
they do not prove delivery. Rebuild the current index from history rather than maintaining two
independent truths. A frozen render records what was carried even after its draft changes.

Keep history for requests, delivery attempts, receipts, returns, and dispositions. Link relevant
vendor transcript evidence instead of copying complete conversations or writing into vendor logs.
Start with one event writer; define recovery for an interrupted final JSONL record and report
interior corruption. The proposed storage and recovery behavior have not been implemented.

Codex documents persisted JSONL thread logs; Claude exposes JSONL transcript paths and maintains
separate Markdown memory. These establish useful precedents, not a shared schema for this device.
Sources: [Codex app-server](https://learn.chatgpt.com/docs/app-server),
[Claude hooks/transcripts](https://code.claude.com/docs/en/hooks),
[Claude memory](https://code.claude.com/docs/en/memory).

## Optional bed, replaceable terminal endpoint

Give the composer workspace a stable ID outside tmux. It can hold:

- an optional RUNBOOK-bed pointer, with its governing instructions and STATUS;
- explicit host, tmux server/socket, observed session and pane identities;
- an attachment revision, plus vendor session/thread references when known.

A tmux-only workspace needs no invented project gate or STATUS. Tmux can remain Majkee's
primary live workspace and session picker while the durable exchange survives closing a frame.
Session death makes an attachment stale. Name reuse must not silently reconnect it. Rebinding
creates a new attachment revision so earlier attempts retain their actual destination. When
server/session incarnation cannot be established, disclose the uncertainty and require explicit
rebinding.

The practical interface is Sublime composition, a small pending/history view, and agent commands
operating on the same files. Tmux holds the running agents. A native control channel may deliver
to an agent that is displayed in tmux; displaying a process and controlling it are separate jobs.

Astrobley's principal challenge: a live pane is not proof of recipient identity or readiness.
It could contain another process or an approval dialogue. Any delivery route needs its own
qualified input/return and interruption behavior. Current Ovitmugen prohibits input injection;
it remains a view manager under the inspected source rules. Source:
[ovitmugen.py](/home/hruzam/ia-sync/zsh/session/ovitmugen.py:14).

This refinement proposes message history and attachment semantics. It installs no storage,
sender, listener, transport, or new project authority.
