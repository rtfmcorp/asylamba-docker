FROM php:fpm
MAINTAINER Kern <kern046@gmail.com>

COPY docker-entrypoint.sh /entrypoint.sh

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y libmcrypt-dev dos2unix
RUN dos2unix /entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql mcrypt

RUN chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://asylamba_blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
