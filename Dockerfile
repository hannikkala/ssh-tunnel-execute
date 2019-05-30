FROM alpine:latest

RUN apk update && apk add autossh

ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
