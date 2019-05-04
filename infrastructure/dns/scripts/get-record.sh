# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Command line arguments
HOSTNAME=$1

# Get the record matching the given HOSTNAME and IP
get_record () {
  curl "https://api.cloudflare.com/client/v4/zones/$(yarn dns-zone)/dns_records?type=A&name=$HOSTNAME" \
    --header "X-Auth-Email: $(yarn dns-email)" \
    --header "X-Auth-Key: $(yarn dns-token)" \
    --header "Content-Type: application/json" \
    --request GET \
    --silent | \
    jq '.result[0] | select (.!=null)'
}

# Get the dns mapping for the supplied hostname
get_record
