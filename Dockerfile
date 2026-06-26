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

# ("dibs" is an acronym to Docker Image Build Steps.)

ENV  APACHE_USER=${DF_APACHE_USER} \
     WORK_DIR=${DF_WORK_DIR}
COPY --chmod=555 ./scripts/docker-image/build-steps/0-create-apache-user.sh /dibs/0
RUN  /dibs/0

ENV  PHPV="83"
COPY --chmod=555 ./scripts/docker-image/build-steps/1-dl-php-c-ext.sh /dibs/1
RUN  /dibs/1

USER ${DF_APACHE_USER}
ENV  CODE_IGNITER_V="4.6.3" \
     WIP_DIR=${DF_WIP_DIR}
COPY --chmod=555 ./scripts/docker-image/build-steps/2-dl-ci.sh /dibs/2
RUN  /dibs/2

# Separated ENV because variables
# depend each other.
ENV  MYBIN_DIR="$WORK_DIR/mybin"
ENV  BUN_INSTALL="$WORK_DIR/bun"
ENV  PATH="$PATH:$MYBIN_DIR:$BUN_INSTALL:$BUN_INSTALL/bin"
COPY --chmod=555 ./scripts/docker-image/build-steps/3-dl-npm-pack.sh /dibs/3
RUN  /dibs/3

USER root
COPY --chmod=555 ./scripts/docker-image/build-steps/4-dl-php-apache.sh /dibs/4
RUN  /dibs/4

USER ${DF_APACHE_USER}
COPY --chmod=555 ./scripts/docker-image/build-steps/5-dl-useful-tools.sh /dibs/5
RUN  /dibs/5

# (Root is used here to allow that
# the owner of the directories that
# stores these configuration files
# can be changed, from root to Apache
# User.)
USER root
ENV  PHPRC="/etc/php$PHPV"            \
     HTTPD_DIR="/etc/apache2"
ENV  PHP_INI_SCAN_DIR="$PHPRC/conf.d"
COPY --chmod=555 ./scripts/docker-image/build-steps/6-dl-conf-files.sh /dibs/6
RUN  /dibs/6

USER ${DF_APACHE_USER}
COPY --chmod=555 ./scripts/docker-image/build-steps/7-dl-3party.sh /dibs/7
RUN  /dibs/7

USER root
COPY --chmod=555 ./scripts/docker-image/build-steps/z-dl-deploy-pack.sh /dibs/z
RUN  /dibs/z

####################################################################################################
# Copy source code into image:

USER ${DF_APACHE_USER}
WORKDIR ${DF_WIP_DIR}

COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/.htaccess          ..
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/index.php          ..
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/.env.debug     .env

COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/writable       ./writable
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/readonly       ./readonly
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/tests          ./tests
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/public         ./public
COPY --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./src/wip/app            ./app

####################################################################################################
# Process source files:

# ("dp" is an acronym to Deploy Pipeline.)

ENV HASF_IO_ROOT_DIR="$WORK_DIR"

# (chown is necessary here because this
# rule will create `/dp`, that must be
# accessible to Apache User.)
COPY --chmod=555 --chown=${DF_APACHE_USER}:${DF_APACHE_USER} ./scripts/deploy-pipeline/0-preprocessing/0-public-env.sh /dp/0/0
RUN  /dp/0/0

COPY --chmod=555 ./scripts/deploy-pipeline/0-preprocessing/1-create-build-dir.sh /dp/0/1
RUN  /dp/0/1

COPY --chmod=555 ./scripts/deploy-pipeline/0-preprocessing/2-compile-files.sh /dp/0/2
RUN  /dp/0/2

COPY --chmod=555 ./scripts/deploy-pipeline/0-preprocessing/3-compress-files.sh /dp/0/3
RUN  /dp/0/3

COPY --chmod=555 ./scripts/deploy-pipeline/1-create-manifests/0-assets.sh /dp/1/0
RUN  /dp/1/0

####################################################################################################
# Entrypoint configurations:

COPY --chmod=555 ./scripts/docker-image/entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]

####################################################################################################
# Other few important configurations:

EXPOSE 8080

# Few improvement in navigation
# among files during debugging.
WORKDIR ${DF_WORK_DIR}

####################################################################################################
