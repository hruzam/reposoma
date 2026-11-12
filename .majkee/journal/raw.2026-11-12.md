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
