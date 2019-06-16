FROM golang:alpine as build
WORKDIR /build
RUN apk --quiet --no-progress --no-cache add git
RUN go get github.com/groob/ulidgen

FROM scratch as release
COPY --from=build /go/bin/ulidgen /bin/ulidgen
ENTRYPOINT ["/bin/ulidgen"]
