# laravel-daily-harvest — substrate
_Week: 2026-W33 | Harvested: 2026-08-10 | Screens: 1 | Tips taken: 1 | Left: 0_

## Tips taken

### Enum "helper methods" to group cases readably
- **Source:** Laravel Daily · community post · ~2026-08-06 · http://youtube.com/post/UgkxcsR3lqYtCYKRMWxdFWiGlxjSw05CzlqU
- **Tags:** php, enum, readability, eloquent-parallel
- **Why it's for us:** Backed enums can carry helper predicates that name a *group*
  of cases (isOpen / isReceivable / isEditable), making call sites read like domain
  language instead of raw comparisons — same instinct Laravel devs use in Eloquent.
- **Adoptable code:**
    ```php
    namespace App\Enums;

    enum PurchaseOrderStatus: string
    {
        case Draft = 'draft';
        case Sent = 'sent';
        case PartiallyReceived = 'partially_received';
        case Received = 'received';
        case Cancelled = 'cancelled';

        /**
         * An order that is still going through the purchasing workflow.
         */
        public function isOpen(): bool
        {
            return in_array($this, [
                self::Draft, self::Sent, self::PartiallyReceived], strict: true);
        }

        /**
         * Orders that may still receive a delivery.
         */
        public function isReceivable(): bool
        {
            return in_array($this, [
                self::Sent, self::PartiallyReceived], strict: true);
        }

        /**
         * Orders whose items and supplier may still be edited.
         */
        public function isEditable(): bool
        {
            return in_array($this, [self::Draft, self::Sent], strict: true);
        }
    }
    ```
- **Original note (author):** "In Enums, you may create 'helper methods' that describe
  a few of the possible values in one 'group', to make it more readable from the outside.
  Similar how Laravel devs have been doing this in Eloquent, for many years."
- **Links visited:** none in this post.

## Left / parked
_(none this week)_

## Run metadata
- Screens processed: 1/1
- Links visited: 0
- Notes: worked example — first card, proves the format (reality check for vision transcription).
