FROM golang:1.20-alpine3.18 AS builder
LABEL authors="cp"

WORKDIR /build

ENV GOPROXY=https://goproxy.cn,direct
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o gin-demo .

FROM alpine:3.18

WORKDIR /app
COPY --from=builder /build/gin-demo /app/

EXPOSE 8080

ENTRYPOINT ["./gin-demo"]