FROM golang:1.9
RUN go get -u github.com/inCaller/prometheus_bot
WORKDIR /go/src/github.com/inCaller/prometheus_bot
RUN CGO_ENABLED=0 GOOS=linux go build -o prometheus_bot .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/inCaller/prometheus_bot/prometheus_bot .
COPY --from=0 /go/src/github.com/inCaller/prometheus_bot/testdata/default.tmpl .
CMD ["/root/prometheus_bot"]
