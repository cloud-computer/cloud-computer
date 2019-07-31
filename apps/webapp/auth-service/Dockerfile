FROM node:10.16.0-alpine
WORKDIR /app

COPY package.json package.json
RUN yarn

COPY . .

CMD yarn dev
