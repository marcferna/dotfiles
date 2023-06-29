#!/bin/sh

FILE="$HOME/Config/git-extensions"
if [ -f "$FILE" ]; then
    if [ "$(stat -c %a "$FILE")" != "755" ] ; then
        chmod 755 "$FILE"
    fi
fi
