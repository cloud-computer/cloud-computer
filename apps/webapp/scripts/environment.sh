### COMMON
echo export JSON_SECRET=cloud-computer-json-secret-$(date +%s)

### POSTGRES
echo export POSTGRES_HOST=postgres
echo export POSTGRES_DB=mantra
echo export POSTGRES_USER=postgres
echo export POSTGRES_PASSWORD=password

### HASURA
echo export HASURA_GRAPHQL_ENABLE_CONSOLE=true
echo export HASURA_GRAPHQL_ENABLE_TELEMETRY=false
echo export HASURA_GRAPHQL_CORS_DOMAIN=*
echo export HASURA_GRAPHQL_ADMIN_SECRET=mantra

### Auth service
echo export AUTH_SERVICE_HOST=https://dev.auth.webapp.$CLOUD_COMPUTER_DNS_NAME
echo export GOOGLE_CLIENT_ID=820336721515-df68p28g744u9cls3m9sipi7fu52or70.apps.googleusercontent.com
echo export GOOGLE_CLIENT_SECRET=A2D3oGjc5LgVciktZPl_fof2
echo export GOOGLE_CALLBACK=https://dev.auth.webapp.$CLOUD_COMPUTER_DNS_NAME/auth/google/callback
echo export GOOGLE_REDIRECT=https://dev.auth.webapp.$CLOUD_COMPUTER_DNS_NAME/auth/google
echo export GITHUB_CLIENT_ID=Iv1.33d7572b0ba5c40a
echo export GITHUB_CLIENT_SECRET=2c78b2f15715c34647498d1573467bbe1646cf43
echo export GITHUB_CALLBACK=https://dev.auth.webapp.$CLOUD_COMPUTER_DNS_NAME/auth/github/callback
echo export GITHUB_REDIRECT=https://dev.auth.webapp.$CLOUD_COMPUTER_DNS_NAME/auth/github

### Mail service
echo export MAIL_SERVICE_DOMAIN=sandbox47f2a5030ace4d899fe52eba517c4551.mailgun.org
echo export MAIL_SERVICE_APIKEY=f77050361b2c8a1731d4ebc4fe4e6d20-16ffd509-09d514e4

### React
echo export REACT_APP=https://dev.client.webapp.$CLOUD_COMPUTER_DNS_NAME
echo export REACT_APP_HOST=https://dev.hasura.webapp.$CLOUD_COMPUTER_DNS_NAME/v1alpha1/graphql
echo export REACT_APP_WEBSOCKET_HOST=wss://dev.hasura.webapp.$CLOUD_COMPUTER_DNS_NAME/v1alpha1/graphql

### Stream service
echo export STREAM_HOST=https://dev.stream.webapp.$CLOUD_COMPUTER_DNS_NAME
