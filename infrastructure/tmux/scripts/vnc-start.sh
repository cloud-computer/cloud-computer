# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

TARGET_GROUP=vnc

# Create a new tmux session
yarn tmux new-session \
  -d \
  -s $TARGET_GROUP

# Start the process in the tmux session
yarn tmux send-keys -t $TARGET_GROUP x11vnc -display :$CLOUD_COMPUTER_VNC_DISPLAY C-m
