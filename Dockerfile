FROM alpine:3.20.10

WORKDIR /app

ENV PATH="$PATH:/app/mybin:/app/mybin/docker-image"
ENV PHPRC="/etc/php83"
ENV PHP_INI_SCAN_DIR="$PHPRC/conf.d"

COPY ./scripts/docker-image                      ./mybin/docker-image
COPY ./scripts/preprocess-source-files           ./

RUN echo "PREPARING ENVIRONMENT..." \
 && 0-environment.sh \
 && 1-dependences.sh

