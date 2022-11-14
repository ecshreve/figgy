debug-fish-init start (status -f)
if status --is-interactive
    set -x FZF_DEFAULT_COMMAND 'fdfind --type f -I'
    # set -x FZF_DEFAULT_OPTS '--preview="head -$LINES {}" --height 40% --layout=reverse --border'
end
debug-fish-init end (status -f)
