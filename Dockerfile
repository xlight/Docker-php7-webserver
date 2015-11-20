FROM php:7-apache

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && echo "deb https://repo.varnish-cache.org/debian/ jessie varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list 
RUN  apt-get update && apt-get install -y varnish

#COPY varnish.vcl /etc/varnish/default.vcl
RUN curl https://raw.githubusercontent.com/xlight/varnish-4.0-configuration-templates/master/default.vcl -o /etc/varnish/default.vcl

EXPOSE 6081 80
VOLUME ["/var/www/html"]
CMD service varnish start && apache2-foreground
