---
title: Browser egress through a Tailscale peer
scope: browser-egress
audience: operator + agent
machine: both
verified: 2026-08-24
---

# Browser egress through a Tailscale peer

Use this when a website accepts requests from one machine's public network but you need
to operate the browser and keep downloads on the other machine. It is the browser-only
alternative to projecting the remote desktop.

## Quick path

Run this on the machine where you are sitting and where the download should land:

```zsh
web-reach-firefox 'https://restricted.example/path'
```

The command starts (or reuses) a loopback SOCKS proxy through `$TAILSCALE_PEER`, then
opens a separate Firefox profile whose traffic uses that proxy. Work in that window.
When the download is complete, close the isolated Firefox window and stop the proxy:

```zsh
web-reach-down
```

For the current two-host mapping:

```text
home Firefox + home download
        │
        │ SOCKS v5 on home 127.0.0.1:1080
        ▼
SSH over Tailscale to office
        │
        ▼
website sees office public egress
```

On home, `$TAILSCALE_PEER` is office (`hruzam-120922`). On office it is home
(`hruzam`), so the same mechanism works in the reverse direction when needed.

## What the command owns

`web-reach-firefox [url]`:

1. Calls `web-reach`, which opens `ssh -D 127.0.0.1:1080` to `$TAILSCALE_PEER`.
2. Creates or refreshes the machine-local profile
   `~/.mozilla/firefox/office-egress/user.js` with SOCKS v5 and proxy-DNS settings.
3. Opens Firefox with `--new-instance --profile ~/.mozilla/firefox/office-egress`.

The normal Firefox profile is untouched. Only the isolated profile uses peer egress;
the rest of the browser host keeps its normal network path. If the isolated profile is
already running, the command points you to its existing window instead of opening a
second instance. With no URL, it opens `about:blank`.

The profile and downloaded files are machine-local state. They do not belong in
ia-sync or Reposoma. The executable truth is
`~/ia-sync/zsh/system/tailscale.zsh`; aliases are in
`~/ia-sync/zsh/system/keyboard.zsh` and deploy to `~/.config/zsh/system/`.

## Verify the path

Check the local listener on the browser host:

```zsh
ss -tln | rg '127\.0\.0\.1:1080'
```

Expected: one `LISTEN` row bound to `127.0.0.1`, never `0.0.0.0` or the Tailscale IP.
While the isolated Firefox window is loading a page, this should show Firefox using the
proxy:

```zsh
ss -tnp | rg '127\.0\.0\.1:1080'
```

The final acceptance test is the protected page itself: it should behave as it does from
the egress peer while the downloaded file appears on the browser host.

## Troubleshooting

```zsh
echo "$TAILSCALE_PEER"       # must name the intended egress host
tailscale ping "$TAILSCALE_PEER"
ssh "$TAILSCALE_PEER" true  # confirms normal SSH key access
web-reach-down
web-reach-firefox 'https://restricted.example/path'
```

- **`127.0.0.1:1080 already listening`:** an earlier proxy is probably active. Use it,
  or run `web-reach-down` and start clean.
- **SSH authentication fails:** repair ordinary host-to-host SSH first. The proxy does
  not bypass SSH key policy.
- **The external authentication wall remains:** verify `$TAILSCALE_PEER`. If it is
  correct, the site may require browser state, a client certificate, or something beyond
  source IP. That is the point to use remote desktop into the egress host instead.
- **The isolated profile is already running:** use that window. Close it before starting
  a fresh isolated session.

## Safety and shutdown

- The SOCKS listener is loopback-only; no browser proxy port is exposed to the LAN,
  tailnet, or public internet.
- Do not browse normally in the isolated profile. Its purpose is the restricted task.
- Treat production downloads as sensitive machine-local data. Keep database dumps outside
  project repositories and confirm ignore rules before importing them into development.
- `web-reach-down` stops the proxy but does not close Firefox. Close the isolated window
  first so it cannot continue with a dead network path.
- The proxy also ends on reboot or when its SSH process dies; never assume it survived a
  disconnect—rerun the quick path and verify the listener.
