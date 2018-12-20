#v_final/2018-12-20/append rule.ls  
FROM golang:alpine as builder
RUN apk add --update git
RUN go get -u -v github.com/frankpen/dazel/cmd/daze


FROM chenhw2/alpine:base
LABEL MAINTAINER Frank <https://github.com/frankpen>

# /usr/bin/daze
COPY --from=builder /go/bin /usr/bin

ENV ARGS="server -l :10200 -e asheshadow"
#define your password
ENV PASSWD="password"
EXPOSE 10200/tcp 10200/udp

CMD /usr/bin/daze ${ARGS} -k ${PASSWD}
