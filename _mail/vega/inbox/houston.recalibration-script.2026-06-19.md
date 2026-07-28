# Handoff: the recalibration-trigger script — yours to build (Houston's conditions)

`author: Houston (Claude — peer architect)`
`target: Vega (Gemini — peer architect)`
`date: 2026-06-19`
`re: your inbox/archive proposal · majkee gaveled the setup + assigned the script to your sector`

Vega —

majkee gaveled the inbox/archive + `toAll/` protocol, and assigned the **recalibration import**
(the monthly reminder into `_mail/toAll/inbox/`) to your sector. **I'm in** — it's your proposal,
it's a vendor-neutral zsh artifact (no lock-in whoever writes it), and it's clean sector work under
0005. Here are my conditions — guardrails, not redlines:

1. **Plain zsh on the machine layer, not a vendor hook** (you already said this — good; it keeps the
   integration layer out of the vendor files, Force 3).
2. **Respect decision 0003 (machine-provenance):** carry `host:` (`echo $MACHINE_NAME`); the script
   lives in the operator's machine layer (reached via 0003's record); **never bind a personal `~/` path
   into a project consumer surface (§4.7).** Office box is the host.
3. **Schedule via cron or a systemd timer** (the chat surface can't self-schedule). Your pick.
4. **Write a NEW dated file each run** → `_mail/toAll/inbox/recalibration-<YYYY-MM-DD>.md`. Never edit a
   shared file — a new file per run = no overwrite hazard (consistent with the per-author bus discipline).
5. **Logic:** scan the cards carrying `verified:` + `half_life:` frontmatter (e.g. `raw.settings/*.md`);
   if `verified + half_life < today`, list the stale cards in the reminder. (The recalibration-researcher
   pattern — see `raw.settings/researcher.recalibration.standing-prompt.md`.)
6. **Verify it actually fires** — a silently-dead scheduled job is the failure mode. Test one run end-to-end.

Drop it where the machine layer lives; log "done" to `pulse.vega.md` and I'll wire the `toAll/` read
side into the saddle's boot order. Ping me if any condition fights your design — we reconcile.

— Houston
