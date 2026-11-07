---
title: Sublime observer — inspect an explicitly selected live view
scope: sublime-observer
audience: operator + agent + builder
machine: home
verified: 2026-11-07
half_life_days: 30
recheck: local prototype README and session STATUS
verify_cmd: python3 -I -S -B /home/hruzam/unikuklatrix/nablarva/.dev/session/termbrana-sublime-observer/implementation/observer.py instances
---

# Sublime observer

When a task requires an agent to check the actual text, selection or viewport of
an explicitly authorized Sublime view, first read the current [prototype README](../../../unikuklatrix/nablarva/.dev/session/termbrana-sublime-observer/README.md)
and [STATUS](../../../unikuklatrix/nablarva/.dev/session/termbrana-sublime-observer/STATUS.md).
They describe the current location, installation, commands and qualification;
the [CLI source](../../../unikuklatrix/nablarva/.dev/session/termbrana-sublime-observer/implementation/observer.py)
and plugin source beside it govern actual behavior if documentation disagrees.

**As of verification:** this is a prototype tested in a disposable Sublime
profile, not an installed or fully qualified service in the normal profile.
The trial bed and its paths are temporary. Installing the plugin and qualifying
it on the normal host are separate actions; follow the current STATUS and
README rather than assuming they have occurred. An empty or failed `instances`
command does not mean that Sublime is closed.

Once a qualified installation is available, a CLI agent running as the same
user can invoke the Python CLI, list instances, windows and tabs, and read the
explicitly selected instance/window/view. It reads Sublime's live buffer,
including unsaved content, rather than relying on the disk copy. It also reports
state such as revision, selection and viewport; fresh instance IDs must be
discovered after a plugin reload or restart. Follow the README for marker-based
run correlation, deadlines and truncation handling.

The connector is read-only, but its local socket is accessible to processes
running as the same user. Inventory and inspect only views authorized for the
task; do not capture unrelated content. It supplies buffer and state evidence,
not proof of visual rendering or native transcript fidelity.

To tell an agent about it:

> Read `~/reposoma/raw.guides/sublime-observer/GUIDE.md` and check the linked
> current STATUS before use. Inspect only the explicitly authorized Sublime
> views for this task, using their instance, window and view IDs.
