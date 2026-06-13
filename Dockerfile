####################################################################################################
# Docker image configurations:

FROM alpine:3.20.10

####################################################################################################
# Global declarations:

# (DockerFile.)
ARG DF_WORK_DIR="/app"
ARG DF_WIP_DIR="${DF_WORK_DIR}/wip"
ARG DF_APACHE_USER="apache-php"
ARG DF_BUILD_STEPS="scripts/docker-image/build-steps"

WORKDIR ${DF_WORK_DIR}

ENV WORK_DIR=${DF_WORK_DIR}

####################################################################################################
# Configure environment and download dependences:

# ("dib" is a acronym to Docker Image Build.)

ENV  APACHE_USER=${DF_APACHE_USER} \
     WORK_DIR=${DF_WORK_DIR}
COPY --chmod=555 ./scripts/docker-image-build/0-create-apache-user.sh /dib/
RUN  /dib/0-create-apache-user.sh

ENV  PHPV="83"
COPY --chmod=555 ./scripts/docker-image-build/1-dl-php-c-ext.sh /dib/
RUN  /dib/1-dl-php-c-ext.sh

USER ${DF_APACHE_USER}
ENV  CODE_IGNITER_V="4.6.3" \
     WIP_DIR=${DF_WIP_DIR}
COPY --chmod=555 --chown=${DF_APACHE_USER} ./scripts/docker-image-build/2-dl-ci.sh /dib/
RUN  /dib/2-dl-ci.sh

# Separated ENV because variables
# depend each other.
ENV  MYBIN_DIR="$WORK_DIR/mybin"
ENV  BUN_INSTALL="$WORK_DIR/bun"
ENV  PATH="$PATH:$MYBIN_DIR:$BUN_INSTALL:$BUN_INSTALL/bin"
COPY --chmod=555 --chown=${DF_APACHE_USER} ./scripts/docker-image-build/3-dl-npm-pack.sh /dib/
RUN  /dib/3-dl-npm-pack.sh

USER root
COPY --chmod=555 ./scripts/docker-image-build/4-dl-php-apache.sh /dib/
RUN  /dib/4-dl-php-apache.sh

USER ${DF_APACHE_USER}
COPY --chmod=555 --chown=${DF_APACHE_USER} ./scripts/docker-image-build/5-dl-useful-tools.sh /dib/
RUN  /dib/5-dl-useful-tools.sh

# (Root is used here to allow that
# the owner of the directories that
# stores these configuration files
# can be changed, from root to Apache
# User.)
USER root
ENV  PHPRC="/etc/php$PHPV"            \
     PHP_INI_SCAN_DIR="$PHPRC/conf.d" \
     HTTPD_DIR="/etc/apache2"
COPY --chmod=555 ./scripts/docker-image-build/6-dl-conf-files.sh /dib/
RUN  /dib/6-dl-conf-files.sh

USER ${DF_APACHE_USER}
COPY --chmod=555 ./scripts/docker-image-build/7-dl-3party.sh /dib/
RUN  /dib/7-dl-3party.sh

####################################################################################################
# Copy source code into image:

WORKDIR ${DF_WIP_DIR}

COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/.htaccess          ..

COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/writable       .
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/readonly       .
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/tests          .
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/public         .
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/app            .

####################################################################################################
# Entrypoint configurations:

COPY --chmod=555 ./scripts/docker-image-build/z-entrypoint.sh /dib/
ENTRYPOINT [ "/dib/z-entrypoint.sh" ]

####################################################################################################
