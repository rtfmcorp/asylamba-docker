#!/bin/bash

if [ DEPLOY_SOURCES != false ]; then
    rm -rf /srv/apps/asylamba-game
    tar xf /srv/archives/asylamba_game.tar.gz -C /srv/apps/
fi

exec "$@"
