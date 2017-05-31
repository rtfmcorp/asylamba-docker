FROM php:cli
MAINTAINER Axel Venet <kern046@gmail.com>

ENV TIMEZONE=Europe/Paris

COPY ranking_cron /etc/cron.d/ranking_cron
COPY docker-entrypoint.sh /entrypoint.sh
COPY archives/asylamba_game.tar.gz /srv/archives/

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y libmcrypt-dev dos2unix cron \
    && dos2unix /entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/* \

    && docker-php-ext-install pdo pdo_mysql mcrypt \

    && ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \

    && chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh \

    && chmod 0644 /etc/cron.d/ranking_cron \
    && touch /var/log/cron.log \
    && /usr/bin/crontab /etc/cron.d/ranking_cron \

    && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://asylamba_blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

ENTRYPOINT ["/entrypoint.sh"]

CMD cron && php /srv/apps/asylamba-game/index.php
