FROM alpine:3.23.3 AS download_deps

WORKDIR /repos

RUN wget -qO ./lucide.zip     https://github.com/lucide-icons/lucide/archive/refs/tags/v0.265.0.zip \
 && wget -qO ./bootstrap.zip  https://github.com/twbs/icons/archive/refs/tags/v1.13.1.zip \
 && unzip -q ./lucide.zip \
 && unzip -q ./bootstrap.zip


FROM shinsenter/phpfpm-apache:dev-php8.3-alpine

# Default WORKDIR: /var/www/html
# Default host context: ./src/

RUN composer create-project 'codeigniter4/framework:4.6.3' ./wip \
 && find . -user root -exec chown www-data:www-data {} \;

ADD --link --chmod=744 --chown=www-data https://raw.githubusercontent.com/vishnubob/wait-for-it/81b1373f17855a4dc21156cfe1694c31d7d1792e/wait-for-it.sh .

COPY --from=download_deps --chown=www-data /repos/lucide-0.265.0/icons ./wip/public/assets/images/icons/lucide-v0.265.0
COPY --from=download_deps --chown=www-data /repos/icons-1.13.1/icons   ./wip/public/assets/images/icons/bootstrap-v1.13.1

COPY --chown=www-data ./scripts/preprocessing.sh .

COPY --chown=www-data ./src/.htaccess    ./
COPY --chown=www-data ./src/wip/writable ./wip/writable
COPY --chown=www-data ./src/wip/tests    ./wip/tests
COPY --chown=www-data ./src/wip/app      ./wip/app
COPY --chown=www-data ./src/wip/public   ./wip/public

RUN ./preprocessing.sh "true"

