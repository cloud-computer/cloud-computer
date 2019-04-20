# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Command line arguments
HOSTNAME=$1

# Get the record matching the given HOSTNAME and IP
get_record () {
  curl "https://api.cloudflare.com/client/v4/zones/$CLOUD_COMPUTER_CLOUDFLARE_ZONE/dns_records?type=A&name=$HOSTNAME" \
    --header "X-Auth-Email: $CLOUD_COMPUTER_CLOUDFLARE_EMAIL" \
    --header "X-Auth-Key: $CLOUD_COMPUTER_CLOUDFLARE_TOKEN" \
    --header "Content-Type: application/json" \
    --request GET \
    --silent | \
    jq '.result[0] | select (.!=null)'
}

# Get the dns mapping for the supplied hostname
get_record
