FROM golang:1.22.5 AS builder

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=builder /app/main .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD ["./main"]
