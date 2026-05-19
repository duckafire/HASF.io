FROM alpine:3.20.10

WORKDIR /app

ENV WORK_DIR="/app"
ENV PHPV="83"

ENV PATH="$PATH:/app/mybin:/app/mybin/docker-image"
ENV PHPRC="/etc/php$PHPV"
ENV PHP_INI_SCAN_DIR="$PHPRC/conf.d"

COPY ./scripts/docker-image                      ./mybin/docker-image
COPY ./scripts/preprocess-source-files           ./

RUN echo "PREPARING ENVIRONMENT..." \
 && 0-environment.sh \
 && 1-dependences.sh

COPY ./src/.htaccess          ./

COPY ./src/wip/writable       ./wip/writable
COPY ./src/wip/readonly       ./wip/readonly
COPY ./src/wip/tests          ./wip/tests
COPY ./src/wip/public         ./wip/public
COPY ./src/wip/app            ./wip/app

