#!/bin/sh

DIR="$HOME/Config/git-extensions"
for FILE in $DIR/*; do
    if [ "$(stat -f %A "$FILE")" != "755" ] ; then
        chmod 755 "$FILE"
    fi
done
