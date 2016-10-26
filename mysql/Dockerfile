FROM mysql
MAINTAINER Kern <kern046@gmail.com>

COPY conf.d/* /etc/mysql/conf.d/
COPY docker-entrypoint-initdb.d/databases.sh /docker-entrypoint-initdb.d/databases.sh

RUN chmod a+x /docker-entrypoint-initdb.d/databases.sh && chown root:root /docker-entrypoint-initdb.d/databases.sh
