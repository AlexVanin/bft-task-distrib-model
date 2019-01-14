FROM golang:1.11-alpine3.8 as builder

RUN apk add --no-cache git

COPY . /bft-task-distrib-model

WORKDIR /bft-task-distrib-model

# https://github.com/golang/go/wiki/Modules#how-do-i-use-vendoring-with-modules-is-vendoring-going-away
# go build -mod=vendor
RUN set -x \
    && export CGO_ENABLED=0 \
    && go build -mod=vendor -o /go/bin/bft-task-distrib-model ./main.go

# Executable image
FROM alpine:3.8

COPY --from=builder /go/bin/bft-task-distrib-model /usr/local/sbin/bft-task-distrib-model