TARGET_GROUP=dashboard

# Create a new tmux session
yarn tmux new-session \
  -d \
  -s $TARGET_GROUP

# Start the process in the tmux session
tmuxinator start dashboard
