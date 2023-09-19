#!/usr/bin/env bash

cd $HOME

if test -d "$HOME/.config/fish" ; then
	rm -rf ~/.config/fish
fi

cp -r ~/dotfiles/.config/fish ~/.config

fish -c 'setup'

exit 0
