FROM docker:18.03.1-ce-git AS release
RUN apk --no-cache add bash
COPY ./run.sh ./
ENTRYPOINT ["/bin/bash"]
CMD ["run.sh"]
