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

####################################################################################################

ENV HASF_IO_ROOT_DIR="$WORK_DIR"

COPY ./scripts/preprocess-source-files           ./mybin/scripts/preprocess-source-files

# Use `eval` to export environment variables
# declared and exported by the stage 0 to
# all other scritps (because Docker executes
# commands from scripts of RUN in dedicated
# subshells, what it does not allow to share
# their exported environment variables).
RUN echo "PROCESSING SOURCE FILES..." \
 && eval "$(cat "$MYBIN_DIR/scripts/preprocess-source-files/0-up-preprocessing-environment.sh")" \
 && 1-compile-files.sh \
 && 2-rename-assets.sh

####################################################################################################

COPY ./src/.htaccess          ./

COPY ./src/wip/writable       ./wip/writable
COPY ./src/wip/readonly       ./wip/readonly
COPY ./src/wip/tests          ./wip/tests
COPY ./src/wip/public         ./wip/public
COPY ./src/wip/app            ./wip/app

