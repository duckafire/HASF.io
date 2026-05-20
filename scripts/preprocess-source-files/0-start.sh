#!/usr/bin/env sh

abort()
{
	echo "$1" 1>&2
	exit 1
}

if [ -z "ROOT_DIR" ]
then
	abort "Expecting environment variable ROOT_DIR."
fi

if [ -n "PRODUCTION" ]
then
	BUILD_DIR="$ROOT_DIR/prod"
else
	BUILD_DIR="$ROOT_DIR/debug"
fi

cp -r "$ROOT_DIR/wip" "$BUILD_DIR"

export BUILD_DIR

