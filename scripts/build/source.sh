#!/usr/bin/env bash

# Exec drush command from the php container.
drush="../vendor/bin/drush -r /var/www/web"

# The .sql file inside a container (use volume in order to import from a host).
sqlfile='/var/www/web/file.sql'

# Helper function to install a Drupal 8 site from scratch.
# @todo use a variable to set a profile!
drupal_install_from_cratch() {
  docker-compose exec --user root php /bin/sh -ci "$drush si standard --yes \
    --account-name=admin \
    --account-pass=admin \
    --site-name='Drupal 8 standard' \
    --db-url=mysql://drupal:drupal@mariadb/drupal
  "
}

# Helper function to install a Drupal 8 site from existing database.
drupal_install_from_existing_db() {
  docker-compose exec --user root php /bin/sh -ci "$drush sql-drop --yes"
  docker-compose exec --user root php /bin/sh -ci "$drush sqlc < $sqlfile"
}

# Helper function to install a Drupal 8 site using existing configuration.
# @see https://www.drupal.org/project/config_installer
drupal_install_from_config_installer() {
  echo "@todo";
}
