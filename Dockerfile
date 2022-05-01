FROM node:18-alpine as base

WORKDIR /usr/src/app

# prevent yarn from throwing up all the logs
ENV CI=true

COPY --chown=node:node yarn.lock .
COPY --chown=node:node package.json .
COPY --chown=node:node .yarnrc.yml .
COPY --chown=node:node .yarn/ .yarn/

FROM base as build

ENV NODE_ENV="development"

COPY --chown=node:node tsconfig.base.json .
COPY --chown=node:node src/ src/

RUN yarn install --immutable
RUN yarn run build

# ================ #
#   Runner Stage   #
# ================ #

FROM base AS runner

ENV NODE_ENV="production"
ENV NODE_OPTIONS="--enable-source-maps"

WORKDIR /usr/src/app

COPY --chown=node:node --from=build /usr/src/app/dist dist

RUN yarn workspaces focus --all --production

USER node

CMD [ "node", "." ]