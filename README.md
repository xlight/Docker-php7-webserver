# Docker-php7-webserver
one Docker container for webserver with:
* php7 support
* http cache
* css&js auto minify (with php Minify build-in)
* rewrite enabled
* disable AllowOverride
* auto include .htaccess in /var/www/html to apache conf 
* add auto prepend php with http header no-cache
* output php logs to /var/www/log

 
@TODO
* add php.ini
* user additional conf for apache & php
* output apache logs to /var/www/log
* add welcome page
* change 503 page
* APM
* apache real ip behind proxy
* mini php_minify
