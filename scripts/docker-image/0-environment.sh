#!/usr/bin/env sh

## Download essential binaries, configuration files, ...,
## to run PHP with Apache.

# (8.3.z) Used to download PHP and its extensions
# using the Linux distribution package manager:
PHP_VERSION="83"

APACHE_CONFIG_FILE='/etc/apache2/httpd.conf'
PHP_COMMON_EXT="php$PHP_VERSION-common php$PHP_VERSION-mysqli php$PHP_VERSION-pgsql php$PHP_VERSION-sqlite3 php$PHP_VERSION-gd php$PHP_VERSION-curl php$PHP_VERSION-intl php$PHP_VERSION-mbstring php$PHP_VERSION-openssl php$PHP_VERSION-xml php$PHP_VERSION-zip php$PHP_VERSION-bcmath php$PHP_VERSION-soap php$PHP_VERSION-pcntl php$PHP_VERSION-posix php$PHP_VERSION-session php$PHP_VERSION-ctype php$PHP_VERSION-dom php$PHP_VERSION-fileinfo php$PHP_VERSION-gettext php$PHP_VERSION-iconv php$PHP_VERSION-opcache php$PHP_VERSION-pdo php$PHP_VERSION-pdo_mysql php$PHP_VERSION-pdo_pgsql php$PHP_VERSION-pdo_sqlite php$PHP_VERSION-phar php$PHP_VERSION-simplexml php$PHP_VERSION-tokenizer php$PHP_VERSION-xmlreader php$PHP_VERSION-xmlwriter php$PHP_VERSION-shmop php$PHP_VERSION-ffi php$PHP_VERSION-exif php$PHP_VERSION-json php$PHP_VERSION-ftp php$PHP_VERSION-snmp php$PHP_VERSION-sockets php$PHP_VERSION-sodium php$PHP_VERSION-imap php$PHP_VERSION-tidy php$PHP_VERSION-gmp php$PHP_VERSION-pdo_mysql php$PHP_VERSION-pdo_odbc php$PHP_VERSION-mysqli php$PHP_VERSION-odbc"

BIN_DIR="/app/mybin"
PHP_INI_DIR="/etc/php$PHP_VERSION"
HTTPD_DIR="/etc/apache2"
PHP_EXT_INI_DIR="$PHP_INI_DIR/conf.d"

# Main#Fallback
BIN_URL_LIST='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/mybin/tp#https://gitlab.com/duckafire/duckafire/-/raw/main/config/apache2/httpd.conf.template?ref_type=heads'

HTTPD_CONF_URL='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/apache2/httpd.conf.template#https://gitlab.com/duckafire/duckafire/-/raw/main/mybin/tp'
PHP_INI_URL='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/php.template.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/php.template.ini?ref_type=heads'

PHP_EXT_INI_URL_LIST='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/0-system.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/0-system.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/1-data-processing.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/1-data-processing.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/2-net.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/2-net.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/3-math.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/3-math.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/4-data-bank.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/4-data-bank.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/5-xml.inig#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/5-xml.ini'

download()
{
	# /abs/dir/path
	dirPath="$1"

	# To add execution permission:
	isBin="$2"

	shift 2

	# url://domain.sub/file.name
	urlList="$@"

	mkdir -p "$dirPath"

	for bothURL in $urlList
	do
		# Separate URLs:
		mainURL="${bothURL%#*}"
		fallbackURL="${bothURL#*#}"

		# Remove URL path and query strings:
		fileName="${mainURL##*/}"
		fileName="${fileName%\?*}"
		filePath="$dirPath/$fileName"

		# Download from main URL; if a failure
		# occur, try the fallback URL:
		for url in "$mainURL" "$fallbackURL"
		do
			wget -qO "$filePath" "$url"

			if [ $? -eq 0 ]
			then
				test "$isBin" -eq 0 && chmod 700 "$filePath"
				continue 2
			fi
		done

		echo "Impossible to download \"$fileName\"." 1>&2
		exit 1
	done
}

extractFileName()
{
	data="$1"

	url="${data%#*}"
	fileName="${url##*/}"

	echo "$fileName"
}

apk update --quiet
apk add --quiet --no-cache apache2 "php$PHP_VERSION-apache2" composer $PHP_COMMON_EXT

# Remove default configurations files:
rm -rf /etc/php*

download "$BIN_DIR"         0 $BIN_URL_LIST
download "$PHP_INI_DIR"     1 $PHP_INI_URL
download "$HTTPD_DIR"       1 $HTTPD_CONF_URL
download "$PHP_EXT_INI_DIR" 1 $PHP_EXT_INI_URL_LIST

httpdConfTemplate="$HTTPD_DIR/$(extractFileName "$HTTPD_CONF_URL")"
phpIniTemplate="$PHP_INI_DIR/$(extractFileName "$PHP_INI_URL")"

echo "$(tp "$httpdConfTemplate"     \
	SERVER_ROOT="\/app"             \
	SERVER_TOKENS="Prod"            \
	SERVER_SIGNATURE="Off"          \
	DOCUMENT_ROOT="\/app\/dev"      \
	LISTEN_PORT="80"                \
	LOG_LEVEL="error"               \
	LOGS_DIR="\/app\/apache2\/logs" \
	CGI_BIN_DIR="")"                \
	> "$HTTPD_DIR/httpd.conf"

echo "$(tp "$phpIniTemplate"                                \
	OUTPUT_BUFFERING="1024"                                 \
	OUTPUT_HANDLER=""                                       \
	URL_REWRITER_TAGS=""                                    \
	URL_REWRITER_HOSTS=""                                   \
	ZLIB_OUTPUT_COMPRESSION="On"                            \
	ZLIB_OUTPUT_COMPRESSION_LEVEL="-1"                      \
	ZLIB_OUTPUT_HANDLER=""                                  \
	OPEN_BASEDIR=""                                         \
	ZEND_EXCEPTION_IGNORE_ARGS="Off"                        \
	ERROR_REPORTING="E_ALL \& \~E_NOTICE \& \~E_STRICT"     \
	ERROR_LOG="\/app\/php\/logs\/error.log"                 \
	FILE_UPLOADS="Off"                                      \
	EXTENSIONS_DIR="\/usr\/lib\/php$PHP_VERSION\/modules")" \
	> "$PHP_INI_DIR/php.ini"

rm "$httpdConfTemplate" "$phpIniTemplate"

#TODO
#export PHPRC="$PHP_INI_DIR"
#export PHP_INI_SCAN_DIR="$PHP_EXT_INI_DIR"

