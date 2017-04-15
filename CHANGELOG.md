## [Unreleased]
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
