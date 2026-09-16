# src/ — the vacuole (the experimental room)

The vacuole is the meeting playground's experimental room: a shelf of **scenario
recipes**, prepared and ready to run the moment the seats + devices line up. Nothing
here is doctrine — a recipe is an *experiment*. A scenario that proves its finding
*closes from the vacuole* and graduates: into a `res/` chapter, or (small findings)
folded straight into `GUIDE.md`.

## How a recipe works
Copy `RECIPE-TEMPLATE.md` → `scenario.NN-name.md`. Each recipe's frontmatter carries:
- `status`: `shelf` → `ready` → `running` → `closed` (graduated)
- `runnable_now` / `requires_second_device`: so you know what you can actually run today.

## The shelf
| # | Scenario | Status | Runnable now | Graduates to |
|---|----------|--------|--------------|--------------|
| 01 | **CAPTURE** — scribe seat (ground-truth transcript) | shelf | ✗ needs 2nd device | `res/capture.md` |
| 02 | **soft "untested?" vs assigned adversary (A/B)** | shelf | ✓ | `res/adversary-vs-soft.md` |
| 03 | **chair-blind** — vendor hidden from chair (observer bias) | shelf | ✓ | `res/observer-bias.md` |
| 04 | **side-swap** — vendors swap seats (seat vs vendor) | shelf | ✓ | `res/seat-vs-vendor.md` |
| 05 | **context-parity** — equal vs asymmetric packs | shelf | ✓ | GUIDE briefing rule |
| 06 | **ground-truth** — checkable-answer topic ("was right") | shelf | ✓ | `res/ground-truth-scoring.md` |
| 07 | **role-by-strength routing** (not vendor-hardcoded) | shelf | ✓ | `res/role-by-strength.md` |

All run on your current two-voice setup **except 01** (needs a device for the scribe).
Scenarios 03–06 isolate the confounds behind "who won" (observer bias · seat/position ·
context asymmetry · verifiable correctness). Scenarios 02 (A/B) and 07 (role routing) come
from the v3 performance revision (@Epoch + @mirror): the **assigned-adversary role**
(GUIDE rule 7) is the load-bearing move — these two quantify it and test strength-routing.
**Highest-priority runs now: 06 (ground-truth) and 02 (adversary A/B).**
