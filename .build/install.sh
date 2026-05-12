#!/usr/bin/env bash

set -e

build_dir=$(dirname "$0")
source ${build_dir}/source.sh

# Install all necessary composer dependencies.
docker compose exec php /bin/sh -c "COMPOSER_MEMORY_LIMIT=-1 COMPOSER_PROCESS_TIMEOUT=0 composer install 2>&1"

# Install Drupal 11.
case "$1" in
"scratch")
    drupal_install_from_scratch
    ;;
"db")
    drupal_install_from_existing_db
    ;;
"config")
    drupal_install_from_config_installer
    ;;
*)
    echo "Usage: install.sh [scratch|db|config]"
    echo "  scratch  Fresh Drupal install"
    echo "  db       Import from existing database dump (web/file.sql)"
    echo "  config   Install from existing exported configuration"
    ;;
esac
