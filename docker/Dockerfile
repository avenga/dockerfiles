FROM koalaman/shellcheck-alpine:v0.6.0 as test
COPY *.sh ./
RUN find . -name "*.sh" | xargs shellcheck

FROM docker:git AS release
ENV WORKDIR=/work
WORKDIR ${WORKDIR}
VOLUME ${WORKDIR}
# Inspired by https://github.com/schickling/dockerfiles to reduce image size:
COPY install.sh ./
RUN ./install.sh && rm install.sh
ENTRYPOINT ["bash"]
