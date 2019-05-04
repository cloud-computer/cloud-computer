# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# List all dns records
list_records () {
  curl "https://api.cloudflare.com/client/v4/zones/$(yarn dns-zone)/dns_records?type=A&per_page=100" \
    --header "X-Auth-Email: $(yarn dns-email)" \
    --header "X-Auth-Key: $(yarn dns-token)" \
    --header "Content-Type: application/json" \
    --request GET \
    --silent |
    jq --raw-output ".result | map(.name) | .[]"
}

# List all dns records
list_records
