---
title: Defensive-security knowledge
scope: technical-knowledge
kind: knowledge-note
updated: '2026-11-05'
---

# Defensive-security knowledge

TC38–TC42 and readable parts of the security-tool lists; extracted 4 November 2026.
Tool demonstrations and terminal screenshots were not independently reproduced.

## Make access rules explicit

Least privilege, denial by default and permission checks on every request are
concrete controls. A guessed object identifier must not let a requester cross an
authorization boundary. [OWASP authorization guidance](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html).

My extraction from the concept posters is to connect each label to an observable
failure: a cross-tenant request, an invalid input, an unbounded request rate or an
unlogged sensitive action. A poster's twelve labels do not demonstrate coverage.

## Separate visibility from enforcement

The blue-team and Linux reels mix auditing, packet inspection, intrusion detection,
host monitoring, access controls and patching. Treat them as different responsibilities
when evaluating a stack. My proposed exercise is one benign test event observed
from source through collection to alert; record where evidence disappears.

## Packet filters are questions

Wireshark documents DNS fields used by the captured filters.
[DNS field reference](https://www.wireshark.org/docs/dfref/d/dns.html).
A long name or TXT lookup is an observation to investigate, not sufficient evidence
of tunneling. The useful habit is to compare timing, frequency, payload and known
application behavior before drawing a conclusion. This is investigative reasoning,
not a claim that the reel's example traffic was malicious.

## Different tools answer different questions

The retained knowledge from the lists is the need to distinguish scanning,
reverse engineering, public search, password auditing and guided learning. Tool
names alone do not supply a method. A lab exercise should state the expected result
and evidence before choosing a tool; the [reference list](tool-references.md) keeps
the readable names without converting them into an installation plan.
