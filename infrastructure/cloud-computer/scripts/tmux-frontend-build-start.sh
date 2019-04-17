# Export cloud computer shell environment
export $(yarn environment)

TARGET_GROUP=build-frontend

# Create a new tmux session
yarn tmux new-session \
  -d \
  -s $TARGET_GROUP

# Start the process in the tmux session
yarn tmux send-keys -t $TARGET_GROUP "yarn --cwd /cloud-computer/frontend dev" C-m
