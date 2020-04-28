FROM php:7.3-apache

RUN yes | pecl install xdebug-2.8.0

# need for xdebug
ARG DEV_MOD=prod

#------- Copy configurations ---------#
# Set up production php configurations by default.
RUN mv ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini
COPY .docker/php/*.ini ${PHP_INI_DIR}/conf.d/
COPY .docker/php/${DEV_MOD}/*.ini ${PHP_INI_DIR}/conf.d/

# Enable apache mods.
RUN a2enmod headers && \
    a2enmod rewrite && \
    # Set apache document root.
    sed -ri -e 's!/var/www/html!/var/www/html/public!g' ${APACHE_CONFDIR}/sites-available/*.conf

EXPOSE 80
