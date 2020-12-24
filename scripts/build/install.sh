#!/usr/bin/env bash

set -e

build_dir=$(dirname "$0")
source ${build_dir}/source.sh

web_container_id=$(docker inspect --format="{{.Id}}" d8d-web)

# Install all necessary composer dependencies.
docker exec -it ${web_container_id} /bin/sh -c "COMPOSER_MEMORY_LIMIT=-1 composer install -o 2>&1"

# Install Drupal 8.
case "$1" in
"scratch")
    drupal_install_from_cratch
    ;;
"db")
    drupal_install_from_existing_db
    ;;
"config")
    drupal_install_from_config_installer
    ;;
*)
    echo "@todo show help message"
    ;;
esac
