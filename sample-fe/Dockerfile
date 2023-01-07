FROM node:18.12.1-bullseye-slim AS build

WORKDIR /app/

COPY --chown=node:node package*.json ./
RUN npm ci

COPY . .
RUN npm run build:production &&  \
    npm prune --omit=dev

FROM nginx:1.23.3-alpine-slim

WORKDIR /var/www

COPY --from=build /app/dist/sample-fe ./
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
