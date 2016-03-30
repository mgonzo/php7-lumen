# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.18

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    git \
    zip \
    unzip \
    nginx \
    php7.0 \
    php7.0-cli \
    php7.0-curl \
    php 7.0-mysql \
    php7.0-pgsql \
    php 7.0-json  \
    php 7.0-mbstring \
    php 7.0-xml \
    php7.0-intl \
    php7.0-zip \
    php 7.0-fpm

COPY default /etc/nginx/sites-enabled/default
RUN sed -i '/fpm\.sock/c\listen = 127\.0\.0\.1:9000' /etc/php/7.0/fpm/pool.d/www.conf

RUN mkdir /run/php \
          /etc/service/nginx \
          /etc/service/php-fpm

ADD nginx.sh /etc/service/nginx/run
ADD php-fpm.sh /etc/service/php-fpm/run

# install composer
RUN curl -o '/tmp/composer-setup.php' 'https://getcomposer.org/installer' && chmod +x /tmp/composer-setup.php
RUN if [ $(shasum -a 384 /tmp/composer-setup.php | awk '{ print $1 }') = '41e71d86b40f28e771d4bb662b997f79625196afcca95a5abf44391188c695c6c1456e16154c75a211d238cc3bc5cb47' ]; then php /tmp/composer-setup.php; fi
RUN mv //composer.phar /usr/bin/composer

# require lumen installer
RUN composer global require "laravel/lumen-installer";
RUN echo "export PATH=$PATH:'$HOME/.composer/vendor/bin'" >> $HOME/.bashrc

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
