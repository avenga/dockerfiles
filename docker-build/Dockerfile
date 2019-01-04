FROM docker:18.03.1-ce-git AS release

# defaults
ENV WORKDIR=/work
ENV IMAGE_PREFIX=""
ENV IMAGES=""
ENV IMAGE_TAG="latest"
ENV TARGET="release"
ENV LABEL_VENDOR=""
ENV LABEL_VCS_URL=""

WORKDIR ${WORKDIR}
VOLUME ${WORKDIR}

# Used for testing shell scripts:
COPY --from=koalaman/shellcheck-alpine:v0.6.0 /bin/shellcheck /bin/shellcheck

COPY run.sh /
RUN shellcheck /run.sh

COPY install.sh ./
RUN shellcheck install.sh
# Inspired by https://github.com/schickling/dockerfiles to reduce image size:
RUN ./install.sh && rm install.sh

ENTRYPOINT ["bash"]
CMD ["/run.sh"]
