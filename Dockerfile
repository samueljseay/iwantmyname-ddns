FROM arm64v8/alpine:latest
COPY entrypoint.sh /entrypoint.sh
RUN apk add --update curl && rm -rf /var/cache/apk/*
ENTRYPOINT ["/entrypoint.sh"]
