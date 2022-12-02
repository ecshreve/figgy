#!/usr/bin/env bash

set -euo pipefail

cd "$HOME" || exit

# check for git installation
# if [ -x "$(command -v git)" ]; then
#   echo 'git is not installed' >&2
#   exit 1
# fi

if [ -f ~/.gitconfig ]; then
  echo "Backing up ~/.gitconfig"
  mv ~/.gitconfig ~/.gitconfig.bak
fi

# check for existing config repo
if ! test -d "$HOME/.cfg" ; then
  echo Cloning dotfiles
  git clone --bare https://github.com/ecshreve/figgy.git "$HOME/.cfg"
  git --git-dir="$HOME/.cfg/" --work-tree="$HOME" checkout
  git --git-dir="$HOME/.cfg/" --work-tree="$HOME" pull --force
fi

# macos specific setup
if [[ "$OSTYPE" = "darwin"* ]] ; then
  if ! xcode-select -p 1>/dev/null 2>&1 ; then
    echo Installing XCode tools

    xcode-select --install
    read -rp "Press enter to continue"
  fi

  if ! test -f /opt/local/bin/port ; then
    echo Installing MacPorts

    echo Go here and find the pkg url:
    echo https://www.macports.org/install.php
    open "https://www.macports.org/install.php"
    read -p "url? " url
    curl --location $url --output macports.pkg
    open macports.pkg
    read -rp "Press enter to continue"
    rm macports.pkg
  fi
fi

# fish shell installation
if ! which fish 1>/dev/null 2>&1 ; then
  echo Installing Fish

  if [[ $OSTYPE = darwin* ]] ; then
    sudo /opt/local/bin/port install fish
  elif which apt-get 1>/dev/null 2>&1 ; then
    sudo apt-add-repository ppa:fish-shell/release-3 -y
    sudo apt-get install fish -y
  fi
fi

# run fish setup script as a command
fish -c 'setup'

exit 0
