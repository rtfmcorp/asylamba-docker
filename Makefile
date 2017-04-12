install: build up status

prod-install: prod-up prod-status

prod-upgrade:

	docker-compose -f production.yml stop
	docker pull asylamba/game
	docker-compose -f production.yml rm game
	docker-compose -f production.yml up -d

up:

	docker-compose up -d

prod-up:

	docker-compose -f production.yml up -d

stop:

	docker-compose stop

prod-stop:

	docker-compose -f production.yml stop

rm:

	docker-compose down

prod-rm:

	docker-compose -f production.yml down

build:

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
	docker tag asylamba_game asylamba/game:$(version)
	docker tag asylamba_game asylamba/game:latest
	docker push docker.io/asylamba/game:$(version)
	docker push docker.io/asylamba/game:latest
