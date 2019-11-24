# Export cloud computer dns environment
eval "$(yarn environment)"

DNS_RECORDS=$(yarn list-records | grep $CLOUD_COMPUTER_DNS_NAME)

# Delete each dns record
for DNS_RECORD in $DNS_RECORDS; do
  yarn --cwd ../dns delete-record $DNS_RECORD &
done

# Wait for dns records to delete in parallel
wait
