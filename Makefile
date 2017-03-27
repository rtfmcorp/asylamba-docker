install: build up status

up:

	docker-compose up -d

stop:

	docker-compose stop

rm:

	docker-compose down

build:

	docker-compose build

status:

	docker-compose ps

build-all: build-game

build-game:

	tar -C volumes/apps -cvzf applications/asylamba-game/archives/asylamba_game.tar.gz asylamba-game --exclude .git
	docker-compose build game
	docker tag asylamba_game asylamba/game:$(version)
	docker push docker.io/asylamba/game

deploy-game:

	docker-compose -f production.yml up -d

build-phpfpm:

	docker-compose build asylamba_phpfpm
