#!/usr/bin/env sh

set -euo pipefail

# Create `foouser:foouser`;
# non-home directory; and
# non-password:
adduser "$APACHE_USER" -D -H

# Allow that Apache User can
# manipulate directories,
# symbolic links, and files
# inside the work directory:
chown "$APACHE_USER:$APACHE_USER" "$WORK_DIR"

