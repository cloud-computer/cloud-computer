# The cloud computer yarn shim
CLOUD_COMPUTER_YARN=$(dirname $(./scripts/readlink-f.sh $0))/../bin/cloud-computer-yarn.js

# The system yarn
SYSTEM_YARN=/usr/bin/yarn

# Early exit if our yarn backup already exists
if [ -f "$SYSTEM_YARN.cloud-computer.bak" ]; then
  exit 0
fi

# Ensure yarn shim source code is built
yarn build

# Backup system yarn
sudo mv "$SYSTEM_YARN" "$SYSTEM_YARN.cloud-computer.bak"

# Symlink cloud computer yarn to system yarn location
sudo ln -s "$CLOUD_COMPUTER_YARN" "$SYSTEM_YARN"
