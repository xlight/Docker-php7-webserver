FROM php:7-apache

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list 
RUN  apt-get update && apt-get install -y varnish

RUN curl https://raw.githubusercontent.com/xlight/varnish-4.0-configuration-templates/master/default.vcl -o /etc/varnish/default.vcl

## is it better to use ADD instead of RUN ?
RUN apt-get install -y unzip
RUN curl https://github.com/mrclay/minify/archive/master.zip -L -o min.zip && \
 unzip min.zip -d /var/www/ && mv /var/www/minify-master /var/www/min && rm min.zip
RUN cd /var/www/min && curl -sS https://getcomposer.org/installer | php && php composer.phar install

EXPOSE 6081 80
VOLUME ["/var/www/html"]
CMD ln -s /var/www/min /var/www/html/min && service varnish start && apache2-foreground
