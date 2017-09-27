FROM nginx:latest
MAINTAINER Kern <kern046@gmail.com>

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/sites-available/* /etc/nginx/sites-available/
COPY docker-entrypoint.sh /entrypoint.sh

RUN mkdir -p /etc/nginx/sites-enabled \
    && chmod a+x /entrypoint.sh && chown root:root /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
