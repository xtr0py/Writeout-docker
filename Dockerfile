# Stage 1: Build the Go application
FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN apk add --no-cache git \
    && go get -d -v \
    && go build -o /app/main .

# Stage 2: Create the final Docker image
FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=builder /app/main .

RUN apk add --no-cache git \
    && git clone https://github.com/beyondcode/writeout.ai

CMD ["/main"]
