#!/usr/bin/env sh

# (Less `-u`.)
set -eo pipefail

# Expected environment variables:
#
#   HASF_IO_ROOT_DIR (always mandatory):
#     parent directory of `wip/` and `prod/`.
#
#   HASF_IO_VERSION (mandatory to production build):
#     HASF.io current version (format: v<major>.<minor>.<patch>).
#
#   HASF_IO_PRODUCTION (mandatory to production build)
#     if it is declared it defines that the application environment
#     is production; else is local (to tests).

# v<major>.<minor>.<patch>
VERSION_REGEXP_FORMAT='^v[:digit:]+\.[:digit:]+\.[:digit:]+$'

# This file will contain the declaration of no-secret environment
# variables required to deploy pipeline jobs.
#
# It is necessary because of the organization of the Dockerfile
# it have as goal makes the most of Docker build cache and because
# of this it executes jobs in different RUN rules.
#
# (Commands and scripts executed in RUN are executed in a subshell,
# so environment variables declared into them are lost after the
# process ends, because the subshell is ended; it cound be get around
# with `RUN eval "$(cat /foo.sh)" && ...` before the execution of
# all the other scripts, but, as said earlier, all files are executed
# in separated RUN rules, what back to the subshells problem
# cited before, because all RUN have themselves shell (they only share
# variables declared in Dockerfile, with ENV rule).
#
# The simple solution is to record them into a SH executable script and
# run it into top of the other scripts, before the majority of their
# commands).
ENV_FILE_NAME="/dp/export-deploy-env-variables"
envFileDeclarations=""

abort()
{
	echo "$1" 1>&2
	exit 1
}

isDefinedVar()
{
	varName="$1"
	varValue="$(eval "echo \"\$$varName\"")"

	if [ -z "$varValue" ]
	then
		abort "Expecting environment variable $varName."
	fi
}

isEmptyDir()
{
	# Check whether the directory is empty:
	# 1. list all files inside it; and
	# 2. count the quantity of lines in stdout.
	#
	# If it founds only two, or less, files
	# (`.` and `..`) it is empty.
	test "$(ls -a "$1" | wc -l)" -le 2
	return $?
}

isDefinedVar "HASF_IO_ROOT_DIR."

if [ -n "$HASF_IO_PRODUCTION" ]
then
	isDefinedVar "HASF_IO_VERSION"

	if ! echo "$HASF_IO_VERSION" | grep -E "$VERSION_REGEXP_FORMAT"
	then
		abort "Invalid version format, expecting (RegExp based format): $VERSION_REGEXP_FORMAT"
	fi

	HASF_IO_BUILD_ROOT_DIR="$HASF_IO_ROOT_DIR/prod/$HASF_IO_VERSION"
else
	HASF_IO_BUILD_ROOT_DIR="$HASF_IO_ROOT_DIR/local"
fi

if [ -e "$HASF_IO_BUILD_ROOT_DIR" ]
then
	if [ ! -d "$HASF_IO_BUILD_ROOT_DIR" ]
	then
		abort "$HASF_IO_BUILD_ROOT_DIR already exists and is not a directory."
	fi

	if ! isEmptyDir "$HASF_IO_BUILD_ROOT_DIR"
	then
		abort "$HASF_IO_BUILD_ROOT_DIR already exists and is not empty."
	fi
fi

HASF_IO_BUILD_WIP_DIR="$HASF_IO_ROOT_DIR/wip"

if [ ! -e "$HASF_IO_BUILD_WIP_DIR" ]
then
	abort "$HASF_IO_BUILD_WIP_DIR does not exist."
fi

if [ ! -d "$HASF_IO_BUILD_WIP_DIR" ]
then
	abort "$HASF_IO_BUILD_WIP_DIR is not a directory."
fi

if isEmptyDir "$HASF_IO_BUILD_WIP_DIR"
then
	abort "$HASF_IO_BUILD_WIP_DIR is empty."
fi

HASF_IO_WORK_DIR="$WORK_DIR"

HASF_IO_BUILD_APP_DIR="$HASF_IO_BUILD_ROOT_DIR/app"
HASF_IO_BUILD_PUBLIC_DIR="$HASF_IO_BUILD_ROOT_DIR/public"
HASF_IO_BUILD_READONLY_DIR="$HASF_IO_BUILD_ROOT_DIR/readonly"
HASF_IO_BUILD_TESTS_DIR="$HASF_IO_BUILD_ROOT_DIR/tests"
HASF_IO_BUILD_WRITABLE_DIR="$HASF_IO_BUILD_ROOT_DIR/writable"

HASF_IO_BUILD_ASSETS_DIR="$HASF_IO_BUILD_PUBLIC_DIR/assets"
HASF_IO_BUILD_MANIFESTS_DIR="$HASF_IO_BUILD_READONLY_DIR/manifests"

VAR_LIST=$(cat << EOF
HASF_IO_WORK_DIR
HASF_IO_BUILD_WIP_DIR
HASF_IO_BUILD_ROOT_DIR
HASF_IO_BUILD_APP_DIR
HASF_IO_BUILD_PUBLIC_DIR
HASF_IO_BUILD_READONLY_DIR
HASF_IO_BUILD_TESTS_DIR
HASF_IO_BUILD_WRITABLE_DIR
HASF_IO_BUILD_ASSETS_DIR
HASF_IO_BUILD_MANIFESTS_DIR
EOF
)

for varName in $VAR_LIST
do
	varValue="$(eval "echo \"\$$varName\"")"

	envFileDeclarations="$envFileDeclarations$varName=\"$varValue\";"
done

echo "$(cat << EOF
#!/usr/bin/env sh

set -eo pipefail

$envFileDeclarations

export $(echo $VAR_LIST)
EOF
)" > "$ENV_FILE_NAME"

chmod 555 "$ENV_FILE_NAME"

