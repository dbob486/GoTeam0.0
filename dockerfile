FROM golang:alpine as build-env

ENV GO111MODULE=on

RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir /GoChat
RUN mkdir -p /GoChat/proto

WORKDIR /GoChat

COPY ./proto/service.pb.go /GoChat/proto
COPY ./main.go /GoChat

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o GoChat .

CMD ./GoChat