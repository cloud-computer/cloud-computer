FROM node:alpine

RUN npm install -g http-server

ADD index.html style.css ./
ADD icon-images icon-images

CMD http-server .
