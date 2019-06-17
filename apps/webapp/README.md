### Requisites
1. node.js
2. docker
3. docker-compose
4. [hasura cli](https://docs.hasura.io/1.0/graphql/manual/hasura-cli/install-hasura-cli.html)

### Development
1. `cp .env.sample .env`
2. `cd client && yarn install`
3. `docker-compose build`
4. `docker-compose up -d`. Sometimes hasura cant wait for postgres to ready so rerun it.
5. `cd hasura-console && hasura migrate apply --access-key=<admin-secret>`
6. `cd client && yarn start`

### Hasura console
1. Update `hasura-console/config.yml` point `endpoint` to `hasura` engine.
2. `cd hasura-console && hasura console --access-key=<admin-secret>`

### Hasura migrations
1. `cd hasura-console && hasura migrate apply --access-key=<admin-secret>`

### Dev
1. `cd client && yarn storybook`