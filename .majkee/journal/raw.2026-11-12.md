On home (here): exit this session (/exit), then in Konsole run:

  tmux new -s traj-home -c ~/ia-sync
  claude --agent trajectory --model claude-opus-5-5 --resume 06352fda-5b7f-4621-b7d1-617be6bc51a4

  On office: the same steps for her, with her own session:

  tmux new -s traj-office -c ~/ia-sync
  claude --agent trajectory --model claude-opus-5-5 --name trajectory-office-executioner --continue

  --continue picks up the latest conversation in ~/ia-sync on office, which is hers (ebe3e188…).

  Then both directions work over SSH, which already passes both ways between home and office:

  # home → office
  ssh hruzam@100.126.182.111 "tmux send-keys -t traj-office 'hello, read 
  ~/ia-sync/_mail/office/inbox/<file>.md' Enter"
  # office → home
  ssh hruzam@100.110.27.60  "tmux send-keys -t traj-home  'hello, read 
  ~/ia-sync/_mail/home/inbox/<file>.md' Enter"

  Things to know:
  - The session names are a convention: traj-home and traj-office, so each side knows where to send
    without asking. Rename them if you like, but both sides have to know the names.
  - Enter: Claude's input box sometimes treats quickly pasted text as a paste. If the hello shows up
    but doesn't submit, sending a second Enter on its own fixes it. I'll check that on the first real
    test.
  - Interruption: this types into the other session's input. If she's in the middle of a task, the text
    waits in her input box, or is submitted as a new message once she's idle. That suits a short
    pointer, which is why the real content stays in the mail file.
  - Monitor can't join yet: it has no tmux, and its keys aren't accepted on home or office.

  Once you've restarted me inside tmux, say "go". I'll check that traj-office exists, send the hello,
  and wait for her reply in _mail/home/inbox/.


---
session : monitor-SSH-instructions (Codex · myShell journal scope; Cartan monitor handoff)
---
# Accept monitor on HOME and OFFICE — 2026-11-12

**Where:** run the block below once in a terminal on **HOME** (`hruzam`), then once
on **OFFICE** (`hruzam-120922`), as user `hruzam`. Do not run it on monitor.
Monitor already authorizes both computers. The remaining peer-side step is to trust
monitor's host key and authorize monitor's client key.

The host agents could not install these entries under their permission boundaries.
This is the operator's explicit terminal action; it needs no sudo and copies no
private key. It verifies the live host key against the published one, backs up
existing SSH files and appends only missing lines. A mismatch stops before installation.

- [ ] HOME: run the block and keep its output.
- [ ] OFFICE: run the same block and keep its output.

```bash
bash <<'BASH'
set -euo pipefail
case "$(hostname -s)" in
  hruzam|hruzam-120922) ;;
  *) echo 'Run this on HOME or OFFICE, not monitor.'; exit 1 ;;
esac
[[ "$(id -un)" == hruzam ]] || { echo 'Run as hruzam, without sudo.'; exit 1; }
cd "$HOME/ia-sync"
git pull --ff-only

expected=$(ssh-keygen -lf ssh/peers/monitor.known_hosts | awk '{print $2}')
actual=$(ssh-keyscan -T 5 -t ed25519 100.80.107.66 2>/dev/null |
         ssh-keygen -lf - | awk '{print $2}')
[[ -n "$expected" && "$actual" == "$expected" ]] ||
  { echo 'Host-key verification failed; nothing installed.'; exit 1; }

umask 077
mkdir -p "$HOME/.ssh"
stamp=$(date +%Y%m%d-%H%M%S-%N)
for name in known_hosts authorized_keys; do
  file="$HOME/.ssh/$name"
  [[ ! -e "$file" ]] || cp -p "$file" "$file.before-monitor-$stamp"
  touch "$file"
  chmod 600 "$file"
done

for pair in 'monitor.known_hosts:known_hosts' 'monitor.client.pub:authorized_keys'; do
  source_file="ssh/peers/${pair%%:*}"
  target_file="$HOME/.ssh/${pair##*:}"
  while IFS= read -r line; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    grep -qxF -- "$line" "$target_file" ||
      printf '%s\n' "$line" >> "$target_file"
  done < "$source_file"
done

ssh -o BatchMode=yes -o StrictHostKeyChecking=yes -o ConnectTimeout=8 \
  hruzam@100.80.107.66 'hostname -s; id -un'
BASH
```

Expected final output is `hruzam-mntr`, then `hruzam`. If the command fails, keep the
error and stop; do not disable host checking or enable password login.

**Return to Cartan on monitor:** say which hosts completed this and provide the
outputs. Cartan then tests monitor → home and monitor → office. This block's
home/office → monitor check alone does not prove those reverse directions.

Evidence/procedure: `~/ia-sync/ssh/peers/README.md` and the published peer files.
Directional state: `~/reposoma/raw.guides/machine-monitor/res/access.md`.
Integration owner: `~/ia-sync/.dev/session/monitor-01-integration/STATUS.md` on monitor.
These are operator instructions requested here, not a second project STATUS.

## Read this journal on either other computer without merging local work

```bash
git -C ~/reposoma fetch origin core
git -C ~/reposoma show origin/core:.majkee/journal/raw.2026-11-12.md | less
```

This reads the published journal without replacing local files or reconciling local
commits. Home's previously reported reposoma divergence remains a separate decision.
Tmux instructions for monitor are being supplied inline in the conversation.
