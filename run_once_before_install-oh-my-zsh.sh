#!/bin/bash

FILE=$HOME/.oh-my-zsh/oh-my-zsh.sh
if [ -f "$FILE" ]; then
  echo "oh-my-zsh already installed."
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
