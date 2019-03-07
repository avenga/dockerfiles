ARG  IMAGE_PREFIX="7val/"
FROM ${IMAGE_PREFIX}nodejs-runner:latest AS release
ONBUILD COPY --from=build /app/package.json ./
ONBUILD COPY --from=build /app/src ./src
ONBUILD COPY --from=build /prod_node_modules ./node_modules
CMD ["node", "."]
