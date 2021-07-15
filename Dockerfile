FROM alpine:3.12
LABEL org.opencontainers.image.source https://github.com/kvclone/rsync-client.git
RUN apk add --no-cache bash
RUN apk add --no-cache vim=8.2.0735-r0
RUN apk add --no-cache rsync==3.1.3-r3

# entrypoint script
COPY scripts/entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod +x /usr/sbin/entrypoint.sh
RUN mkdir -p /entrypoint.d
VOLUME /data
ENTRYPOINT [ "entrypoint.sh" ]
