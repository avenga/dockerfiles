FROM mhart/alpine-node:base-10.0.0 AS release
ENV NODE_ENV=production
RUN apk add --no-cache tini
WORKDIR /app
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node"]
