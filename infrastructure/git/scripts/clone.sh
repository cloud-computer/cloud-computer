# Local repository branch
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Clone cloud-computer backend repository
yarn git clone https://github.com/cloud-computer/cloud-computer.git --branch $GIT_BRANCH --depth 1 --single-branch . 2>/dev/null

# Restore refs after shallow clone
yarn git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Fetch refs after shallow clone
yarn git fetch --depth 1
