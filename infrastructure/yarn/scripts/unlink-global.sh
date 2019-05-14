# The cloud computer yarn shim
CLOUD_COMPUTER_YARN=$(dirname $(./scripts/readlink-f.sh $0))/../bin/cloud-computer-yarn.js

# The system yarn
SYSTEM_YARN=/usr/bin/yarn

# Early exit if our yarn backup does not exist
if [ ! -f "$SYSTEM_YARN.cloud-computer.bak" ]; then
  exit 0
fi

# Remove the yarn shim symlink
sudo rm -f "$SYSTEM_YARN"

# Restore the original yarn
sudo mv "$SYSTEM_YARN.cloud-computer.bak" "$SYSTEM_YARN"
