# build for production
FROM node:18.12.1-alpine AS build

WORKDIR /app

COPY --chown=node:node package*.json ./

RUN npm ci

COPY --chown=node:node . .

RUN npm run build && \
    npm prune --omit=dev

USER node

# production
FROM node:18.12.1-alpine AS production

WORKDIR /app

COPY --chown=node:node --from=build /app/node_modules ./node_modules
COPY --chown=node:node --from=build /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/main.js"]
