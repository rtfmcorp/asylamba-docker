## [1.0.0]
### Added
- TLS certificates support in Nginx container
- Stripe API keys in environment variables
- Lets encrypt tools in Nginx container
- OpenSSL configuration for local SSL certificates forging
- Shortcut command to generate root certificate authority
- Shortcut command to generate security certificates
- Proxy request header containing user request scheme
- Chickenbot container in production environment
- Chickenbot virtual host for production environment
- MongoDB container
- Feedback management API container

### Changed
- Pre-production DNS is now preprod.asylamba.com
- Local DNS is now local.asylamba.com

## [0.3.1] - 2017-09-06
### Added
- Support of SVG images as static files
- Support of Websocket frames

## [0.3.0] - 2017-07-21
### Added
- Redis container
- Redis commander container
- Redis extension in game container
- Production configuration for Redis containers

## [0.2.3] - 2017-06-13
### Fixed
- Nginx access to game static files
- CWD issue in game container entrypoint
- Default IV length

## [0.2.2] - 2017-06-12
### Fixed
- Set zip and unzip commands for the game container
- Fix MySQL container environment variables
- Fix composer install in production env

## [0.2.1] - 2017-06-11
### Added
- Compress game sources at first build
- Composer in game container
- Composer install at game container launch

### Fixed
- Add missing log folder

## [0.2.0] - 2017-06-11
### Added
- Environment variables file
- PHPUnit in game container
- Node 7.1 in game container
- NPM 5.0.3 in game container
- Gulp in game container
- Restart command for game container
- Run command to connect the game container

### Removed
- Volumes for the game in production environment

## [0.1.5] - 2017-05-14
### Added
- Game logs in the volumes
- Fix IP addresses for the local containers

### Changed
- The game container version is now the game sources git tag

### Removed
- Network subnet for production containers

### Fixed
- Line endings for MySQL container entrypoint
- Client abort in Nginx virtual host

## [0.1.4] - 2017-04-10
### Added
- Deployment command for Docker registry
- Production handling commands
- Production deployment documentation

### Changed
- Exclude logs from game archive
- Increase session lifetime for PhpMyAdmin

## [0.1.3] - 2017-03-30
### Added
- Game applicative container
- Virtual host for production environment

### Changed
- Nginx is now a reverse proxy for the game
- Static files are served directly by Nginx

### Removed
- PHP-FPM container

## [0.1.2] - 2016-12-13
### Added
- Blackfire Agent container
- Blackfire Probe in PHP-FPM container
- Blackfire usage documentation

### Fixed
- Fix nginx APT upgrade
- Fix special characters in PHP-FPM and NGINX entrypoint files

## [0.1.1] - 2016-11-19
### Added
- Custom Dockerfile for PHP-FPM
- PDO MySQL extension for PHP
- Mcrypt extension for PHP
- Log write permissions for PHP-FPM

## [0.1.0] - 2016-10-26
### Added
- Nginx container
- PHP-FPM container
- PhpMyAdmin container
- MySQL container
- Setup documentation
- Usage documentation
- Shortcut commands for docker-compose
- Editor configuration file
- VHost for Asylamba game
- Asylamba game database
