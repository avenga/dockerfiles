FROM alpine:3.8 AS release
WORKDIR /tmp
RUN wget -O serve.tar.gz $(wget -q -O - https://api.github.com/repos/syntaqx/serve/releases/latest \
    | grep 'browser_download_url.*linux_x86_64' \
    | awk '{ print $2 }' | tr -d '"') \
    && tar xzf ./serve.tar.gz \
    && cp /tmp/serve /bin \
    && chmod +x /bin/serve \
    && rm -f *
WORKDIR /srv
ENTRYPOINT [ "/bin/serve" ]
EXPOSE 8080
