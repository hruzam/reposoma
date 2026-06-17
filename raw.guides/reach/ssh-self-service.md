<!-- PUBLISHED MIRROR · do not edit here · source: piql.dev/guides/ssh-self-service.md · regenerate with: sync-guides -->

# SSH Self-Service & Field Guide (piql office box)

_Written by @Houston · 2026-06-06 · for @majkee_

A short, standalone guide so you can restart/diagnose SSH on the office machine
without pinging the team. Also a bit of "why", so each fix teaches you something.

Office box: `192.168.0.68` · hostname `hruzam-120922` · user `hruzam`
Connect from home with: `ssh office` (once Gate D of Phase 6 is done).

---

## 1. The 10-second mental model

SSH has two sides:
- **Server** (`sshd`) — runs on the **office** machine. A daemon listening on port 22.
- **Client** (`ssh`) — runs on whatever machine you're sitting at (home).

When "SSH doesn't work", it's almost always one of four things:
1. The **server isn't running** (sshd stopped/crashed).
2. The **network** is down (wrong IP, machine asleep, not on same LAN).
3. **Auth** is rejecting you (key not installed, wrong permissions, password off too early).
4. A **bad config** stopped sshd from starting (you edited `sshd_config`, made a typo).

Diagnose in that order. Each section below maps to one of these.

---

## 2. Restart / check the SSH service (office machine)

Run these AT the office machine (or via an already-open session).

```bash
# Is it running?
systemctl status sshd

# Restart it (use this if it's misbehaving)
sudo systemctl restart sshd

# Start it if it's stopped
sudo systemctl start sshd

# Make sure it auto-starts on every boot (already set, but to confirm)
sudo systemctl enable sshd

# Is it actually listening on port 22?
ss -tlnp | grep :22
# Expect a line showing 0.0.0.0:22 (and/or [::]:22)
```

**`restart` vs `reload`:**
- `reload` re-reads the config without dropping existing connections — use after a config edit.
- `restart` fully stops and starts — use when sshd is stuck/crashed. Existing sessions drop.

---

## 3. THE GOLDEN RULE (don't lock yourself out)

> **Never trust an `sshd_config` change until a SECOND, fresh SSH session proves it works —
> while your first session stays open.**

Why: if you edit the config wrong and `restart` sshd, your *current* session keeps running,
but new logins may fail. If you'd closed your session first, the box is now unreachable and
someone has to physically walk to it. So: keep one session open, open a second to test, and
only when the second works do you trust the change.

Always validate before reloading:
```bash
sudo sshd -t      # NO output = config is valid. Any output = a real error, fix it first.
```
`sshd -t` printing nothing is the PASS condition — that confused us once, so: silence = good.

---

## 4. Config lives here

```
/etc/ssh/sshd_config          # the server config
/etc/ssh/sshd_config.bak-*    # timestamped backups we made before editing
```

**Restore a backup if an edit broke things:**
```bash
ls -la /etc/ssh/sshd_config.bak-*           # find the latest backup
sudo cp /etc/ssh/sshd_config.bak-YYYYMMDD /etc/ssh/sshd_config
sudo sshd -t && sudo systemctl reload sshd  # validate, then reload
```

Key settings currently in place (and why):
| Setting | Value | Why |
|---|---|---|
| `Port` | 22 | standard SSH port |
| `PermitRootLogin` | no | root over SSH is a big attack target — never allow |
| `PubkeyAuthentication` | yes | key-based login (what we want) |
| `PasswordAuthentication` | yes *(temporary)* | needed to copy the key the first time; flips to `no` at Gate E |
| `MaxAuthTries` | 3 | limits brute-force attempts |
| `AllowUsers` | hruzam | explicit allowlist — only this user may SSH in |
| `ClientAliveInterval` | 300 | drop dead/silent connections after 5 min |

When colleagues are added later, their usernames get appended to `AllowUsers` — not doing that
is the #1 reason a newly-created user "can't log in".

---

## 5. Client side (home machine) — connecting

```bash
ssh office                        # uses ~/.ssh/config alias
ssh hruzam@192.168.0.68           # explicit, if the alias isn't set up

ssh -v office                     # VERBOSE — shows exactly where a login fails
```
`ssh -v` (or `-vv`) is your best friend: it prints each step (which key it tried, whether the
server accepted it). Read the last few lines before the failure.

Your `~/.ssh/config` alias block:
```
Host office
    HostName 192.168.0.68
    User hruzam
    IdentityFile ~/.ssh/id_ed25519   # your existing (GitHub) key — reused
    IdentitiesOnly yes
```

---

## 6. Symptom → cause → fix

**"Connection refused"**
→ sshd isn't running, OR nothing is listening on port 22.
Fix: on office, `sudo systemctl start sshd`; check `ss -tlnp | grep :22`.

**"Connection timed out" / "No route to host"**
→ Network problem, not SSH. Machine is off/asleep, wrong IP, or not on the same LAN.
Fix: `ping 192.168.0.68`. If ping fails, it's a network/power issue (this is what Wake-on-LAN,
Phase 7, will solve — waking the box remotely). Confirm the IP hasn't changed (DHCP can move it):
on the office box run `hostname -I`.

**"Permission denied (publickey)"**
→ Your key isn't being accepted. Either the public key isn't in the office's
`~/.ssh/authorized_keys`, or file permissions are wrong.
Fix: re-run `ssh-copy-id -i ~/.ssh/id_ed25519.pub hruzam@192.168.0.68`. Permissions must be:
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys     # on the OFFICE machine
chmod 600 ~/.ssh/config              # on the HOME machine
```
SSH silently refuses keys if the files are too open — this is a common gotcha.

**"Asks for password but I set up a key"**
→ The key login failed and it fell back to password. Run `ssh -v office` to see why the key
was rejected (usually permissions, per above).

**Locked out completely (no session, can't connect)**
→ Physical access required. Sit at the office box, restore the config backup (section 4),
`sudo systemctl restart sshd`. This is exactly the scenario the Golden Rule prevents.

---

## 7. Where the project state lives (so you're oriented)

- `pulse.md` — current phase status at a glance.
- `session/plan/session.plan.md` — the full plan + the **RESUME CARD** (start here after a break).
- `session/ssh-setup/tasks/PHASE_06_SSH_SETUP.md` — the authoritative SSH runbook, gate by gate.
- `flag.md` — settled hardware/security decisions (don't re-litigate these).

Phase line: **6 SSH → 7 Wake-on-LAN → 8 Ollama+Qwen3 → deferred.** You are mid-Phase-6.

---

## 8. A little theory for your self-study

- **Asymmetric keys:** your keypair is a private key (stays secret, on home) + public key
  (safe to share, copied to office). The server encrypts a challenge with your public key;
  only your private key can answer it. You prove identity without sending a secret.
- **`ed25519` vs `rsa`:** ed25519 is the modern default — shorter, faster, strong. RSA still
  works if ≥3072-bit. Either is fine; ed25519 is preferred for new keys.
- **Why loopback-only matters (relevant at Phase 8):** binding a service to `127.0.0.1` means
  only the machine itself can reach it; `0.0.0.0` means the whole network can. Our Ollama model
  will bind `127.0.0.1` — exposing it to the LAN is a deliberate, gated security decision later.
- **Good next reads:** `man ssh_config`, `man sshd_config`, and the Arch Wiki "OpenSSH" page
  (excellent and matches Manjaro).

---

_If something here doesn't match reality, trust the machine and tell @Houston — I'll fix the guide._
