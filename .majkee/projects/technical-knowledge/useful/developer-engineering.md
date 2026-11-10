---
title: Developer engineering
scope: technical-knowledge
kind: knowledge-note
updated: '2026-11-05'
---

# Developer engineering

Extracted 4 November 2026 from TC22–TC35. These are condensed principles and
proposed exercises, not implementations. [INDEX.md](../INDEX.md) maps individual items.

## Large lists need a bounded contract

The million-row interview question becomes tractable when the API defines page
size, ordering, filters and access boundaries. PostgreSQL warns that pagination
needs a predictable ordering and that large OFFSETs still require computing skipped
rows. [PostgreSQL LIMIT/OFFSET](https://www.postgresql.org/docs/current/queries-limit.html).

My proposed design exercise is a stable ordered cursor, a matching index and a
bounded payload. Test duplicate sort values and records inserted between page
requests. Cursor pagination is not automatically correct merely because it avoids
OFFSET: define what consistency clients should expect.

## Webhooks are a reliability exercise

Stripe documents signature verification, retries, duplicate deliveries and lack
of guaranteed event ordering. Those properties should shape an integration's
processing contract. [Stripe webhook documentation](https://docs.stripe.com/webhooks).

My synthesis of the portfolio list is one integrated exercise: authenticate the
delivery, record a durable event identity, apply business work idempotently, retry
recoverable failures and expose bounded status queries. Require evidence of one
logical outcome after a duplicate delivery. This is more actionable than twelve
unrelated portfolio repositories.

## Choose communication from the interaction

HTTP uses request/response semantics and can reuse connections; it is not limited
to opening a fresh TCP connection per request.
[MDN HTTP overview](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Overview).
WebSocket supports bidirectional interaction over a connection.
[MDN WebSocket API](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API).

The API/endpoint reel is useful vocabulary: identify an operation with method,
address and contract, then describe the API as the broader interface. My selection
question is whether clients need polling, one-way updates or bidirectional exchange;
that determines which mechanism deserves evaluation.

## Read structure before rewriting code

ast-grep searches and rewrites syntax structures rather than only matching raw
characters. [Upstream project](https://github.com/ast-grep/ast-grep).
My proposed use is a read-only query with positive and negative fixtures before
authorizing a rewrite. Keep ordinary text search for tasks that need no syntax model.

Roadmaps, algorithm posters and repository collections are indexes to material.
Pick the next missing concept for an actual task; their existence does not create
a requirement to adopt every listed tool. [Roadmap reference](https://roadmap.sh/).
Cache policy notes from TC31 live in [cache-methods](../../cache-methods/README.md).
