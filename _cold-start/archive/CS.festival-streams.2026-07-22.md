CS · 2026-07-22 · festival streams (detaily + storno)

commit : a82046cde (hotfix/festival-kasa) · master tip a4e516c8a (festival core pushed)
task   : two festival streams, gaveled, briefs written, dispatch handed off
context: Festival core (kasa v.1, 6 files) cherry-picked → master → pushed. Two streams staged:
         A · kasa "detaily" price toggle — GAVEL: ALL CELLS. Low risk. In progress.
         B · order STORNO → festival stock — HIGH care. Fix locus resolved: increaseStock() :5329
             (single-order path) + changeOrderStatus() :1294/1303 (bulk), both gated shipping_code='festival',
             eshop byte-for-byte; badge "Obj. festival → sklad festival"; festival salled -= qty;
             festival příjemka gated off (stops metric double-count). Not started.
         Medusa has no spawn tool → krakens run as fresh sessions from the briefs.

briefs : A → .dev/session/festival-prices/tasks/A-detaily-dispatch.md   (launch: claude --agent flight)
         B → .dev/session/festival-storno/tasks/B-storno-dispatch.md    (launch: claude --agent trajectory)
live   : program.pulse.md (root) · session.md at .dev/session/festival-prices/

next   : 1. A → REPORT (A-detaily.report.md) → @Assay → cherry-pick own commit.
         2. Launch B (trajectory) → resolve verify-item #2 (returnOrderForm path) → @Assay → cherry-pick.
         3. DB confirm order 2026001251 shipping_code='festival' via fo -db / delta-sql / MCP (Medusa's bash can't reach fo).
         4. On each green → tell Houston (closes flag/pulse/handoff/journal).

resume : claude --agent medusa → /project-read  (then continue from program.pulse.md)
