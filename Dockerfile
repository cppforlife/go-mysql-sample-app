FROM golang:1.10.1
WORKDIR /go/src/github.com/techslides/sampleapp/
COPY . .
RUN go get .
RUN CGO_ENABLED=0 GOOS=linux go build -v -o app server.go

FROM scratch
COPY --from=0 /go/src/github.com/techslides/sampleapp/app .
COPY --from=0 /go/src/github.com/techslides/sampleapp/public public
COPY --from=0 /go/src/github.com/techslides/sampleapp/templates templates
EXPOSE 8080
ENTRYPOINT ["/app"]
