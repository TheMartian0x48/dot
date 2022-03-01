# Tmux Configuration

`prefix` is `ctrl + a`

***Split***

```bash
# vertical split
prefix  v
# Horizontal split
prefix  h
# Navigating pans
Alt + arrow_button
```

***Window***

```bash
# Create new window
prefix  c
# Renaming window
prefix ,
# Changing windows
shift + arrow_button
```

***Session***

```bash
# Creating new session
tmux new -s "session-name"

# List session
tmux list-sessions
tmux ls # shorter version

# Deattach session
prefix d

# Attach session
tmux attach
tmux a # shorter version

# Attach to specific session
tmux attach -t <session-id>
tmux a -t <session-id> # shorter version

tmux attach -t <session-name>
tmux a -t <session-name> # shorter version

# switching between session
prefix s # and select session then enter

# deleting session
tmux kill-session -t <session-name> 
tmux kill-session -t <session-id>
```



