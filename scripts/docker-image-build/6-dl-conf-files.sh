#!/usr/bin/env sh

set -euo pipefail

# Download URL;
# fallback download URL;
# integrity hash code;
# destine path; and
# macros and their values:
TEMPLATES=$(cat << EOF
 https://raw.githubusercontent.com/duckafire/duckafire/82215077c9a2bf7a9c52e59f96b7da1349e7ba3f/config/php/php.template.ini
#https://gitlab.com/duckafire/duckafire/-/raw/82215077c9a2bf7a9c52e59f96b7da1349e7ba3f/config/php/php.template.ini
#b066c7d42b0ef4a3fa6120352e2b7f9b5798fdd22c414a672956fca302823bc7
#$PHPRC/php.ini
#OUTPUT_BUFFERING=1024,
 OUTPUT_HANDLER=,
 URL_REWRITER_TAGS=,
 URL_REWRITER_HOSTS=,
 ZLIB_OUTPUT_COMPRESSION=On,
 ZLIB_OUTPUT_COMPRESSION_LEVEL=-1,
 ZLIB_OUTPUT_HANDLER=,
 OPEN_BASEDIR=,
 ZEND_EXCEPTION_IGNORE_ARGS=Off,
 ERROR_REPORTING=E_ALL,
 ERROR_LOG=\\/app\\/php\\/logs\\/error.log,
 FILE_UPLOADS=Off,
 EXTENSIONS_DIR=\\/usr\\/lib\\/php$PHPV\\/modules,
;;
 https://raw.githubusercontent.com/duckafire/duckafire/3cc35cfed44e0961ee6db4e5c34262298473a45c/config/apache2/httpd.conf.template
#https://gitlab.com/duckafire/duckafire/-/raw/3cc35cfed44e0961ee6db4e5c34262298473a45c/config/apache2/httpd.conf.template
#95c14c64c3201240ded2875eaeac92cc629668100f843dd77b55fb3b86e0be44
#$HTTPD_DIR/httpd.conf
#SERVER_NAME=localhost,
 SERVER_ROOT=\\/app,
 SERVER_TOKENS=Prod,
 SERVER_SIGNATURE=Off,
 DOCUMENT_ROOT=$(echo $WORK_DIR | sed 's/\//\\\//g'),
 LISTEN_PORT=80,
 LOG_LEVEL=error,
 CGI_BIN_DIR=\\/app\\/cgi-bin,
 USER_NAME=$APACHE_USER,
 USER_GROUP=$APACHE_USER,
 LOGS_DIR=.,
;;
EOF
)

# (Download URL;
# fallback download URL;
# integrity hash code; and
# destine path.)
FILES=$(cat << EOF
 https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/0-system.ini
#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/0-system.ini
#c03276dd3e0f9ddd22263564b3c2aac3750612f7296793972cf0ebb63c116da7
#$PHP_INI_SCAN_DIR/0-system.ini
;;
 https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/1-data-processing.ini
#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/1-data-processing.ini
#46c2b3bcd84faa528931121cbfef352e298e83513b236b4005c032bcd787ee71
#$PHP_INI_SCAN_DIR/1-data-processing.ini
;;
 https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/2-net.ini
#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/2-net.ini
#aa75c5fed3b30f11c2a83f637c676ad99e2cdca848950ba5f940394585e2dcb3
#$PHP_INI_SCAN_DIR/2-net.ini
;;
 https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/3-math.ini
#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/3-math.ini
#ce1cb7ef4ad48208c978fab3bc8a8ee93e770700a301df49f27b1db42c80a9fc
#$PHP_INI_SCAN_DIR/3-math.ini
;;
 https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/4-data-bank.ini
#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/4-data-bank.ini
#e212759d6efa614f81107ed4d3cf724a15381b1b98e7abbd85d81451d196c728
#$PHP_INI_SCAN_DIR/4-data-bank.ini
;;
 https://raw.githubusercontent.com/duckafire/duckafire/refs/heads/main/config/php/conf.d/5-xml.ini
#https://gitlab.com/duckafire/duckafire/-/raw/main/config/php/conf.d/5-xml.ini
#4ae7598e302961f51cc78a51a3593bdff7dc4fedb3b376b07f3a9cea81dd8732
#$PHP_INI_SCAN_DIR/5-xml.ini
EOF
)

processData()
{
	isTemplate="$1"

	shift

	# (Process `$@`:
	# remove line feeds;
	# remove spaces before `#`;
	# remove spaces after `,`; and
	# replace `;;` with one space.)
	for data in $(echo "$@" | tr -d '\n' | sed 's/ \+#/#/g' | sed 's/, \+/,/g' | sed 's/;;/ /g')
	do
		mainURL="${data%%#*}"
		data="${data#*#}"

		fallbackURL="${data%%#*}"
		data="${data#*#}"

		expectedHashCode="${data%%#*}"
		data="${data#*#}"

		destFilePath="${data%%#*}"
		templateMacros="${data#*#}"

		fileName="${mainURL##*/}"
		destDirPath="${destFilePath%/*}"

		if ! wget -q "$mainURL" && ! wget -q "$fallbackURL"
		then
			echo "Impossible download file: $fileName" 1>&2
			exit 1
		fi

		receivedHashCode="$(sha256sum "$fileName")"
		if [ "$expectedHashCode" != "${receivedHashCode%% *}" ]
		then
			echo "Invalid configuration file; (CAUTION) different hash codes!" 1>&2
			exit 1
		fi

		if [ ! -d "$destDirPath" ]
		then
			mkdir -p "$destDirPath"
		fi

		if [ "$(stat -c '%U' "$destDirPath")" = "root" ]
		then
			chown "$APACHE_USER:$APACHE_USER" "$destDirPath"
		fi

		if [ -f "$destFilePath" ] && [ "$(stat -c '%U' "$destFilePath")" = "root" ]
		then
			chown "$APACHE_USER:$APACHE_USER" "$destFilePath"
		fi

		if [ "$isTemplate" = "false" ]
		then
			mv "$fileName" "$destFilePath"
			return
		fi

		templateMacros="$(echo "$templateMacros" | sed 's/,/ /g')"
		tp "$fileName" $templateMacros > "$destFilePath"
		rm "$fileName"
	done
}

processData "true"  "$TEMPLATES"
processData "false" "$FILES"

