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
