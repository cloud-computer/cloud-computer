# Export cloud computer dns environment
eval "$(yarn environment)"

# Command line arguments
HOSTNAME=$1

# Get the record matching the given HOSTNAME and IP
get_record () {
  curl "https://api.cloudflare.com/client/v4/zones/$CLOUD_COMPUTER_DNS_ZONE/dns_records?type=A&name=$HOSTNAME" \
    --header "Authorization: Bearer $CLOUD_COMPUTER_DNS_TOKEN" \
    --header "Content-Type: application/json" \
    --request GET \
    --silent | \
    jq '.result[0] | select (.!=null)'
}

# Get the dns mapping for the supplied hostname
get_record
