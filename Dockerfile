FROM golang:alpine AS build-stage
WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

FROM alpine AS export-stage
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
COPY --from=build-stage /go/bin/pgroute66 /usr/bin/
COPY config/pgroute66.yaml /etc/pgroute66/config.yaml
CMD /usr/bin/pgroute66
