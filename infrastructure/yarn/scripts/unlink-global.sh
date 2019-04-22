# The cloud computer yarn shim
CLOUD_COMPUTER_YARN=$(dirname $(yarn readlink-f $0))/../bin/cloud-computer-yarn.js

# Yarn installs to /usr/bin, so use /usr/local/bin to appear first in PATH
SYSTEM_YARN=/usr/local/bin/yarn

# Early exit if yarn is not our symlink
if [ "$(yarn readlink-f $SYSTEM_YARN)" != "$(yarn readlink-f $CLOUD_COMPUTER_YARN)" ]; then
  exit 0
fi

# Remove the yarn shim symlink
sudo rm -f "$SYSTEM_YARN"
