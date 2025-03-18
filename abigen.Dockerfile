FROM golang:1.24-alpine AS builder

RUN apk add --no-cache gcc musl-dev linux-headers git

# Get dependencies - will also be cached if we won't change go.mod/go.sum
COPY go.mod /go-ethereum/
COPY go.sum /go-ethereum/
RUN cd /go-ethereum && go mod download

ADD . /go-ethereum
RUN cd /go-ethereum && go build -o abigen ./cmd/abigen

FROM alpine:3.21

COPY --from=builder /go-ethereum/abigen /usr/local/bin/

ENTRYPOINT ["abigen"]
