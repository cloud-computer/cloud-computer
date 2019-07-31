FROM node:10.16.0-alpine
WORKDIR /app

RUN npm config set unsafe-perm true

COPY package.json package.json
RUN yarn

COPY . .

CMD yarn dev
