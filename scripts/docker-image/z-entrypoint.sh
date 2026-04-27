#!/usr/bin/env sh

# WAIT_FOR must be an environment variable
# (it also must have a space-separated list
# of hosts and ports, separated with a colon).

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

# Set stderr as destine to error log messages;
# and execute apache in foregound.
#
# `exec` sets PID 1 to Apache, what it allows
# that Docker stops it through of SIGTERM; without
# this, Apache never will catch SIGTERMs.
exec apache2 -E /dev/stderr -D FOREGROUND

