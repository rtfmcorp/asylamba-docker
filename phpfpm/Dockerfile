FROM php:fpm
MAINTAINER Kern <kern046@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y libmcrypt-dev
RUN rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql mcrypt
