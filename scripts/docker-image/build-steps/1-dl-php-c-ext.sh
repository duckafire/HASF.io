#!/usr/bin/env sh

set -euo pipefail

PHP="php$PHPV"

PACKAGES=$(cat << EOF
composer       $PHP-bcmath    $PHP-common    $PHP-ctype      $PHP-curl
$PHP-dom       $PHP-exif      $PHP-ffi       $PHP-fileinfo   $PHP-ftp
$PHP-gd        $PHP-gettext   $PHP-gmp       $PHP-iconv      $PHP-imap
$PHP-intl      $PHP-mbstring  $PHP-mysqli    $PHP-mysqli     $PHP-odbc
$PHP-opcache   $PHP-openssl   $PHP-pcntl     $PHP-pdo        $PHP-pdo_mysql
$PHP-pdo_mysql $PHP-pdo_odbc  $PHP-pdo_pgsql $PHP-pdo_sqlite $PHP-pgsql
$PHP-phar      $PHP-posix     $PHP-session   $PHP-shmop      $PHP-simplexml
$PHP-snmp      $PHP-soap      $PHP-sockets   $PHP-sodium     $PHP-sqlite3
$PHP-tidy      $PHP-tokenizer $PHP-xml       $PHP-xmlreader  $PHP-xmlwriter
$PHP-xsl       $PHP-zip
EOF
)

apk update --quiet
apk add --quiet --no-cache $PACKAGES

