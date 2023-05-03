if status is-interactive
    # commands to run in interactive sessions can go here
    set -xg FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=nowrap --marker="*"'
    set -xg fzf_processes_opts --preview-window="top:4:wrap"
    set -xg fzf_history_opts --preview-window="top:4:wrap"

    # aliases
    alias cl="clear -x"
    alias clear="clear -x"
    alias top htop
    alias cat bat
    alias ls 'exa --icons'
    alias date-iso 'date -u +%H:%M:%S:%z'

    # general abbreviations
    abbr -a ll ls -al
    abbr -a rr rm -rf
    abbr -a mkdirp mkdir -p

    # convenience abbreviations for config git repo
    abbr -a caa config add
    abbr -a cmsg config commit -m
    abbr -a cush config push
    abbr -a cst config status
    abbr -a ciff config diff
    abbr -a clog config log

    # general git abbreviations
    abbr -a gaa git add --all
    abbr -a guu git add -u
    abbr -a gst git status
    abbr -a gcmsg git commit -m
    abbr -a gcm git checkout main

    fzf_configure_bindings --directory=\cff --git_log=\cfl --git_status=\cfs --processes=\cfp --variables=\cfv
end
