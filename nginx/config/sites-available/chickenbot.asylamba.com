server {
  listen 80;
  listen [::]:80;

  server_name chickenbot.asylamba.com;

  return 302 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    ssl_certificate /etc/letsencrypt/live/chickenbot.asylamba.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/chickenbot.asylamba.com/privkey.pem;

    server_name chickenbot.asylamba.com;

    access_log /var/log/nginx/chickenbot.access.log;
    error_log /var/log/nginx/chickenbot.error.log;

    merge_slashes on;

    location / {
        proxy_http_version 1.1;
        proxy_pass http://chicken_bot;
        proxy_set_header        Host            $host;
        proxy_set_header        X-Real-IP       $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Scheme        $scheme;
        proxy_set_header        Connection "";
        proxy_buffering off;
    }

    location ~ /\.ht {
        deny all;
    }

    location ~ /public/log/stats/ {
        deny all;
    }
}
