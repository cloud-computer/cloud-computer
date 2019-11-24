# Export cloud computer dns environment
eval "$(yarn --cwd infrastructure/dns environment)"

# Print link for click-to-open access
echo
echo https://$CLOUD_COMPUTER_DNS_NAME
echo
