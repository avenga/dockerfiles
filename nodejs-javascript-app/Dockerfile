ARG IMAGE_PREFIX="avenga/"
ARG VERSION="latest"
FROM ${IMAGE_PREFIX}nodejs-runner:${VERSION} AS release
ONBUILD COPY --from=build /app/package.json ./
ONBUILD COPY --from=build /app/src ./src
ONBUILD COPY --from=build /prod_node_modules ./node_modules
CMD ["node", "."]
