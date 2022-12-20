FROM node:16.13.1-stretch

ADD ./sample.api /app/sample.api

WORKDIR /app/sample.api
RUN npm i
RUN npm run build

EXPOSE 3000

CMD ["node", "./dist/main.js"]
