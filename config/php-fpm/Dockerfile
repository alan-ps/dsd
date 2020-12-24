# from https://www.drupal.org/docs/8/system-requirements/drupal-8-php-requirements
FROM php:7.4-fpm-alpine

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
		--with-freetype=/usr/include/ \
		--with-jpeg=/usr/include/ \
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
	apk add --virtual .drupal-phpexts-rundeps $runDeps

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_VERSION 1.9.3

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/b5a70434f0f582468a7824418553defaf67d5299/web/installer; \
	php -r " \
		\$signature = 'c5b9b6d368201a9db6f74e2611495f369991b72d9c8cbd3ffbc63edff210eb73d46ffbfce88669ad33695ef77dc76976'; \
		\$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
		if (!hash_equals(\$signature, \$hash)) { \
			unlink('/tmp/installer.php'); \
			echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
			exit(1); \
		} \
	"; \
	php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION}; \
	composer --ansi --version --no-interaction; \
 	rm -rf /tmp/* /tmp/.htaccess

# Setup the xDebug version to install.
ENV XDEBUG_VERSION 2.9.2

# Install xDebug.
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
