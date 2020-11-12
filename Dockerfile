FROM golang:1.14 as builder

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . .
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -o mirror

FROM scratch
COPY --from=builder /usr/src/app/mirror /bin/mirror
ENTRYPOINT ["/bin/mirror"]
EXPOSE 8080