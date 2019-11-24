# Export cloud computer dns environment
eval "$(yarn --cwd ../dns environment)"

# The container that starts the tmux server will run all subsequent tmux commands, not the container that issued the command.
yarn tmux new-session -d -s tmux-server zsh 2>/dev/null

# Set environment for all sessions
yarn tmux set-environment -g CLOUD_COMPUTER_DNS_NAME $CLOUD_COMPUTER_DNS_NAME
