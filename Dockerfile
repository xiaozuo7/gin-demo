FROM alpine:3.18.0
LABEL authors="cp"

WORKDIR /build

ENV GOPROXY=https://goproxy.cn,direct
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o gin-demo .

EXPOSE 8080

ENTRYPOINT ["./gin-demo"]