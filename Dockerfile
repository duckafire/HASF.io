FROM shinsenter/phpfpm-apache:dev-php8.3-alpine

RUN test ! -d /var/www/html
	&& mkdir --parents /var/www/html
	&& composer create-project 'codeigniter4/framework:^4.6.3' /var/www/html

WORKDIR /var/www/html

COPY ./tests ./tests
COPY ./app ./app
COPY ./public ./public

