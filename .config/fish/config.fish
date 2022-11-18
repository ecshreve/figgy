if status is-interactive
    # commands to run in interactive sessions can go here
    set fzf_fd_opts --hidden --no-ignore --exclude=.git
    fzf_configure_bindings --directory=\cff --git_log=\cfl --git_status=\cfs --processes=\cfp --variables=\cfv

    # preserve scrollback buffer
    alias clear="clear -x"

    # convenience abbreviations for config git repo
    abbr -a caa config add
    abbr -a cmsg config commit -m
    abbr -a cush config push
    abbr -a cst config status
    abbr -a ciff config diff
    abbr -a clog config log

    # git aliases
    abbr -a gst git status
    abbr -a gcmsg git commit -m 

end
