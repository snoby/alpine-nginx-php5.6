#FROM gliderlabs/alpine:latest
FROM alpine:3.4

MAINTAINER Matt Snoby <snobym@cisco.com>
RUN cat /etc/apk/repositories


RUN apk --no-cache add  \
      bash              \
      mysql-client      \
      ca-certificates   \
      openssl           \
      nginx             \
      php5-fpm          \
      php5-curl         \
      php5-gd           \
      php5-mcrypt       \
      php5-json         \
      php5-dom          \
      php5-pdo          \
      php5-pdo_mysql    \
      php5-xml          \
      php5-iconv        \
      php5-phar         \
      php5-openssl


# Setup NGINX
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /var/www/html
RUN echo "<?php phpinfo(); ?>" > /var/www/html/index.php
RUN chmod 555 /var/www/ -R && chown -R nginx:www-data /var/www/html

# Setup PHP-FPM
COPY php-fpm.conf /etc/php5/php-fpm.conf

# Setup default entrypoint
ADD entry.sh /entry.sh
RUN chmod +x /entry.sh



# php-fpm5.6 will not start if this directory does not exist
#RUN mkdir /run/php

# NGINX ports
EXPOSE 80

CMD ["/entry.sh"]
