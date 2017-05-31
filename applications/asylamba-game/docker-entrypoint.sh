#!/bin/bash

if [ $DEPLOY_SOURCES == true ]; then
    rm -rf /srv/apps/asylamba-game
    tar xf /srv/archives/asylamba_game.tar.gz -C /srv/apps/
fi
rm -rf /var/spool/cron/crontabs/root
eval "echo \"$(cat /etc/cron.d/ranking_cron)\"" > /var/spool/cron/crontabs/root
rm /etc/cron.d/ranking_cron

exec "$@"
