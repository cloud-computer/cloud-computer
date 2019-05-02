# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# List all dns records
list_records () {
  curl "https://api.cloudflare.com/client/v4/zones/$(yarn cloudflare-zone)/dns_records?type=A&per_page=100" \
    --header "X-Auth-Email: $(yarn cloudflare-email)" \
    --header "X-Auth-Key: $(yarn cloudflare-token)" \
    --header "Content-Type: application/json" \
    --request GET \
    --silent |
    jq --raw-output ".result | map(.name) | .[]"
}

# List all dns records
list_records
