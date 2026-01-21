FROM shinsenter/phpfpm-apache:dev-php8.3-alpine

WORKDIR /var/www/html

RUN composer create-project 'codeigniter4/framework:^4.6.3' ../html \
	&& wget -O ./wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/refs/heads/master/wait-for-it.sh \
	&& chmod 700 ./wait-for-it.sh

ENTRYPOINT [ "./wait-for-it.sh", "hasf-io-test-db:3306", "-t", "0", "--", "docker-php-entrypoint" ]

COPY ./tests ./tests
COPY ./app ./app
COPY ./public ./public

