FROM nginx:latest
MAINTAINER Kern <kern046@gmail.com>

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/sites-available/* /etc/nginx/sites-available/
RUN mkdir -p /etc/nginx/sites-enabled

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

RUN apt-get update
RUN apt-get upgrade -y --force-yes
RUN apt-get install -y dos2unix
RUN dos2unix /entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
