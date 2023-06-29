#!/bin/sh

DIRECTORY="$HOME/Config/git-extensions"
for file in "$DIRECTORY"/*; do
  if [ -f "$file" ]; then
    chmod 755 "$file"
  fi
done
