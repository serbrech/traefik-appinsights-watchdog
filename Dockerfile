# build stage
FROM ataraev/golang-alpine-git AS build-env
ADD . /go/app
WORKDIR /go/app
ENV GOBIN /go/bin
RUN go get -d -v ./
RUN go build -o traefik-appinsights-watchdog -v

# final stage
FROM golang:alpine
WORKDIR /app
COPY --from=build-env /go/app/traefik-appinsights-watchdog .
ENTRYPOINT ["./traefik-appinsights-watchdog"]