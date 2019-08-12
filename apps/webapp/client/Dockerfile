FROM node:10.16.0-alpine
WORKDIR /app

COPY package.json package.json
RUN yarn --pure-lockfile

COPY . .

CMD yarn dev
