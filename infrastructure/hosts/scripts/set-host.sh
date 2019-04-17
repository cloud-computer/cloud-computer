# Command line arguments
HOSTNAME=$1
IP=$2

remove_host () {
  # Docker is always writing to the hosts file, so operate on a copy
  cp /etc/hosts /tmp/hosts
  sed -i "/$HOSTNAME/d" /tmp/hosts
  sudo cp -f /tmp/hosts /etc/hosts
}

insert_host () {
  # Docker is always writing to the hosts file, so operate on a copy
  echo "$(cat /etc/hosts)\n$IP $HOSTNAME" > /tmp/hosts
  sudo cp -f /tmp/hosts /etc/hosts
}

set_host () {
  remove_host $HOSTNAME
  insert_host $HOSTNAME
}

# Set a mapping for the supplied host and ip
set_host
