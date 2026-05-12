#!/usr/bin/env sh

# (8.3.z) Used to download PHP and its extensions
# using the Linux distribution package manager:
PHP_VERSION="83"

APACHE_CONFIG_FILE='/etc/apache2/httpd.conf'
PHP_COMMON_EXT="php$PHP_VERSION-common php$PHP_VERSION-mysqli php$PHP_VERSION-pgsql php$PHP_VERSION-sqlite3 php$PHP_VERSION-gd php$PHP_VERSION-curl php$PHP_VERSION-intl php$PHP_VERSION-mbstring php$PHP_VERSION-openssl php$PHP_VERSION-xml php$PHP_VERSION-zip php$PHP_VERSION-bcmath php$PHP_VERSION-soap php$PHP_VERSION-pcntl php$PHP_VERSION-posix php$PHP_VERSION-session php$PHP_VERSION-ctype php$PHP_VERSION-dom php$PHP_VERSION-fileinfo php$PHP_VERSION-gettext php$PHP_VERSION-iconv php$PHP_VERSION-json php$PHP_VERSION-opcache php$PHP_VERSION-pdo php$PHP_VERSION-pdo_mysql php$PHP_VERSION-pdo_pgsql php$PHP_VERSION-pdo_sqlite php$PHP_VERSION-phar php$PHP_VERSION-simplexml php$PHP_VERSION-tokenizer php$PHP_VERSION-xmlreader php$PHP_VERSION-xmlwriter"

BIN_DIR="/mybin"
PHP_INI_DIR="/usr/local/etc/php"
HTTPD_DIR="/etc/apache2"
PHP_EXT_INI_DIR="/usr/local/etc/php/conf.d"

# Main#Fallback
BIN_URL_LIST='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/mybin/tp#https://gitlab.com/duckafire/duckafire/-/raw/main/config/apache2/httpd.conf.template?ref_type=heads'

PHP_INI_URL='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/apache2/httpd.conf.template#https://gitlab.com/duckafire/duckafire/-/raw/main/mybin/tp'
HTTPD_CONF_URL='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/php.template.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/php.template.ini?ref_type=heads'

PHP_EXT_INI_URL_LIST='https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/0-system.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/0-system.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/1-data-processing.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/1-data-processing.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/2-net.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/2-net.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/3-math.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/3-math.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/4-data-bank.ini#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/4-data-bank.ini
https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/5-xml.inig#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/5-xml.ini'

apk update --quiet
apk add --quiet --no-cache apache2 "php$PHP_VERSION-apache2" composer $PHP_COMMON_EXT

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

download "$BIN_DIR"         0 $BIN_URL_LIST
download "$PHP_INI_DIR"     1 $PHP_INI_URL
download "$HTTPD_DIR"       1 $HTTPD_CONF_URL
download "$PHP_EXT_INI_DIR" 1 $PHP_EXT_INI_URL_LIST

