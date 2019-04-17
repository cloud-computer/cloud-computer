# Get all tmux child sessions
CLIENT_SESSIONS=$(yarn tmux ls | grep -E "*[^ ]+-[0-9]{4}-[0-9]{4}: " | cut -f 1 -d :)

if [ ! -z "$CLIENT_SESSIONS" ]; then

  # Kill each child session
  for CLIENT_SESSION in $CLIENT_SESSIONS; do
    yarn tmux kill-session -t $CLIENT_SESSION
  done

fi
