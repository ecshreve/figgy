if status is-interactive
    # commands to run in interactive sessions can go here

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
    abbr -a gaa git add --all
    abbr -a guu git add -u
    abbr -a gst git status
    abbr -a gcmsg git commit -m
end
