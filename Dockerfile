#v1.1/2018-12-3/自定义密码变量
FROM golang:alpine as builder
RUN apk add --update git
RUN go get -u -v github.com/mohanson/daze/cmd/daze


FROM chenhw2/alpine:base
LABEL MAINTAINER Frank <https://github.com/frankpen>

# /usr/bin/daze
COPY --from=builder /go/bin /usr/bin

USER nobody
ENV ARGS="server -l :10200 -e asheshadow"
#define your password
ENV PASSWD="password"
EXPOSE 10200/tcp 10200/udp

CMD /usr/bin/daze ${ARGS} -k ${PASSWD}
