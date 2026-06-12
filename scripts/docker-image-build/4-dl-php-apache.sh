#!/usr/bin/env sh

set -euo pipefail

apk add --quiet --no-cache "php$PHPV-apache2"

DATA='
/usr/lib/apache2#modules
/var/log/apache2#logs
/run/apache2#run
'

for data in $DATA
do
	path="${data%#*}"
	link="${data#*#}"

	ln -s "$path" "$link"
	chown "$APACHE_USER:$APACHE_USER" "$link"
done

