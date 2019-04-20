# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# List all dns records
list_records () {
  curl "https://api.cloudflare.com/client/v4/zones/$CLOUD_COMPUTER_CLOUDFLARE_ZONE/dns_records?type=A&per_page=100" \
    --header "X-Auth-Email: $CLOUD_COMPUTER_CLOUDFLARE_EMAIL" \
    --header "X-Auth-Key: $CLOUD_COMPUTER_CLOUDFLARE_TOKEN" \
    --header "Content-Type: application/json" \
    --request GET \
    --silent |
    jq --raw-output ".result | map(.name) | .[]"
}

# List all dns records
list_records
