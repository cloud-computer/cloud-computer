### Requisites
1. node.js
2. docker
3. docker-compose
4. [hasura cli](https://docs.hasura.io/1.0/graphql/manual/hasura-cli/install-hasura-cli.html)
5. next.js

### Development
1. `cp .env.sample .env`
2. `cd client && yarn install`
3. `yarn global add next`
3. `docker-compose build`
4. `docker-compose up -d`. Sometimes hasura cant wait for postgres to ready so rerun it.
5. `cd hasura-console && hasura migrate apply --access-key=<admin-secret>`
6. `cd client && yarn dev`

### Running services
1. Auth service  on `localhost:9995`
2. Mail service on `localhost:9994`
3. Hasura ( GraphQL server ) on `localhost:9999`
4. Access Client application on `localhost:9998`

### Hasura console
1. Update `hasura-console/config.yml` point `endpoint` to `hasura` engine.
2. `cd hasura-console && hasura console --access-key=<admin-secret>`

### Hasura migrations
1. `cd hasura-console && hasura migrate apply --access-key=<admin-secret>`

### Dev
1. `cd client && yarn storybook`

### Keys
1. https://gist.github.com/sabrehagen/3a23320706dc30bf6a4e99a1e69efd9d