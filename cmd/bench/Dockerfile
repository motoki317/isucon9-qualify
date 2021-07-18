FROM golang:1.16.6-alpine

WORKDIR /app

COPY go.* .
RUN go mod download

COPY . .
RUN mkdir -p /app/bin
RUN go build -o /app/bin/bench ./cmd/bench
RUN go build -o /app/bin/payment ./cmd/payment
RUN go build -o /app/bin/shipment ./cmd/shipment

ENTRYPOINT ["/bin/sh", "-c", "while :; do sleep 10; done"]
