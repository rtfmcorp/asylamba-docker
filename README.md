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
127.0.0.1 game.asylamba.com
127.0.0.1 asylamba.com
```

This file is located in ```C:\Windows\System32\drivers\etc\hosts``` on Windows and ```/etc/hosts``` on Linux.

It should work properly by now :) !

## Contribute

Any feedback and suggestion is welcome, feel free to contact us !
