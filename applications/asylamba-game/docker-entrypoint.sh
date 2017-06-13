#!/bin/bash
cd /
mkdir -p /srv/apps
if [ $DEPLOY_SOURCES == true ]; then
    rm -rf /srv/apps/asylamba-game
    tar xf /srv/archives/asylamba_game.tar.gz -C /srv/apps/
fi

if [ ! -d /srv/apps/asylamba-game/vendor ]; then
    composer install -d /srv/apps/asylamba-game
fi

exec "$@"
