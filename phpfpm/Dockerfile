FROM php:fpm
MAINTAINER Kern <kern046@gmail.com>

COPY docker-entrypoint.sh /entrypoint.sh

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y libmcrypt-dev dos2unix
RUN dos2unix /entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql mcrypt

RUN chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
