#!/bin/bash

setfacl -R -m u:"www-data":rwX /srv/apps/asylamba-game/public/log
setfacl -dR -m u:"www-data":rwX /srv/apps/asylamba-game/public/log

exec "$@"
