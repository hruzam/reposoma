---
artifact: agent-readable-shop
project: reposoma
scope: shop-facing publication and bounded agent access
written: 2026-09-25
language: en
author: Wave / Asymmetry
status: proposed-scoped-design-brief
implementation_authority: false
supersedes: none
live_shop_audited: false
companions:
  - 01_premises_after_forecast_2026-09-25.md
  - 03_identity_and_termbrana_2026-09-25.md
---

# 2. An agent-readable shop without replacing the shop

## 1. Decision and boundary

**USER DIRECTION:** retain the normal human-facing design and add a way for agents to obtain meaningful product and category information without depending on carousel gestures, scrolling, or other incidental UI behavior.

**MY PROPOSAL:** start with a read-only publication path, using existing data and web conventions. Keep mutation and checkout separate. I use “agent-readable” instead of “drainable” because exhaustive extraction is not the success criterion: a correct, bounded answer that retains a route to the merchant is.

This is suitable as a starting brief for the imago context discussed in the thread, but no current imago page, source tree, feed, or database was inspected. CZ/SK, language, currency, variants, and price-visibility cases below are considerations to check, not findings about current defects.

## 2. Do not confuse three different consumers

| Consumer | Needs | What must not be assumed |
|---|---|---|
| Search crawler | Reachable pages and interpretable published content. | That it will click every button or execute every interactive path. |
| Our agent/CLI integration | A documented read contract and the tools/permissions to call it. | That inventing an endpoint makes an unconfigured model aware of it. |
| A partner platform's shopping agent | Its supported feed, schema, or action protocol. | That one provider's integration is universal or remains stable. |

Google specifically documents that its crawler generally discovers links in `<a href>` and does not activate action-dependent buttons. It describes link-based pagination alongside load-more/infinite-scroll designs. This is a Google crawling fact, not a statement that no interactive agent can click. [S1]

## 3. The architectural shape

```text
Existing catalogue, pricing and stock authorities
                    |
          shared business/read logic
          /            |             
 human pages      standard markup    existing feed or bounded read API
 + current UI     for those pages    for a named consumer
          \            |             /
          same product, variant and commercial context

Cart / reservation / order / payment
  -> separate authorized application actions, not catalogue reads
```

The “shared” part is responsibility, not a requirement for microservices or a new framework. In a legacy application it might be a reusable function, existing model/service, or export path. Do not duplicate pricing formulas in a new AI controller.

An existing database can remain the authoritative store for current offers. Files remain useful for specifications, publication snapshots, and evidence; they need not become a second commerce database.

## 4. Make navigation independent of presentation

A category is a meaningful resource, not merely the cards presently visible. A carousel can be a curated subset, not the whole category. A loader is a UI action, not the only definition of “next results.”

**Proposed read behavior:**

- Identify collections and products independently of their display position. Preserve parent/variant relationships and distinguish taxonomy from temporary editorial selections.
- Expose a bounded page of results with explicit continuation and a defined sort/filter context. Avoid unbounded “return everything” requests.
- Distinguish the number returned from a total, and state whether any total is exact, estimated, unavailable, or tied to a snapshot.
- Keep human-facing paginated URLs distinct and navigable. Google's guidance recommends a self-canonical URL for each page in a paginated sequence, not canonicalizing every page to the first. [S1]
- Keep filter combinations under deliberate crawl/index policy; agent queryability does not require indexing every possible facet combination.

For a live catalogue, state how membership changes affect pagination. A cursor alone does not prove snapshot consistency. For a full audit, use a fixed export or a revisioned snapshot; for interactive browsing, documented live semantics may suffice.

**No redesign requirement:** the human can still drag the carousel. The machine's alternative path should reach the same underlying objects without reverse-engineering that drag.

## 5. Reuse publication mechanisms before adding an API

**First, inventory what exists.** Check product/category links, sitemaps, structured product data, export feeds, and internal read services. Improve the smallest missing piece.

Google's merchant-listing guidance covers `Product`/`Offer` data and recommends product markup in initial HTML; it warns that JavaScript-generated markup can be less reliable for fast-changing price and availability. [S2] Its variant guidance provides `ProductGroup` and related properties rather than requiring an invented variant vocabulary. [S3]

Generate markup and visible facts from the same authority. Google explicitly requires structured data to represent the page rather than unrelated or misleading hidden claims. [S4] This is not a reason to expose private customer fields in public markup.

A feed may be enough for catalogue enumeration. An API earns its place when a consumer needs selective reads, current offers, filters, or refreshes that the available feed does not serve well. Use conventional API documentation and schemas already supported by the project; no new discovery standard is necessary for the first consumer.

Google says its AI search features require no extra AI text files or special schema. That does not decide other agents' capabilities, but it rules out treating a new “AI file” as a prerequisite for Google visibility. [S5]

Chrome's February 10, 2026 WebMCP announcement proposed structured browser actions through forms and JavaScript. This is a dated proposal/preview signal, not verified cross-browser support today. Keep any such adapter optional and recheck the target runtime before using it. [S6]

## 6. Minimum useful meaning of an offer

**Proposed fields, not a frozen public schema:**

| Group | Information to preserve |
|---|---|
| Identity | Stable product ID, actual variant/SKU, product-group relation where relevant, canonical human URL. |
| Context | Store/market, locale, currency, and whether the response is public or customer-specific. |
| Product facts | Names, useful attributes with units, explicit distinctions such as edition/language/size, and known identifiers. Missing facts stay missing. |
| Offer | Seller, actual applicable amount, tax-inclusion status, availability semantics, and conditions affecting eligibility. |
| Fulfilment | Whether shipping cost and delivery estimate are known, estimated, or require a destination/checkout. |
| Freshness | Offer observation/as-of time and a version/validator where supported; source update time only when genuinely known. |
| Return path | Human detail page and the permitted next action. A detail link is sufficient in the first release. |

Separate public catalogue data from personalized discounts, negotiated prices, account information, and order history. Do not infer purchase eligibility from the fact that a product is listed.

**Illustrative internal read response — invented data, not production code or a standard:**

```json
{
  "schema_version": "example-0",
  "context": {"market": "CZ", "locale": "cs-CZ", "currency": "CZK", "audience": "public"},
  "product": {
    "id": "demo-product-42",
    "variant_id": "demo-product-42-cs",
    "name": "Example product, Czech edition",
    "human_url": "https://shop.example/products/demo-product-42-cs"
  },
  "offer": {
    "id": "demo-offer-42-cz",
    "price": {"amount": "799.00", "currency": "CZK", "tax_included": true},
    "availability": "in_stock",
    "shipping": {"status": "requires_destination"},
    "as_of": "2026-09-25T08:00:00Z",
    "version": "demo-revision-7",
    "revalidation_required_before_commit": true
  },
  "source": {
    "publisher": "Example merchant",
    "representation": "public-offer",
    "human_url": "https://shop.example/products/demo-product-42-cs"
  }
}
```

This example is intentionally not a complete JSON-LD merchant listing. Map the project's model into the relevant established format when publishing to a particular consumer. The response contains no checkout authority and no guarantee that stock remains available after observation.

Decimal strings here are an example representation, not a requirement to change existing monetary arithmetic. A hidden or not-yet-priced product must not become an offer with price zero. Do not manufacture GTINs, ratings, availability, delivery promises, or descriptions to fill required fields.

## 7. Freshness and caching are business correctness

**Proposed policy:** cache relatively stable descriptions separately from volatile offers. Choose refresh budgets from actual pricing/stock behavior; do not assign a universal lifetime in this design brief. Use standard HTTP cache validation where appropriate. RFC 9111 provides freshness and validation semantics and special rules for authenticated responses in shared caches. [S7]

The cache key must account for every context that can change the answer. Never allow a customer-specific offer to leak through a public cache. A new serialization timestamp does not prove that the underlying stock data was refreshed. Expose stale/unknown status rather than presenting an old offer as current.

Before a consequential action, validate through the existing commerce authority. A fresh read alone is not an inventory reservation: the eventual action must handle concurrent changes. Failed refreshes should block commitments that require current facts, not silently reuse yesterday's price.

Public `GET` reads should not change carts, reserve stock, or create orders. Prepare later mutations as explicit operations with scoped authorization, replay/duplicate handling, and confirmation of the actual offer and effect.

## 8. Access, source accountability, and economics

A permitted machine reader need not receive everything the business holds. Keep public product facts, partner exports, account-specific information, and administrative operations distinct. Rate-limit expensive operations, cap result sizes, and define bounded retries and backoff.

`robots.txt` states crawler rules; RFC 9309 explicitly says these are not access authorization. Use real server-side controls for private endpoints. A user-agent string is not a trustworthy identity, and a source/usage notice alone does not enforce reuse terms. [S8]

Keep merchant attribution and human detail links in outputs from our own consumer. Preserve labels such as estimate, customer review, merchant description, or measured specification. A merchant's recommendation is not independent corroboration of product quality.

Measure **useful outcomes**, not data drained: correct product/variant matches, successful refreshes, customer handoffs, completed orders where attributable, server cost, and correction burden. External crawlers cannot be fully controlled by our schema; provenance fields improve our integration's behavior but do not guarantee external attribution or revenue.

No automatic SEO, conversion, ranking, or token-saving percentage is claimed here.

## 9. Resource accounting and deployment shape

The publication path can serialize existing data deterministically. It does not need an LLM on every request. No framework migration is justified merely by this brief.

A useful measurement model is:

```text
publisher cost = database reads + serialization + cache/storage + egress
                 + logging + abuse handling + maintenance
consumer cost  = retrieval/tool overhead + selected context + model use
                 + retries + human correction
```

Structured data may reduce context and browser interaction in a particular task; large JSON dumps or repeated refreshes can erase that gain. Compare the same task, facts, model, tool access, and correction requirements. Record actual request/byte counts, latency, and billed usage where available.

## 10. One pilot with falsifiable acceptance criteria

**Suggested fixture:** one category with enough products to require multiple pages; include variants, two market/currency contexts, a missing price, an out-of-stock item, a changing offer, and a curated carousel subset. These are test cases, not assumed production defects.

Run a deterministic reader first, then one configured CLI agent. The task is to find a product matching explicit requirements, report the correct variant and current public offer, and open its human detail page. No automatic purchase.

| Test | Pass condition |
|---|---|
| Discover beyond initially visible cards | Complete the declared fixture without UI gesture replay; distinguish the carousel subset from the category. |
| Pagination | No omissions/duplicates in a fixed snapshot, or explicitly reported live-change limitations. |
| Context parity | UI, published markup, and read response agree for the same variant, market, customer context, and source revision. |
| Missing/hidden price | Report unknown/not published; never substitute zero or a different variant's price. |
| Stale offer | Refresh or identify unavailable freshness; no commitment on an unvalidated observation. |
| Access and cache separation | Private fields absent from public responses; missing credentials do not yield protected data. |
| Source return | Output leads back to the exact human product/variant context. |
| Cost | Record actual total retrieval and correction cost against the existing route. |

**Build order:** inventory -> fix conventional discovery/markup -> reuse or add one bounded read path -> validate parity/freshness -> measure a named agent's workflow. Consider partner or browser-action adapters afterward. Checkout is a separate scope.

**Stop or shrink:** an existing feed/read path already satisfies the task; maintenance cost exceeds measured gain; or coherent facts cannot yet be obtained from the application. Fix the underlying source before publishing a second inconsistent representation.

## Sources and handoff

All sources inspected September 25, 2026. Recommendations above are proposed architecture, not guarantees made by these sources.

[S1] Google Search Central, pagination and incremental loading. https://developers.google.com/search/docs/specialty/ecommerce/pagination-and-incremental-page-loading

[S2] Google Search Central, merchant listings (`Product`, `Offer`), especially technical guidelines. https://developers.google.com/search/docs/appearance/structured-data/merchant-listing

[S3] Google Search Central, product variants. https://developers.google.com/search/docs/appearance/structured-data/product-variants

[S4] Google Search Central, structured-data guidelines. https://developers.google.com/search/docs/appearance/structured-data/sd-policies

[S5] Google Search Central, AI features and your website. https://developers.google.com/search/docs/appearance/ai-features

[S6] Chrome for Developers, WebMCP early preview, published February 10, 2026. https://developer.chrome.com/blog/webmcp-epp

[S7] IETF RFC 9111, HTTP Caching. https://www.rfc-editor.org/rfc/rfc9111.html

[S8] IETF RFC 9309, Robots Exclusion Protocol. https://www.rfc-editor.org/rfc/rfc9309.html

Baseline: the source conversation's proposal to retain today's shop and add machine-facing access; the companion premises brief. Existing implementation, feeds, routing, pricing logic, and actual budgets remain unverified. No code, infrastructure, or shop settings were changed.
