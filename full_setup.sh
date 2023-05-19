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
  if [ -f ~/.gitconfig ]; then
    echo "backing up existing up ~/.gitconfig"
    mv ~/.gitconfig ~/.gitconfig.bak
  fi
  
  echo Cloning dotfiles
  git clone --bare https://github.com/ecshreve/figgy.git "$HOME/.cfg"
  git --git-dir="$HOME/.cfg/" --work-tree="$HOME" checkout
  git --git-dir="$HOME/.cfg/" --work-tree="$HOME" pull --force
fi

if ! which python3 1>/dev/null 2>&1 ; then
  echo Installing python3
  sudo apt-get update -y
  sudo apt-get install -y python3
fi

if ! which pip 1>/dev/null 2>&1 ; then
  echo Installing pip
  sudo apt-get update -y
  sudo apt-get install -y python3-pip
fi

if ! which ansible 1>/dev/null 2>&1 ; then
  echo Installing ansible
  python3 -m pip install --user ansible
  python3 -m pip install --user ansible-lint
fi

rm $HOME/.bash_profile
echo "export PATH=\$PATH:\$HOME/.local/bin" > $HOME/.bash_profile
source $HOME/.bash_profile

ansible-playbook $HOME/ansible/playbook.yml -vvv
fish -c 'setup'
exit 0