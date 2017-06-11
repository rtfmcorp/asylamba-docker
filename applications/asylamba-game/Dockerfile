FROM php:cli
MAINTAINER Axel Venet <kern046@gmail.com>

ENV TIMEZONE=Europe/Paris

COPY docker-entrypoint.sh /entrypoint.sh
COPY archives/asylamba_game.tar.gz /srv/archives/

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget zip unzip \

    && docker-php-ext-install pdo pdo_mysql \

    && ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \

    && wget https://phar.phpunit.de/phpunit-6.1.phar \
    && chmod +x phpunit-6.1.phar \
    && mv phpunit-6.1.phar /usr/bin/phpunit \

    && curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -yq nodejs build-essential \

    && npm install -g npm \
    && npm install -g gulp-cli \

    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin/ --filename=composer \
    && php -r "unlink('composer-setup.php');" \

    && chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh \

    && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://asylamba_blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini


WORKDIR /srv/apps/asylamba-game
ENTRYPOINT ["/entrypoint.sh"]

CMD php /srv/apps/asylamba-game/index.php
