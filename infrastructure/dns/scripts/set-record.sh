# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Command line arguments
HOSTNAME=$1
IP=$2

# Create the record for the given HOSTNAME and IP
create_record () {
  curl "https://api.cloudflare.com/client/v4/zones/$(yarn dns-zone)/dns_records" \
    --data '{"type":"A","name":'\"$HOSTNAME\"',"content":'\"$IP\"',"ttl":1,"priority":10,"proxied":true}' \
    --header "X-Auth-Email: $(yarn dns-email)" \
    --header "X-Auth-Key: $(yarn dns-token)" \
    --header "Content-Type: application/json" \
    --output /dev/null \
    --request POST \
    --silent
}

# Update the record matching the given HOSTNAME and IP
update_record () {
  RECORD_ID=$1
  curl "https://api.cloudflare.com/client/v4/zones/$(yarn dns-zone)/dns_records/$RECORD_ID" \
    --data '{"type":"A","name":'\"$HOSTNAME\"',"content":'\"$IP\"',"ttl":1,"priority":10,"proxied":true}' \
    --header "X-Auth-Email: $(yarn dns-email)" \
    --header "X-Auth-Key: $(yarn dns-token)" \
    --header "Content-Type: application/json" \
    --output /dev/null \
    --request PUT \
    --silent
}

add_record () {
  EXISTING_RECORD=$(yarn get-record $HOSTNAME)
  if [ ! -z "$EXISTING_RECORD" ]; then
    EXISTING_RECORD_ID=$(echo "$EXISTING_RECORD" | jq .id --raw-output)
    update_record "$EXISTING_RECORD_ID"
  else
    create_record
  fi
}

# Add the dns mapping for the supplied ip and hostname
add_record
