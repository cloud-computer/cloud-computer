TARGET_GROUP=weechat

# Create a new tmux session
yarn tmux new-session \
  -d \
  -s $TARGET_GROUP

# Start the process in the tmux session
yarn tmux send-keys -t $TARGET_GROUP weechat C-m
