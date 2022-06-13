FROM node:14.17.6-alpine as build-step

RUN apk add --no-cache git

RUN mkdir /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.17.1-alpine

COPY  ./deployment/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build-step /app/build /usr/share/nginx/html