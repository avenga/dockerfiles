ARG IMAGE_PREFIX="avenga/"
FROM ${IMAGE_PREFIX}nodejs-runner:latest AS release
ENV YARN_VERSION="1.15.0"
RUN wget -O /yarn.js https://github.com/yarnpkg/yarn/releases/download/v${YARN_VERSION}/yarn-${YARN_VERSION}.js
COPY yarn /usr/bin
RUN yarn --version
ONBUILD COPY package.json yarn.lock ./
ONBUILD RUN yarn install --frozen-lockfile --production=true --modules-folder /prod_node_modules --silent
ONBUILD RUN yarn install --frozen-lockfile --production=false
ONBUILD COPY src ./src
ONBUILD COPY test ./test
# run unit tests
ONBUILD RUN yarn test:unit
