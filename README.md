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

Now you have to copy the dist file for environment variables. This environment variables contain sensitive informations about security aspects of the game, like database access or game admin scripts access.

```
cp asylamba.dist.env asylamba.env
```

You can keep the default values in a local environment, but we highly recommend that you set more complex values in a remote environment.

Here is the documentation about the values :

```
# All variables prefixed with ASYLAMBA_ will be used as parameters in the game container
# For more informations, please refer to the game documentation

# The ID which identifies the game server to the main portal API
ASYLAMBA_SERVER_ID=0
# The DNS of the game, for static files and Ajax calls
ASYLAMBA_SERVER_HOST=game.asylamba.local
# The port of the game server. Please be sure it is an open port of the game container
ASYLAMBA_SERVER_PORT=9999

# The timeout for the socket listening, in seconds. It is the time the game is updated when no user request is performed.
# Be aware that a low value will increase the CPU usage heavily
ASYLAMBA_SERVER_CYCLE_TIMEOUT=20
# Number of listening loops before cleaning the application (garbage collector, etc...)
ASYLAMBA_SERVER_COLLECTION_CYCLES_NUMBER=25

# The start time of the game server
ASYLAMBA_SERVER_START_TIME='2017-05-29 20:00:00'
# The roleplay "year" of the game server at its start
ASYLAMBA_SEGMENT_SHIFT=650

# The host of the database server. Could be an IP address
ASYLAMBA_DATABASE_HOST=asylamba_mysql
ASYLAMBA_DATABASE_NAME=asylamba_game
ASYLAMBA_DATABASE_USER=root
ASYLAMBA_DATABASE_PASSWORD=asylamba
# Admin credentials for the database. Used for admin scripts
ASYLAMBA_DATABASE_ADMIN_USER=root
ASYLAMBA_DATABASE_ADMIN_PASSWORD=asylamba

# Number of task runners that the engine will launch
ASYLAMBA_WORKER_SCALE=3
# Timeout for the task runner socket listening, in seconds.
# Be aware that a low value will increase the CPU usage heavily
ASYLAMBA_WORKER_CYCLE_TIMEOUT=60
# Number of listening loops before cleaning the task runner
ASYLAMBA_WORKER_COLLECTION_CYCLES_NUMBER=5

# The crypting key of the security component
ASYLAMBA_SECURITY_IV=abcde
# Security keys used to access admin views. It must be changed in remote environments
ASYLAMBA_SECURITY_BUFFER_KEY=123456
ASYLAMBA_SECURITY_SERVER_KEY=123456
ASYLAMBA_SECURITY_SCRIPT_KEY=123456
ASYLAMBA_SECURITY_API_KEY=123456

# The environment mode. Behaviour between "dev" and "prod" is not the same for many game components.
# For further information, read the game documentation
ASYLAMBA_ENVIRONMENT=dev
# When set to "enabled", the game will connect to the ASYLAMBA_GETOUT_ROOT API for certain actions such as registration
ASYLAMBA_APIMODE=disabled
# Path to the game root
ASYLAMBA_APP_ROOT=/
# Path to the logout location. It is also used for the moment as the API domain when APIMODE is enabled
ASYLAMBA_GETOUT_ROOT=/buffer/

# This is used to tell Nginx which virtual host it must enable
NGINX_ENABLED_VHOST=asylamba.local,game.asylamba.local,asylamba-preprod.cloudapp.net,s14.asylamba.com
# This one is important. If set to true, it will copy the game version in the built game image.
# If set to true, THIS WILL ERASE THE PREVIOUS CODE; DO NOT SET IT TO TRUE ON LOCAL ENV.
# Set it to true in remote environments, it will deploy the code contained in the new images you will push to production.
DEPLOY_SOURCES=false

# MySQL credentials used by the MySQL container
MYSQL_DATABASES: asylamba_game
MYSQL_ROOT_PASSWORD: asylamba
MYSQL_HOST: localhost
MYSQL_USER: asylamba
MYSQL_PASSWORD: asylamba
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

To stop the containers, use `docker-compose stop` or `make stop`.

To remove the containers (you would need to do it in case of strange problems or build new versions), use `docker-compose rm` or `make rm`.

To see the containers status, use `docker-compose ps` or `make status` shortcut command.

To see logs related to a container, use `docker logs [container name]` (eg. `docker logs asylamba_game`).

### CLI

The game container is used as a CLI, to launch commands such as PHPUnit or Gulp.

You have two ways of accessing it, when the container is started :

```sh
docker exec -it asylamba_game /bin/bash
```

or the shortcut

```sh
make run
```

You are directly located to the game folder, where you can launch the available commands.

#### PHPUnit

Simply use ```phpunit``` to launch the game test suit.

### PhpMyAdmin

To access PhpMyAdmin, run your containers and then access to `127.0.0.1:8082` in your browser.

The root credentials are `root:asylamba` ("asylamba" is the password).

The other available user is `asylamba:asylamba`.

### Applications

To install the game, run the following procedure :

```sh
cd volumes/apps
git clone git@github.com:rtfmcorp/asylamba-game.git
```

You can access the game with `127.0.0.1` in your browser.

If you want to use hostnames, the default ones are `http://game.asylamba.local` and `http://asylamba.local`.

To enable it on your computer and access it with your browser, you must add these lines to your `hosts` file :

```
127.0.0.1 game.asylamba.local
127.0.0.1 asylamba.local
```

This file is located in `C:\Windows\System32\drivers\etc\hosts` on Windows and `/etc/hosts` on Linux.

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
