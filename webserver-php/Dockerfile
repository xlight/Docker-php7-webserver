FROM php:7-apache

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list 
RUN  apt-get update && apt-get install -y varnish

RUN curl https://raw.githubusercontent.com/xlight/varnish-4.0-configuration-templates/master/default.vcl -o /etc/varnish/default.vcl

## is it better to use ADD instead of RUN ?
RUN apt-get install -y unzip
RUN curl https://github.com/mrclay/minify/archive/master.zip -L -o min.zip && \
 unzip min.zip -d /root/ && mv /root/minify-master /root/min && rm min.zip
RUN cd /root/min && curl -sS https://getcomposer.org/installer | php && php composer.phar install --no-dev

# enable rewrite 
RUN mv /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/ 

# Install modules : GD mcrypt iconv
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

# memcached module	
RUN apt-get install -y libmemcached-dev
RUN curl -o /root/memcached.zip https://github.com/php-memcached-dev/php-memcached/archive/php7.zip -L
RUN cd /root && unzip memcached.zip && rm memcached.zip && cd php-memcached-php7 && \
 phpize && ./configure && make && make install && \
 cd /root && rm -rf /root/php-memcached-php7 && \
 echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini  && \
 echo "memcached.use_sasl = 1" >> /usr/local/etc/php/conf.d/memcached.ini 

EXPOSE 6081 80
VOLUME ["/var/www"]
CMD ln -fs /root/min /var/www/html/min && service varnish start && apache2-foreground
