FROM php:7.1-alpine

RUN apk update && apk upgrade && \
    apk add --update curl mysql-client openssl libxml2-dev libmcrypt-dev zlib-dev

RUN docker-php-ext-install pdo_mysql soap mcrypt mbstring zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
