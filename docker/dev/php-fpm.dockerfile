FROM php:7.4-fpm-buster

WORKDIR /var/www/app

RUN apt-get update && apt-get install -y \
        nano \
        unzip \
        zlib1g-dev libzip-dev \
        libjpeg62-turbo-dev libpng-dev \
        libicu-dev \
        libpq-dev \
        cron \
        procps \
        exim4-base \
        libfreetype6-dev \
        acl \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd zip intl pdo_pgsql opcache exif bcmath \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD ./config/crontab.conf /etc/cron.d/cron-jobs
ADD ./config/exim4.conf /etc/exim4/update-exim4.conf

RUN crontab /etc/cron.d/cron-jobs && update-exim4.conf

