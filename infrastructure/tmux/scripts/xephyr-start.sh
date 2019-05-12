# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

TARGET_GROUP=xephyr

# Create a new tmux session
yarn tmux new-session \
  -d \
  -s $TARGET_GROUP

# Start the process in the tmux session
yarn tmux send-keys -t $TARGET_GROUP "DISPLAY=$CLOUD_COMPUTER_XPRA_DISPLAY Xephyr -ac -host-cursor -fullscreen -parent $CLOUD_COMPUTER_XPRA_DISPLAY -resizeable $DISPLAY" C-m

# Wait for xephyr to start
sleep 5

# Start window manager
openbox-session >/dev/null 2>/dev/null &

# Resize xephyr when xpra is resized
xeventbind resolution $PWD/scripts/xpra-resize.sh >/dev/null 2>/dev/null &

# Perform manual resize to set initial state
$PWD/scripts/xpra-resize.sh
