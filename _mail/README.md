# _mail/ — the temple bus (NON-CANONICAL · gitignored)

Working-state message bus for the temple. **Nothing here is canon**. Only this `README.md` + `.gitignore` are
tracked; everything else is gitignored and **drainable** (Cinderella rule: extract what matters into
its real home, then delete).

## What goes where
- **Deep proposals / architectural arguments** (architect ↔ architect) → `_mail/<recipient>/…`
- **Fast status / "what I just did"** → the **per-author pulse bus**: `pulse.claude.md` · `pulse.gemini.md`
  (each owner writes ONLY their own file — collision-free; read both). NOT here.
- **The rolling plan memo** (Houston → next incarnation) → `_mail/monkey/houston.monkey-not-forget-this.<date>.md`.

## Inbox / Archive protocol (gaveled 2026-06-19)
The filesystem is the state machine — no tracking tables, no vendor hooks.

```
_mail/houston/{inbox,archive}/      _mail/vega/{inbox,archive}/      _mail/toAll/{inbox,archive}/
```
- **Presence in `inbox/` = unread.** When a memo is read and fully processed, the final action is
  `mv _mail/<who>/inbox/<memo>.md _mail/<who>/archive/`.
- **`toAll/`** = global broadcasts (e.g. "card half-life expired", "model deprecated").
- **Ask-first rule (token economy):** do NOT auto-read the inbox on every boot. If files are present,
  ask: *"I see inbox/toAll items — read them now, or is this a quick run?"*
- **Recalibration trigger:** a **native zsh script on the machine layer** (decision 0003 — NOT a vendor
  hook) drops a monthly reminder into `_mail/toAll/inbox/` when `raw.settings/` card half-lives expire.
  Built + owned by Vega (Gemini sector). Spec: `_mail/vega/…/houston.recalibration-script.2026-06-19.md`.

## Addressing & the round-trip (gaveled 2026-06-25)
- **Filename shape:** `_mail/<receiver>/<inbox|archive>/<sender>.<scope>.<YYYY-MM-DD>.md` · carry `host:`
  provenance where it matters.
- **Address = logical `<origin>:<agent>`** (e.g. `subai:houston`, `temple:houston`). It is **derived, not
  stored**: `origin` → the project's beacon repo-root; the inbox → the `_mail/<agent>/inbox/` convention; any
  machine/physical path resolves through **decision 0003**, *never* written into a beacon (**0004 L4** — no
  `~/`/absolute paths in the registry). The address book is a *derivation rule*, not a new data field.
- **The receiver owns the message.** You write a message **into the receiver's inbox**; the receiver `mv`s it
  to `archive/` once processed.
- **No sent-copy.** The sender keeps nothing in their own folder — the filesystem *is* the state machine. A
  reply returns to **your** inbox (`_mail/<you>/inbox/<them>.<scope>.<date>.md`); that is where you look for
  answers.
- **Cross-repo / basement staging** (here-vs-direct delivery) is a transport detail, deferred to the
  mail-transport mechanism (candidate 0008) — the *logical* rule above holds regardless of topology.
