install: build up status

prod-install: prod-up prod-status

prod-upgrade:

	docker pull asylamba/game
	docker-compose -f production.yml up -d game

up:

	docker-compose up -d

prod-up:

	docker-compose -f production.yml up -d

restart:

	docker-compose stop game && docker-compose up -d game

prod-restart:

	docker-compose -f production.yml stop game && docker-compose -f production.yml up -d game

run:

	docker exec -it asylamba_game /bin/bash

stop:

	docker-compose stop

prod-stop:

	docker-compose -f production.yml stop

rm:

	docker-compose down

prod-rm:

	docker-compose -f production.yml down

build:

	tar -C volumes/apps -cvzf applications/asylamba-game/archives/asylamba_game.tar.gz asylamba-game --exclude .git --exclude *.log
	docker-compose build

status:

	docker-compose ps

prod-status:

	docker-compose -f production.yml ps

build-all: build-game

build-game:

	$(eval version = $(shell git -C volumes/apps/asylamba-game describe --tags))
	tar -C volumes/apps -cvzf applications/asylamba-game/archives/asylamba_game.tar.gz asylamba-game --exclude .git --exclude *.log
	docker-compose build game
	docker tag asylamba/game asylamba/game:$(version)
	docker tag asylamba/game asylamba/game:latest
	docker push docker.io/asylamba/game:$(version)
	docker push docker.io/asylamba/game:latest

ssl-root:

	openssl genrsa -des3 -out volumes/ssl/rootCA.key 2048
	openssl req -x509 -new -nodes -key volumes/ssl/rootCA.key -sha256 -days 1024 -out volumes/ssl/rootCA.pem

ssl-cert:

	openssl req -new -sha256 -nodes -out volumes/ssl/server.csr -newkey rsa:2048 -keyout volumes/ssl/server.key -config nginx/config/ssl/local.asylamba.com.conf
	openssl x509 -req -in volumes/ssl/server.csr -CA volumes/ssl/rootCA.pem -CAkey volumes/ssl/rootCA.key -CAcreateserial -out volumes/ssl/server.crt -days 500 -sha256 -extfile nginx/config/ssl/v3.ext
