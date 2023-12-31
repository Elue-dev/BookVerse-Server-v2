FROM golang:1.19 AS builder

WORKDIR /app

COPY go.mod .

COPY go.sum .

RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main main.go


FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main .

EXPOSE 8080

CMD [ "./main" ]