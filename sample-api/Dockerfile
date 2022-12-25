# build for production
FROM node:18.12.1-alpine AS build

ADD ./sample-api /usr/src/app
WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm ci

COPY --chown=node:node . .

RUN npm run build

ENV NODE_ENV production

RUN npm prune --production

USER node

# production
FROM node:18.12.1-alpine AS production

COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./

EXPOSE 3000

CMD ["node", "./src/main.js"]
