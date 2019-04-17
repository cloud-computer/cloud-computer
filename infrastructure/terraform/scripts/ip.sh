# Point shell context to the current environment's terraform host
export $(yarn environment)

# Export cloud computer shell environment
export $(yarn --cwd ../cloud-computer environment)

# Check for an ip cached in the hosts file
TERRAFORM_TARGET_IP=$(yarn --cwd ../hosts get-host $TERRAFORM_TARGET-$CLOUD_COMPUTER_HOST_DNS)

# Get the ip from terraform if not cached
if [ -z "$TERRAFORM_TARGET_IP" ] || [ "$1" = "--no-cache" ]; then
  TERRAFORM_TARGET_IP=$(yarn output ip 2>/dev/null)
fi

echo $TERRAFORM_TARGET_IP
