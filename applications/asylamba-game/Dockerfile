FROM debian:latest
MAINTAINER Axel Venet <kern046@gmail.com>

COPY docker-entrypoint.sh /entrypoint.sh
COPY archives/asylamba_game.tar.gz /srv/archives/

RUN chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
