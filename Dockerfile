FROM alpine:3.15.5

ARG USERNAME=vpn

ENV SSH_USER_USERNAME=${USERNAME}
ENV SSH_USER_PASSWORD=""
ENV SSH_PUBLIC_KEY_VALUE=""

RUN set -eux; \
    apk add --no-cache bash openssh; \
    \
    addgroup -g 1000 -S ${USERNAME}; \
    adduser -u 1000 -S -D -G ${USERNAME} -h /home/${USERNAME} -s /bin/sh ${USERNAME}; \
    mkdir -p /home/${USERNAME}/.ssh; \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh; \
    chmod -R 700 /home/${USERNAME}/.ssh

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["sshd"]
