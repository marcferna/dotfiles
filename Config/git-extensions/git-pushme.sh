#!/bin/bash

#
# Pushes the current branch to the fork or to the main remote
# Optional set --force to force push commit
#

branch="$(git rev-parse --abbrev-ref HEAD)"

# set remote to fork or origin
remote="$(git remote | grep 'fork')"
if [ -z "$remote" ]; then
  remote="$(git remote)"
fi

# output description of actions
prefix="Pushing"
if [ "$1" == "--force" ] || [ "$2" == "--force" ]; then
  prefix="Force pushing"
fi
echo "$prefix $branch to $remote..."

# push or force push depending on remote and flags
if [ $remote == "origin" ] && [ "$1" != "--force" ] && [ "$2" != "--force" ]; then
  git push $remote $branch
else
  git push $remote $branch -f
fi
