FROM docker:18.03.1-ce-git AS release

# defaults
ENV IMAGE_PREFIX=""
ENV IMAGES=""
ENV CURRENT_BRANCH=""
ENV ONLY_BRANCH="master"

WORKDIR /work

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
