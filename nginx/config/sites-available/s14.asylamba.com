server {
  listen 80;

  server_name s14.asylamba.com;

  access_log /var/log/nginx/asylamba_game.access.log;
  error_log /var/log/nginx/asylamba_game.error.log;

  merge_slashes on;

  location ~ \.(css|js|png|jpg) {
    root /srv/apps/asylamba-game;
  }

  location / {
        proxy_http_version 1.1;
        proxy_pass http://asylamba_game:9999;
        proxy_set_header        Host            $host;
        proxy_set_header        X-Real-IP       $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        Connection "";
        proxy_buffering off;
        proxy_ignore_client_abort on;
  }

  location ~ /\.ht {
    deny all;
  }

  location ~ /public/log/stats/ {
    deny all;
  }
}
