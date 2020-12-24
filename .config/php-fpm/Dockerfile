# from https://www.drupal.org/docs/system-requirements/php-requirements
FROM php:8.0-fpm-alpine3.12

# install the PHP extensions we need
# postgresql-dev is needed for https://bugs.alpinelinux.org/issues/3642
RUN set -eux; \
	\
	apk add --no-cache --virtual .build-deps \
		g++ \
		make \
		autoconf \
		coreutils \
		freetype-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		libzip-dev \
		postgresql-dev \
	; \
	\
	apk add --no-cache \
		git \
		mysql-client \
	; \
	\
	docker-php-ext-configure gd \
		--with-freetype \
		--with-jpeg=/usr/include \
	; \
	\
	docker-php-ext-install -j "$(nproc)" \
		gd \
		opcache \
		pdo_mysql \
		pdo_pgsql \
		zip \
	; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --virtual .drupal-phpexts-rundeps $runDeps;

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# https://github.com/drupal/drupal/blob/9.0.1/composer.lock#L4052-L4053
COPY --from=composer:1.10 /usr/bin/composer /usr/local/bin/

# install xDebug
ENV XDEBUG_VERSION 3.0.1
RUN set -x; \
    curl -SL "http://www.xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz" -o xdebug.tgz; \
    mkdir -p /usr/src/xdebug; \
    tar -xf xdebug.tgz -C /usr/src/xdebug --strip-components=1; \
    rm xdebug.*; \
    cd /usr/src/xdebug; \
    phpize; \
    ./configure; \
    make -j"$(nproc)"; \
    make install; \
    make clean

COPY ./ext-xdebug.ini /usr/local/etc/php/conf.d/ext-xdebug.ini
RUN apk del .build-deps

WORKDIR /var/www/web
