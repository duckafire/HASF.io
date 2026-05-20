FROM alpine:3.20.10

WORKDIR /app

####################################################################################################

ENV WORK_DIR="/app"
ENV PHPV="83"
ENV MYBIN_DIR="$WORK_DIR/mybin"

ENV PHPRC="/etc/php$PHPV"
ENV PHP_INI_SCAN_DIR="$PHPRC/conf.d"
ENV BUN_INSTALL_GLOBAL_DIR="$MYBIN_DIR/bun-global-packages"
ENV PATH="$PATH:$MYBIN_DIR/bin:$MYBIN_DIR/scripts/preprocess-source-files:$MYBIN_DIR/scripts/docker-image:$BUN_INSTALL_GLOBAL_PACKAGES/.bin"

COPY ./scripts/docker-image                      ./mybin/scripts/docker-image

RUN echo "PREPARING ENVIRONMENT..." \
 && 0-environment.sh \
 && 1-dependences.sh

COPY ./src/.htaccess          ./

COPY ./src/wip/writable       ./wip/writable
COPY ./src/wip/readonly       ./wip/readonly
COPY ./src/wip/tests          ./wip/tests
COPY ./src/wip/public         ./wip/public
COPY ./src/wip/app            ./wip/app

