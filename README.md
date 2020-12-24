# D8D (Drupal 8 Docker)
Easy way to deploy Drupal 8 project (fresh installation or from with existing database) using Docker.

### Prerequosites
[Docker](https://docs.docker.com/engine/installation) and [Docker Compose](https://docs.docker.com/compose/install) ([direnv](https://direnv.net) is optinal).

### Installation
1. Clone the directory `git clone https://github.com/alan-ps/d8d`
2. Build containers `sudo docker-compose up -d`
3. Run installation `/bin/bash scripts/build/install.sh scratch`

### @TODO
 - Use [direnv](https://direnv.net) in order to create wrappers for drush, drupal console etc. An alternative solutions:
     - **Drush:** `docker-compose exec --user root php /bin/sh -ci "/var/www/vendor/bin/drush status"`;
     - **Drupal console:** `docker-compose exec --user root php /bin/sh -ci "/var/www/vendor/bin/drupal --root=/var/www/web"` 

### Refs
  - [Composer template for Drupal projects](https://github.com/drupal-composer/drupal-project).
