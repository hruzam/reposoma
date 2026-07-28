# System cron configurations

- I did it manually
- only need to create zsh guide but for common case based on rest of file context
- checked timer is running, just only check if its ok on formal side
- clean conflict information from `/home/hruzam/.config/zsh/guides/ai.md`. Important, this file will once containing more than this specific sript which was already done. So structure should be prepared for it. In other word my zsh sript (office machine) complex guide all about ai bonded zsh scripts.

## Step 1: Create the Service File
This file defines what program or script should run.

   1. Open your terminal and create the directory for user services if it does not exist:
   
   mkdir -p ~/.config/systemd/user
   
   2. Create and edit the service file:
   
   nano ~/.config/systemd/user/harness.service
   
   3. Paste the following configuration:
   
   [Unit]
   Description=Harness Check Script
   
   [Service]
   Type=oneshot
   ExecStart=/bin/zsh /home/hruzam/.config/zsh/fresh/harness-check.zsh
   
   4. Save and exit (in Nano: press Ctrl+O, Enter, then Ctrl+X).

## Step 2: Create the Timer File
This file defines when the script should run.

   1. Create and edit the timer file:
   
   nano ~/.config/systemd/user/harness.timer
   
   2. Paste the following configuration:
   
   [Unit]
   Description=Run Harness Check weekly and catch up if missed
   
   [Timer]
   OnCalendar=Mon *-*-* 09:00:00
   Persistent=true
   
   [Install]
   WantedBy=timers.target
   
   Note: OnCalendar=Mon *-*-* 09:00:00 targets every Monday at 9:00 AM. Persistent=true triggers the event immediately after boot if the system was powered off during that time.

## Step 3: Enable and Start the Timer
Run these commands as your regular user (do not use sudo, as this is a user-level service).

   1. Reload the systemd manager configuration to recognize the new files:
   
   systemctl --user daemon-reload
   
   2. Enable the timer to start automatically at boot and start it right now:
   
   systemctl --user enable --now harness.timer
   
   
------------------------------
## Useful Commands for Management

* Check the status and next execution time:

systemctl --user list-timers --all

(Look for harness.timer in the list to see exactly when it will run next).
* Manually trigger the script right now (for testing):

systemctl --user start harness.service

* View the script output and logs:

journalctl --user -u harness.service


