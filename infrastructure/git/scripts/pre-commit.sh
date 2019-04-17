CURRENT_BRANCH=$(git symbolic-ref --short HEAD)

RED="\033[31m"
ESC="\e[0m"

RESTRICTED_BRANCHES="master staging"

for BRANCH in $RESTRICTED_BRANCHES; do
  if [ "$CURRENT_BRANCH" = "$BRANCH" ]; then
    echo "$RED You can not commit to $CURRENT_BRANCH! $ESC"

    if [ ! -z "$1" ]; then
      echo "$RED Changing to new branch $1. $ESC"
    else
      exit 1
    fi
  fi
done
