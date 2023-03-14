# Stage 1: Build the Go application
FROM golang:alpine AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache git

WORKDIR /app

RUN git clone https://github.com/beyondcode/writeout.ai .
RUN go build -o writeout

# Stage 2: Create the final Docker image
FROM alpine:latest

RUN apk update && apk upgrade && \
    apk add --no-cache ca-certificates

COPY --from=builder /app/writeout /usr/local/bin/writeout

CMD ["writeout"]
