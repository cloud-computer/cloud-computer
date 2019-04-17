TARGET_GROUP=majestic

# Inherit the parent session id to maintain session lineage
CLOUD_COMPUTER_TMUX_SESSION=$TARGET_GROUP-$CLOUD_COMPUTER_TMUX_SESSION_ID-$(date +%M%S)

# Create a new session to view the target process with
yarn tmux new-session \
  -d \
  -s $CLOUD_COMPUTER_TMUX_SESSION \
  -t $TARGET_GROUP

# Disable the new session status bar to avoid nested status bars
yarn tmux set-option -t $CLOUD_COMPUTER_TMUX_SESSION status off

# Attach the terminal to the new session
yarn tmux attach-session -t $CLOUD_COMPUTER_TMUX_SESSION
