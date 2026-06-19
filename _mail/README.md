# _mail/ — the temple bus (NON-CANONICAL · gitignored)

Working-state message bus for the temple. **Nothing here is canon** (canon lives in
`temple/decisions/`, `temple/doctrine.md`, `raw.canon/`). Only this `README.md` + `.gitignore` are
tracked; everything else is gitignored and **drainable** (Cinderella rule: extract what matters into
its real home, then delete).

## What goes where
- **Deep proposals / architectural arguments** (architect ↔ architect) → `_mail/<recipient>/…`
- **Fast status / "what I just did"** → the **per-author pulse bus**: `pulse.houston.md` · `pulse.vega.md`
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

## Filename shape
`_mail/<recipient>/<inbox|archive>/<sender>.<topic>.<YYYY-MM-DD>.md` · carry `host:` provenance where it matters.
