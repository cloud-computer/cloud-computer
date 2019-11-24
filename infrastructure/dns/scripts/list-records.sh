# Export cloud computer dns environment
eval "$(yarn environment)"

# List all dns records
list_records () {
  curl "https://api.cloudflare.com/client/v4/zones/$CLOUD_COMPUTER_DNS_ZONE/dns_records?type=A&per_page=100" \
    --header "Authorization: Bearer $CLOUD_COMPUTER_DNS_TOKEN" \
    --header "Content-Type: application/json" \
    --request GET \
    --silent |
    jq --raw-output ".result | map(.name) | .[]"
}

# List all dns records
list_records
