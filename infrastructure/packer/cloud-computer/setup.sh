# Install shell utilities
apt-get update && \
  apt-get install -qq \
  git \
  htop

# Allow the sudo group to use sudo without a password
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Increase max open files on host
echo 'fs.file-max=1000000' >> /etc/sysctl.conf

# Increase max open file watchers on host
echo 'fs.inotify.max_user_watches=1000000' >> /etc/sysctl.conf

# Support ipv4 forwarding in docker
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

# Increase max virtual memory maps
echo 'vm.max_map_count=262144' >> /etc/sysctl.conf

# Increase file descriptor limit
echo '* soft nofile 1000000' >> /etc/security/limits.conf
echo '* hard nofile 1000000' >> /etc/security/limits.conf

# Users and groups to be used
DOCKER_GROUP=999
PIPELINE_SERVER=4000
PIPELINE_CONTAINERS=4001

# Create the pipeline-server group
groupadd \
  --gid $PIPELINE_SERVER \
  pipeline-server

# Create the pipeline-server user
useradd \
  --gid $PIPELINE_SERVER \
  --uid $PIPELINE_SERVER \
  pipeline-server

# Create the pipeline group
groupadd \
  --gid $PIPELINE_CONTAINERS \
  pipeline

# Create the pipeline user
useradd \
  --gid $PIPELINE_CONTAINERS \
  --uid $PIPELINE_CONTAINERS \
  pipeline

# Create the docker group
groupadd \
  --gid $DOCKER_GROUP \
  docker

# Add the first non-root user to the docker and sudo groups
usermod \
  --append \
  --groups $DOCKER_GROUP,sudo \
  ubuntu

# What does this do?
systemd-run \
  --property="After=apt-daily.service apt-daily-upgrade.service" \
  --wait \
  /bin/true

# Disable systemd apt auto-updates to avoid lockfile contention
systemctl mask \
  apt-daily-upgrade.service \
  apt-daily-upgrade.timer \
  apt-daily.service \
  apt-daily.timer
