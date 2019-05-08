# Export cloud computer dns environment
eval "$(yarn environment)"

# Command line arguments
HOSTNAME=$1
IP=$2

# Create the record for the given HOSTNAME and IP
create_record () {
  curl "https://api.cloudflare.com/client/v4/zones/$CLOUD_COMPUTER_DNS_ZONE/dns_records" \
    --data '{"type":"A","name":'\"$HOSTNAME\"',"content":'\"$IP\"',"ttl":30,"proxied":false}' \
    --header "X-Auth-Email: $CLOUD_COMPUTER_DNS_EMAIL" \
    --header "X-Auth-Key: $CLOUD_COMPUTER_DNS_TOKEN" \
    --header "Content-Type: application/json" \
    --output /dev/null \
    --request POST \
    --silent
}

# Update the record matching the given HOSTNAME and IP
update_record () {
  RECORD_ID=$1
  curl "https://api.cloudflare.com/client/v4/zones/$CLOUD_COMPUTER_DNS_ZONE/dns_records/$RECORD_ID" \
    --data '{"type":"A","name":'\"$HOSTNAME\"',"content":'\"$IP\"',"ttl":30,"proxied":false}' \
    --header "X-Auth-Email: $CLOUD_COMPUTER_DNS_EMAIL" \
    --header "X-Auth-Key: $CLOUD_COMPUTER_DNS_TOKEN" \
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
