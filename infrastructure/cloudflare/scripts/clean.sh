# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

DNS_RECORDS=$(yarn list-records | grep $CLOUD_COMPUTER_HOST_DNS)

# Delete each dns record
for DNS_RECORD in $DNS_RECORDS; do
  yarn --cwd ../cloudflare delete-record $DNS_RECORD &
done

# Wait for dns records to delete in parallel
wait
