fzf_configure_bindings --directory=\cff --git_log=\cfl --git_status=\cfs --processes=\cfp --variables=\cfv

if status is-interactive
    # commands to run in interactive sessions can go here

    # aliases
    alias cl="clear -x"
    alias clear="clear -x"
    alias top htop
    alias cat bat
    alias ls 'exa --icons'
    alias date-iso 'date -u +%H:%M:%S:%z'

    # general abbreviations
    abbr -a ll ls -al

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
end
