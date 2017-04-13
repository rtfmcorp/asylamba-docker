FROM mysql
MAINTAINER Kern <kern046@gmail.com>

COPY conf.d/* /etc/mysql/conf.d/
COPY docker-entrypoint-initdb.d/databases.sh /docker-entrypoint-initdb.d/databases.sh

RUN chmod a+x /docker-entrypoint-initdb.d/databases.sh \
    && chown root:root /docker-entrypoint-initdb.d/databases.sh \
    && apt-get update \
    && apt-get upgrade -y --force-yes \
    && apt-get install -y dos2unix \
    && dos2unix /docker-entrypoint-initdb.d/databases.sh \
    && apt-get --purge remove -y dos2unix \
    && rm -rf /var/lib/apt/lists/*
