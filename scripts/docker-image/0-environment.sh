#!/usr/bin/env sh

## Download essential binaries, configuration files, ...,
## to run PHP with Apache.

PHP_COMMON_EXT="php$PHPV-common php$PHPV-mysqli php$PHPV-pgsql php$PHPV-sqlite3 php$PHPV-gd php$PHPV-curl php$PHPV-intl php$PHPV-mbstring php$PHPV-openssl php$PHPV-xml php$PHPV-zip php$PHPV-bcmath php$PHPV-soap php$PHPV-pcntl php$PHPV-posix php$PHPV-session php$PHPV-ctype php$PHPV-dom php$PHPV-fileinfo php$PHPV-gettext php$PHPV-iconv php$PHPV-opcache php$PHPV-pdo php$PHPV-pdo_mysql php$PHPV-pdo_pgsql php$PHPV-pdo_sqlite php$PHPV-phar php$PHPV-simplexml php$PHPV-tokenizer php$PHPV-xmlreader php$PHPV-xmlwriter php$PHPV-shmop php$PHPV-ffi php$PHPV-exif php$PHPV-ftp php$PHPV-snmp php$PHPV-sockets php$PHPV-sodium php$PHPV-imap php$PHPV-tidy php$PHPV-gmp php$PHPV-pdo_mysql php$PHPV-pdo_odbc php$PHPV-mysqli php$PHPV-odbc"

BIN_DIR="/app/mybin"
HTTPD_DIR="/etc/apache2"

# Main#Fallback
BIN_URL_LIST='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/mybin/tp#https://gitlab.com/duckafire/duckafire/-/raw/main/config/apache2/httpd.conf.template?ref_type=heads'

HTTPD_CONF_URL='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/apache2/httpd.conf.template#https://gitlab.com/duckafire/duckafire/-/raw/main/mybin/tp'
PHP_INI_URL='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/php.template.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/php.template.ini?ref_type=heads'

PHP_EXT_INI_URL_LIST='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/0-system.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/0-system.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/1-data-processing.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/1-data-processing.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/2-net.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/2-net.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/3-math.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/3-math.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/4-data-bank.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/4-data-bank.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/5-xml.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/5-xml.ini'

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
apk add --quiet --no-cache apache2 "php$PHPV-apache2" composer $PHP_COMMON_EXT

# Remove default configurations files:
rm -rf /etc/php*

download "$BIN_DIR"         0 $BIN_URL_LIST
download "$PHPRC"     1 $PHP_INI_URL
download "$HTTPD_DIR"       1 $HTTPD_CONF_URL
download "$PHP_INI_SCAN_DIR" 1 $PHP_EXT_INI_URL_LIST

httpdConfTemplate="$HTTPD_DIR/$(extractFileName "$HTTPD_CONF_URL")"
phpIniTemplate="$PHPRC/$(extractFileName "$PHP_INI_URL")"

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
	EXTENSIONS_DIR="\/usr\/lib\/php$PHPV\/modules")" \
	> "$PHPRC/php.ini"

rm "$httpdConfTemplate" "$phpIniTemplate"

