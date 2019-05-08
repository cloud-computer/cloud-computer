TARGET_GROUP=dashboard

# Inherit the parent session id to maintain session lineage
CLOUD_COMPUTER_TMUX_SESSION=$TARGET_GROUP-$CLOUD_COMPUTER_TMUX_SESSION_ID-$(date +%M%S)

# Create a new session to view the target process with
yarn tmux new-session \
  -d \
  -s $CLOUD_COMPUTER_TMUX_SESSION \
  -t $TARGET_GROUP

# Attach the terminal to the new session
yarn tmux attach-session -t $CLOUD_COMPUTER_TMUX_SESSION
