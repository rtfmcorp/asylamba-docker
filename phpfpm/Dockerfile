FROM php:fpm
MAINTAINER Kern <kern046@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y libmcrypt-dev
RUN rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql mcrypt

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
