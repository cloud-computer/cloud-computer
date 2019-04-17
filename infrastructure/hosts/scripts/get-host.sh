# Command line arguments
HOSTNAME=$1

# Return ip mapping for supplied host
grep $HOSTNAME /etc/hosts | cut -f 1 -d \  | head -n 1
