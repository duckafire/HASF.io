#!/usr/bin/env sh

for hostPortPair in $WAIT_FOR
do
	host="${hostPortPair%%:*}"
	port="${hostPortPair#*:}"

	until nc -z "$host" "$port"
	do
		echo "Waiting for $hostPortPair"
		sleep 1
	done

	echo "Responsed by $hostPortPair"
done

#exec apache2 -E /dev/stderr -D FOREGROUND

