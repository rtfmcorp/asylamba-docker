Asylamba Docker
==============

This repository contains the Docker environment used to make the Asylamba project work.

Docker is a tool which allows us to virtualize our environment, producing containers with stack elements inside.

To learn more, go to the [Docker website](https://www.docker.com/).

## Requirements

- [docker](https://docs.docker.com/engine/installation/)
- [docker-compose](https://docs.docker.com/compose/install/)

## Install

First, clone the project :

```sh
git clone git@github.com:rtfmcorp/asylamba-docker.git
cd asylamba-docker
```

## Usage

To make the containers run, you can use the following commands :

```sh
docker-compose build
docker-compose up -d
```

The shortcut command for this is :

```sh
make install
```

To stop the containers, use ```docker-compose stop``` or ```make stop```.

To remove the containers (you would need to do it in case of strange problems or build new versions), use ```docker-compose rm``` or ```make rm```.

To see the containers status, use ```docker-compose ps``` or ```make status``` shortcut command.

### PhpMyAdmin

To access PhpMyAdmin, run your containers and then access to ```127.0.0.1:8082``` in your browser.

The root credentials are ```root:asylamba``` ("asylamba" is the password).

The other available user is ```asylamba:asylamba```.

### Applications

To install the game, run the following procedure :

```sh
cd volumes/apps
git clone git@github.com:rtfmcorp/asylamba-game.git
```

You can access the game with ```127.0.0.1``` in your browser.

If you want to use hostnames, the default ones are ```http://game.asylamba.local``` and ```http://asylamba.local```.

To enable it on your computer and access it with your browser, you must add these lines to your ```hosts``` file :

```
127.0.0.1 game.asylamba.local
127.0.0.1 asylamba.local
```

This file is located in ```C:\Windows\System32\drivers\etc\hosts``` on Windows and ```/etc/hosts``` on Linux.

It should work properly by now :) !

#### Deployment

If you want to push a new version of the game in preprod/prod environment (and if such action is granted to you ;)), you will have to build and push a new tag of the game image.

To perform this, you can use two methods. We assume in this example that you want to push v1.1.12.

**The short way**

```
make version=1.1.12 build-game
```

**The less short way**

```
tar -C volumes/apps -cvzf applications/asylamba-game/archives/asylamba_game.tar.gz asylamba-game --exclude .git --exclude *.log
docker-compose build game
docker tag asylamba_game asylamba/game:1.1.12
docker tag asylamba_game asylamba/game:latest
docker push docker.io/asylamba/game:1.1.12
```

An explaination of the process is needed.

To deploy the game, we create a compressed archive of it first. Then, when building the image, Docker will add the archive to the image. Then we push the built image to the registry, to be available from all environments.

**The short-way**

```
make prod-upgrade
```

**The less short way**

```
docker-compose -f production.yml stop
docker pull asylamba/game
docker-compose -f production.yml rm game
docker-compose -f production.yml up -d
```

As you may see, it is quite simple, we just stop the stack, remove the old game container, pull the new one and launch the stack again. The sources contained in the new image will be deployed.

## Blackfire

Blackfire is a profiling tool allowing us to analyze the behavior and performances of the application.

To use it, you must first get an account on https://blackfire.io and then set the following environment variables :

```
BLACKFIRE_CLIENT_ID
BLACKFIRE_CLIENT_TOKEN
BLACKFIRE_SERVER_ID
BLACKFIRE_SERVER_TOKEN
```

An export shortcut with the values associated to your account are available [here](https://blackfire.io/docs/integrations/docker).

To run a profile, you can use the following command :

```sh
docker exec asylamba_blackfire blackfire curl --proxy http://$NGINX_CONTAINER_IP:80 http://game.asylamba.local/
```

You must replace the ``$NGINX_CONTAINER_IP`` variable with the right value.

To get it, fetch the IP address of your NGINX container with the following command :

```sh
docker inspect asylamba_nginx | grep IPAddress
```

Now you can launch the blackfire command and the profile shall appear in your Blackfire dashboard.

## Contribute

Any feedback and suggestion is welcome, feel free to contact us !
