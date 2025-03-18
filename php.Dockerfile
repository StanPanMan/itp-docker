FROM php:8.3.18RC1-fpm-alpine3.21
RUN docker-php-ext-install pdo pdo_mysql