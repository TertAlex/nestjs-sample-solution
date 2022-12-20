FROM node:16.13.1-stretch AS BUILDER

WORKDIR /app/

ADD . .

WORKDIR /app/sample-fe

RUN npm i
RUN node --max_old_space_size=8192
RUN npm run build

FROM nginx:stable-alpine

WORKDIR /var/www

COPY --from=BUILDER /app/sample-fe/dist/sample-fe ./
COPY --from=BUILDER /app/sample-fe/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
