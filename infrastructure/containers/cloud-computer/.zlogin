# Load cloud computer ssh keys if present
if [ -d $CLOUD_COMPUTER_CREDENTIALS ]; then
  ssh-add $CLOUD_COMPUTER_CREDENTIALS/cloud-computer.prv >/dev/null 2>&1
fi

# Print mesasge of the day
/bin/cat $HOME/.motd

# Print container build info if present
if [ ! -z "$CONTAINER_BUILD_DATE" ]; then
  GREEN=$(tput setaf 2)
  MAGENTA=$(tput setaf 5)
  WHITE=$(tput setaf 7)
  YELLOW=$(tput setaf 3)

  CURRENT_DATE=$(date +%s)
  TIME_SINCE_CONTAINER_BUILD=$(echo $((CURRENT_DATE-CONTAINER_BUILD_DATE)) | awk '{print int($1/(60*60*24))" days "int(($1/(60*60)%24))" hrs "int($1/60%60)" mins "int($1%60)" secs ago"}')

  COLOURED_TIME_SINCE_CONTAINER_BUILD=$(echo $TIME_SINCE_CONTAINER_BUILD | sed -E "s;([0-9]+);$GREEN\1$WHITE;g")
  COLOURED_CONTAINER_GIT_SHA="$YELLOW${CONTAINER_GIT_SHA}$WHITE"
  COLOURED_CONTAINER_IMAGE_NAME="$MAGENTA${CONTAINER_IMAGE_NAME}$WHITE"

  echo
  echo "$COLOURED_CONTAINER_IMAGE_NAME | built $COLOURED_TIME_SINCE_CONTAINER_BUILD | $COLOURED_CONTAINER_GIT_SHA"
fi

# Log current working directory structure
tree -L 1 -d

# Unlock ssh private key
eval $(keychain --eval id_rsa 2>/dev/null)

# Make unlocked key available to tmux clients
if [ ! -z "$SSH_AUTH_SOCK" ]; then
  tmux set-environment -g SSH_AGENT_PID $SSH_AGENT_PID
  tmux set-environment -g SSH_AUTH_SOCK $SSH_AUTH_SOCK
fi
