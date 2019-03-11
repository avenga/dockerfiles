ARG NODE_VERSION=10.15.3
FROM mhart/alpine-node:base-${NODE_VERSION} AS release
ENV NODE_ENV=production
RUN apk add --no-cache tini
RUN node --version
WORKDIR /app
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node"]
