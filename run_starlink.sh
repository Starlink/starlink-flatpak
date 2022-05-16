#!/bin/bash

mkdir -p "/tmp/adam"

export HTX_TMP="$XDG_RUNTIME_DIR/app/$FLATPAK_ID/htx"
mkdir -p "$HTX_TMP"

if [[ $# -gt 0 ]]; then
    . /app/etc/profile
    /app/bin/gaia/gaia.sh "$@"
else
    bash --init-file /app/etc/run_starlink_init
fi
