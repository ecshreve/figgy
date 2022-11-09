# set up config repo
debug-fish-init start (status -f)
if test -d "$HOME/.cfg"
    alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    config config --local status.showUntrackedFiles no

    abbr -a caa config add
    abbr -a cmsg config commit -m
    abbr -a cush config push
    abbr -a cst config status
    abbr -a ciff config diff

end
debug-fish-init end (status -f)
