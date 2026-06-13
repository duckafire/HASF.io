#!/usr/bin/env sh

# z-entrypoint [host:port [, [host:port [, ...]]]]

# Remove interpreter name:
shift

for data in $@
do
	host="${data%%:*}"
	port="${data#*:}"

	until nc -z "$host" "$port"
	do
		echo "Waiting for $data."
		sleep 1
	done

	echo "Responsed by $data."
done

# `exec` sets PID 1 to Apache, what it allows
# that Docker stops it through of SIGTERM; without
# this, Apache never will catch SIGTERMs.
#
# (Send errors to stderr; and run at foreground.)
exec httpd -E /dev/stderr -D FOREGROUND

