#!/usr/bin/env bash

set -x 

cd "$HOME" || exit

# check for git installation
if ! [ -x "$(command -v git)" ]; then
  echo 'git is not installed' >&2
  exit 1
fi

# check for existing config repo
if ! test -d "$HOME/.cfg" ; then
  echo Cloning dotfiles
  git clone https://github.com/ecshreve/figgy.git "$HOME/.cfg"

  # git clone --bare https://github.com/ecshreve/figgy.git "$HOME/.cfg"
  # git --git-dir="$HOME/.cfg/" --work-tree="$HOME" checkout
  # git --git-dir="$HOME/.cfg/" --work-tree="$HOME" pull --force
fi

rm -rf ~/.config/fish
mkdir -p ~/.config/fish
cp -r ~/.cfg/.config/fish ~/.config/
cp ~/.cfg/.gitconfig ~/.gitconfig

fish -c 'setup'

exit 0
