FROM golang:1.16.6-alpine

WORKDIR /app

COPY go.* .
RUN go mod download

COPY . .
RUN go build -o /app/isucari .

ENTRYPOINT ["/app/isucari"]
