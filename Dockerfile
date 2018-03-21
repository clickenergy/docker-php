FROM php:7.1-apache

RUN apt-get update && apt-get install -y \
    mysql-client \
    libmcrypt4 \
    libmcrypt-dev \
    openssl \
    ca-certificates \
    zlib1g-dev \
    libxml2-dev

RUN docker-php-ext-install mcrypt pdo_mysql zip soap bcmath

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN cd ~ \
    && export NEWRELIC_VERSION="$(curl -sS https://download.newrelic.com/php_agent/release/ | sed -n 's/.*>\(.*linux\).tar.gz<.*/\1/p')" \
    && curl -sS "https://download.newrelic.com/php_agent/release/${NEWRELIC_VERSION}.tar.gz" | gzip -dc | tar xf - \
    && cd "${NEWRELIC_VERSION}" \
    && NR_INSTALL_SILENT=true ./newrelic-install install \
    && cd ../ \
    && unset NEWRELIC_VERSION
